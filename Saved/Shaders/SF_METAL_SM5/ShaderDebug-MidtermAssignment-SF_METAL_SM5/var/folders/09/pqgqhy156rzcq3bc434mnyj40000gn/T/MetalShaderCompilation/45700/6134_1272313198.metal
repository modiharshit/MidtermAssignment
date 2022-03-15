

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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    float4 in_var_TEXCOORD4 [[user(locn4)]];
    float4 in_var_TEXCOORD6 [[user(locn7)]];
};

fragment MainPixelShader_out Main_000017f6_4bd5f56e(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(1)]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], texture2d<float> Material_Texture2D_1 [[texture(1)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], sampler Material_Texture2D_1Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _88 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _106 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _106) : (PrimitiveDither.PrimitiveDither_LODFactor < _106)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_88.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float2 _122 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float3 _124 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _125 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _138 = _122 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _139 = dfdx(_138);
    float2 _140 = dfdy(_138);
    float2 _142 = _139 * _140.yx;
    float _148 = fast::min(abs(_142.x - _142.y) / fast::max(length(cross(_124, _125)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _165;
    float _166;
    if (_148 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _159 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _160 = _148 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _165 = float4(_160 / _159, (_159 - _160) / _159, 0.0, 1.0);
        _166 = _160;
    }
    else
    {
        float _153 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _154 = _148 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _165 = float4(0.0, _154 / _153, (_153 - _154) / _153, 1.0);
        _166 = _154;
    }
    float _168 = _166 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_122 * _Globals.LightMapResolutionScale)) * ((((((((_165 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_168, _168, _168, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

