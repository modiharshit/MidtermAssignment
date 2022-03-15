

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
    char _m1_pad[32];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001476_b4a4d500(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    float _63 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _64 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _63;
    float _67 = _63 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _68 = -_67;
    float _69 = pow(2.0, _68);
    float2 _70 = in.in_var_ATTRIBUTE0.xy * _69;
    float2 _71 = floor(_70);
    float _72 = -_63;
    float _73 = pow(2.0, _72);
    float _76 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _73;
    float _77 = _76 - 1.0;
    float _78 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _79 = _78 * _73;
    float _80 = fast::max(_79, 2.0);
    float _81 = _80 - 1.0;
    float2 _82 = float2(_77, _81);
    float2 _85 = _82 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _86 = _85.x;
    float2 _87 = float2(_86);
    float2 _88 = _71 / _87;
    float2 _89 = _71 * 0.5;
    float2 _90 = floor(_89);
    float _91 = _85.y;
    float2 _92 = float2(_91);
    float2 _93 = _90 / _92;
    float2 _97 = _88 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _99 = _97 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _100 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _101 = _99 + _100;
    float2 _106 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _107 = _101 + _106;
    float4 _111 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _107, level(_63));
    float _112 = _111.x;
    float _113 = _112 * 65280.0;
    float _114 = _111.y;
    float _115 = _114 * 255.0;
    float _116 = _113 + _115;
    float _117 = _116 - 32768.0;
    float _118 = _117 * 0.0078125;
    float2 _119 = _93 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _120 = _119 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _121 = _120 + _100;
    float2 _122 = _121 + _106;
    float _123 = _63 + 1.0;
    float4 _125 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _122, level(_123));
    float _126 = _125.x;
    float _127 = _126 * 65280.0;
    float _128 = _125.y;
    float _129 = _128 * 255.0;
    float _130 = _127 + _129;
    float _131 = _130 - 32768.0;
    float _132 = _131 * 0.0078125;
    float _133 = _88.x;
    float _134 = _88.y;
    float3 _135 = float3(_133, _134, _118);
    float _136 = _93.x;
    float _137 = _93.y;
    float3 _138 = float3(_136, _137, _132);
    float3 _139 = float3(_64);
    float3 _140 = mix(_135, _138, _139);
    float2 _142 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _143 = _142.x;
    float _144 = _142.y;
    float3 _145 = float3(_143, _144, 0.0);
    float3 _146 = _140 + _145;
    float3 _150 = _146.xxx;
    float3 _151 = Primitive.Primitive_LocalToWorld[0u].xyz * _150;
    float3 _155 = _146.yyy;
    float3 _156 = Primitive.Primitive_LocalToWorld[1u].xyz * _155;
    float3 _157 = _151 + _156;
    float3 _161 = _146.zzz;
    float3 _162 = Primitive.Primitive_LocalToWorld[2u].xyz * _161;
    float3 _163 = _157 + _162;
    float3 _167 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _168 = _163 + _167;
    float _169 = _168.x;
    float _170 = _168.y;
    float _171 = _168.z;
    float4 _172 = float4(_169, _170, _171, 1.0);
    float4 _173 = float4(_172.x, _172.y, _172.z, _172.w);
    float4 _174 = View.View_TranslatedWorldToClip * _173;
    out.gl_Position = _174;
    return out;
}

