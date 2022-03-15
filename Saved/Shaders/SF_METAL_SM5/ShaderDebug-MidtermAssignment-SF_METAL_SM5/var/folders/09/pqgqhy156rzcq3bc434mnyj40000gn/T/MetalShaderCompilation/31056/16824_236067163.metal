

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _149 = {};
constant float _151 = {};
constant float4 _152 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000041b8_0e12195b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float3 _223 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _234 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _235 = in.in_var_PRIMITIVE_ID * 36u;
    uint _236 = _235 + 20u;
    float _284;
    float _285;
    float _286;
    float3 _287;
    float3 _288;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _254 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _258 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _254, level(0.0));
        float4 _261 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _254, level(0.0));
        float4 _264 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _254, level(0.0));
        float _274 = _264.w;
        _284 = (_234 * _274) + _264.z;
        _285 = (0.5 * _274) + _264.y;
        _286 = _264.x;
        _287 = (float3(0.180000007152557373046875) * _258.w) + _258.xyz;
        _288 = normalize((_223 * _261.w) + ((_261.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _284 = _234;
        _285 = 0.5;
        _286 = 0.0;
        _287 = float3(0.180000007152557373046875);
        _288 = _223;
    }
    bool _298 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _304;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235 + 18u)].w > 0.0) && _298)
    {
        _304 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _304 = 1.0;
    }
    float _351;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236)].z > 0.0)
    {
        float3 _319 = fast::clamp((_215 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _330 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_319.x), int(_319.y), int(_319.z), 0).xyz), 0));
        _351 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_330.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_319 / float3(_330.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _351 = _304;
    }
    float3 _365 = ((_287 - (_287 * _286)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _372 = (mix(float3(0.07999999821186065673828125 * _285), _287, float3(_286)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _375 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _380;
    if (_375)
    {
        _380 = _365 + (_372 * 0.449999988079071044921875);
    }
    else
    {
        _380 = _365;
    }
    float3 _382 = select(_372, float3(0.0), bool3(_375));
    float3 _384 = float3(dot(_382, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _458;
    if (_298)
    {
        float3 _410 = fast::clamp((_215 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _414 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _410);
        float4 _418 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _410);
        float4 _421 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _410);
        float4 _439 = _152;
        _439.y = (-0.48860299587249755859375) * _288.y;
        float4 _442 = _439;
        _442.z = 0.48860299587249755859375 * _288.z;
        float4 _445 = _442;
        _445.w = (-0.48860299587249755859375) * _288.x;
        float4 _446 = _445;
        _446.x = 0.886227548122406005859375;
        float3 _448 = _446.yzw * 2.094395160675048828125;
        float4 _449 = float4(_446.x, _448.x, _448.y, _448.z);
        float3 _451 = float3(0.0);
        _451.x = dot(float4(_414.x, _418.x, _421.x, _414.w), _449);
        float3 _453 = _451;
        _453.y = dot(float4(_414.y, _418.y, _421.y, _418.w), _449);
        float3 _455 = _453;
        _455.z = dot(float4(_414.z, _418.z, _421.zw), _449);
        _458 = fast::max(float3(0.0), _455) * float3(0.3183098733425140380859375);
    }
    else
    {
        _458 = float3(0.0);
    }
    float _484;
    float _485;
    float3 _486;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _474;
        float _475;
        if (_298)
        {
            _474 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _475 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _474 = _288;
            _475 = 1.0;
        }
        float _476 = 1.0 - _475;
        float _478 = 1.0 - (_476 * _476);
        _484 = mix(fast::clamp(dot(_474, _288), 0.0, 1.0), 1.0, _478);
        _485 = _475;
        _486 = mix(_474, _288, float3(_478));
    }
    else
    {
        _484 = 1.0;
        _485 = 1.0;
        _486 = _288;
    }
    float4 _490 = float4(_486, 1.0);
    float3 _494 = _149;
    _494.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _490);
    float3 _498 = _494;
    _498.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _490);
    float3 _502 = _498;
    _502.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _490);
    float4 _505 = _490.xyzz * _490.yzzx;
    float3 _509 = _149;
    _509.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _505);
    float3 _513 = _509;
    _513.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _505);
    float3 _517 = _513;
    _517.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _505);
    float3 _532 = (_458 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_502 + _517) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_486.x * _486.x) - (_486.y * _486.y)))) * View.View_SkyLightColor.xyz) * (_485 * _484));
    float3 _554 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _583;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _582;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235 + 19u)].xyz + float3(1.0))))
        {
            _582 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _582 = _554;
        }
        _583 = _582;
    }
    else
    {
        _583 = _554;
    }
    float4 _590 = float4(((mix(float3(0.0), _380 + (_382 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_532 * _380) * fast::max(float3(1.0), ((((((_287 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_287 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_287 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _583) * 1.0, 0.0);
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
    float3 _609 = (_288 * 0.5) + float3(0.5);
    float4 _611 = float4(_609.x, _609.y, _609.z, float4(0.0).w);
    _611.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _236)].y;
    float4 _612 = float4(0.0);
    _612.x = _286;
    float4 _613 = _612;
    _613.y = _285;
    float4 _614 = _613;
    _614.z = _284;
    float4 _615 = _614;
    _615.w = 0.50588238239288330078125;
    float4 _627 = float4(_287.x, _287.y, _287.z, float4(0.0).w);
    _627.w = ((log2(((dot(_532, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_384 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_384 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_384 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_601.xyx * _601.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _597 * View.View_PreExposure;
    out.out_var_SV_Target1 = _611;
    out.out_var_SV_Target2 = _615;
    out.out_var_SV_Target3 = _627;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_351, 1.0, 1.0, 1.0);
    return out;
}

