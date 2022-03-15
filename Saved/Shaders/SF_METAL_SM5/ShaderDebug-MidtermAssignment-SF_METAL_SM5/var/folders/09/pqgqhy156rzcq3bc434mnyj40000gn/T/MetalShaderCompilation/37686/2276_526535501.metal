

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn3)]];
    float in_var_TEXCOORD6 [[user(locn5)]];
};

fragment MainOpacityPS_out Main_000008e4_1f624b4d(MainOpacityPS_in in [[stage_in]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]])
{
    MainOpacityPS_out out = {};
    float4 _63 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _65 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _71 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_63, _65, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    if ((_71 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _83 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * ((in.in_var_TEXCOORD6 * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth) + _Globals.TranslucentShadowStartOffset);
    float _89 = (-2.0) * log(fast::max(1.0 - (_71 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_89, cos(_83) * _89);
    out.out_var_SV_Target1 = float4(0.0, sin(_83) * _89);
    return out;
}

