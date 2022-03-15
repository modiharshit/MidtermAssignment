

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
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004a33_5c308358(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float4 _247 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0].xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _250 = (_247.xy * float2(2.0)) - float2(1.0);
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_250, sqrt(fast::clamp(1.0 - dot(_250, _250), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _281 = mix(0.4000000059604644775390625, 1.0, _279.x);
    float4 _285 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _310;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _310 = _230.w;
                break;
            }
            else
            {
                float _294 = _230.z;
                _310 = ((_294 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_294 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _314 = fast::min(fast::max((_310 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _315 = _285.y;
    float4 _319 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _321 = _319.y;
    float3 _334 = fast::clamp(float3(mix(_281, 1.0 - _281, mix(_315, 1.0, _314)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_321 + mix(_315, 0.0, _314), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _339 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _321) + mix(mix(0.699999988079071044921875, 1.0, _315), 1.0, _314), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _386;
    float _387;
    float _388;
    float3 _389;
    float3 _390;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _356 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _360 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _356, level(0.0));
        float4 _363 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _356, level(0.0));
        float4 _366 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _356, level(0.0));
        float _376 = _366.w;
        _386 = (_339 * _376) + _366.z;
        _387 = (0.5 * _376) + _366.y;
        _388 = _366.x;
        _389 = (_334 * _360.w) + _360.xyz;
        _390 = normalize((_267 * _363.w) + ((_363.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _386 = _339;
        _387 = 0.5;
        _388 = 0.0;
        _389 = _334;
        _390 = _267;
    }
    bool _398 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _404;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _398)
    {
        _404 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _404 = 1.0;
    }
    float _451;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _419 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _430 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_419.x), int(_419.y), int(_419.z), 0).xyz), 0));
        _451 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_430.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_419 / float3(_430.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _451 = _404;
    }
    float3 _465 = ((_389 - (_389 * _388)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _472 = (mix(float3(0.07999999821186065673828125 * _387), _389, float3(_388)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _475 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _480;
    if (_475)
    {
        _480 = _465 + (_472 * 0.449999988079071044921875);
    }
    else
    {
        _480 = _465;
    }
    float3 _482 = select(_472, float3(0.0), bool3(_475));
    float3 _484 = float3(dot(_482, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _570;
    if (_398)
    {
        float4 _520 = _169;
        _520.y = (-0.48860299587249755859375) * _390.y;
        float4 _523 = _520;
        _523.z = 0.48860299587249755859375 * _390.z;
        float4 _526 = _523;
        _526.w = (-0.48860299587249755859375) * _390.x;
        float3 _527 = _390 * _390;
        float4 _530 = _166;
        _530.x = (1.09254801273345947265625 * _390.x) * _390.y;
        float4 _533 = _530;
        _533.y = ((-1.09254801273345947265625) * _390.y) * _390.z;
        float4 _538 = _533;
        _538.z = 0.3153919875621795654296875 * ((3.0 * _527.z) - 1.0);
        float4 _541 = _538;
        _541.w = ((-1.09254801273345947265625) * _390.x) * _390.z;
        float4 _545 = _526;
        _545.x = 0.886227548122406005859375;
        float3 _547 = _545.yzw * 2.094395160675048828125;
        float4 _548 = float4(_545.x, _547.x, _547.y, _547.z);
        float4 _549 = _541 * 0.785398185253143310546875;
        float _550 = (_527.x - _527.y) * 0.4290426075458526611328125;
        float3 _556 = float3(0.0);
        _556.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _548) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _549)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _550);
        float3 _562 = _556;
        _562.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _548) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _549)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _550);
        float3 _568 = _562;
        _568.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _548) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _549)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _550);
        _570 = fast::max(float3(0.0), _568);
    }
    else
    {
        _570 = float3(0.0);
    }
    float _596;
    float _597;
    float3 _598;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _586;
        float _587;
        if (_398)
        {
            _586 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _587 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _586 = _390;
            _587 = 1.0;
        }
        float _588 = 1.0 - _587;
        float _590 = 1.0 - (_588 * _588);
        _596 = mix(fast::clamp(dot(_586, _390), 0.0, 1.0), 1.0, _590);
        _597 = _587;
        _598 = mix(_586, _390, float3(_590));
    }
    else
    {
        _596 = 1.0;
        _597 = 1.0;
        _598 = _390;
    }
    float4 _602 = float4(_598, 1.0);
    float3 _606 = _167;
    _606.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _602);
    float3 _610 = _606;
    _610.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _602);
    float3 _614 = _610;
    _614.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _602);
    float4 _617 = _602.xyzz * _602.yzzx;
    float3 _621 = _167;
    _621.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _617);
    float3 _625 = _621;
    _625.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _617);
    float3 _629 = _625;
    _629.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _617);
    float3 _644 = (_570 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_614 + _629) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_598.x * _598.x) - (_598.y * _598.y)))) * View.View_SkyLightColor.xyz) * (_597 * _596));
    float3 _666 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _692;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _691;
        if (any(abs(_239 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _691 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _691 = _666;
        }
        _692 = _691;
    }
    else
    {
        _692 = _666;
    }
    float4 _699 = float4(((mix(float3(0.0), _480 + (_482 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_644 * _480) * fast::max(float3(1.0), ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _692) * 1.0, 0.0);
    float4 _706;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _705 = _699;
        _705.w = 0.0;
        _706 = _705;
    }
    else
    {
        _706 = _699;
    }
    float2 _710 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _718 = (_390 * 0.5) + float3(0.5);
    float4 _720 = float4(_718.x, _718.y, _718.z, float4(0.0).w);
    _720.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _721 = float4(0.0);
    _721.x = _388;
    float4 _722 = _721;
    _722.y = _387;
    float4 _723 = _722;
    _723.z = _386;
    float4 _724 = _723;
    _724.w = 0.50588238239288330078125;
    float4 _736 = float4(_389.x, _389.y, _389.z, float4(0.0).w);
    _736.w = ((log2(((dot(_644, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_484 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_484 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_484 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_710.xyx * _710.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _706 * View.View_PreExposure;
    out.out_var_SV_Target1 = _720;
    out.out_var_SV_Target2 = _724;
    out.out_var_SV_Target3 = _736;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_451, 1.0, 1.0, 1.0);
    return out;
}

