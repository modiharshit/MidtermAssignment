

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

fragment Main_out Main_0000024b_6755e40d(constant type_Globals& _Globals [[buffer(0)]])
{
    Main_out out = {};
    out.out_var_SV_Target0 = _Globals.HitProxyId;
    return out;
}

