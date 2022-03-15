

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

constant float4 _165 = {};
constant float3 _166 = {};
constant float4 _168 = {};

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
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004a34_24065499(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _229 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = (_233.xyz / float3(_233.w)) - View.View_PreViewTranslation;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0].xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float3 _266 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _280 = mix(0.4000000059604644775390625, 1.0, _278.x);
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _309;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _309 = _229.w;
                break;
            }
            else
            {
                float _293 = _229.z;
                _309 = ((_293 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_293 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _313 = fast::min(fast::max((_309 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _314 = _284.y;
    float4 _318 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _320 = _318.y;
    float3 _333 = fast::clamp(float3(mix(_280, 1.0 - _280, mix(_314, 1.0, _313)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_320 + mix(_314, 0.0, _313), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _338 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _320) + mix(mix(0.699999988079071044921875, 1.0, _314), 1.0, _313), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _385;
    float _386;
    float _387;
    float3 _388;
    float3 _389;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _355 = ((_229.xy / float2(_229.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _359 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _365 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float _375 = _365.w;
        _385 = (_338 * _375) + _365.z;
        _386 = (0.5 * _375) + _365.y;
        _387 = _365.x;
        _388 = (_333 * _359.w) + _359.xyz;
        _389 = normalize((_266 * _362.w) + ((_362.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _385 = _338;
        _386 = 0.5;
        _387 = 0.0;
        _388 = _333;
        _389 = _266;
    }
    bool _397 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _403;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _397)
    {
        _403 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _403 = 1.0;
    }
    float _450;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _418 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _429 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_418.x), int(_418.y), int(_418.z), 0).xyz), 0));
        _450 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_429.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_418 / float3(_429.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _450 = _403;
    }
    float3 _464 = ((_388 - (_388 * _387)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _471 = (mix(float3(0.07999999821186065673828125 * _386), _388, float3(_387)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _474 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _479;
    if (_474)
    {
        _479 = _464 + (_471 * 0.449999988079071044921875);
    }
    else
    {
        _479 = _464;
    }
    float3 _481 = select(_471, float3(0.0), bool3(_474));
    float3 _483 = float3(dot(_481, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _569;
    if (_397)
    {
        float4 _519 = _168;
        _519.y = (-0.48860299587249755859375) * _389.y;
        float4 _522 = _519;
        _522.z = 0.48860299587249755859375 * _389.z;
        float4 _525 = _522;
        _525.w = (-0.48860299587249755859375) * _389.x;
        float3 _526 = _389 * _389;
        float4 _529 = _165;
        _529.x = (1.09254801273345947265625 * _389.x) * _389.y;
        float4 _532 = _529;
        _532.y = ((-1.09254801273345947265625) * _389.y) * _389.z;
        float4 _537 = _532;
        _537.z = 0.3153919875621795654296875 * ((3.0 * _526.z) - 1.0);
        float4 _540 = _537;
        _540.w = ((-1.09254801273345947265625) * _389.x) * _389.z;
        float4 _544 = _525;
        _544.x = 0.886227548122406005859375;
        float3 _546 = _544.yzw * 2.094395160675048828125;
        float4 _547 = float4(_544.x, _546.x, _546.y, _546.z);
        float4 _548 = _540 * 0.785398185253143310546875;
        float _549 = (_526.x - _526.y) * 0.4290426075458526611328125;
        float3 _555 = float3(0.0);
        _555.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _547) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _548)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _549);
        float3 _561 = _555;
        _561.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _547) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _548)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _549);
        float3 _567 = _561;
        _567.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _547) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _548)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _549);
        _569 = fast::max(float3(0.0), _567);
    }
    else
    {
        _569 = float3(0.0);
    }
    float _595;
    float _596;
    float3 _597;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _585;
        float _586;
        if (_397)
        {
            _585 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _586 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _585 = _389;
            _586 = 1.0;
        }
        float _587 = 1.0 - _586;
        float _589 = 1.0 - (_587 * _587);
        _595 = mix(fast::clamp(dot(_585, _389), 0.0, 1.0), 1.0, _589);
        _596 = _586;
        _597 = mix(_585, _389, float3(_589));
    }
    else
    {
        _595 = 1.0;
        _596 = 1.0;
        _597 = _389;
    }
    float4 _601 = float4(_597, 1.0);
    float3 _605 = _166;
    _605.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _601);
    float3 _609 = _605;
    _609.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _601);
    float3 _613 = _609;
    _613.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _601);
    float4 _616 = _601.xyzz * _601.yzzx;
    float3 _620 = _166;
    _620.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _616);
    float3 _624 = _620;
    _624.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _616);
    float3 _628 = _624;
    _628.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _616);
    float3 _643 = (_569 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_613 + _628) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_597.x * _597.x) - (_597.y * _597.y)))) * View.View_SkyLightColor.xyz) * (_596 * _595));
    float3 _665 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _691;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _690;
        if (any(abs(_238 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _690 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _690 = _665;
        }
        _691 = _690;
    }
    else
    {
        _691 = _665;
    }
    float4 _698 = float4(((mix(float3(0.0), _479 + (_481 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_643 * _479) * fast::max(float3(1.0), ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _691) * 1.0, 0.0);
    float4 _705;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _704 = _698;
        _704.w = 0.0;
        _705 = _704;
    }
    else
    {
        _705 = _698;
    }
    float2 _709 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _717 = (_389 * 0.5) + float3(0.5);
    float4 _719 = float4(_717.x, _717.y, _717.z, float4(0.0).w);
    _719.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _720 = float4(0.0);
    _720.x = _387;
    float4 _721 = _720;
    _721.y = _386;
    float4 _722 = _721;
    _722.z = _385;
    float4 _723 = _722;
    _723.w = 0.50588238239288330078125;
    float4 _735 = float4(_388.x, _388.y, _388.z, float4(0.0).w);
    _735.w = ((log2(((dot(_643, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_483 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_483 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_483 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_709.xyx * _709.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _705 * View.View_PreExposure;
    out.out_var_SV_Target1 = _719;
    out.out_var_SV_Target2 = _723;
    out.out_var_SV_Target3 = _735;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_450, 1.0, 1.0, 1.0);
    return out;
}

