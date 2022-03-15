

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_Globals
{
    float TranslucentShadowStartOffset;
};

struct MainOpacityPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct MainOpacityPS_in
{
    float in_var_TEXCOORD6 [[user(locn3)]];
};

fragment MainOpacityPS_out Main_000004a5_17ba0954(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]])
{
    MainOpacityPS_out out = {};
    float3 _38 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    out.out_var_SV_Target0 = float4(0.3250378072261810302734375, cos(_38) * 0.3250378072261810302734375);
    out.out_var_SV_Target1 = float4(0.0, sin(_38) * 0.3250378072261810302734375);
    return out;
}

