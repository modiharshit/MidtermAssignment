

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
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
    float4 in_var_TEXCOORD4 [[user(locn5)]];
    float4 in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainPixelShader_out Main_000016ef_c2bfa6d5(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], texture2d<float> Material_Texture2D_1 [[texture(1)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], sampler Material_Texture2D_1Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _85 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _99 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _99) : (in.in_var_COLOR1.w < _99)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _85.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float2 _115 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float3 _117 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _118 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _131 = _115 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _132 = dfdx(_131);
    float2 _133 = dfdy(_131);
    float2 _135 = _132 * _133.yx;
    float _141 = fast::min(abs(_135.x - _135.y) / fast::max(length(cross(_117, _118)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _158;
    float _159;
    if (_141 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _152 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _153 = _141 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _158 = float4(_153 / _152, (_152 - _153) / _152, 0.0, 1.0);
        _159 = _153;
    }
    else
    {
        float _146 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _147 = _141 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _158 = float4(0.0, _147 / _146, (_146 - _147) / _146, 1.0);
        _159 = _147;
    }
    float _161 = _159 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_115 * _Globals.LightMapResolutionScale)) * ((((((((_158 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_161, _161, _161, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

