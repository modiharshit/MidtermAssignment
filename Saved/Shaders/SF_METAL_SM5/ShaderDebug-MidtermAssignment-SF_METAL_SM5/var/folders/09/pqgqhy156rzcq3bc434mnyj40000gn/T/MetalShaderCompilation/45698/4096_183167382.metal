

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
    float4 in_var_COLOR1 [[user(locn2)]];
    float4 in_var_TEXCOORD6 [[user(locn3)]];
};

fragment MainPixelShader_out Main_00001000_0aeae996(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _71 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _71) : (in.in_var_COLOR1.w < _71)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _83 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _84 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _97 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _98 = dfdx(_97);
    float2 _99 = dfdy(_97);
    float2 _101 = _98 * _99.yx;
    float _107 = fast::min(abs(_101.x - _101.y) / fast::max(length(cross(_83, _84)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _124;
    float _125;
    if (_107 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _118 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _119 = _107 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _124 = float4(_119 / _118, (_118 - _119) / _118, 0.0, 1.0);
        _125 = _119;
    }
    else
    {
        float _112 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _113 = _107 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _124 = float4(0.0, _113 / _112, (_112 - _113) / _112, 1.0);
        _125 = _113;
    }
    float _127 = _125 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_124 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_127, _127, _127, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

