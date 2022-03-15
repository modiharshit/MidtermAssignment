

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct MainPixelShader_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment MainPixelShader_out Main_000001ce_9ea73c08()
{
    MainPixelShader_out out = {};
    out.out_var_SV_Target0 = float4(0.5);
    return out;
}

