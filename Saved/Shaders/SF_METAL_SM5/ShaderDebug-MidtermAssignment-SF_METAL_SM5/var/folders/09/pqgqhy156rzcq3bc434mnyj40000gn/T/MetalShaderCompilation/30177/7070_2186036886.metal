

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_View
{
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
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

struct type_Globals
{
    uint LayerId;
};

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainForGS_out Main_00001b9e_824c4696(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    MainForGS_out out = {};
    float _77 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _78 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _77;
    float _81 = _77 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _82 = -_81;
    float _83 = pow(2.0, _82);
    float2 _84 = in.in_var_ATTRIBUTE0.xy * _83;
    float2 _85 = floor(_84);
    float _86 = -_77;
    float _87 = pow(2.0, _86);
    float _90 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _87;
    float _91 = _90 - 1.0;
    float _92 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _93 = _92 * _87;
    float _94 = fast::max(_93, 2.0);
    float _95 = _94 - 1.0;
    float2 _96 = float2(_91, _95);
    float2 _99 = _96 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _100 = _99.x;
    float2 _101 = float2(_100);
    float2 _102 = _85 / _101;
    float2 _103 = _85 * 0.5;
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
    float4 _125 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _121, level(_77));
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
    float _137 = _77 + 1.0;
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
    float3 _153 = float3(_78);
    float3 _154 = mix(_149, _152, _153);
    float2 _164 = (mix(float2(_125.zw), float2(_139.zw), float2(_78)) * float2(2.0)) - float2(1.0);
    float2 _173 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _174 = _173.x;
    float _175 = _173.y;
    float3 _176 = float3(_174, _175, 0.0);
    float3 _177 = _154 + _176;
    float3 _181 = _177.xxx;
    float3 _182 = Primitive.Primitive_LocalToWorld[0u].xyz * _181;
    float3 _186 = _177.yyy;
    float3 _187 = Primitive.Primitive_LocalToWorld[1u].xyz * _186;
    float3 _188 = _182 + _187;
    float3 _192 = _177.zzz;
    float3 _193 = Primitive.Primitive_LocalToWorld[2u].xyz * _192;
    float3 _194 = _188 + _193;
    float3 _198 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _199 = _194 + _198;
    float _200 = _199.x;
    float _201 = _199.y;
    float _202 = _199.z;
    float4 _203 = float4(_200, _201, _202, 1.0);
    float4 _204 = float4(_203.x, _203.y, _203.z, _203.w);
    float4 _209 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _204;
    out.out_var_TEXCOORD6 = _204;
    out.out_var_TEXCOORD8 = float3(_164, sqrt(fast::max(1.0 - dot(_164, _164), 0.0)));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _209;
    return out;
}

