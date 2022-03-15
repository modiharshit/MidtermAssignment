

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

struct type_TranslucentDepthPass
{
    char _m0_pad[180];
    float TranslucentDepthPass_InvMaxSubjectDepth;
};

struct type_Globals
{
    float TranslucentShadowStartOffset;
};

constant float _50 = {};

struct MainOpacityPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct MainOpacityPS_in
{
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainOpacityPS_out Main_00000a01_4e73926a(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _59 = float4(_50, _50, gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float _84;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _84 = _59.w;
                break;
            }
            else
            {
                float _68 = _59.z;
                _84 = ((_68 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_68 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _99 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _105 = (-2.0) * log(fast::max(1.0 - (fast::clamp(in.in_var_TEXCOORD2.w * fast::min(fast::max((1000000.0 - _84) * 0.01666666753590106964111328125, 0.0), 1.0), 0.0, 1.0) * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_105, cos(_99) * _105);
    out.out_var_SV_Target1 = float4(0.0, sin(_99) * _105);
    return out;
}

