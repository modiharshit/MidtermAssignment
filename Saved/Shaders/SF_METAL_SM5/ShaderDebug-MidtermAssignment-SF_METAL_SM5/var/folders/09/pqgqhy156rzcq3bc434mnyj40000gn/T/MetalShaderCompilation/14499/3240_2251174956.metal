

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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    float in_var_TEXCOORD6 [[user(locn5)]];
};

fragment MainOpacityPS_out Main_00000ca8_862e342c(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]])
{
    MainOpacityPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _63 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _68 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _69 = dfdx(_68);
    float _70 = dot(_69, _69);
    float3 _71 = dfdy(_68);
    float _72 = dot(_71, _71);
    float _80 = 1.0 / sqrt((abs(_70 - _72) > 9.9999997473787516355514526367188e-06) ? ((_70 >= _72) ? _70 : _72) : _72);
    float _88 = fast::clamp((((_63.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _80)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _80), 0.0), 1.0), 0.0, 1.0);
    if ((_88 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _97 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _103 = (-2.0) * log(fast::max(1.0 - (_88 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_103, cos(_97) * _103);
    out.out_var_SV_Target1 = float4(0.0, sin(_97) * _103);
    return out;
}

