

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_TranslucentDepthPass
{
    char _m0_pad[180];
    float TranslucentDepthPass_InvMaxSubjectDepth;
};

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

fragment MainOpacityPS_out Main_000005ca_f0aeec2a(MainOpacityPS_in in [[stage_in]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]])
{
    MainOpacityPS_out out = {};
    float3 _49 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    out.out_var_SV_Target0 = float4(1.38629436492919921875, cos(_49) * 1.38629436492919921875);
    out.out_var_SV_Target1 = float4(0.0, sin(_49) * 1.38629436492919921875);
    return out;
}

