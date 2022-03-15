

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m22_pad[48];
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
    float4x4 Primitive_LocalToWorld;
    char _m1_pad[16];
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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _168 = {};
constant float4 _169 = {};
constant float3 _170 = {};
constant float _172 = {};
constant float4 _173 = {};
constant float3 _174 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00005b4b_c2ed3171(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float3x3 _230 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _242 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _172, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _247 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _252 = (_247.xyz / float3(_247.w)) - View.View_PreViewTranslation;
    float3 _257 = (Primitive.Primitive_LocalToWorld * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _269 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _272 = (float3(-0.5) + _269.xyz) * 2.0;
    float3 _288 = ((((_257 / float3(sqrt(dot(_257, _257)))) * _230) * (-1.0)) * _272.z) + (float3(_272.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _230));
    float3 _300 = normalize(_230 * normalize(((_288 / float3(sqrt(dot(_288, _288)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _311 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _318 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _334 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _334) : (in.in_var_COLOR1.w < _334)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((_311.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _349 = fast::clamp(_311.xyz, float3(0.0), float3(1.0));
    float _354 = (fast::clamp(_269.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _364 = (fast::clamp(float4(_318.xyz, _168).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _412;
    float _413;
    float _414;
    float _415;
    float3 _416;
    float3 _417;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _381 = ((_242.xy / float2(_242.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _385 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float4 _388 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float4 _391 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float _393 = _385.w;
        float _401 = _391.w;
        _412 = _364 * _393;
        _413 = (_354 * _401) + _391.z;
        _414 = (0.5 * _401) + _391.y;
        _415 = _391.x;
        _416 = (_349 * _393) + _385.xyz;
        _417 = normalize((_300 * _388.w) + ((_388.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _412 = _364;
        _413 = _354;
        _414 = 0.5;
        _415 = 0.0;
        _416 = _349;
        _417 = _300;
    }
    bool _425 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _431;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _425)
    {
        _431 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _431 = 1.0;
    }
    float _478;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _446 = fast::clamp((_252 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _457 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_446.x), int(_446.y), int(_446.z), 0).xyz), 0));
        _478 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_457.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_446 / float3(_457.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _478 = _431;
    }
    float3 _481 = sqrt(fast::clamp(_412, float3(0.0), float3(1.0)));
    float4 _483 = float4(_481.x, _481.y, _481.z, float4(0.0).w);
    _483.w = 1.0;
    float3 _488 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _489 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _507 = ((_416 - (_416 * _415)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _514 = (mix(float3(0.07999999821186065673828125 * _414), _416, float3(_415)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _517 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _522;
    if (_517)
    {
        _522 = _507 + (_514 * 0.449999988079071044921875);
    }
    else
    {
        _522 = _507;
    }
    float3 _524 = select(_514, float3(0.0), bool3(_517));
    float3 _526 = float3(dot(_524, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _665;
    float3 _666;
    if (_425)
    {
        float4 _562 = _173;
        _562.y = (-0.48860299587249755859375) * _417.y;
        float4 _565 = _562;
        _565.z = 0.48860299587249755859375 * _417.z;
        float4 _568 = _565;
        _568.w = (-0.48860299587249755859375) * _417.x;
        float3 _569 = _417 * _417;
        float4 _572 = _169;
        _572.x = (1.09254801273345947265625 * _417.x) * _417.y;
        float4 _575 = _572;
        _575.y = ((-1.09254801273345947265625) * _417.y) * _417.z;
        float4 _580 = _575;
        _580.z = 0.3153919875621795654296875 * ((3.0 * _569.z) - 1.0);
        float4 _583 = _580;
        _583.w = ((-1.09254801273345947265625) * _417.x) * _417.z;
        float4 _587 = _568;
        _587.x = 0.886227548122406005859375;
        float3 _589 = _587.yzw * 2.094395160675048828125;
        float4 _590 = float4(_587.x, _589.x, _589.y, _589.z);
        float4 _591 = _583 * 0.785398185253143310546875;
        float _592 = (_569.x - _569.y) * 0.4290426075458526611328125;
        float3 _598 = float3(0.0);
        _598.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _590) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _591)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _592);
        float3 _604 = _598;
        _604.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _590) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _591)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _592);
        float3 _610 = _604;
        _610.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _590) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _591)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _592);
        float3 _612 = -_417;
        float _613 = _612.y;
        float4 _615 = _173;
        _615.y = (-0.48860299587249755859375) * _613;
        float _616 = _612.z;
        float4 _618 = _615;
        _618.z = 0.48860299587249755859375 * _616;
        float _619 = _612.x;
        float4 _621 = _618;
        _621.w = (-0.48860299587249755859375) * _619;
        float3 _622 = _612 * _612;
        float4 _625 = _169;
        _625.x = (1.09254801273345947265625 * _619) * _613;
        float4 _628 = _625;
        _628.y = ((-1.09254801273345947265625) * _613) * _616;
        float4 _633 = _628;
        _633.z = 0.3153919875621795654296875 * ((3.0 * _622.z) - 1.0);
        float4 _636 = _633;
        _636.w = ((-1.09254801273345947265625) * _619) * _616;
        float4 _640 = _621;
        _640.x = 0.886227548122406005859375;
        float3 _642 = _640.yzw * 2.094395160675048828125;
        float4 _643 = float4(_640.x, _642.x, _642.y, _642.z);
        float4 _644 = _636 * 0.785398185253143310546875;
        float _645 = (_622.x - _622.y) * 0.4290426075458526611328125;
        float3 _651 = _174;
        _651.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _643) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _644)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _645);
        float3 _657 = _651;
        _657.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _643) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _644)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _645);
        float3 _663 = _657;
        _663.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _643) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _644)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _645);
        _665 = fast::max(float3(0.0), _663);
        _666 = fast::max(float3(0.0), _610);
    }
    else
    {
        _665 = float3(0.0);
        _666 = float3(0.0);
    }
    float _693;
    float _694;
    float3 _695;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _683;
        float _684;
        if (_425)
        {
            _683 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _684 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _683 = _417;
            _684 = 1.0;
        }
        float _685 = 1.0 - _684;
        float _687 = 1.0 - (_685 * _685);
        _693 = mix(fast::clamp(dot(_683, _417), 0.0, 1.0), 1.0, _687);
        _694 = _684;
        _695 = mix(_683, _417, float3(_687));
    }
    else
    {
        _693 = 1.0;
        _694 = 1.0;
        _695 = _417;
    }
    float4 _699 = float4(_695, 1.0);
    float3 _703 = _170;
    _703.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _699);
    float3 _707 = _703;
    _707.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _699);
    float3 _711 = _707;
    _711.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _699);
    float4 _714 = _699.xyzz * _699.yzzx;
    float3 _718 = _170;
    _718.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _714);
    float3 _722 = _718;
    _722.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _714);
    float3 _726 = _722;
    _726.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _714);
    float3 _741 = -_417;
    float _742 = _741.x;
    float _743 = _741.y;
    float4 _745 = float4(_742, _743, _741.z, 1.0);
    float3 _748 = _174;
    _748.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _745);
    float3 _751 = _748;
    _751.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _745);
    float3 _754 = _751;
    _754.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _745);
    float4 _757 = _745.xyzz * _745.yzzx;
    float3 _760 = _174;
    _760.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _757);
    float3 _763 = _760;
    _763.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _757);
    float3 _766 = _763;
    _766.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _757);
    float3 _779 = (_666 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_711 + _726) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_695.x * _695.x) - (_695.y * _695.y)))) * View.View_SkyLightColor.xyz) * (_694 * _693));
    float3 _803 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _829;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _828;
        if (any(abs(_252 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _828 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_252, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _828 = _803;
        }
        _829 = _828;
    }
    else
    {
        _829 = _803;
    }
    float4 _836 = float4(((mix(float3(0.0), _522 + (_524 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_779 * _522) + (((_665 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_754 + _766) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_742 * _742) - (_743 * _743)))) * View.View_SkyLightColor.xyz) * _694)) * _412)) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _829) * 1.0, 0.0);
    float4 _843;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _842 = _836;
        _842.w = 0.0;
        _843 = _842;
    }
    else
    {
        _843 = _836;
    }
    float2 _847 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _855 = (_417 * 0.5) + float3(0.5);
    float4 _857 = float4(_855.x, _855.y, _855.z, float4(0.0).w);
    _857.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _858 = float4(0.0);
    _858.x = _415;
    float4 _859 = _858;
    _859.y = _414;
    float4 _860 = _859;
    _860.z = fast::max(_413, fast::clamp((pow(fast::max(dot(_488, _488), dot(_489, _489)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _861 = _860;
    _861.w = 0.525490224361419677734375;
    float4 _873 = float4(_416.x, _416.y, _416.z, float4(0.0).w);
    _873.w = ((log2(((dot(_779, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_526 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_526 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_526 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_847.xyx * _847.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _843 * View.View_PreExposure;
    out.out_var_SV_Target1 = _857;
    out.out_var_SV_Target2 = _861;
    out.out_var_SV_Target3 = _873;
    out.out_var_SV_Target4 = _483;
    out.out_var_SV_Target5 = float4(_478, 1.0, 1.0, 1.0);
    return out;
}

