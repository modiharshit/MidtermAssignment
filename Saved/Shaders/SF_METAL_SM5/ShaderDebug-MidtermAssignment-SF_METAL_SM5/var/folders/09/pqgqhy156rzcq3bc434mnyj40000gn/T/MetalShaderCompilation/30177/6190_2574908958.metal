

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

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000182e_9979fe1e(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    float _67 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _68 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _67;
    float _71 = _67 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _72 = -_71;
    float _73 = pow(2.0, _72);
    float2 _74 = in.in_var_ATTRIBUTE0.xy * _73;
    float2 _75 = floor(_74);
    float _76 = -_67;
    float _77 = pow(2.0, _76);
    float _81 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _77;
    float _82 = _81 - 1.0;
    float _83 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _84 = _83 * _77;
    float _85 = fast::max(_84, 2.0);
    float _86 = _85 - 1.0;
    float2 _87 = float2(_82, _86);
    float2 _90 = _87 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _91 = _90.x;
    float2 _92 = float2(_91);
    float2 _93 = _75 / _92;
    float2 _94 = _75 * 0.5;
    float2 _95 = floor(_94);
    float _96 = _90.y;
    float2 _97 = float2(_96);
    float2 _98 = _95 / _97;
    float2 _102 = _93 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _104 = _102 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _105 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _106 = _104 + _105;
    float2 _111 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _112 = _106 + _111;
    float4 _116 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _112, level(_67));
    float _117 = _116.x;
    float _118 = _117 * 65280.0;
    float _119 = _116.y;
    float _120 = _119 * 255.0;
    float _121 = _118 + _120;
    float _122 = _121 - 32768.0;
    float _123 = _122 * 0.0078125;
    float2 _124 = _98 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _125 = _124 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _126 = _125 + _105;
    float2 _127 = _126 + _111;
    float _128 = _67 + 1.0;
    float4 _130 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _127, level(_128));
    float _131 = _130.x;
    float _132 = _131 * 65280.0;
    float _133 = _130.y;
    float _134 = _133 * 255.0;
    float _135 = _132 + _134;
    float _136 = _135 - 32768.0;
    float _137 = _136 * 0.0078125;
    float _138 = _93.x;
    float _139 = _93.y;
    float3 _140 = float3(_138, _139, _123);
    float _141 = _98.x;
    float _142 = _98.y;
    float3 _143 = float3(_141, _142, _137);
    float3 _144 = float3(_68);
    float3 _145 = mix(_140, _143, _144);
    float2 _147 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _148 = _147.x;
    float _149 = _147.y;
    float3 _150 = float3(_148, _149, 0.0);
    float3 _151 = _145 + _150;
    float3 _155 = _151.xxx;
    float3 _156 = Primitive.Primitive_LocalToWorld[0u].xyz * _155;
    float3 _160 = _151.yyy;
    float3 _161 = Primitive.Primitive_LocalToWorld[1u].xyz * _160;
    float3 _162 = _156 + _161;
    float3 _166 = _151.zzz;
    float3 _167 = Primitive.Primitive_LocalToWorld[2u].xyz * _166;
    float3 _168 = _162 + _167;
    float3 _172 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _173 = _168 + _172;
    float _174 = _173.x;
    float _175 = _173.y;
    float _176 = _173.z;
    float4 _177 = float4(_174, _175, _176, 1.0);
    float2 _178 = _145.xy;
    float4 _183 = float4(_177.x, _177.y, _177.z, _177.w);
    float4 _186 = View.View_TranslatedWorldToClip * _183;
    float2 _195 = ((_178 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _199 = (((_178 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _105) + _111;
    out.out_var_TEXCOORD0 = (_178 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _147;
    out.out_var_TEXCOORD1 = float4(_195.x, _195.y, _199.x, _199.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _183;
    out.gl_Position = _186;
    return out;
}

