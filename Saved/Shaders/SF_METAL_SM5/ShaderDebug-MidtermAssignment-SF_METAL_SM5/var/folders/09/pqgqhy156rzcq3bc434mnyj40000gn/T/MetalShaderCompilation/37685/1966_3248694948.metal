

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    float4 in_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 in_var_TEXCOORD4 [[user(locn1)]];
    float4 in_var_TEXCOORD5 [[user(locn2)]];
    float in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainOpacityPS_out Main_000007ae_c1a326a4(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]])
{
    MainOpacityPS_out out = {};
    float4 _59 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _61 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _67 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_59, _61, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    if ((_67 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _76 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _82 = (-2.0) * log(fast::max(1.0 - (_67 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_82, cos(_76) * _82);
    out.out_var_SV_Target1 = float4(0.0, sin(_76) * _82);
    return out;
}

