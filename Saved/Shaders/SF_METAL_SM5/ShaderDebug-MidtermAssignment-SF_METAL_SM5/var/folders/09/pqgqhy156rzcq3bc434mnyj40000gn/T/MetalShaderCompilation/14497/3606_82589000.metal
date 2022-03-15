

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    float4 in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainPixelShader_out Main_00000e16_04ec3548(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float2 _62 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float3 _64 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _65 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _78 = _62 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _79 = dfdx(_78);
    float2 _80 = dfdy(_78);
    float2 _82 = _79 * _80.yx;
    float _88 = fast::min(abs(_82.x - _82.y) / fast::max(length(cross(_64, _65)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _105;
    float _106;
    if (_88 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _99 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _100 = _88 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _105 = float4(_100 / _99, (_99 - _100) / _99, 0.0, 1.0);
        _106 = _100;
    }
    else
    {
        float _93 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _94 = _88 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _105 = float4(0.0, _94 / _93, (_93 - _94) / _93, 1.0);
        _106 = _94;
    }
    float _108 = _106 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_62 * _Globals.LightMapResolutionScale)) * ((((((((_105 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_108, _108, _108, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

