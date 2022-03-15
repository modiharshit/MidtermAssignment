

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

constant float _62 = {};

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

fragment MainOpacityPS_out Main_00000ba3_637c781e(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> Material_Texture2D_1 [[texture(0)]], sampler Material_Texture2D_1Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _76 = float4(_62, _62, gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _80 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _82 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _114;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _114 = _76.w;
                break;
            }
            else
            {
                float _98 = _76.z;
                _114 = ((_98 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_98 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _120 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * mix(_80, _82, float4(in.in_var_TEXCOORD4.x)).w, 0.0), 1.0) * fast::min(fast::max((1000000.0 - _114) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    if ((_120 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _129 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _135 = (-2.0) * log(fast::max(1.0 - (_120 * 3.0), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_135, cos(_129) * _135);
    out.out_var_SV_Target1 = float4(0.0, sin(_129) * _135);
    return out;
}

