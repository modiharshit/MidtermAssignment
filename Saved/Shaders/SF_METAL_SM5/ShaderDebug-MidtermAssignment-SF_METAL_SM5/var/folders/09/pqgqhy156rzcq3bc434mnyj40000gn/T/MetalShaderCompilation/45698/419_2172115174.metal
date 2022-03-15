

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment Main_out Main_000001a3_8177d8e6()
{
    Main_out out = {};
    out.out_var_SV_Target0 = float4(0.0);
    return out;
}

