

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
    float4 in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainPixelShader_out Main_00001007_cf7b741d(MainPixelShader_in in [[stage_in]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _74 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _74) : (in.in_var_COLOR1.w < _74)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _86 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _87 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _100 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _101 = dfdx(_100);
    float2 _102 = dfdy(_100);
    float2 _104 = _101 * _102.yx;
    float _110 = fast::min(abs(_104.x - _104.y) / fast::max(length(cross(_86, _87)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _127;
    float _128;
    if (_110 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _121 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _122 = _110 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _127 = float4(_122 / _121, (_121 - _122) / _121, 0.0, 1.0);
        _128 = _122;
    }
    else
    {
        float _115 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _116 = _110 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _127 = float4(0.0, _116 / _115, (_115 - _116) / _115, 1.0);
        _128 = _116;
    }
    float _130 = _128 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_127 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_130, _130, _130, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

