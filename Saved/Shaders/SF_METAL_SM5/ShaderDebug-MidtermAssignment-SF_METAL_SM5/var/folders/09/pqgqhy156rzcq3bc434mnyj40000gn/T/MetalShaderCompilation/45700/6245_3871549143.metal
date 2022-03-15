

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

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
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

struct PositionOnlyMain_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_00001865_e6c326d7(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    PositionOnlyMain_out out = {};
    float _88 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _94 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _88) : _88;
    float _105 = _88 * _88;
    float _106 = _105 * _88;
    float _108 = 3.0 * _105;
    float3 _129 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _141 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _129) * _105) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _129) * _88)) + _Globals.SplineParams[1].xyz);
    float3 _145 = normalize(cross(_Globals.SplineParams[6].xyz, _141));
    float3 _147 = normalize(cross(_141, _145));
    float2 _154 = float2(_94);
    float2 _155 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _154);
    float _166 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _94);
    float _167 = sin(_166);
    float _168 = cos(_166);
    float2 _177 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _154);
    float3x3 _191 = float3x3(float3(0.0), ((_145 * _168) - (_147 * _167)) * _177.x, ((_147 * _168) + (_145 * _167)) * _177.y) * transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3 _196 = float4x3(_191[0], _191[1], _191[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _106) - _108) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_106 - (2.0 * _105)) + _88))) + (_Globals.SplineParams[4].xyz * (_106 - _105))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _106) + _108))) + (_145 * _155.x)) + (_147 * _155.y)) * in.in_var_ATTRIBUTE0;
    float4 _220 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _196.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _196.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _196.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _241 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * _220;
    float4 _252;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_241.z < 0.0))
    {
        float4 _250 = _241;
        _250.z = 9.9999999747524270787835121154785e-07;
        float4 _251 = _250;
        _251.w = 1.0;
        _252 = _251;
    }
    else
    {
        _252 = _241;
    }
    float _258 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE2.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE2.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE2.zzz)));
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_TEXCOORD6 = _252.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_258) > 0.0) ? (sqrt(fast::clamp(1.0 - (_258 * _258), 0.0, 1.0)) / _258) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _220.xyz;
    out.gl_Position = _252;
    return out;
}

