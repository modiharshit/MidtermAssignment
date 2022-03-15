

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

struct MainVertexShader_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_0000189f_61d008b0(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    MainVertexShader_out out = {};
    float _69 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _70 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _69;
    float _73 = _69 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _74 = -_73;
    float _75 = pow(2.0, _74);
    float2 _76 = in.in_var_ATTRIBUTE0.xy * _75;
    float2 _77 = floor(_76);
    float _78 = -_69;
    float _79 = pow(2.0, _78);
    float _83 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _79;
    float _84 = _83 - 1.0;
    float _85 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _86 = _85 * _79;
    float _87 = fast::max(_86, 2.0);
    float _88 = _87 - 1.0;
    float2 _89 = float2(_84, _88);
    float2 _92 = _89 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _93 = _92.x;
    float2 _94 = float2(_93);
    float2 _95 = _77 / _94;
    float2 _96 = _77 * 0.5;
    float2 _97 = floor(_96);
    float _98 = _92.y;
    float2 _99 = float2(_98);
    float2 _100 = _97 / _99;
    float2 _104 = _95 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _106 = _104 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _107 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _108 = _106 + _107;
    float2 _113 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _114 = _108 + _113;
    float4 _118 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _114, level(_69));
    float _119 = _118.x;
    float _120 = _119 * 65280.0;
    float _121 = _118.y;
    float _122 = _121 * 255.0;
    float _123 = _120 + _122;
    float _124 = _123 - 32768.0;
    float _125 = _124 * 0.0078125;
    float2 _126 = _100 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _127 = _126 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _128 = _127 + _107;
    float2 _129 = _128 + _113;
    float _130 = _69 + 1.0;
    float4 _132 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _129, level(_130));
    float _133 = _132.x;
    float _134 = _133 * 65280.0;
    float _135 = _132.y;
    float _136 = _135 * 255.0;
    float _137 = _134 + _136;
    float _138 = _137 - 32768.0;
    float _139 = _138 * 0.0078125;
    float _140 = _95.x;
    float _141 = _95.y;
    float3 _142 = float3(_140, _141, _125);
    float _143 = _100.x;
    float _144 = _100.y;
    float3 _145 = float3(_143, _144, _139);
    float3 _146 = float3(_70);
    float3 _147 = mix(_142, _145, _146);
    float2 _149 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _150 = _149.x;
    float _151 = _149.y;
    float3 _152 = float3(_150, _151, 0.0);
    float3 _153 = _147 + _152;
    float3 _157 = _153.xxx;
    float3 _158 = Primitive.Primitive_LocalToWorld[0u].xyz * _157;
    float3 _162 = _153.yyy;
    float3 _163 = Primitive.Primitive_LocalToWorld[1u].xyz * _162;
    float3 _164 = _158 + _163;
    float3 _168 = _153.zzz;
    float3 _169 = Primitive.Primitive_LocalToWorld[2u].xyz * _168;
    float3 _170 = _164 + _169;
    float3 _174 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _175 = _170 + _174;
    float _176 = _175.x;
    float _177 = _175.y;
    float _178 = _175.z;
    float4 _179 = float4(_176, _177, _178, 1.0);
    float4 _180 = float4(_179.x, _179.y, _179.z, _179.w);
    float4 _181 = View.View_TranslatedWorldToClip * _180;
    float2 _182 = _147.xy;
    float2 _195 = ((_182 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _199 = (((_182 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _107) + _113;
    out.out_var_TEXCOORD0 = (_182 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _149;
    out.out_var_TEXCOORD1 = float4(_195.x, _195.y, _199.x, _199.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _180;
    out.gl_Position = _181;
    return out;
}

