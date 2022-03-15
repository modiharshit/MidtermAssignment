

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

constant float _65 = {};

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
    float in_var_TEXCOORD6 [[user(locn7)]];
};

fragment MainOpacityPS_out Main_00000cc2_0a41ff05(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_1 [[texture(0)]], sampler Material_Texture2D_1Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _79 = float4(_65, _65, gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _83 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _85 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _117;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _117 = _79.w;
                break;
            }
            else
            {
                float _101 = _79.z;
                _117 = ((_101 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_101 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _123 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * mix(_83, _85, float4(in.in_var_TEXCOORD4.x)).w, 0.0), 1.0) * fast::min(fast::max((1000000.0 - _117) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    if ((_123 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _135 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _141 = (-2.0) * log(fast::max(1.0 - (_123 * 3.0), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_141, cos(_135) * _141);
    out.out_var_SV_Target1 = float4(0.0, sin(_135) * _141);
    return out;
}

