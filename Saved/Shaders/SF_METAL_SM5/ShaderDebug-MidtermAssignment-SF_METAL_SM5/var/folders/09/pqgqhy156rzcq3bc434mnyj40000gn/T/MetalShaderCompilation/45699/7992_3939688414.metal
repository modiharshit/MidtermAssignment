

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
    float4 LandscapeParameters_WeightmapUVScaleBias;
    char _m2_pad[16];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct type_Globals
{
    uint LayerId;
};

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float3 out_var_TEXCOORD8 [[user(locn5)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001f38_ead2dfde(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    float _83 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _84 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _83;
    float _87 = _83 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x;
    float _88 = -_87;
    float _89 = pow(2.0, _88);
    float2 _90 = in.in_var_ATTRIBUTE0.xy * _89;
    float2 _91 = floor(_90);
    float _92 = -_83;
    float _93 = pow(2.0, _92);
    float _97 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _93;
    float _98 = _97 - 1.0;
    float _99 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _100 = _99 * _93;
    float _101 = fast::max(_100, 2.0);
    float _102 = _101 - 1.0;
    float2 _103 = float2(_98, _102);
    float2 _106 = _103 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _107 = _106.x;
    float2 _108 = float2(_107);
    float2 _109 = _91 / _108;
    float2 _110 = _91 * 0.5;
    float2 _111 = floor(_110);
    float _112 = _106.y;
    float2 _113 = float2(_112);
    float2 _114 = _111 / _113;
    float2 _118 = _109 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _120 = _118 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _121 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _122 = _120 + _121;
    float2 _127 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _128 = _122 + _127;
    float4 _132 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _128, level(_83));
    float _133 = _132.x;
    float _134 = _133 * 65280.0;
    float _135 = _132.y;
    float _136 = _135 * 255.0;
    float _137 = _134 + _136;
    float _138 = _137 - 32768.0;
    float _139 = _138 * 0.0078125;
    float2 _140 = _114 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _141 = _140 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _142 = _141 + _121;
    float2 _143 = _142 + _127;
    float _144 = _83 + 1.0;
    float4 _146 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _143, level(_144));
    float _147 = _146.x;
    float _148 = _147 * 65280.0;
    float _149 = _146.y;
    float _150 = _149 * 255.0;
    float _151 = _148 + _150;
    float _152 = _151 - 32768.0;
    float _153 = _152 * 0.0078125;
    float _154 = _109.x;
    float _155 = _109.y;
    float3 _156 = float3(_154, _155, _139);
    float _157 = _114.x;
    float _158 = _114.y;
    float3 _159 = float3(_157, _158, _153);
    float3 _160 = float3(_84);
    float3 _161 = mix(_156, _159, _160);
    float2 _171 = (mix(float2(_132.zw), float2(_146.zw), float2(_84)) * float2(2.0)) - float2(1.0);
    float2 _180 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _181 = _180.x;
    float _182 = _180.y;
    float3 _183 = float3(_181, _182, 0.0);
    float3 _184 = _161 + _183;
    float3 _188 = _184.xxx;
    float3 _189 = Primitive.Primitive_LocalToWorld[0u].xyz * _188;
    float3 _193 = _184.yyy;
    float3 _194 = Primitive.Primitive_LocalToWorld[1u].xyz * _193;
    float3 _195 = _189 + _194;
    float3 _199 = _184.zzz;
    float3 _200 = Primitive.Primitive_LocalToWorld[2u].xyz * _199;
    float3 _201 = _195 + _200;
    float3 _205 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _206 = _201 + _205;
    float _207 = _206.x;
    float _208 = _206.y;
    float _209 = _206.z;
    float4 _210 = float4(_207, _208, _209, 1.0);
    float4 _211 = float4(_210.x, _210.y, _210.z, _210.w);
    float2 _212 = _161.xy;
    float2 _225 = ((_212 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _229 = (((_212 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _121) + _127;
    float4 _236 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _211;
    out.out_var_TEXCOORD0 = (_212 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _180;
    out.out_var_TEXCOORD1 = float4(_225.x, _225.y, _229.x, _229.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD7 = _210.xyz;
    out.out_var_TEXCOORD6 = _236;
    out.out_var_TEXCOORD8 = float3(_171, sqrt(fast::max(1.0 - dot(_171, _171), 0.0)));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _236;
    return out;
}

