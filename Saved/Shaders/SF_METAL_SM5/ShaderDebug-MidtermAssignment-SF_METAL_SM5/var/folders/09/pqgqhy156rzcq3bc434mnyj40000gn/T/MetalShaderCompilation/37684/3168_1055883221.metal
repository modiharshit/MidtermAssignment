

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

constant float _60 = {};

struct MainOpacityPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct MainOpacityPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD1 [[user(locn2), flat]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn5)]];
    float in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainOpacityPS_out Main_00000c60_3eef7fd5(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> Material_Texture2D_1 [[texture(0)]], sampler Material_Texture2D_1Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _75 = float4(_60, _60, gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _79 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _81 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _83 = mix(_79, _81, float4(in.in_var_TEXCOORD10.w));
    float _86 = _83.x;
    float _120;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _120 = _75.w;
                break;
            }
            else
            {
                float _104 = _75.z;
                _120 = ((_104 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_104 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _126 = fast::clamp(fast::min(fast::max(fast::min(fast::max((_86 <= 0.0) ? 0.0 : pow(_86, in.in_var_TEXCOORD1.y + 1.0), 0.0), 1.0) * in.in_var_TEXCOORD2.w, 0.0), 1.0) * fast::min(fast::max((1000000.0 - _120) * 0.01666666753590106964111328125, 0.0), 1.0), 0.0, 1.0);
    if ((_126 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _135 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _141 = (-2.0) * log(fast::max(1.0 - (_126 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_141, cos(_135) * _141);
    out.out_var_SV_Target1 = float4(0.0, sin(_135) * _141);
    return out;
}

