

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
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
    float4 LandscapeParameters_LandscapeLightmapScaleBias;
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
    float4 LandscapeParameters_LightmapSubsectionOffsetParams;
};

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001b9a_d6b9ad37(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    float _75 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _76 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _75;
    float _79 = _75 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _80 = -_79;
    float _81 = pow(2.0, _80);
    float2 _82 = in.in_var_ATTRIBUTE0.xy * _81;
    float2 _83 = floor(_82);
    float _84 = -_75;
    float _85 = pow(2.0, _84);
    float _89 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _85;
    float _90 = _89 - 1.0;
    float _91 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _92 = _91 * _85;
    float _93 = fast::max(_92, 2.0);
    float _94 = _93 - 1.0;
    float2 _95 = float2(_90, _94);
    float2 _98 = _95 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _99 = _98.x;
    float2 _100 = float2(_99);
    float2 _101 = _83 / _100;
    float2 _102 = _83 * 0.5;
    float2 _103 = floor(_102);
    float _104 = _98.y;
    float2 _105 = float2(_104);
    float2 _106 = _103 / _105;
    float2 _110 = _101 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _112 = _110 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _113 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _114 = _112 + _113;
    float2 _119 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _120 = _114 + _119;
    float4 _124 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _120, level(_75));
    float _125 = _124.x;
    float _126 = _125 * 65280.0;
    float _127 = _124.y;
    float _128 = _127 * 255.0;
    float _129 = _126 + _128;
    float _130 = _129 - 32768.0;
    float _131 = _130 * 0.0078125;
    float2 _132 = _106 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _133 = _132 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _134 = _133 + _113;
    float2 _135 = _134 + _119;
    float _136 = _75 + 1.0;
    float4 _138 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _135, level(_136));
    float _139 = _138.x;
    float _140 = _139 * 65280.0;
    float _141 = _138.y;
    float _142 = _141 * 255.0;
    float _143 = _140 + _142;
    float _144 = _143 - 32768.0;
    float _145 = _144 * 0.0078125;
    float _146 = _101.x;
    float _147 = _101.y;
    float3 _148 = float3(_146, _147, _131);
    float _149 = _106.x;
    float _150 = _106.y;
    float3 _151 = float3(_149, _150, _145);
    float3 _152 = float3(_76);
    float3 _153 = mix(_148, _151, _152);
    float2 _155 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _156 = _155.x;
    float _157 = _155.y;
    float3 _158 = float3(_156, _157, 0.0);
    float3 _159 = _153 + _158;
    float3 _163 = _159.xxx;
    float3 _164 = Primitive.Primitive_LocalToWorld[0u].xyz * _163;
    float3 _168 = _159.yyy;
    float3 _169 = Primitive.Primitive_LocalToWorld[1u].xyz * _168;
    float3 _170 = _164 + _169;
    float3 _174 = _159.zzz;
    float3 _175 = Primitive.Primitive_LocalToWorld[2u].xyz * _174;
    float3 _176 = _170 + _175;
    float3 _180 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _181 = _176 + _180;
    float _182 = _181.x;
    float _183 = _181.y;
    float _184 = _181.z;
    float4 _185 = float4(_182, _183, _184, 1.0);
    float2 _186 = _153.xy;
    float4 _191 = float4(_185.x, _185.y, _185.z, _185.w);
    float4 _192 = View.View_TranslatedWorldToClip * _191;
    float2 _201 = ((_186 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _205 = (((_186 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _113) + _119;
    float2 _223 = ((((_186 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_186 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _155;
    out.out_var_TEXCOORD1 = float4(_201.x, _201.y, _205.x, _205.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_223.x, _223.y, float2(0.0).x, float2(0.0).y);
    out.gl_Position = _192;
    return out;
}

