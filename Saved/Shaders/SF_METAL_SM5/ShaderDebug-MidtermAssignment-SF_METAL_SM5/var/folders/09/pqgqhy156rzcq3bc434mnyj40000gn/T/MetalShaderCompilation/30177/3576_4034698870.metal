

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

fragment MainPixelShader_out Main_00000df8_f07c9e76(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float3 _56 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _57 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _70 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _71 = dfdx(_70);
    float2 _72 = dfdy(_70);
    float2 _74 = _71 * _72.yx;
    float _80 = fast::min(abs(_74.x - _74.y) / fast::max(length(cross(_56, _57)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _97;
    float _98;
    if (_80 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _91 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _92 = _80 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _97 = float4(_92 / _91, (_91 - _92) / _91, 0.0, 1.0);
        _98 = _92;
    }
    else
    {
        float _85 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _86 = _80 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _97 = float4(0.0, _86 / _85, (_85 - _86) / _85, 1.0);
        _98 = _86;
    }
    float _100 = _98 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_97 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_100, _100, _100, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

