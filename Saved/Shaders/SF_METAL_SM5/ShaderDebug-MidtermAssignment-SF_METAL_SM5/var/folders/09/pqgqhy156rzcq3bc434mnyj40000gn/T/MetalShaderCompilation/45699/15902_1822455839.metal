

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
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
    char _m1_pad[32];
    float3 View_PreViewTranslation;
    char _m2_pad[1144];
    float View_GameTime;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
    char _m3_pad[176];
    float4 Primitive_ObjectOrientation;
    char _m4_pad[16];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
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

constant float3x3 _113 = {};
constant float4 _114 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
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

vertex Main_out Main_00003e1e_6ca0781f(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Material& Material [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _126 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _127 = 3u * _126;
    float4 _129 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_127));
    float4 _131 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_127 + 1u)));
    float4 _133 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_127 + 2u)));
    float4 _135 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_126));
    uint _139 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _140 = 2u * _139;
    float4 _145 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_140 + 1u)));
    float _146 = _145.w;
    float3 _147 = _145.xyz;
    float3 _149 = cross(_147, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_140)).xyz) * _146;
    float3x3 _152 = _113;
    _152[0] = cross(_149, _147) * _146;
    float3x3 _153 = _152;
    _153[1] = _149;
    float3x3 _154 = _153;
    _154[2] = _147;
    float3x3 _168 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_129.xyz, _131.xyz, _133.xyz));
    float3x3 _171 = _168;
    _171[0] = normalize(_168[0]);
    float3x3 _174 = _171;
    _174[1] = normalize(_168[1]);
    float3x3 _177 = _174;
    _177[2] = normalize(_168[2]);
    float3x3 _178 = spvFMulMatrixMatrix(_177, _154);
    float _184 = trunc(spvFMul(_129.w, 0.00390625));
    float _185 = _135.w;
    float4 _186 = _114;
    _186.x = _185;
    float3 _191 = spvFAdd(_135.xyz, _Globals.InstancingOffset.xyz);
    float3 _200 = spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _191.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _191.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _191.yyy))), Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _211 = _186;
    _211.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_200, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _255 = fma(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _185, length(_200 - _Globals.InstancingWorldViewOriginZero.xyz))) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginZero.w, spvFMul(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _185, length(_200 - _Globals.InstancingWorldViewOriginOne.xyz))) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginOne.w));
    float4 _256 = _211;
    _256.w = _255;
    float _260 = spvFMul(fma(_Globals.InstancingFadeOutParams.z, _184, spvFMul(_Globals.InstancingFadeOutParams.w, 1.0 - _184)), float(abs(_255) < 0.999000012874603271484375));
    float4 _261 = _256;
    _261.z = _260;
    float4x4 _278 = float4x4(float4(_129.xyz, 0.0), float4(_131.xyz, 0.0), float4(_133.xyz, 0.0), float4(_135.xyz, 1.0));
    float4 _279 = spvFMulMatrixVector(_278, in.in_var_ATTRIBUTE0);
    float4 _292 = float4(spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _279.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _279.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _279.yyy))), spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation)), 1.0) * _260;
    float3 _293 = _292.xyz;
    float4x4 _294 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _278);
    uint _297 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _303 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_297 * _139) + min(0u, (_297 - 1u)))));
    float3 _304 = _178[2];
    float3 _477;
    switch (0u)
    {
        default:
        {
            if (_260 < 1.0)
            {
                _477 = float3(0.0);
                break;
            }
            float3 _311 = spvFMulMatrixVector(_294, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _312 = _311 - View.View_WorldCameraOrigin;
            float3 _316 = _312 / float3(sqrt(dot(_312, _312)));
            float _320 = dot(Primitive.Primitive_ObjectOrientation.xyz, _316);
            float3 _322 = _316 - (Primitive.Primitive_ObjectOrientation.xyz * _320);
            float _327 = dot(_322 / float3(sqrt(dot(_322, _322))), _304);
            float _342 = spvFMul(_320, _320);
            float _343 = spvFMul(_342, _342);
            float3 _349 = _293 - View.View_PreViewTranslation;
            float3 _350 = _349 - _311;
            float _394 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_349, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _395 = spvFMul(_394, _394);
            float3 _409 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_311 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _395))).xy, level(-1.0)).xyz) * 2.0;
            float3 _415 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _431 = spvFAdd(_350, spvFAdd(_415 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_409.z, 1.0)), spvFAdd(_415 * _409.x, (cross(_415, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _409.y) * Material.Material_ScalarExpressions[3].x) * _395);
            float _432 = dot(_431, _431);
            float3x3 _458 = float3x3(_294[0].xyz, _294[1].xyz, _294[2].xyz);
            float3 _460 = -spvFMulMatrixVector(_458, float3(1.0, 0.0, 0.0));
            float3 _464 = -spvFMulMatrixVector(_458, float3(0.0, 1.0, 0.0));
            float3 _468 = -spvFMulMatrixVector(_458, float3(0.0, 0.0, 1.0));
            _477 = select(_349 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_431 / float3(sqrt(_432)), 0.0), bool4(_432 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_432 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_350, _350)), _311) - _349, float3(sqrt(dot(_460, _460)), sqrt(dot(_464, _464)), sqrt(dot(_468, _468)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_327, _327), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _304).z, spvFMul(_343, _343)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float3 _478 = spvFAdd(_293, _477);
    float4 _484 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_478.x, _478.y, _478.z, _292.w));
    float4 _495;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_484.z < 0.0))
    {
        float4 _493 = _484;
        _493.z = 9.9999999747524270787835121154785e-07;
        float4 _494 = _493;
        _494.w = 1.0;
        _495 = _494;
    }
    else
    {
        _495 = _484;
    }
    float _501 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _304));
    float3 _521 = spvFMulMatrixVector(_294, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _525 = _521 / float3(sqrt(dot(_521, _521)));
    float _529 = dot(Primitive.Primitive_ObjectOrientation.xyz, _525);
    float3 _531 = _525 - (Primitive.Primitive_ObjectOrientation.xyz * _529);
    float _536 = dot(_531 / float3(sqrt(dot(_531, _531))), _304);
    float _551 = spvFMul(_529, _529);
    float _552 = spvFMul(_551, _551);
    float2 _558 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_536, _536), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _304).z, spvFMul(_552, _552)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _568 = float4(_304, spvFMul(_146, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _569 = { float4(_303.x, _303.y, _558.x, _558.y) };
    out.out_var_TEXCOORD10_centroid = float4(_178[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _568;
    out.out_var_TEXCOORD15 = _568;
    out.out_var_COLOR1 = _261;
    out_var_TEXCOORD0 = _569;
    out.out_var_TEXCOORD6 = _495.z;
    out.out_var_TEXCOORD8 = fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_501) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_501, _501), 0.0, 1.0)) / _501) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x);
    out.out_var_TEXCOORD7 = _478.xyz;
    out.gl_Position = _495;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

