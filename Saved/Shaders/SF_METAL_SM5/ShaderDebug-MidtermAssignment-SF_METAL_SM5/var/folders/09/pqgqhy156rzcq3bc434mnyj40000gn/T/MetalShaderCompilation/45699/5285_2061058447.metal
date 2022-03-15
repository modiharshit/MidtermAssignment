

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_LandscapeFixedGrid
{
    float4 LandscapeFixedGrid_LodValues;
};

struct type_LandscapeParameters
{
    char _m0_pad[32];
    float4 LandscapeParameters_HeightmapUVScaleBias;
    float4 LandscapeParameters_WeightmapUVScaleBias;
    char _m2_pad[16];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float2 out_var_TEXCOORD0 [[user(locn2)]];
    float4 out_var_TEXCOORD1 [[user(locn3)]];
    float4 out_var_TEXCOORD2 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_000014a5_7ad9418f(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    MainVertexShader_out out = {};
    float _78 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float2 _86 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_78 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x)));
    float _88 = pow(2.0, -_78);
    float2 _101 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _88) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _88, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _104 = _86 / float2(_101.x);
    float2 _109 = floor(_86 * 0.5) / float2(_101.y);
    float2 _116 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _122 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _127 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_104 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _116) + _122), level(_78));
    float4 _141 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_109 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _116) + _122), level(_78 + 1.0));
    float3 _156 = mix(float3(_104, (((_127.x * 65280.0) + (_127.y * 255.0)) - 32768.0) * 0.0078125), float3(_109, (((_141.x * 65280.0) + (_141.y * 255.0)) - 32768.0) * 0.0078125), float3(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _78));
    float2 _158 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _162 = _156 + float3(_158, 0.0);
    float3 _179 = ((Primitive.Primitive_LocalToWorld[0u].xyz * _162.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _162.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _162.zzz);
    float2 _188 = _156.xy;
    float2 _201 = ((_188 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _205 = (((_188 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _116) + _122;
    float4 _215 = View.View_TranslatedWorldToClip * float4(_179 + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _224 = _215;
    _224.z = _215.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _215.w) : 0.0);
    out.gl_Position = _224;
    out.out_var_TEXCOORD6 = _215;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_179 + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PrevPreViewTranslation), 1.0);
    out.out_var_TEXCOORD0 = (_188 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _158;
    out.out_var_TEXCOORD1 = float4(_201.x, _201.y, _205.x, _205.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    return out;
}

