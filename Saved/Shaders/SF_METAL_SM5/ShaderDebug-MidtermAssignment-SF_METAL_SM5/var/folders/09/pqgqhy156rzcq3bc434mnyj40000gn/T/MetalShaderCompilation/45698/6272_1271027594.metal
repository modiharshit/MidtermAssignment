

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
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_00001880_4bc2578a(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    PositionOnlyMain_out out = {};
    float _87 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _93 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _87) : _87;
    float _104 = _87 * _87;
    float _105 = _104 * _87;
    float _107 = 3.0 * _104;
    float3 _128 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _140 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _128) * _104) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _128) * _87)) + _Globals.SplineParams[1].xyz);
    float3 _144 = normalize(cross(_Globals.SplineParams[6].xyz, _140));
    float3 _146 = normalize(cross(_140, _144));
    float2 _153 = float2(_93);
    float2 _154 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _153);
    float _165 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _93);
    float _166 = sin(_165);
    float _167 = cos(_165);
    float2 _176 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _153);
    float3x3 _190 = float3x3(float3(0.0), ((_144 * _167) - (_146 * _166)) * _176.x, ((_146 * _167) + (_144 * _166)) * _176.y) * transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3 _195 = float4x3(_190[0], _190[1], _190[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _105) - _107) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_105 - (2.0 * _104)) + _87))) + (_Globals.SplineParams[4].xyz * (_105 - _104))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _105) + _107))) + (_144 * _154.x)) + (_146 * _154.y)) * in.in_var_ATTRIBUTE0;
    float4 _219 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _195.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _195.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _195.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _240 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * _219;
    float4 _251;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_240.z < 0.0))
    {
        float4 _249 = _240;
        _249.z = 9.9999999747524270787835121154785e-07;
        float4 _250 = _249;
        _250.w = 1.0;
        _251 = _250;
    }
    else
    {
        _251 = _240;
    }
    float _257 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE2.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE2.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE2.zzz)));
    float4 _282 = _251;
    _282.z = ((_251.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_257) > 0.0) ? (sqrt(fast::clamp(1.0 - (_257 * _257), 0.0, 1.0)) / _257) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _251.w;
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _219.xyz;
    out.gl_Position = _282;
    return out;
}

