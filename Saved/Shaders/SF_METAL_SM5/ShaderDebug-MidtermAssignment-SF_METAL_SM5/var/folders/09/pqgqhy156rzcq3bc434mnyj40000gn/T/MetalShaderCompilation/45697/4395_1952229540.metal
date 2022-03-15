

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
    float4 in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainPixelShader_out Main_0000112b_745ca8a4(MainPixelShader_in in [[stage_in]], constant type_PrimitiveDither& PrimitiveDither [[buffer(0)]], constant type_LightmapDensityPass& LightmapDensityPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> LightmapDensityPass_GridTexture [[texture(0)]], sampler LightmapDensityPass_GridTextureSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _81 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _81) : (PrimitiveDither.PrimitiveDither_LODFactor < _81)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _93 = dfdx(in.in_var_TEXCOORD6.xyz);
    float3 _94 = dfdy(in.in_var_TEXCOORD6.xyz);
    float2 _107 = float2(0.100000001490116119384765625) * (_Globals.LightMapResolutionScale * 2.0);
    float2 _108 = dfdx(_107);
    float2 _109 = dfdy(_107);
    float2 _111 = _108 * _109.yx;
    float _117 = fast::min(abs(_111.x - _111.y) / fast::max(length(cross(_93, _94)), 9.9999999392252902907785028219223e-09), LightmapDensityPass.LightmapDensityPass_LightMapDensity.w);
    float4 _134;
    float _135;
    if (_117 > LightmapDensityPass.LightmapDensityPass_LightMapDensity.z)
    {
        float _128 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        float _129 = _117 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.z;
        _134 = float4(_129 / _128, (_128 - _129) / _128, 0.0, 1.0);
        _135 = _129;
    }
    else
    {
        float _122 = LightmapDensityPass.LightmapDensityPass_LightMapDensity.z - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        float _123 = _117 - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y;
        _134 = float4(0.0, _123 / _122, (_122 - _123) / _122, 1.0);
        _135 = _123;
    }
    float _137 = _135 / (LightmapDensityPass.LightmapDensityPass_LightMapDensity.w - LightmapDensityPass.LightmapDensityPass_LightMapDensity.y);
    out.out_var_SV_Target0 = LightmapDensityPass_GridTexture.sample(LightmapDensityPass_GridTextureSampler, (float2(0.100000001490116119384765625) * _Globals.LightMapResolutionScale)) * ((((((((_134 * _Globals.LightMapDensityDisplayOptions.y) + (float4(_137, _137, _137, 1.0) * _Globals.LightMapDensityDisplayOptions.x)) * _Globals.BuiltLightingAndSelectedFlags.x) + _Globals.BuiltLightingAndSelectedFlags.yyyy) * _Globals.LightMapDensityDisplayOptions.z) + (LightmapDensityPass.LightmapDensityPass_VertexMappedColor * _Globals.LightMapDensityDisplayOptions.w)) * (1.0 - _Globals.BuiltLightingAndSelectedFlags.z)) + (LightmapDensityPass.LightmapDensityPass_DensitySelectedColor * _Globals.BuiltLightingAndSelectedFlags.z));
    return out;
}

