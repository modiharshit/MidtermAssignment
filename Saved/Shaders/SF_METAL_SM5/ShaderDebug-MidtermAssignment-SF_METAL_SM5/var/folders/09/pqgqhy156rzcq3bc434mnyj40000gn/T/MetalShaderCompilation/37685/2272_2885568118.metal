

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[528];
    float4 View_InvDeviceZToWorldZTransform;
};

struct type_Globals
{
    float TranslucentShadowStartOffset;
};

constant float _49 = {};

struct MainOpacityPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct MainOpacityPS_in
{
    float4 in_var_TEXCOORD5 [[user(locn2)]];
    float in_var_TEXCOORD6 [[user(locn5)]];
};

fragment MainOpacityPS_out Main_000008e0_abfe4676(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _58 = float4(_49, _49, gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float _83;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _83 = _58.w;
                break;
            }
            else
            {
                float _67 = _58.z;
                _83 = ((_67 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_67 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _95 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _101 = (-2.0) * log(fast::max(1.0 - (fast::clamp(in.in_var_TEXCOORD5.w * fast::min(fast::max((1000000.0 - _83) * 0.01666666753590106964111328125, 0.0), 1.0), 0.0, 1.0) * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_101, cos(_95) * _101);
    out.out_var_SV_Target1 = float4(0.0, sin(_95) * _101);
    return out;
}

