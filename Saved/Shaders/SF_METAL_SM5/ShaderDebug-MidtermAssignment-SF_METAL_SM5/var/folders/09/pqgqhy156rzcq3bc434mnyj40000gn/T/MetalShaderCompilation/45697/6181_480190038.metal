

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
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001825_1c9f1e56(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_LandscapeFixedGrid& LandscapeFixedGrid [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(0)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    float _79 = floor(LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x);
    float _80 = LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x - _79;
    float2 _87 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_79 - LandscapeFixedGrid.LandscapeFixedGrid_LodValues.x)));
    float _89 = pow(2.0, -_79);
    float2 _102 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _89) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _89, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _105 = _87 / float2(_102.x);
    float2 _110 = floor(_87 * 0.5) / float2(_102.y);
    float2 _117 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _123 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _128 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_105 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _117) + _123), level(_79));
    float4 _142 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_110 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _117) + _123), level(_79 + 1.0));
    float3 _157 = mix(float3(_105, (((_128.x * 65280.0) + (_128.y * 255.0)) - 32768.0) * 0.0078125), float3(_110, (((_142.x * 65280.0) + (_142.y * 255.0)) - 32768.0) * 0.0078125), float3(_80));
    float2 _167 = (mix(float2(_128.zw), float2(_142.zw), float2(_80)) * float2(2.0)) - float2(1.0);
    float2 _176 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _180 = _157 + float3(_176, 0.0);
    float4 _206 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _180.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _180.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _180.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _212 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_206.x, _206.y, _206.z, _206.w);
    float4 _223;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_212.z < 0.0))
    {
        float4 _221 = _212;
        _221.z = 9.9999999747524270787835121154785e-07;
        float4 _222 = _221;
        _222.w = 1.0;
        _223 = _222;
    }
    else
    {
        _223 = _212;
    }
    float _229 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_167, sqrt(fast::max(1.0 - dot(_167, _167), 0.0)))));
    float4 _254 = _223;
    _254.z = ((_223.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_229) > 0.0) ? (sqrt(fast::clamp(1.0 - (_229 * _229), 0.0, 1.0)) / _229) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _223.w;
    float2 _255 = _157.xy;
    float2 _268 = ((_255 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _272 = (((_255 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _117) + _123;
    out.out_var_TEXCOORD0 = (_255 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _176;
    out.out_var_TEXCOORD1 = float4(_268.x, _268.y, _272.x, _272.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _206.xyz;
    out.gl_Position = _254;
    return out;
}

