

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
    float4 in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainPixelShader_out Main_00000e1e_d91d4b33(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float2 _59 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float3 _61 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _62 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _75 = _59 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _76 = dfdx(_75);
    float2 _77 = dfdy(_75);
    float2 _79 = _76 * _77.yx;
    float _85 = fast::min(abs(_79.x - _79.y) / fast::max(length(cross(_61, _62)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _102;
    float _103;
    if (_85 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _96 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _97 = _85 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _102 = float4(_97 / _96, (_96 - _97) / _96, 0.0, 1.0);
        _103 = _97;
    }
    else
    {
        float _90 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _91 = _85 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _102 = float4(0.0, _91 / _90, (_90 - _91) / _90, 1.0);
        _103 = _91;
    }
    float _105 = _103 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_59 * _Globals.LightMapResolutionScale)) * ((((((((_102 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_105, _105, _105, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

