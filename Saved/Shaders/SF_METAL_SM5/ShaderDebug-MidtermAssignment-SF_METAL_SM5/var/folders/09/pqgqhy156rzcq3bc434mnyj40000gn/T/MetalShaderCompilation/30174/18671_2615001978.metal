

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _166 = {};
constant float3 _167 = {};
constant float4 _169 = {};

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000048ef_9bddc37a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _257 = normalize(float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0)) * normalize(((float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _271 = mix(0.4000000059604644775390625, 1.0, _269.x);
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _300;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _300 = _220.w;
                break;
            }
            else
            {
                float _284 = _220.z;
                _300 = ((_284 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_284 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _304 = fast::min(fast::max((_300 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _305 = _275.y;
    float4 _309 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _311 = _309.y;
    float3 _324 = fast::clamp(float3(mix(_271, 1.0 - _271, mix(_305, 1.0, _304)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_311 + mix(_305, 0.0, _304), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _329 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _311) + mix(mix(0.699999988079071044921875, 1.0, _305), 1.0, _304), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _376;
    float _377;
    float _378;
    float3 _379;
    float3 _380;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _346 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _350 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float4 _353 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float4 _356 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float _366 = _356.w;
        _376 = (_329 * _366) + _356.z;
        _377 = (0.5 * _366) + _356.y;
        _378 = _356.x;
        _379 = (_324 * _350.w) + _350.xyz;
        _380 = normalize((_257 * _353.w) + ((_353.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _376 = _329;
        _377 = 0.5;
        _378 = 0.0;
        _379 = _324;
        _380 = _257;
    }
    bool _388 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _394;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _388)
    {
        _394 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _394 = 1.0;
    }
    float _441;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _409 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _420 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_409.x), int(_409.y), int(_409.z), 0).xyz), 0));
        _441 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_420.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_409 / float3(_420.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _441 = _394;
    }
    float3 _455 = ((_379 - (_379 * _378)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _462 = (mix(float3(0.07999999821186065673828125 * _377), _379, float3(_378)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _465 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _470;
    if (_465)
    {
        _470 = _455 + (_462 * 0.449999988079071044921875);
    }
    else
    {
        _470 = _455;
    }
    float3 _472 = select(_462, float3(0.0), bool3(_465));
    float3 _474 = float3(dot(_472, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _560;
    if (_388)
    {
        float4 _510 = _169;
        _510.y = (-0.48860299587249755859375) * _380.y;
        float4 _513 = _510;
        _513.z = 0.48860299587249755859375 * _380.z;
        float4 _516 = _513;
        _516.w = (-0.48860299587249755859375) * _380.x;
        float3 _517 = _380 * _380;
        float4 _520 = _166;
        _520.x = (1.09254801273345947265625 * _380.x) * _380.y;
        float4 _523 = _520;
        _523.y = ((-1.09254801273345947265625) * _380.y) * _380.z;
        float4 _528 = _523;
        _528.z = 0.3153919875621795654296875 * ((3.0 * _517.z) - 1.0);
        float4 _531 = _528;
        _531.w = ((-1.09254801273345947265625) * _380.x) * _380.z;
        float4 _535 = _516;
        _535.x = 0.886227548122406005859375;
        float3 _537 = _535.yzw * 2.094395160675048828125;
        float4 _538 = float4(_535.x, _537.x, _537.y, _537.z);
        float4 _539 = _531 * 0.785398185253143310546875;
        float _540 = (_517.x - _517.y) * 0.4290426075458526611328125;
        float3 _546 = float3(0.0);
        _546.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _538) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _539)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _540);
        float3 _552 = _546;
        _552.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _538) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _539)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _540);
        float3 _558 = _552;
        _558.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _538) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _539)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _540);
        _560 = fast::max(float3(0.0), _558);
    }
    else
    {
        _560 = float3(0.0);
    }
    float _586;
    float _587;
    float3 _588;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _576;
        float _577;
        if (_388)
        {
            _576 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _577 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _576 = _380;
            _577 = 1.0;
        }
        float _578 = 1.0 - _577;
        float _580 = 1.0 - (_578 * _578);
        _586 = mix(fast::clamp(dot(_576, _380), 0.0, 1.0), 1.0, _580);
        _587 = _577;
        _588 = mix(_576, _380, float3(_580));
    }
    else
    {
        _586 = 1.0;
        _587 = 1.0;
        _588 = _380;
    }
    float4 _592 = float4(_588, 1.0);
    float3 _596 = _167;
    _596.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _592);
    float3 _600 = _596;
    _600.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _592);
    float3 _604 = _600;
    _604.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _592);
    float4 _607 = _592.xyzz * _592.yzzx;
    float3 _611 = _167;
    _611.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _607);
    float3 _615 = _611;
    _615.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _607);
    float3 _619 = _615;
    _619.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _607);
    float3 _634 = (_560 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_604 + _619) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_588.x * _588.x) - (_588.y * _588.y)))) * View.View_SkyLightColor.xyz) * (_587 * _586));
    float3 _656 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _682;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _681;
        if (any(abs(_229 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _681 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _681 = _656;
        }
        _682 = _681;
    }
    else
    {
        _682 = _656;
    }
    float4 _689 = float4(((mix(float3(0.0), _470 + (_472 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_634 * _470) * fast::max(float3(1.0), ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _682) * 1.0, 0.0);
    float4 _696;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _695 = _689;
        _695.w = 0.0;
        _696 = _695;
    }
    else
    {
        _696 = _689;
    }
    float2 _700 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _708 = (_380 * 0.5) + float3(0.5);
    float4 _710 = float4(_708.x, _708.y, _708.z, float4(0.0).w);
    _710.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _711 = float4(0.0);
    _711.x = _378;
    float4 _712 = _711;
    _712.y = _377;
    float4 _713 = _712;
    _713.z = _376;
    float4 _714 = _713;
    _714.w = 0.50588238239288330078125;
    float4 _726 = float4(_379.x, _379.y, _379.z, float4(0.0).w);
    _726.w = ((log2(((dot(_634, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_474 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_474 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_474 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_700.xyx * _700.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _696 * View.View_PreExposure;
    out.out_var_SV_Target1 = _710;
    out.out_var_SV_Target2 = _714;
    out.out_var_SV_Target3 = _726;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_441, 1.0, 1.0, 1.0);
    return out;
}

