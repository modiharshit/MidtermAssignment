

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

struct type_View
{
    char _m0_pad[2292];
    float View_MaterialTextureMipBias;
};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    float4 in_var_TEXCOORD6 [[user(locn5)]];
};

fragment MainPixelShader_out Main_000014b2_3611eba5(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]])
{
    MainPixelShader_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    if (((Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias)).w * in.in_var_COLOR0.w) - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _84 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _85 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _98 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _99 = dfdx(_98);
    float2 _100 = dfdy(_98);
    float2 _102 = _99 * _100.yx;
    float _108 = fast::min(abs(_102.x - _102.y) / fast::max(length(cross(_84, _85)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _125;
    float _126;
    if (_108 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _113 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _114 = _108 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _125 = float4(_114 / _113, (_113 - _114) / _113, 0.0, 1.0);
        _126 = _114;
    }
    else
    {
        float _119 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _120 = _108 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _125 = float4(0.0, _120 / _119, (_119 - _120) / _119, 1.0);
        _126 = _120;
    }
    float _128 = _126 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_125 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_128, _128, _128, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

