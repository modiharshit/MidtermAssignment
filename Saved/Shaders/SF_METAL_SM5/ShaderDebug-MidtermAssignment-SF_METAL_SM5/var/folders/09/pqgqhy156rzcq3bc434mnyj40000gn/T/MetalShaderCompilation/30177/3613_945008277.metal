

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
    float4 in_var_TEXCOORD3 [[user(locn3)]];
    float4 in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainPixelShader_out Main_00000e1d_3853ae95(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float2 _58 = in.in_var_TEXCOORD3.xy * float2(1.0, 0.5);
    float3 _60 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _61 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _74 = _58 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _75 = dfdx(_74);
    float2 _76 = dfdy(_74);
    float2 _78 = _75 * _76.yx;
    float _84 = fast::min(abs(_78.x - _78.y) / fast::max(length(cross(_60, _61)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _101;
    float _102;
    if (_84 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _95 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _96 = _84 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _101 = float4(_96 / _95, (_95 - _96) / _95, 0.0, 1.0);
        _102 = _96;
    }
    else
    {
        float _89 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _90 = _84 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _101 = float4(0.0, _90 / _89, (_89 - _90) / _89, 1.0);
        _102 = _90;
    }
    float _104 = _102 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_58 * _Globals.LightMapResolutionScale)) * ((((((((_101 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_104, _104, _104, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

