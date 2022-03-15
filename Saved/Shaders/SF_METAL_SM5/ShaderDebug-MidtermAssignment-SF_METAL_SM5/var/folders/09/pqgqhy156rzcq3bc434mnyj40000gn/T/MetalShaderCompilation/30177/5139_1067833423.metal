

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001413_3fa5d84f(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    float _72 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _73 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _72;
    float2 _80 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_72 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x)));
    float _82 = pow(2.0, -_72);
    float2 _94 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _82) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _82, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _97 = _80 / float2(_94.x);
    float2 _102 = floor(_80 * 0.5) / float2(_94.y);
    float2 _109 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _115 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _120 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_97 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _109) + _115), level(_72));
    float4 _134 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_102 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _109) + _115), level(_72 + 1.0));
    float2 _159 = (mix(float2(_120.zw), float2(_134.zw), float2(_73)) * float2(2.0)) - float2(1.0);
    float3 _172 = mix(float3(_97, (((_120.x * 65280.0) + (_120.y * 255.0)) - 32768.0) * 0.0078125), float3(_102, (((_134.x * 65280.0) + (_134.y * 255.0)) - 32768.0) * 0.0078125), float3(_73)) + float3(in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww, 0.0);
    float4 _198 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _172.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _172.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _172.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _204 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_198.x, _198.y, _198.z, _198.w);
    float4 _215;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_204.z < 0.0))
    {
        float4 _213 = _204;
        _213.z = 9.9999999747524270787835121154785e-07;
        float4 _214 = _213;
        _214.w = 1.0;
        _215 = _214;
    }
    else
    {
        _215 = _204;
    }
    float _221 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_159, sqrt(fast::max(1.0 - dot(_159, _159), 0.0)))));
    out.out_var_TEXCOORD6 = _215.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_221) > 0.0) ? (sqrt(fast::clamp(1.0 - (_221 * _221), 0.0, 1.0)) / _221) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _215;
    return out;
}

