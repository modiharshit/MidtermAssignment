

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
    float4 in_var_TEXCOORD1 [[user(locn2)]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_COLOR1 [[user(locn4)]];
    float in_var_TEXCOORD6 [[user(locn5)]];
};

fragment MainOpacityPS_out Main_00000799_cbed3126(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]])
{
    MainOpacityPS_out out = {};
    float4 _57 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _59 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float _65 = fast::clamp(in.in_var_COLOR1.w * mix(_57, _59, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    if ((_65 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _74 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _80 = (-2.0) * log(fast::max(1.0 - (_65 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_80, cos(_74) * _80);
    out.out_var_SV_Target1 = float4(0.0, sin(_74) * _80);
    return out;
}

