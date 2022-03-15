

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _158 = {};
constant float _160 = {};
constant float4 _161 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
    float4 out_var_SV_Target3 [[color(3)]];
    float4 out_var_SV_Target4 [[color(4)]];
    float4 out_var_SV_Target5 [[color(5)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000046fc_ba3414b6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _160, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _253 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _264 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _271 = _264.y;
    float3 _281 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_271)), float3(0.0), float3(1.0));
    float _282 = fast::clamp(mix(0.0, 1.0, _271), 0.0, 1.0);
    float _283 = fast::clamp(_264.x, 0.0, 1.0);
    float _288 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _271), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _289 = in.in_var_PRIMITIVE_ID * 36u;
    uint _290 = _289 + 20u;
    float _340;
    float _341;
    float _342;
    float3 _343;
    float3 _344;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _308 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _312 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _315 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _318 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float _328 = _318.w;
        _340 = (_288 * _328) + _318.z;
        _341 = (0.5 * _328) + _318.y;
        _342 = (_282 * _328) + _318.x;
        _343 = (_281 * _312.w) + _312.xyz;
        _344 = normalize((_253 * _315.w) + ((_315.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _340 = _288;
        _341 = 0.5;
        _342 = _282;
        _343 = _281;
        _344 = _253;
    }
    bool _354 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _360;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 18u)].w > 0.0) && _354)
    {
        _360 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _360 = 1.0;
    }
    float _407;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].z > 0.0)
    {
        float3 _375 = fast::clamp((_228 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _386 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_375.x), int(_375.y), int(_375.z), 0).xyz), 0));
        _407 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_386.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_375 / float3(_386.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _407 = _360;
    }
    float3 _421 = ((_343 - (_343 * _342)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _428 = (mix(float3(0.07999999821186065673828125 * _341), _343, float3(_342)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _431 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _436;
    if (_431)
    {
        _436 = _421 + (_428 * 0.449999988079071044921875);
    }
    else
    {
        _436 = _421;
    }
    float3 _438 = select(_428, float3(0.0), bool3(_431));
    float3 _440 = float3(dot(_438, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _447 = float3(_283);
    float3 _515;
    if (_354)
    {
        float3 _467 = fast::clamp((_228 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _471 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _467);
        float4 _475 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _467);
        float4 _478 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _467);
        float4 _496 = _161;
        _496.y = (-0.48860299587249755859375) * _344.y;
        float4 _499 = _496;
        _499.z = 0.48860299587249755859375 * _344.z;
        float4 _502 = _499;
        _502.w = (-0.48860299587249755859375) * _344.x;
        float4 _503 = _502;
        _503.x = 0.886227548122406005859375;
        float3 _505 = _503.yzw * 2.094395160675048828125;
        float4 _506 = float4(_503.x, _505.x, _505.y, _505.z);
        float3 _508 = float3(0.0);
        _508.x = dot(float4(_471.x, _475.x, _478.x, _471.w), _506);
        float3 _510 = _508;
        _510.y = dot(float4(_471.y, _475.y, _478.y, _475.w), _506);
        float3 _512 = _510;
        _512.z = dot(float4(_471.z, _475.z, _478.zw), _506);
        _515 = fast::max(float3(0.0), _512) * float3(0.3183098733425140380859375);
    }
    else
    {
        _515 = float3(0.0);
    }
    float _541;
    float _542;
    float3 _543;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _531;
        float _532;
        if (_354)
        {
            _531 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _532 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _531 = _344;
            _532 = 1.0;
        }
        float _533 = 1.0 - _532;
        float _535 = 1.0 - (_533 * _533);
        _541 = mix(fast::clamp(dot(_531, _344), 0.0, 1.0), 1.0, _535);
        _542 = _532;
        _543 = mix(_531, _344, float3(_535));
    }
    else
    {
        _541 = 1.0;
        _542 = 1.0;
        _543 = _344;
    }
    float4 _547 = float4(_543, 1.0);
    float3 _551 = _158;
    _551.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _547);
    float3 _555 = _551;
    _555.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _547);
    float3 _559 = _555;
    _559.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _547);
    float4 _562 = _547.xyzz * _547.yzzx;
    float3 _566 = _158;
    _566.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _562);
    float3 _570 = _566;
    _570.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _562);
    float3 _574 = _570;
    _574.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _562);
    float3 _589 = (_515 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_559 + _574) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_543.x * _543.x) - (_543.y * _543.y)))) * View.View_SkyLightColor.xyz) * (_542 * _541));
    float3 _611 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _640;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _639;
        if (any(abs(_228 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 19u)].xyz + float3(1.0))))
        {
            _639 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _639 = _611;
        }
        _640 = _639;
    }
    else
    {
        _640 = _611;
    }
    float4 _647 = float4(((mix(float3(0.0), _436 + (_438 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_589 * _436) * fast::max(_447, ((((((_343 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _283) + ((_343 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _283) + ((_343 * 2.755199909210205078125) + float3(0.69029998779296875))) * _283))) + _640) * 1.0, 0.0);
    float4 _654;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _653 = _647;
        _653.w = 0.0;
        _654 = _653;
    }
    else
    {
        _654 = _647;
    }
    float2 _658 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _666 = (_344 * 0.5) + float3(0.5);
    float4 _668 = float4(_666.x, _666.y, _666.z, float4(0.0).w);
    _668.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].y;
    float4 _669 = float4(0.0);
    _669.x = _342;
    float4 _670 = _669;
    _670.y = _341;
    float4 _671 = _670;
    _671.z = _340;
    float4 _672 = _671;
    _672.w = 0.50588238239288330078125;
    float4 _684 = float4(_343.x, _343.y, _343.z, float4(0.0).w);
    _684.w = ((log2(((dot(_589, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_447, ((((((_440 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _283) + ((_440 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _283) + ((_440 * 2.755199909210205078125) + float3(0.69029998779296875))) * _283).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_658.xyx * _658.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _654 * View.View_PreExposure;
    out.out_var_SV_Target1 = _668;
    out.out_var_SV_Target2 = _672;
    out.out_var_SV_Target3 = _684;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_407, 1.0, 1.0, 1.0);
    return out;
}

