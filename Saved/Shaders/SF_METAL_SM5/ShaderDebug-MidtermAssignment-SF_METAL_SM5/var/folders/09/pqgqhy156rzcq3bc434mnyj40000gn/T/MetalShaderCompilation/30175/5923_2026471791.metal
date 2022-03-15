

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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_00001723_78c9816f(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    PositionOnlyMain_out out = {};
    float _83 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _89 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _83) : _83;
    float _100 = _83 * _83;
    float _101 = _100 * _83;
    float _103 = 3.0 * _100;
    float3 _124 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _136 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _124) * _100) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _124) * _83)) + _Globals.SplineParams[1].xyz);
    float3 _140 = normalize(cross(_Globals.SplineParams[6].xyz, _136));
    float3 _142 = normalize(cross(_136, _140));
    float2 _149 = float2(_89);
    float2 _150 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _149);
    float _161 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _89);
    float _162 = sin(_161);
    float _163 = cos(_161);
    float2 _172 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _149);
    float3x3 _186 = float3x3(float3(0.0), ((_140 * _163) - (_142 * _162)) * _172.x, ((_142 * _163) + (_140 * _162)) * _172.y) * transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3 _191 = float4x3(_186[0], _186[1], _186[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _101) - _103) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_101 - (2.0 * _100)) + _83))) + (_Globals.SplineParams[4].xyz * (_101 - _100))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _101) + _103))) + (_140 * _150.x)) + (_142 * _150.y)) * in.in_var_ATTRIBUTE0;
    float4 _236 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4((((Primitive.Primitive_LocalToWorld[0].xyz * _191.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _191.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _191.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _247;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_236.z < 0.0))
    {
        float4 _245 = _236;
        _245.z = 9.9999999747524270787835121154785e-07;
        float4 _246 = _245;
        _246.w = 1.0;
        _247 = _246;
    }
    else
    {
        _247 = _236;
    }
    float _253 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE2.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE2.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE2.zzz)));
    out.out_var_TEXCOORD6 = _247.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_253) > 0.0) ? (sqrt(fast::clamp(1.0 - (_253 * _253), 0.0, 1.0)) / _253) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _247;
    return out;
}

