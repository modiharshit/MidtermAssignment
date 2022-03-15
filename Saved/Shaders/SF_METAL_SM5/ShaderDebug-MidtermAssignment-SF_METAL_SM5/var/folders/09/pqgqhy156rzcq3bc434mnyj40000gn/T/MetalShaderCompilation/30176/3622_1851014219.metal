

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
    float4 in_var_TEXCOORD4 [[user(locn4)]];
    float4 in_var_TEXCOORD6 [[user(locn5)]];
};

fragment MainPixelShader_out Main_00000e26_6e543c4b(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    float2 _60 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float3 _62 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _63 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _76 = _60 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _77 = dfdx(_76);
    float2 _78 = dfdy(_76);
    float2 _80 = _77 * _78.yx;
    float _86 = fast::min(abs(_80.x - _80.y) / fast::max(length(cross(_62, _63)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _103;
    float _104;
    if (_86 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _97 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _98 = _86 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _103 = float4(_98 / _97, (_97 - _98) / _97, 0.0, 1.0);
        _104 = _98;
    }
    else
    {
        float _91 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _92 = _86 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _103 = float4(0.0, _92 / _91, (_91 - _92) / _91, 1.0);
        _104 = _92;
    }
    float _106 = _104 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_60 * _Globals.LightMapResolutionScale)) * ((((((((_103 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_106, _106, _106, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

