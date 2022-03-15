

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_Globals
{
    float4 HitProxyId;
};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_COLOR1 [[user(locn2)]];
    float4 in_var_HIT_PROXY_ID [[user(locn3)]];
};

fragment Main_out Main_000004af_86bb9cda(Main_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _47 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _47) : (in.in_var_COLOR1.w < _47)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    out.out_var_SV_Target0 = _Globals.HitProxyId + in.in_var_HIT_PROXY_ID;
    return out;
}

