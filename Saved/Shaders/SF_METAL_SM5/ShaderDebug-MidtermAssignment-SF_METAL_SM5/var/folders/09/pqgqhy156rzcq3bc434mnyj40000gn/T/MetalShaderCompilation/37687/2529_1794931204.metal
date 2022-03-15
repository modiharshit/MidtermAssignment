

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

struct type_Globals
{
    float TranslucentShadowStartOffset;
};

struct MainOpacityPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct MainOpacityPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainOpacityPS_out Main_000009e1_6afc7a04(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]])
{
    MainOpacityPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float _47 = in_var_TEXCOORD0[0].x - 0.5;
    float _50 = in_var_TEXCOORD0[0].y - 0.5;
    float _53 = 1.0 - ((_47 * _47) + (_50 * _50));
    float3 _64 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _70 = (-2.0) * log(fast::max(1.0 - (fast::clamp(fast::min(fast::max((_53 <= 0.0) ? 0.0 : pow(_53, 30.0), 0.0), 1.0), 0.0, 1.0) * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_70, cos(_64) * _70);
    out.out_var_SV_Target1 = float4(0.0, sin(_64) * _70);
    return out;
}

