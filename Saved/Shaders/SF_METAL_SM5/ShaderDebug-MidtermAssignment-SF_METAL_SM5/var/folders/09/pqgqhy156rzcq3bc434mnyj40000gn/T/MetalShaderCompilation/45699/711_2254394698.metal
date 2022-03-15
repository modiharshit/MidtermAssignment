

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
    float4 in_var_HIT_PROXY_ID [[user(locn3)]];
};

fragment Main_out Main_000002c7_865f554a(Main_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]])
{
    Main_out out = {};
    out.out_var_SV_Target0 = _Globals.HitProxyId + in.in_var_HIT_PROXY_ID;
    return out;
}
