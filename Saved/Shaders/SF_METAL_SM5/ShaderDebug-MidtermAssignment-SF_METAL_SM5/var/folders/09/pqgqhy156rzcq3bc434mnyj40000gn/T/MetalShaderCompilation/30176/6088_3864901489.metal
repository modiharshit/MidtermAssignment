

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

struct VSMain_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct VSMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex VSMain_out Main_000017c8_e65db771(VSMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    VSMain_out out = {};
    float _68 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _69 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _68;
    float _72 = _68 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _73 = -_72;
    float _74 = pow(2.0, _73);
    float2 _75 = in.in_var_ATTRIBUTE0.xy * _74;
    float2 _76 = floor(_75);
    float _77 = -_68;
    float _78 = pow(2.0, _77);
    float _82 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _78;
    float _83 = _82 - 1.0;
    float _84 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _85 = _84 * _78;
    float _86 = fast::max(_85, 2.0);
    float _87 = _86 - 1.0;
    float2 _88 = float2(_83, _87);
    float2 _91 = _88 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _92 = _91.x;
    float2 _93 = float2(_92);
    float2 _94 = _76 / _93;
    float2 _95 = _76 * 0.5;
    float2 _96 = floor(_95);
    float _97 = _91.y;
    float2 _98 = float2(_97);
    float2 _99 = _96 / _98;
    float2 _103 = _94 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _105 = _103 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _106 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _107 = _105 + _106;
    float2 _112 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _113 = _107 + _112;
    float4 _117 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _113, level(_68));
    float _118 = _117.x;
    float _119 = _118 * 65280.0;
    float _120 = _117.y;
    float _121 = _120 * 255.0;
    float _122 = _119 + _121;
    float _123 = _122 - 32768.0;
    float _124 = _123 * 0.0078125;
    float2 _125 = _99 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _126 = _125 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _127 = _126 + _106;
    float2 _128 = _127 + _112;
    float _129 = _68 + 1.0;
    float4 _131 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _128, level(_129));
    float _132 = _131.x;
    float _133 = _132 * 65280.0;
    float _134 = _131.y;
    float _135 = _134 * 255.0;
    float _136 = _133 + _135;
    float _137 = _136 - 32768.0;
    float _138 = _137 * 0.0078125;
    float _139 = _94.x;
    float _140 = _94.y;
    float3 _141 = float3(_139, _140, _124);
    float _142 = _99.x;
    float _143 = _99.y;
    float3 _144 = float3(_142, _143, _138);
    float3 _145 = float3(_69);
    float3 _146 = mix(_141, _144, _145);
    float2 _148 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _149 = _148.x;
    float _150 = _148.y;
    float3 _151 = float3(_149, _150, 0.0);
    float3 _152 = _146 + _151;
    float3 _156 = _152.xxx;
    float3 _157 = Primitive.Primitive_LocalToWorld[0u].xyz * _156;
    float3 _161 = _152.yyy;
    float3 _162 = Primitive.Primitive_LocalToWorld[1u].xyz * _161;
    float3 _163 = _157 + _162;
    float3 _167 = _152.zzz;
    float3 _168 = Primitive.Primitive_LocalToWorld[2u].xyz * _167;
    float3 _169 = _163 + _168;
    float3 _173 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _174 = _169 + _173;
    float _175 = _174.x;
    float _176 = _174.y;
    float _177 = _174.z;
    float4 _178 = float4(_175, _176, _177, 1.0);
    float4 _179 = View.View_TranslatedWorldToClip * _178;
    float2 _180 = _146.xy;
    float2 _193 = ((_180 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _197 = (((_180 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _106) + _112;
    out.out_var_TEXCOORD0 = (_180 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _148;
    out.out_var_TEXCOORD1 = float4(_193.x, _193.y, _197.x, _197.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.gl_Position = _179;
    return out;
}

