

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
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TEXCOORD5 [[user(locn1)]];
    float in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainOpacityPS_out Main_00000a9f_e2b71662(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]])
{
    MainOpacityPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float2 _52 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) - float2(0.5);
    float _58 = fast::min(fast::max(1.0 - (sqrt(dot(_52, _52)) * 2.0), 0.0), 1.0);
    float _64 = fast::clamp(in.in_var_TEXCOORD5.w * ((_58 <= 0.0) ? 0.0 : pow(_58, 4.0)), 0.0, 1.0);
    if ((_64 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _73 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _79 = (-2.0) * log(fast::max(1.0 - (_64 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_79, cos(_73) * _79);
    out.out_var_SV_Target1 = float4(0.0, sin(_73) * _79);
    return out;
}

