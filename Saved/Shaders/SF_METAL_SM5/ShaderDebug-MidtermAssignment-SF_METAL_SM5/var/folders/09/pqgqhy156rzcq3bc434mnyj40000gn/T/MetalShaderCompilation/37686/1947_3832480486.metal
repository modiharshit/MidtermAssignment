

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

fragment MainOpacityPS_out Main_0000079b_e46f02e6(MainOpacityPS_in in [[stage_in]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]])
{
    MainOpacityPS_out out = {};
    float2 _51 = in.in_var_TEXCOORD2.xy - float2(0.5);
    float _57 = fast::min(fast::max(1.0 - (sqrt(dot(_51, _51)) * 2.0), 0.0), 1.0);
    float _63 = fast::clamp(in.in_var_TEXCOORD3.w * ((_57 <= 0.0) ? 0.0 : pow(_57, 4.0)), 0.0, 1.0);
    if ((_63 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _75 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _81 = (-2.0) * log(fast::max(1.0 - (_63 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_81, cos(_75) * _81);
    out.out_var_SV_Target1 = float4(0.0, sin(_75) * _81);
    return out;
}

