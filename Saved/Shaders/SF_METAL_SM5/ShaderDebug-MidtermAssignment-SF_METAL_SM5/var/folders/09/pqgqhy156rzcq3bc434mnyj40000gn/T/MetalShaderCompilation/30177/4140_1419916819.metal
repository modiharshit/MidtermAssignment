

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
    float4 in_var_TEXCOORD4 [[user(locn4)]];
    float4 in_var_TEXCOORD6 [[user(locn5)]];
};

fragment MainPixelShader_out Main_0000102c_54a23613(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _76 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _76) : (in.in_var_COLOR1.w < _76)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float2 _88 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float3 _90 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _91 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _104 = _88 * (_Globals.LightMapResolutionScale * 2.0);
    float2 _105 = dfdx(_104);
    float2 _106 = dfdy(_104);
    float2 _108 = _105 * _106.yx;
    float _114 = fast::min(abs(_108.x - _108.y) / fast::max(length(cross(_90, _91)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _131;
    float _132;
    if (_114 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _125 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _126 = _114 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _131 = float4(_126 / _125, (_125 - _126) / _125, 0.0, 1.0);
        _132 = _126;
    }
    else
    {
        float _119 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _120 = _114 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _131 = float4(0.0, _120 / _119, (_119 - _120) / _119, 1.0);
        _132 = _120;
    }
    float _134 = _132 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (_88 * _Globals.LightMapResolutionScale)) * ((((((((_131 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_134, _134, _134, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

