

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
    float4 in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainPixelShader_out Main_00000df8_5ddeef72(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float3 _59 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _60 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _73 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _74 = dfdx(_73);
    float2 _75 = dfdy(_73);
    float2 _77 = _74 * _75.yx;
    float _83 = fast::min(abs(_77.x - _77.y) / fast::max(length(cross(_59, _60)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _100;
    float _101;
    if (_83 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _94 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _95 = _83 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _100 = float4(_95 / _94, (_94 - _95) / _94, 0.0, 1.0);
        _101 = _95;
    }
    else
    {
        float _88 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _89 = _83 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _100 = float4(0.0, _89 / _88, (_88 - _89) / _88, 1.0);
        _101 = _89;
    }
    float _103 = _101 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_100 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_103, _103, _103, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

