

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

constant float3x3 _112 = {};
constant float4 _113 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD15 [[user(locn2)]];
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

vertex Main_out Main_00003e3e_a40b98ea(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Material& Material [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], sampler Material_Texture2D_2Sampler [[sampler(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _125 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _126 = 3u * _125;
    float4 _128 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_126));
    float4 _130 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_126 + 1u)));
    float4 _132 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_126 + 2u)));
    float4 _134 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_125));
    uint _138 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _139 = 2u * _138;
    float4 _144 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_139 + 1u)));
    float _145 = _144.w;
    float3 _146 = _144.xyz;
    float3 _148 = cross(_146, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_139)).xyz) * _145;
    float3x3 _151 = _112;
    _151[0] = cross(_148, _146) * _145;
    float3x3 _152 = _151;
    _152[1] = _148;
    float3x3 _153 = _152;
    _153[2] = _146;
    float3x3 _167 = spvFMulMatrixMatrix(float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz), float3x3(_128.xyz, _130.xyz, _132.xyz));
    float3x3 _170 = _167;
    _170[0] = normalize(_167[0]);
    float3x3 _173 = _170;
    _173[1] = normalize(_167[1]);
    float3x3 _176 = _173;
    _176[2] = normalize(_167[2]);
    float3x3 _177 = spvFMulMatrixMatrix(_176, _153);
    float _183 = trunc(spvFMul(_128.w, 0.00390625));
    float _184 = _134.w;
    float4 _185 = _113;
    _185.x = _184;
    float3 _190 = spvFAdd(_134.xyz, _Globals.InstancingOffset.xyz);
    float3 _199 = spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _190.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _190.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _190.yyy))), Primitive.Primitive_LocalToWorld[3].xyz);
    float4 _210 = _185;
    _210.y = 1.0 - fast::clamp(spvFMul(length(spvFAdd(_199, View.View_PreViewTranslation)) - _Globals.InstancingFadeOutParams.x, _Globals.InstancingFadeOutParams.y), 0.0, 1.0);
    float _254 = fma(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _184, length(_199 - _Globals.InstancingWorldViewOriginZero.xyz))) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginZero.w, spvFMul(dot(select(float3(0.0), float3(1.0), float3(fma(_Globals.InstancingViewZCompareZero.w, _184, length(_199 - _Globals.InstancingWorldViewOriginOne.xyz))) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz), _Globals.InstancingWorldViewOriginOne.w));
    float4 _255 = _210;
    _255.w = _254;
    float _259 = spvFMul(fma(_Globals.InstancingFadeOutParams.z, _183, spvFMul(_Globals.InstancingFadeOutParams.w, 1.0 - _183)), float(abs(_254) < 0.999000012874603271484375));
    float4 _260 = _255;
    _260.z = _259;
    float4x4 _277 = float4x4(float4(_128.xyz, 0.0), float4(_130.xyz, 0.0), float4(_132.xyz, 0.0), float4(_134.xyz, 1.0));
    float4 _278 = spvFMulMatrixVector(_277, in.in_var_ATTRIBUTE0);
    float4 _291 = float4(spvFAdd(fma(Primitive.Primitive_LocalToWorld[2].xyz, _278.zzz, fma(Primitive.Primitive_LocalToWorld[0].xyz, _278.xxx, spvFMul(Primitive.Primitive_LocalToWorld[1].xyz, _278.yyy))), spvFAdd(Primitive.Primitive_LocalToWorld[3].xyz, View.View_PreViewTranslation)), 1.0) * _259;
    float3 _292 = _291.xyz;
    float4x4 _293 = spvFMulMatrixMatrix(Primitive.Primitive_LocalToWorld, _277);
    uint _296 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _302 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_296 * _138) + min(0u, (_296 - 1u)))));
    float3 _303 = _177[2];
    float3 _476;
    switch (0u)
    {
        default:
        {
            if (_259 < 1.0)
            {
                _476 = float3(0.0);
                break;
            }
            float3 _310 = spvFMulMatrixVector(_293, float4(0.0, 0.0, 0.0, 1.0)).xyz;
            float3 _311 = _310 - View.View_WorldCameraOrigin;
            float3 _315 = _311 / float3(sqrt(dot(_311, _311)));
            float _319 = dot(Primitive.Primitive_ObjectOrientation.xyz, _315);
            float3 _321 = _315 - (Primitive.Primitive_ObjectOrientation.xyz * _319);
            float _326 = dot(_321 / float3(sqrt(dot(_321, _321))), _303);
            float _341 = spvFMul(_319, _319);
            float _342 = spvFMul(_341, _341);
            float3 _348 = _292 - View.View_PreViewTranslation;
            float3 _349 = _348 - _310;
            float _393 = fast::min(fast::max((((spvFMulMatrixVector(Primitive.Primitive_WorldToLocal, float4(_348, 1.0)).xyz - Primitive.Primitive_LocalObjectBoundsMin) / (Primitive.Primitive_LocalObjectBoundsMax - Primitive.Primitive_LocalObjectBoundsMin)).z - Material.Material_ScalarExpressions[1].w) / Material.Material_ScalarExpressions[2].x, 0.0), 1.0);
            float _394 = spvFMul(_393, _393);
            float3 _408 = spvFAdd(float3(-0.5), Material_Texture2D_2.sample(Material_Texture2D_2Sampler, spvFAdd(_310 * Material.Material_ScalarExpressions[1].y, float3(-1.0, 0.0, 0.0) * (spvFMul(View.View_GameTime, Material.Material_ScalarExpressions[1].z) - spvFMul(Material.Material_ScalarExpressions[2].y, _394))).xy, level(-1.0)).xyz) * 2.0;
            float3 _414 = select(float4(1.0, 0.0, 0.0, 1.0), select(float4(1.0, 0.0, 0.0, 1.0), Material.Material_VectorExpressions[5], bool4(Material.Material_ScalarExpressions[0].w >= 9.9999999747524270787835121154785e-07)), bool4(abs(Material.Material_ScalarExpressions[0].w - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz;
            float3 _430 = spvFAdd(_349, spvFAdd(_414 * spvFMul(Material.Material_ScalarExpressions[2].z, spvFAdd(_408.z, 1.0)), spvFAdd(_414 * _408.x, (cross(_414, float3(0.0, 0.0, 1.0)) * Material.Material_ScalarExpressions[2].w) * _408.y) * Material.Material_ScalarExpressions[3].x) * _394);
            float _431 = dot(_430, _430);
            float3x3 _457 = float3x3(_293[0].xyz, _293[1].xyz, _293[2].xyz);
            float3 _459 = -spvFMulMatrixVector(_457, float3(1.0, 0.0, 0.0));
            float3 _463 = -spvFMulMatrixVector(_457, float3(0.0, 1.0, 0.0));
            float3 _467 = -spvFMulMatrixVector(_457, float3(0.0, 0.0, 1.0));
            _476 = select(_348 * (-1.0), spvFMul(spvFAdd(select(float4(0.0, 0.0, 0.0, 1.0), select(float4(0.0, 0.0, 0.0, 1.0), float4(_430 / float3(sqrt(_431)), 0.0), bool4(_431 >= 9.9999999747524270787835121154785e-07)), bool4(abs(_431 - 9.9999999747524270787835121154785e-07) > 9.9999997473787516355514526367188e-06)).xyz * sqrt(dot(_349, _349)), _310) - _348, float3(sqrt(dot(_459, _459)), sqrt(dot(_463, _463)), sqrt(dot(_467, _467)))), bool3(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_326, _326), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _303).z, spvFMul(_342, _342)), 0.0199999995529651641845703125), 0.0, 1.0) >= 0.100000001490116119384765625));
            break;
        }
    }
    float3 _477 = spvFAdd(_292, _476);
    float4 _483 = spvFMulMatrixVector(ShadowDepthPass.ShadowDepthPass_ProjectionMatrix, float4(_477.x, _477.y, _477.z, _291.w));
    float4 _494;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_483.z < 0.0))
    {
        float4 _492 = _483;
        _492.z = 9.9999999747524270787835121154785e-07;
        float4 _493 = _492;
        _493.w = 1.0;
        _494 = _493;
    }
    else
    {
        _494 = _483;
    }
    float _500 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _303));
    float4 _523 = _494;
    _523.z = spvFMul(fma(_494.z, ShadowDepthPass.ShadowDepthPass_ShadowParams.w, fma(ShadowDepthPass.ShadowDepthPass_ShadowParams.y, fast::clamp((abs(_500) > 0.0) ? (sqrt(fast::clamp(1.0 - spvFMul(_500, _500), 0.0, 1.0)) / _500) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z), ShadowDepthPass.ShadowDepthPass_ShadowParams.x)), _494.w);
    float3 _526 = spvFMulMatrixVector(_293, float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float3 _530 = _526 / float3(sqrt(dot(_526, _526)));
    float _534 = dot(Primitive.Primitive_ObjectOrientation.xyz, _530);
    float3 _536 = _530 - (Primitive.Primitive_ObjectOrientation.xyz * _534);
    float _541 = dot(_536 / float3(sqrt(dot(_536, _536))), _303);
    float _556 = spvFMul(_534, _534);
    float _557 = spvFMul(_556, _556);
    float2 _563 = float2(fast::clamp(spvFAdd(mix(spvFMul(spvFMul(_541, _541), Material.Material_ScalarExpressions[0].z), spvFMulMatrixVector(float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz), _303).z, spvFMul(_557, _557)), 0.0199999995529651641845703125), 0.0, 1.0));
    float4 _573 = float4(_303, spvFMul(_145, Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w));
    spvUnsafeArray<float4, 1> _574 = { float4(_302.x, _302.y, _563.x, _563.y) };
    out.out_var_TEXCOORD10_centroid = float4(_177[0], 0.0);
    out.out_var_TEXCOORD11_centroid = _573;
    out.out_var_TEXCOORD15 = _573;
    out.out_var_COLOR1 = _260;
    out_var_TEXCOORD0 = _574;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _477.xyz;
    out.gl_Position = _523;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

