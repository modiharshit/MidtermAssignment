

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_LightmapDensityPass
{
    char _m0_pad[112];
    float4 LightmapDensityPass_LightMapDensity;
    float4 LightmapDensityPass_DensitySelectedColor;
    float4 LightmapDensityPass_VertexMappedColor;
};

struct type_Material
{
    char _m0_pad[96];
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainPixelShader_out Main_000014f8_352b60f5(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(1)]])
{
    MainPixelShader_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    if (((mix(1.0, Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)).w, Material.Material_ScalarExpressions[0].y) * Material.Material_ScalarExpressions[0].z) - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _85 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _86 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _99 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _100 = dfdx(_99);
    float2 _101 = dfdy(_99);
    float2 _103 = _100 * _101.yx;
    float _109 = fast::min(abs(_103.x - _103.y) / fast::max(length(cross(_85, _86)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _126;
    float _127;
    if (_109 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _114 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _115 = _109 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _126 = float4(_115 / _114, (_114 - _115) / _114, 0.0, 1.0);
        _127 = _115;
    }
    else
    {
        float _120 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _121 = _109 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _126 = float4(0.0, _121 / _120, (_120 - _121) / _120, 1.0);
        _127 = _121;
    }
    float _129 = _127 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_126 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_129, _129, _129, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

