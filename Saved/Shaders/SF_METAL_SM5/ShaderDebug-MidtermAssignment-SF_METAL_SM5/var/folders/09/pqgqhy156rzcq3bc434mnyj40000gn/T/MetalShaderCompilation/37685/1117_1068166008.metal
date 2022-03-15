

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
    float in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainOpacityPS_out Main_0000045d_3faaeb78(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]])
{
    MainOpacityPS_out out = {};
    float3 _41 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    out.out_var_SV_Target0 = float4(-0.0, cos(_41) * (-0.0));
    out.out_var_SV_Target1 = float4(0.0, sin(_41) * (-0.0));
    return out;
}

