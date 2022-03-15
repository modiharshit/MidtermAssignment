

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_COLOR1 [[user(locn2)]];
};

fragment Main_out Main_000003e1_7d2587b4(Main_in in [[stage_in]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _44 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _44) : (in.in_var_COLOR1.w < _44)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    out.out_var_SV_Target0 = float4(0.0);
    return out;
}

