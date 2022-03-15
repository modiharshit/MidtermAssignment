

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
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_00001738_c5848ce9(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    PositionOnlyMain_out out = {};
    float _82 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _88 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _82) : _82;
    float _99 = _82 * _82;
    float _100 = _99 * _82;
    float _102 = 3.0 * _99;
    float3 _123 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _135 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _123) * _99) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _123) * _82)) + _Globals.SplineParams[1].xyz);
    float3 _139 = normalize(cross(_Globals.SplineParams[6].xyz, _135));
    float3 _141 = normalize(cross(_135, _139));
    float2 _148 = float2(_88);
    float2 _149 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _148);
    float _160 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _88);
    float _161 = sin(_160);
    float _162 = cos(_160);
    float2 _171 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _148);
    float3x3 _185 = float3x3(float3(0.0), ((_139 * _162) - (_141 * _161)) * _171.x, ((_141 * _162) + (_139 * _161)) * _171.y) * transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3 _190 = float4x3(_185[0], _185[1], _185[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _100) - _102) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_100 - (2.0 * _99)) + _82))) + (_Globals.SplineParams[4].xyz * (_100 - _99))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _100) + _102))) + (_139 * _149.x)) + (_141 * _149.y)) * in.in_var_ATTRIBUTE0;
    float4 _235 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4((((Primitive.Primitive_LocalToWorld[0].xyz * _190.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _190.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _190.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _246;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_235.z < 0.0))
    {
        float4 _244 = _235;
        _244.z = 9.9999999747524270787835121154785e-07;
        float4 _245 = _244;
        _245.w = 1.0;
        _246 = _245;
    }
    else
    {
        _246 = _235;
    }
    float _252 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE2.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE2.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE2.zzz)));
    float4 _277 = _246;
    _277.z = ((_246.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_252) > 0.0) ? (sqrt(fast::clamp(1.0 - (_252 * _252), 0.0, 1.0)) / _252) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _246.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _277;
    return out;
}

