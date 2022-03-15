

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
    float4 PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias;
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

vertex Main_out Main_00001cc0_8416023e(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    float _74 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _75 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _74;
    float _78 = _74 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _79 = -_78;
    float _80 = pow(2.0, _79);
    float2 _81 = in.in_var_ATTRIBUTE0.xy * _80;
    float2 _82 = floor(_81);
    float _83 = -_74;
    float _84 = pow(2.0, _83);
    float _88 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _84;
    float _89 = _88 - 1.0;
    float _90 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _91 = _90 * _84;
    float _92 = fast::max(_91, 2.0);
    float _93 = _92 - 1.0;
    float2 _94 = float2(_89, _93);
    float2 _97 = _94 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _98 = _97.x;
    float2 _99 = float2(_98);
    float2 _100 = _82 / _99;
    float2 _101 = _82 * 0.5;
    float2 _102 = floor(_101);
    float _103 = _97.y;
    float2 _104 = float2(_103);
    float2 _105 = _102 / _104;
    float2 _109 = _100 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _111 = _109 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _112 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _113 = _111 + _112;
    float2 _118 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _119 = _113 + _118;
    float4 _123 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _119, level(_74));
    float _124 = _123.x;
    float _125 = _124 * 65280.0;
    float _126 = _123.y;
    float _127 = _126 * 255.0;
    float _128 = _125 + _127;
    float _129 = _128 - 32768.0;
    float _130 = _129 * 0.0078125;
    float2 _131 = _105 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _132 = _131 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _133 = _132 + _112;
    float2 _134 = _133 + _118;
    float _135 = _74 + 1.0;
    float4 _137 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _134, level(_135));
    float _138 = _137.x;
    float _139 = _138 * 65280.0;
    float _140 = _137.y;
    float _141 = _140 * 255.0;
    float _142 = _139 + _141;
    float _143 = _142 - 32768.0;
    float _144 = _143 * 0.0078125;
    float _145 = _100.x;
    float _146 = _100.y;
    float3 _147 = float3(_145, _146, _130);
    float _148 = _105.x;
    float _149 = _105.y;
    float3 _150 = float3(_148, _149, _144);
    float3 _151 = float3(_75);
    float3 _152 = mix(_147, _150, _151);
    float2 _154 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _155 = _154.x;
    float _156 = _154.y;
    float3 _157 = float3(_155, _156, 0.0);
    float3 _158 = _152 + _157;
    float3 _162 = _158.xxx;
    float3 _163 = Primitive.Primitive_LocalToWorld[0u].xyz * _162;
    float3 _167 = _158.yyy;
    float3 _168 = Primitive.Primitive_LocalToWorld[1u].xyz * _167;
    float3 _169 = _163 + _168;
    float3 _173 = _158.zzz;
    float3 _174 = Primitive.Primitive_LocalToWorld[2u].xyz * _173;
    float3 _175 = _169 + _174;
    float3 _179 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _180 = _175 + _179;
    float _181 = _180.x;
    float _182 = _180.y;
    float _183 = _180.z;
    float4 _184 = float4(_181, _182, _183, 1.0);
    float2 _185 = _152.xy;
    float4 _190 = float4(_184.x, _184.y, _184.z, _184.w);
    float4 _191 = View.View_TranslatedWorldToClip * _190;
    float2 _200 = ((_185 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _204 = (((_185 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _112) + _118;
    float2 _215 = ((_185 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy);
    float2 _222 = (_215 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    float2 _228 = (_215 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_185 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _154;
    out.out_var_TEXCOORD1 = float4(_200.x, _200.y, _204.x, _204.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_222.x, _222.y, _228.x, _228.y);
    out.gl_Position = _191;
    return out;
}

