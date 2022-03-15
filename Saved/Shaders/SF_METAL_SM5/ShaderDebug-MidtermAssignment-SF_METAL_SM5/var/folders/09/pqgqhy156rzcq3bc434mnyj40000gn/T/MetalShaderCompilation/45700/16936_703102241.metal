

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
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

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _145 = {};
constant float _147 = {};
constant float4 _148 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004228_29e87d21(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _207 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _147, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = (_212.xyz / float3(_212.w)) - View.View_PreViewTranslation;
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _240 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _244 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _289;
    float _290;
    float _291;
    float3 _292;
    float3 _293;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _261 = ((_207.xy / float2(_207.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _265 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        _289 = (_244 * _271.w) + _271.z;
        _290 = _271.y;
        _291 = _271.x;
        _292 = (_240 * _265.w) + _265.xyz;
        _293 = normalize((_231 * _268.w) + ((_268.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _289 = _244;
        _290 = 0.0;
        _291 = 0.0;
        _292 = _240;
        _293 = _231;
    }
    bool _301 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _307;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _301)
    {
        _307 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _307 = 1.0;
    }
    float _354;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _322 = fast::clamp((_217 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _333 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_322.x), int(_322.y), int(_322.z), 0).xyz), 0));
        _354 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_333.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_322 / float3(_333.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _354 = _307;
    }
    float3 _368 = ((_292 - (_292 * _291)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _375 = (mix(float3(0.07999999821186065673828125 * _290), _292, float3(_291)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _378 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _383;
    if (_378)
    {
        _383 = _368 + (_375 * 0.449999988079071044921875);
    }
    else
    {
        _383 = _368;
    }
    float3 _385 = select(_375, float3(0.0), bool3(_378));
    float3 _387 = float3(dot(_385, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _461;
    if (_301)
    {
        float3 _413 = fast::clamp((_217 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _417 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _413);
        float4 _421 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _413);
        float4 _424 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _413);
        float4 _442 = _148;
        _442.y = (-0.48860299587249755859375) * _293.y;
        float4 _445 = _442;
        _445.z = 0.48860299587249755859375 * _293.z;
        float4 _448 = _445;
        _448.w = (-0.48860299587249755859375) * _293.x;
        float4 _449 = _448;
        _449.x = 0.886227548122406005859375;
        float3 _451 = _449.yzw * 2.094395160675048828125;
        float4 _452 = float4(_449.x, _451.x, _451.y, _451.z);
        float3 _454 = float3(0.0);
        _454.x = dot(float4(_417.x, _421.x, _424.x, _417.w), _452);
        float3 _456 = _454;
        _456.y = dot(float4(_417.y, _421.y, _424.y, _421.w), _452);
        float3 _458 = _456;
        _458.z = dot(float4(_417.z, _421.z, _424.zw), _452);
        _461 = fast::max(float3(0.0), _458) * float3(0.3183098733425140380859375);
    }
    else
    {
        _461 = float3(0.0);
    }
    float _487;
    float _488;
    float3 _489;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _477;
        float _478;
        if (_301)
        {
            _477 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _478 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _477 = _293;
            _478 = 1.0;
        }
        float _479 = 1.0 - _478;
        float _481 = 1.0 - (_479 * _479);
        _487 = mix(fast::clamp(dot(_477, _293), 0.0, 1.0), 1.0, _481);
        _488 = _478;
        _489 = mix(_477, _293, float3(_481));
    }
    else
    {
        _487 = 1.0;
        _488 = 1.0;
        _489 = _293;
    }
    float4 _493 = float4(_489, 1.0);
    float3 _497 = _145;
    _497.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _493);
    float3 _501 = _497;
    _501.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _493);
    float3 _505 = _501;
    _505.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _493);
    float4 _508 = _493.xyzz * _493.yzzx;
    float3 _512 = _145;
    _512.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _508);
    float3 _516 = _512;
    _516.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _508);
    float3 _520 = _516;
    _520.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _508);
    float3 _535 = (_461 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_505 + _520) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_489.x * _489.x) - (_489.y * _489.y)))) * View.View_SkyLightColor.xyz) * (_488 * _487));
    float3 _557 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _583;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _582;
        if (any(abs(_217 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _582 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _582 = _557;
        }
        _583 = _582;
    }
    else
    {
        _583 = _557;
    }
    float4 _590 = float4(((mix(float3(0.0), _383 + (_385 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_535 * _383) * fast::max(float3(1.0), ((((((_292 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_292 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_292 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _583) * 1.0, 0.0);
    float4 _597;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _596 = _590;
        _596.w = 0.0;
        _597 = _596;
    }
    else
    {
        _597 = _590;
    }
    float2 _601 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _609 = (_293 * 0.5) + float3(0.5);
    float4 _611 = float4(_609.x, _609.y, _609.z, float4(0.0).w);
    _611.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _612 = float4(0.0);
    _612.x = _291;
    float4 _613 = _612;
    _613.y = _290;
    float4 _614 = _613;
    _614.z = _289;
    float4 _615 = _614;
    _615.w = 0.50588238239288330078125;
    float4 _627 = float4(_292.x, _292.y, _292.z, float4(0.0).w);
    _627.w = ((log2(((dot(_535, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_387 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_387 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_387 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_601.xyx * _601.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _597 * View.View_PreExposure;
    out.out_var_SV_Target1 = _611;
    out.out_var_SV_Target2 = _615;
    out.out_var_SV_Target3 = _627;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_354, 1.0, 1.0, 1.0);
    return out;
}

