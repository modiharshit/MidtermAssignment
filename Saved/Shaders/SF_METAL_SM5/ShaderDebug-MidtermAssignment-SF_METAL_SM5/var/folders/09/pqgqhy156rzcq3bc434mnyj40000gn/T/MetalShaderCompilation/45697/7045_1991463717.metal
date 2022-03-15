

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
    char _m1_pad[32];
    float4x4 Primitive_WorldToLocal;
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

struct type_Globals
{
    float2 RenderOffset;
};

struct VSMain_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD9 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct VSMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex VSMain_out Main_00001b85_76b35325(VSMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    VSMain_out out = {};
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
    float3 _165 = _160.xxx;
    float3 _166 = Primitive.Primitive_LocalToWorld[0u].xyz * _165;
    float3 _170 = _160.yyy;
    float3 _171 = Primitive.Primitive_LocalToWorld[1u].xyz * _170;
    float3 _172 = _166 + _171;
    float3 _176 = _160.zzz;
    float3 _177 = Primitive.Primitive_LocalToWorld[2u].xyz * _176;
    float3 _178 = _172 + _177;
    float3 _182 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _183 = _178 + _182;
    float _184 = _183.x;
    float _185 = _183.y;
    float _186 = _183.z;
    float4 _187 = float4(_184, _185, _186, 1.0);
    float3x3 _196 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
    float3 _197 = _196 * float3(0.0);
    float3 _198 = _197 * float3(0.0, 0.0, 1.0);
    float3x3 _206 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _207 = _206 * _198;
    float3 _208 = _187.xyz;
    float3 _209 = _208 + _207;
    float4 _210 = float4(_209.x, _209.y, _209.z, _187.w);
    float2 _211 = _154.xy;
    float2 _224 = ((_211 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _228 = (((_211 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _114) + _120;
    float4 _230 = View.View_TranslatedWorldToClip * _210;
    float4 _235 = float4(_Globals.RenderOffset, 0.0, 0.0);
    float4 _236 = _230 + _235;
    out.gl_Position = _236;
    out.out_var_TEXCOORD0 = (_211 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _156;
    out.out_var_TEXCOORD1 = float4(_224.x, _224.y, _228.x, _228.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD9 = _230;
    return out;
}

