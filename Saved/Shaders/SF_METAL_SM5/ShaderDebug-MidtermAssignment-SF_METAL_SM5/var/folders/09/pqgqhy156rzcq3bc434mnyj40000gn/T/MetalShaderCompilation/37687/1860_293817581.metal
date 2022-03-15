

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
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_TEXCOORD3 [[user(locn3)]];
    float in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainOpacityPS_out Main_00000744_11834ced(MainOpacityPS_in in [[stage_in]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]])
{
    MainOpacityPS_out out = {};
    float _47 = in.in_var_TEXCOORD2.x - 0.5;
    float _50 = in.in_var_TEXCOORD2.y - 0.5;
    float _53 = 1.0 - ((_47 * _47) + (_50 * _50));
    float3 _69 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _75 = (-2.0) * log(fast::max(1.0 - (fast::clamp(fast::min(fast::max((_53 <= 0.0) ? 0.0 : pow(_53, 30.0), 0.0), 1.0) * in.in_var_TEXCOORD3.w, 0.0, 1.0) * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_75, cos(_69) * _75);
    out.out_var_SV_Target1 = float4(0.0, sin(_69) * _75);
    return out;
}

