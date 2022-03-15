

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    float4 in_var_TEXCOORD6 [[user(locn6)]];
};

fragment MainPixelShader_out Main_00001150_aa851660(MainPixelShader_in in [[stage_in]], constant type_PrimitiveDither& PrimitiveDither [[buffer(0)]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _84 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _84) : (PrimitiveDither.PrimitiveDither_LODFactor < _84)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float2 _96 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float3 _98 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _99 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _112 = _96 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _113 = dfdx(_112);
    float2 _114 = dfdy(_112);
    float2 _116 = _113 * _114.yx;
    float _122 = fast::min(abs(_116.x - _116.y) / fast::max(length(cross(_98, _99)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _139;
    float _140;
    if (_122 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _133 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _134 = _122 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _139 = float4(_134 / _133, (_133 - _134) / _133, 0.0, 1.0);
        _140 = _134;
    }
    else
    {
        float _127 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _128 = _122 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _139 = float4(0.0, _128 / _127, (_127 - _128) / _127, 1.0);
        _140 = _128;
    }
    float _142 = _140 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_96 * _Globals.LightMapResolutionScale)) * ((((((((_139 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_142, _142, _142, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

