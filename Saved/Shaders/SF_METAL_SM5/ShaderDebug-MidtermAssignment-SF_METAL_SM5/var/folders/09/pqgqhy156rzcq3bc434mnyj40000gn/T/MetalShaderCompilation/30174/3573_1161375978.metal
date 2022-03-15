

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
    float4 in_var_TEXCOORD6 [[user(locn3)]];
};

fragment MainPixelShader_out Main_00000df5_453930ea(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float3 _57 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _58 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _71 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _72 = dfdx(_71);
    float2 _73 = dfdy(_71);
    float2 _75 = _72 * _73.yx;
    float _81 = fast::min(abs(_75.x - _75.y) / fast::max(length(cross(_57, _58)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _98;
    float _99;
    if (_81 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _92 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _93 = _81 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _98 = float4(_93 / _92, (_92 - _93) / _92, 0.0, 1.0);
        _99 = _93;
    }
    else
    {
        float _86 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _87 = _81 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _98 = float4(0.0, _87 / _86, (_86 - _87) / _86, 1.0);
        _99 = _87;
    }
    float _101 = _99 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_98 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_101, _101, _101, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

