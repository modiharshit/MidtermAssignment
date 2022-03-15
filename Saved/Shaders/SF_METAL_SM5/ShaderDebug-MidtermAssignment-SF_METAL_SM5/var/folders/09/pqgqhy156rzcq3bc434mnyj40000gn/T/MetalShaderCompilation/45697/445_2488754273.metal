

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct PSMain_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment PSMain_out Main_000001bd_94576061()
{
    PSMain_out out = {};
    out.out_var_SV_Target0 = float4(0.0);
    return out;
}

