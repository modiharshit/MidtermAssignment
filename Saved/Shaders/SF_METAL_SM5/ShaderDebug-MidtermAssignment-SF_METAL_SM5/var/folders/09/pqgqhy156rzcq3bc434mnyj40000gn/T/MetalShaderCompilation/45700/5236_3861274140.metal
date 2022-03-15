

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
    float4 in_var_TEXCOORD1_0 [[user(locn2)]];
    float4 in_var_TEXCOORD6 [[user(locn3)]];
};

fragment MainPixelShader_out Main_00001474_e6265e1c(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]])
{
    MainPixelShader_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD1 = {};
    in_var_TEXCOORD1[0] = in.in_var_TEXCOORD1_0;
    if ((Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y), bias(View.View_MaterialTextureMipBias)).w - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _78 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _79 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _92 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _93 = dfdx(_92);
    float2 _94 = dfdy(_92);
    float2 _96 = _93 * _94.yx;
    float _102 = fast::min(abs(_96.x - _96.y) / fast::max(length(cross(_78, _79)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _119;
    float _120;
    if (_102 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _107 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _108 = _102 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _119 = float4(_108 / _107, (_107 - _108) / _107, 0.0, 1.0);
        _120 = _108;
    }
    else
    {
        float _113 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _114 = _102 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _119 = float4(0.0, _114 / _113, (_113 - _114) / _113, 1.0);
        _120 = _114;
    }
    float _122 = _120 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_119 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_122, _122, _122, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

