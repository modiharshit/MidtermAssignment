

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
    float4 in_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 in_var_TEXCOORD4 [[user(locn1)]];
    float4 in_var_TEXCOORD5 [[user(locn2)]];
    float in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainOpacityPS_out Main_000008dd_c99ced0f(MainOpacityPS_in in [[stage_in]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]])
{
    MainOpacityPS_out out = {};
    float4 _64 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _66 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _72 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_64, _66, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    if ((_72 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _84 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _90 = (-2.0) * log(fast::max(1.0 - (_72 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_90, cos(_84) * _90);
    out.out_var_SV_Target1 = float4(0.0, sin(_84) * _90);
    return out;
}

