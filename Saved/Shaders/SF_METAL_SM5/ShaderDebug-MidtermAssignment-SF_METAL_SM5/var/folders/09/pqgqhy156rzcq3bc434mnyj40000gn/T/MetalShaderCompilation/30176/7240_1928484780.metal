

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

struct MainVertexShader_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001c48_72f257ac(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    MainVertexShader_out out = {};
    float _76 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _77 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _76;
    float _80 = _76 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _81 = -_80;
    float _82 = pow(2.0, _81);
    float2 _83 = in.in_var_ATTRIBUTE0.xy * _82;
    float2 _84 = floor(_83);
    float _85 = -_76;
    float _86 = pow(2.0, _85);
    float _90 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _86;
    float _91 = _90 - 1.0;
    float _92 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _93 = _92 * _86;
    float _94 = fast::max(_93, 2.0);
    float _95 = _94 - 1.0;
    float2 _96 = float2(_91, _95);
    float2 _99 = _96 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _100 = _99.x;
    float2 _101 = float2(_100);
    float2 _102 = _84 / _101;
    float2 _103 = _84 * 0.5;
    float2 _104 = floor(_103);
    float _105 = _99.y;
    float2 _106 = float2(_105);
    float2 _107 = _104 / _106;
    float2 _111 = _102 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _113 = _111 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _114 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _115 = _113 + _114;
    float2 _120 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _121 = _115 + _120;
    float4 _125 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _121, level(_76));
    float _126 = _125.x;
    float _127 = _126 * 65280.0;
    float _128 = _125.y;
    float _129 = _128 * 255.0;
    float _130 = _127 + _129;
    float _131 = _130 - 32768.0;
    float _132 = _131 * 0.0078125;
    float2 _133 = _107 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _134 = _133 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _135 = _134 + _114;
    float2 _136 = _135 + _120;
    float _137 = _76 + 1.0;
    float4 _139 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _136, level(_137));
    float _140 = _139.x;
    float _141 = _140 * 65280.0;
    float _142 = _139.y;
    float _143 = _142 * 255.0;
    float _144 = _141 + _143;
    float _145 = _144 - 32768.0;
    float _146 = _145 * 0.0078125;
    float _147 = _102.x;
    float _148 = _102.y;
    float3 _149 = float3(_147, _148, _132);
    float _150 = _107.x;
    float _151 = _107.y;
    float3 _152 = float3(_150, _151, _146);
    float3 _153 = float3(_77);
    float3 _154 = mix(_149, _152, _153);
    float2 _156 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _157 = _156.x;
    float _158 = _156.y;
    float3 _159 = float3(_157, _158, 0.0);
    float3 _160 = _154 + _159;
    float3 _164 = _160.xxx;
    float3 _165 = Primitive.Primitive_LocalToWorld[0u].xyz * _164;
    float3 _169 = _160.yyy;
    float3 _170 = Primitive.Primitive_LocalToWorld[1u].xyz * _169;
    float3 _171 = _165 + _170;
    float3 _175 = _160.zzz;
    float3 _176 = Primitive.Primitive_LocalToWorld[2u].xyz * _175;
    float3 _177 = _171 + _176;
    float3 _181 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _182 = _177 + _181;
    float _183 = _182.x;
    float _184 = _182.y;
    float _185 = _182.z;
    float4 _186 = float4(_183, _184, _185, 1.0);
    float2 _187 = _154.xy;
    float4 _192 = float4(_186.x, _186.y, _186.z, _186.w);
    float4 _193 = View.View_TranslatedWorldToClip * _192;
    float2 _202 = ((_187 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _206 = (((_187 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _114) + _120;
    float2 _224 = ((((_187 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_187 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _156;
    out.out_var_TEXCOORD1 = float4(_202.x, _202.y, _206.x, _206.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_224.x, _224.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _192;
    out.gl_Position = _193;
    return out;
}

