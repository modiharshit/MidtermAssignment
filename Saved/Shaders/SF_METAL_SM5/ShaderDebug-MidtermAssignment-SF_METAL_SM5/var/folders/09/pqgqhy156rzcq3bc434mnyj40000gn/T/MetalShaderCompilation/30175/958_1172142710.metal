

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    float in_var_TEXCOORD6 [[user(locn0)]];
    float in_var_TEXCOORD8 [[user(locn1)]];
};

fragment Main_out Main_000003be_45dd7a76(Main_in in [[stage_in]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(0)]])
{
    Main_out out = {};
    out.out_var_SV_Target0 = float4(0.0);
    out.gl_FragDepth = fast::clamp((in.in_var_TEXCOORD6 * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + in.in_var_TEXCOORD8, 0.0, 1.0);
    return out;
}

