

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>


template<typename T>
static inline __attribute__((always_inline))
T ue4_cross(T x, T y)
{
    metal::float3 fx = metal::float3(x);
    metal::float3 fy = metal::float3(y);
    return T(metal::fma(fx[1], fy[2], -metal::fma(fy[1], fx[2], 0.0)), metal::fma(fx[2], fy[0], -metal::fma(fy[2], fx[0], 0.0)), metal::fma(fx[0], fy[1], -metal::fma(fy[0], fx[1], 0.0)));
}
#define cross ue4_cross

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_View
{
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
    char _m1_pad[1144];
    float View_GameTime;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
    char _m3_pad[144];
    float3 Primitive_ObjectBounds;
    char _m4_pad[48];
    float3 Primitive_LocalObjectBoundsMin;
    float3 Primitive_LocalObjectBoundsMax;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

struct type_Globals
{
    float4 InstancingViewZCompareZero;
    float4 InstancingViewZCompareOne;
    float4 InstancingViewZConstant;
    float4 InstancingWorldViewOriginZero;
    float4 InstancingWorldViewOriginOne;
    float4 InstancingOffset;
    float4 InstancingFadeOutParams;
    uint InstanceOffset;
};

constant float3x3 _124 = {};
constant float4 _125 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float3 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

template<typename T>
T spvFMul(T l, T r)
{
    return fma(l, r, T(0));
}

template<typename T, int Cols, int Rows>
vec<T, Cols> spvFMulVectorMatrix(vec<T, Rows> v, matrix<T, Cols, Rows> m)
{
    vec<T, Cols> res = vec<T, Cols>(0);
    for (uint i = Rows; i > 0; --i)
    {
        vec<T, Cols> tmp(0);
        for (uint j = 0; j < Cols; ++j)
        {
            tmp[j] = m[j][i - 1];
        }
        res = fma(tmp, vec<T, Cols>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int Cols, int Rows>
vec<T, Rows> spvFMulMatrixVector(matrix<T, Cols, Rows> m, vec<T, Cols> v)
{
    vec<T, Rows> res = vec<T, Rows>(0);
    for (uint i = Cols; i > 0; --i)
    {
        res = fma(m[i - 1], vec<T, Rows>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int LCols, int LRows, int RCols, int RRows>
matrix<T, RCols, LRows> spvFMulMatrixMatrix(matrix<T, LCols, LRows> l, matrix<T, RCols, RRows> r)
{
    matrix<T, RCols, LRows> res;
    for (uint i = 0; i < RCols; i++)
    {
        vec<T, RCols> tmp(0);
        for (uint j = 0; j < LCols; j++)
        {
            tmp = fma(vec<T, RCols>(r[i][j]), l[j], tmp);
        }
        res[i] = tmp;
    }
    return res;
}

template<typename T>
T spvFAdd(T l, T r)
{
    return fma(T(1), l, r);
}

vertex Main_out Main_00004365_ab2d3db6(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_LocalVF& LocalVF [[buffer(8)]], constant type_Material& Material [[buffer(9)]], constant type_Globals& _Globals [[buffer(10)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(4)]], texture2d<float> Material_Texture2D_2 [[texture(5)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _136 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _146 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _147 = 3u * _146;
    float4 _149 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_147));
    float4 _151 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_147 + 1u)));
    float4 _153 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_147 + 2u)));
    float4 _155 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_146));
    uint _156 = 2u * _136;
    float4 _161 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_156 + 1u)));
    float _162 = _161.w;
    float3 _163 = _161.xyz;
    float3 _165 = cross(_163, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_156)).xyz) * _162;
    float3x3 _168 = _124;
    _168[0] = cross(_165, _163) * _162;
    float3x3 _169 = _168;
    _169[1] = _165;
    float3x3 _170 = _169;
    _170[2] = _163;
    float3x3 _184 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_149.xyz, _151.xyz, _153.xyz));
    float3x3 _187 = _184;
    _187[0] = normalize(_184[0]);
    float3x3 _190 = _187;
    _190[1] = normalize(_184[1]);
    float3x3 _193 = _190;
    _193[2] = normalize(_184[2]);
    float3x3 _194 = spvFMulMatrixMatrix(_193, _170);
    float _200 = trunc(spvFMul(_149.w, 0.00390625));
    float _201 = _155.w;
    float4 _202 = _125;
    _202.x = _201;
    float3 _207 = spvFAdd(_155.xyz, _Globals.InstancingOffset.xyz);
    float3 _216 = spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _207.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _207.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _207.yyy))), Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _227 = _202;
    _227.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_216, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _271 = fma(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _201, length(_216 - _Globals.InstancingWorldViewOriginZero.xyz))) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginZero.w, spvFMul(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _201, length(_216 - _Globals.InstancingWorldViewOriginOne.xyz))) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginOne.w));
    float4 _272 = _227;
    _272.w = _271;
    float _276 = spvFMul(fma(_Globals.InstancingFadeOutParams.z, _200, spvFMul(_Globals.InstancingFadeOutParams.w, 1.0 - _200)), float(abs(_271) < 0.999000012874603271484375));
    float4 _277 = _272;
    _277.z = _276;
    float4x4 _294 = float4x4(float4(_149.xyz, 0.0), float4(_151.xyz, 0.0), float4(_153.xyz, 0.0), float4(_155.xyz, 1.0));
    float4 _295 = spvFMulMatrixVector(_294, in.in_var_ATTRIBUTE0);
    float4 _308 = float4(spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _295.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _295.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _295.yyy))), spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation)), 1.0) * _276;
    float3 _309 = _308.xyz;
    float4x4 _310 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _294);
    uint _313 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _314 = _313 - 1u;
    uint _316 = _313 * _136;
    float4 _319 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_316 + min(0u, _314))));
    float4 _322 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_316 + min(1u, _314))));
    float4 _325 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_316 + min(2u, _314))));
    float3 _326 = _194[2];
    float3 _597;
    switch (0u)
    {
        default:
        {
            if (_276 < 1.0)
            {
                _597 = float3(0.0);
                break;
            }
            float3 _345 = spvFMulMatrixVector(_310, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _346 = _309 - View.View_PreViewTranslation;
            float3 _353 = _345 * Material.Material_ScalarExpressions[1].x;
            float _362 = _325.y;
            float3 _374 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_346 - _345) * Material.Material_ScalarExpressions[0].w, _353), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _362))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _379 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _401 = float3x3(_310[0].xyz, _310[1].xyz, _310[2].xyz);
            float3 _402 = spvFMulMatrixVector(_401, spvFAdd(float3(-0.5), fract(spvFMul(float3(_322.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _405 = _325.x;
            float3 _408 = float3(1.0) - (_402 * spvFMul(Material.Material_ScalarExpressions[2].y, _405));
            float3 _409 = spvFAdd(_346, spvFAdd(_379 * spvFMul(Material.Material_ScalarExpressions[1].w, _374.x), float3(0.0, 0.0, 1.0) * spvFMul(_374.y, Material.Material_ScalarExpressions[2].x)) * _362) - _408;
            float _416 = dot(_379, _402 / float3(sqrt(dot(_402, _402))));
            float3 _419 = spvFAdd(_379, float3(0.0, 0.0, 1.0) * spvFMul(_416, _416));
            float3 _423 = _419 / float3(sqrt(dot(_419, _419)));
            float _424 = _322.x;
            float _427 = floor(spvFMul(_424, 7.111111164093017578125));
            float _429 = spvFMul(_424, 256.0) - spvFMul(_427, 36.0);
            float _431 = floor(spvFMul(_429, 0.16666667163372039794921875));
            float3 _459 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_429 - spvFMul(_431, 6.0), _431, _427), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_353, _353))) - spvFMul(Material.Material_ScalarExpressions[3].x, _405))).xy, level(-1.0)).xyz) * 2.0;
            float3 _479 = spvFAdd(_409, spvFAdd(_423 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_459.z, 1.0)), spvFAdd(_423 * _459.x, Material.Material_VectorExpressions[6].xyz * _459.y) * Material.Material_ScalarExpressions[3].w) * _405);
            float _480 = dot(_479, _479);
            float3 _499 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_479 / float3(sqrt(_480)), 0.0), bool4(_480 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_480 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_409, _409)), _408) - _345;
            float _528 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_346, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _529 = spvFMul(_528, _528);
            float3 _541 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_353, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _529))).xy, level(-1.0)).xyz) * 2.0;
            float3 _562 = spvFAdd(_499, spvFAdd(_379 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_541.z, 1.0)), spvFAdd(_379 * _541.x, (cross(_379, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _541.y) * Material.Material_ScalarExpressions[5].z) * _529);
            float _563 = dot(_562, _562);
            float3 _584 = -spvFMulMatrixVector(_401, float3(1.0, 0.0, 0.0));
            float3 _588 = -spvFMulMatrixVector(_401, float3(0.0, 1.0, 0.0));
            float3 _592 = -spvFMulMatrixVector(_401, float3(0.0, 0.0, 1.0));
            _597 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_562 / float3(sqrt(_563)), 0.0), bool4(_563 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_563 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_499, _499)), _345) - _346, float3(sqrt(dot(_584, _584)), sqrt(dot(_588, _588)), sqrt(dot(_592, _592))));
            break;
        }
    }
    float3 _598 = spvFAdd(_309, _597);
    float4 _604 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_598.x, _598.y, _598.z, _308.w));
    float4 _615;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_604.z < 0.0))
    {
        float4 _613 = _604;
        _613.z = 9.9999999747524270787835121154785e-07;
        float4 _614 = _613;
        _614.w = 1.0;
        _615 = _614;
    }
    else
    {
        _615 = _604;
    }
    float _621 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _326));
    float4 _644 = _615;
    _644.z = spvFMul(fma(_615.z, ShadowDepthPass.ShadowDepthPass_ShadowParams.w, fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_621) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_621, _621), 0.0, 1.0)) / _621) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x)), _615.w);
    spvUnsafeArray<float4, 1> _655 = { float4(_319.x, _319.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_194[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_326, spvFMul(_162, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_136 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _277;
    out_var_TEXCOORD0 = _655;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _598.xyz;
    out.gl_Position = _644;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

