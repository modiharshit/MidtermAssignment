

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
    char _m0_pad[2292];
    float View_MaterialTextureMipBias;
};

struct type_ShadowDepthPass
{
    char _m0_pad[432];
    float4 ShadowDepthPass_ShadowParams;
};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float gl_FragDepth [[depth(any)]];
};

struct Main_in
{
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
    float in_var_TEXCOORD6 [[user(locn5)]];
    float in_var_TEXCOORD8 [[user(locn6)]];
};

fragment Main_out Main_00000c6b_98fd4ed8(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], texture2d<float> Material_Texture2D_1 [[texture(0)]], sampler Material_Texture2D_1Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _70 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _84 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _84) : (in.in_var_COLOR1.w < _84)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((_70.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    out.out_var_SV_Target0 = float4(0.0);
    out.gl_FragDepth = fast::clamp((in.in_var_TEXCOORD6 * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + in.in_var_TEXCOORD8, 0.0, 1.0);
    return out;
}

