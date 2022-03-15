

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

fragment MainPixelShader_out Main_00000df5_90453e82(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float3 _55 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _56 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _69 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _70 = dfdx(_69);
    float2 _71 = dfdy(_69);
    float2 _73 = _70 * _71.yx;
    float _79 = fast::min(abs(_73.x - _73.y) / fast::max(length(cross(_55, _56)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _96;
    float _97;
    if (_79 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _90 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _91 = _79 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _96 = float4(_91 / _90, (_90 - _91) / _90, 0.0, 1.0);
        _97 = _91;
    }
    else
    {
        float _84 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _85 = _79 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _96 = float4(0.0, _85 / _84, (_84 - _85) / _84, 1.0);
        _97 = _85;
    }
    float _99 = _97 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_96 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_99, _99, _99, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

