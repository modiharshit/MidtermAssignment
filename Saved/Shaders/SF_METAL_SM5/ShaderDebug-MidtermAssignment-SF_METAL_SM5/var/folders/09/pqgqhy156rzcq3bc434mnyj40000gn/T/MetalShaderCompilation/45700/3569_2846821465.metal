

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_LightmapDensityPass
{
    char _m0_pad[112];
    float4 LightmapDensityPass_LightMapDensity;
    float4 LightmapDensityPass_DensitySelectedColor;
    float4 LightmapDensityPass_VertexMappedColor;
};

struct type_Globals
{
    float2 LightMapResolutionScale;
    float3 BuiltLightingAndSelectedFlags;
    float4 LightMapDensityDisplayOptions;
};

struct MainPixelShader_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPixelShader_in
{
    float4 in_var_TEXCOORD6 [[user(locn2)]];
};

fragment MainPixelShader_out Main_00000df1_a9af0c59(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float3 _54 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _55 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _68 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _69 = dfdx(_68);
    float2 _70 = dfdy(_68);
    float2 _72 = _69 * _70.yx;
    float _78 = fast::min(abs(_72.x - _72.y) / fast::max(length(cross(_54, _55)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _95;
    float _96;
    if (_78 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _89 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _90 = _78 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _95 = float4(_90 / _89, (_89 - _90) / _89, 0.0, 1.0);
        _96 = _90;
    }
    else
    {
        float _83 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _84 = _78 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _95 = float4(0.0, _84 / _83, (_83 - _84) / _83, 1.0);
        _96 = _84;
    }
    float _98 = _96 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_95 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_98, _98, _98, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

