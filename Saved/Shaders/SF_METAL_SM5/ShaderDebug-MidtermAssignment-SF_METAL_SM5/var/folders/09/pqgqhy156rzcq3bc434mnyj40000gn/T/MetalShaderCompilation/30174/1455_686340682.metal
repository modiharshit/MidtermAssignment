

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
    float4 in_var_COLOR1 [[user(locn2)]];
    float in_var_TEXCOORD6 [[user(locn4)]];
    float in_var_TEXCOORD8 [[user(locn5)]];
};

fragment Main_out Main_000005af_28e8ba4a(Main_in in [[stage_in]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(0)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _56 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _56) : (in.in_var_COLOR1.w < _56)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    out.out_var_SV_Target0 = float4(0.0);
    out.gl_FragDepth = fast::clamp((in.in_var_TEXCOORD6 * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + in.in_var_TEXCOORD8, 0.0, 1.0);
    return out;
}

