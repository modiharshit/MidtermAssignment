

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

constant float _64 = {};

struct MainOpacityPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct MainOpacityPS_in
{
    float4 in_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 in_var_TEXCOORD4 [[user(locn2)]];
    float4 in_var_TEXCOORD5 [[user(locn3)]];
    float in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainOpacityPS_out Main_00000d2a_9274e394(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_1 [[texture(0)]], sampler Material_Texture2D_1Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _78 = float4(_64, _64, gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _82 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _84 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _86 = mix(_82, _84, float4(in.in_var_TEXCOORD4.x));
    float _87 = _86.x;
    float _121;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _121 = _78.w;
                break;
            }
            else
            {
                float _105 = _78.z;
                _121 = ((_105 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_105 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _127 = fast::clamp(fast::min(fast::max(fast::min(fast::max((_87 <= 0.0) ? 0.0 : pow(_87, 1.0), 0.0), 1.0) * in.in_var_TEXCOORD5.w, 0.0), 1.0) * fast::min(fast::max((1000000.0 - _121) * 0.01666666753590106964111328125, 0.0), 1.0), 0.0, 1.0);
    if ((_127 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _139 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _145 = (-2.0) * log(fast::max(1.0 - (_127 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_145, cos(_139) * _145);
    out.out_var_SV_Target1 = float4(0.0, sin(_139) * _145);
    return out;
}

