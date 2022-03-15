

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

constant float3x3 _125 = {};
constant float4 _126 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float out_var_TEXCOORD8 [[user(locn6)]];
    float3 out_var_TEXCOORD7 [[user(locn7)]];
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

vertex Main_out Main_00004345_0a450fed(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_LocalVF& LocalVF [[buffer(8)]], constant type_Material& Material [[buffer(9)]], constant type_Globals& _Globals [[buffer(10)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(4)]], texture2d<float> Material_Texture2D_2 [[texture(5)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _137 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _147 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _148 = 3u * _147;
    float4 _150 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_148));
    float4 _152 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_148 + 1u)));
    float4 _154 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_148 + 2u)));
    float4 _156 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_147));
    uint _157 = 2u * _137;
    float4 _162 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_157 + 1u)));
    float _163 = _162.w;
    float3 _164 = _162.xyz;
    float3 _166 = cross(_164, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_157)).xyz) * _163;
    float3x3 _169 = _125;
    _169[0] = cross(_166, _164) * _163;
    float3x3 _170 = _169;
    _170[1] = _166;
    float3x3 _171 = _170;
    _171[2] = _164;
    float3x3 _185 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_150.xyz, _152.xyz, _154.xyz));
    float3x3 _188 = _185;
    _188[0] = normalize(_185[0]);
    float3x3 _191 = _188;
    _191[1] = normalize(_185[1]);
    float3x3 _194 = _191;
    _194[2] = normalize(_185[2]);
    float3x3 _195 = spvFMulMatrixMatrix(_194, _171);
    float _201 = trunc(spvFMul(_150.w, 0.00390625));
    float _202 = _156.w;
    float4 _203 = _126;
    _203.x = _202;
    float3 _208 = spvFAdd(_156.xyz, _Globals.InstancingOffset.xyz);
    float3 _217 = spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _208.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _208.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _208.yyy))), Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _228 = _203;
    _228.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_217, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _272 = fma(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _202, length(_217 - _Globals.InstancingWorldViewOriginZero.xyz))) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginZero.w, spvFMul(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _202, length(_217 - _Globals.InstancingWorldViewOriginOne.xyz))) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginOne.w));
    float4 _273 = _228;
    _273.w = _272;
    float _277 = spvFMul(fma(_Globals.InstancingFadeOutParams.z, _201, spvFMul(_Globals.InstancingFadeOutParams.w, 1.0 - _201)), float(abs(_272) < 0.999000012874603271484375));
    float4 _278 = _273;
    _278.z = _277;
    float4x4 _295 = float4x4(float4(_150.xyz, 0.0), float4(_152.xyz, 0.0), float4(_154.xyz, 0.0), float4(_156.xyz, 1.0));
    float4 _296 = spvFMulMatrixVector(_295, in.in_var_ATTRIBUTE0);
    float4 _309 = float4(spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _296.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _296.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _296.yyy))), spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation)), 1.0) * _277;
    float3 _310 = _309.xyz;
    float4x4 _311 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _295);
    uint _314 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _315 = _314 - 1u;
    uint _317 = _314 * _137;
    float4 _320 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_317 + min(0u, _315))));
    float4 _323 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_317 + min(1u, _315))));
    float4 _326 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_317 + min(2u, _315))));
    float3 _327 = _195[2];
    float3 _598;
    switch (0u)
    {
        default:
        {
            if (_277 < 1.0)
            {
                _598 = float3(0.0);
                break;
            }
            float3 _346 = spvFMulMatrixVector(_311, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _347 = _310 - View.View_PreViewTranslation;
            float3 _354 = _346 * Material.Material_ScalarExpressions[1].x;
            float _363 = _326.y;
            float3 _375 = spvFAdd(Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd((_347 - _346) * Material.Material_ScalarExpressions[0].w, _354), float3(1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].y) - spvFMul(Material.Material_ScalarExpressions[1].z, _363))).xy, level(-1.0)).xyz, float3(-0.25, -0.5, -0.5)) * 2.0;
            float3 _380 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].y >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].y - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3x3 _402 = float3x3(_311[0].xyz, _311[1].xyz, _311[2].xyz);
            float3 _403 = spvFMulMatrixVector(_402, spvFAdd(float3(-0.5), fract(spvFMul(float3(_323.y), float3(0.0625, 1.0, 16.0)))) * 2.0);
            float _406 = _326.x;
            float3 _409 = float3(1.0) - (_403 * spvFMul(Material.Material_ScalarExpressions[2].y, _406));
            float3 _410 = spvFAdd(_347, spvFAdd(_380 * spvFMul(Material.Material_ScalarExpressions[1].w, _375.x), float3(0.0, 0.0, 1.0) * spvFMul(_375.y, Material.Material_ScalarExpressions[2].x)) * _363) - _409;
            float _417 = dot(_380, _403 / float3(sqrt(dot(_403, _403))));
            float3 _420 = spvFAdd(_380, float3(0.0, 0.0, 1.0) * spvFMul(_417, _417));
            float3 _424 = _420 / float3(sqrt(dot(_420, _420)));
            float _425 = _323.x;
            float _428 = floor(spvFMul(_425, 7.111111164093017578125));
            float _430 = spvFMul(_425, 256.0) - spvFMul(_428, 36.0);
            float _432 = floor(spvFMul(_430, 0.16666667163372039794921875));
            float3 _460 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(spvFAdd(spvFMul(spvFMul(float3(_430 - spvFMul(_432, 6.0), _432, _428), float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.16666667163372039794921875)), Primitive.Primitive_ObjectBounds) * Material.Material_ScalarExpressions[2].z, float3(1.0)), float3(-1.0, 0.0, 0.0) * (fma(View.View_GameTime, Material.Material_ScalarExpressions[2].w, fract(dot(_354, _354))) - spvFMul(Material.Material_ScalarExpressions[3].x, _406))).xy, level(-1.0)).xyz) * 2.0;
            float3 _480 = spvFAdd(_410, spvFAdd(_424 * spvFMul(Material.Material_ScalarExpressions[3].y, spvFAdd(_460.z, 1.0)), spvFAdd(_424 * _460.x, Material.Material_VectorExpressions[6].xyz * _460.y) * Material.Material_ScalarExpressions[3].w) * _406);
            float _481 = dot(_480, _480);
            float3 _500 = spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_480 / float3(sqrt(_481)), 0.0), bool4(_481 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_481 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_410, _410)), _409) - _346;
            float _529 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_347, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[4].y) / Material.Material_ScalarExpressions[4].z, 0.0), 1.0);
            float _530 = spvFMul(_529, _529);
            float3 _542 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_354, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[4].x) - spvFMul(Material.Material_ScalarExpressions[4].w, _530))).xy, level(-1.0)).xyz) * 2.0;
            float3 _563 = spvFAdd(_500, spvFAdd(_380 * spvFMul(Material.Material_ScalarExpressions[5].x, spvFAdd(_542.z, 1.0)), spvFAdd(_380 * _542.x, (cross(_380, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[5].y) * _542.y) * Material.Material_ScalarExpressions[5].z) * _530);
            float _564 = dot(_563, _563);
            float3 _585 = -spvFMulMatrixVector(_402, float3(1.0, 0.0, 0.0));
            float3 _589 = -spvFMulMatrixVector(_402, float3(0.0, 1.0, 0.0));
            float3 _593 = -spvFMulMatrixVector(_402, float3(0.0, 0.0, 1.0));
            _598 = spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_563 / float3(sqrt(_564)), 0.0), bool4(_564 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_564 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_500, _500)), _346) - _347, float3(sqrt(dot(_585, _585)), sqrt(dot(_589, _589)), sqrt(dot(_593, _593))));
            break;
        }
    }
    float3 _599 = spvFAdd(_310, _598);
    float4 _605 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_599.x, _599.y, _599.z, _309.w));
    float4 _616;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_605.z < 0.0))
    {
        float4 _614 = _605;
        _614.z = 9.9999999747524270787835121154785e-07;
        float4 _615 = _614;
        _615.w = 1.0;
        _616 = _615;
    }
    else
    {
        _616 = _605;
    }
    float _622 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _327));
    spvUnsafeArray<float4, 1> _650 = { float4(_320.x, _320.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_195[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_327, spvFMul(_163, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_137 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _278;
    out_var_TEXCOORD0 = _650;
    out.out_var_TEXCOORD6 = _616.z;
    out.out_var_TEXCOORD8 = fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_622) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_622, _622), 0.0, 1.0)) / _622) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x);
    out.out_var_TEXCOORD7 = _599.xyz;
    out.gl_Position = _616;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

