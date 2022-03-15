

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn4)]];
    float in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainOpacityPS_out Main_00000cc9_6d484942(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_1 [[texture(0)]], sampler Material_Texture2D_1Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _78 = float4(_64, _64, gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _82 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _84 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _116;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _116 = _78.w;
                break;
            }
            else
            {
                float _100 = _78.z;
                _116 = ((_100 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_100 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _122 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * mix(_82, _84, float4(in.in_var_TEXCOORD10.w)).w, 0.0), 1.0) * fast::min(fast::max((1000000.0 - _116) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    if ((_122 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _134 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _140 = (-2.0) * log(fast::max(1.0 - (_122 * 3.0), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_140, cos(_134) * _140);
    out.out_var_SV_Target1 = float4(0.0, sin(_134) * _140);
    return out;
}

