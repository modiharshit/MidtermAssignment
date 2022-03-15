

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
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
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _182 = {};
constant float3 _183 = {};
constant float4 _185 = {};

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

fragment MainPS_out Main_00005152_8f1d80af(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _246 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _250 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _255 = (_250.xyz / float3(_250.w)) - View.View_PreViewTranslation;
    float2 _262 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _268 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float _278 = sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)) + 1.0;
    float _286 = sin(((_255.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _293 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_286 * (-0.0599999986588954925537109375), _286 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _296 = (_293.xy * float2(2.0)) - float2(1.0);
    float3 _305 = float4(_296, sqrt(fast::clamp(1.0 - dot(_296, _296), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _308 = float3(_271, _278);
    float3 _312 = float3(_305.xy * (-1.0), _305.z);
    float3 _316 = (_308 * dot(_308, _312)) - (_312 * _278);
    float _318 = _316.z + 1.0;
    float2 _322 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _324 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _322, bias(View.View_MaterialTextureMipBias));
    float2 _327 = (_324.xy * float2(2.0)) - float2(1.0);
    float4 _339 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _366;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _366 = _246.w;
                break;
            }
            else
            {
                float _350 = _246.z;
                _366 = ((_350 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_350 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _373 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _339.x) + _366) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _374 = mix(float4(_327, sqrt(fast::clamp(1.0 - dot(_327, _327), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _373);
    float3 _379 = float3(_316.xy, _318);
    float3 _383 = float3(_374.xy * (-1.0), _374.z);
    float3 _395 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_379 * dot(_379, _383)) - (_383 * _318)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _406 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _322, bias(View.View_MaterialTextureMipBias));
    float4 _408 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float3 _423 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_406.x * _408.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _373), float3(0.0), float3(1.0));
    float _427 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _428 = in.in_var_PRIMITIVE_ID * 36u;
    uint _429 = _428 + 20u;
    float _477;
    float _478;
    float _479;
    float3 _480;
    float3 _481;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _429)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _447 = ((_246.xy / float2(_246.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _451 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _447, level(0.0));
        float4 _454 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _447, level(0.0));
        float4 _457 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _447, level(0.0));
        float _467 = _457.w;
        _477 = (_427 * _467) + _457.z;
        _478 = (0.5 * _467) + _457.y;
        _479 = _457.x;
        _480 = (_423 * _451.w) + _451.xyz;
        _481 = normalize((_395 * _454.w) + ((_454.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _477 = _427;
        _478 = 0.5;
        _479 = 0.0;
        _480 = _423;
        _481 = _395;
    }
    bool _491 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _497;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _428 + 18u)].w > 0.0) && _491)
    {
        _497 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _497 = 1.0;
    }
    float _544;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _429)].z > 0.0)
    {
        float3 _512 = fast::clamp((_255 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _523 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_512.x), int(_512.y), int(_512.z), 0).xyz), 0));
        _544 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_523.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_512 / float3(_523.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _544 = _497;
    }
    float3 _558 = ((_480 - (_480 * _479)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _565 = (mix(float3(0.07999999821186065673828125 * _478), _480, float3(_479)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _568 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _573;
    if (_568)
    {
        _573 = _558 + (_565 * 0.449999988079071044921875);
    }
    else
    {
        _573 = _558;
    }
    float3 _575 = select(_565, float3(0.0), bool3(_568));
    float3 _577 = float3(dot(_575, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _663;
    if (_491)
    {
        float4 _613 = _185;
        _613.y = (-0.48860299587249755859375) * _481.y;
        float4 _616 = _613;
        _616.z = 0.48860299587249755859375 * _481.z;
        float4 _619 = _616;
        _619.w = (-0.48860299587249755859375) * _481.x;
        float3 _620 = _481 * _481;
        float4 _623 = _182;
        _623.x = (1.09254801273345947265625 * _481.x) * _481.y;
        float4 _626 = _623;
        _626.y = ((-1.09254801273345947265625) * _481.y) * _481.z;
        float4 _631 = _626;
        _631.z = 0.3153919875621795654296875 * ((3.0 * _620.z) - 1.0);
        float4 _634 = _631;
        _634.w = ((-1.09254801273345947265625) * _481.x) * _481.z;
        float4 _638 = _619;
        _638.x = 0.886227548122406005859375;
        float3 _640 = _638.yzw * 2.094395160675048828125;
        float4 _641 = float4(_638.x, _640.x, _640.y, _640.z);
        float4 _642 = _634 * 0.785398185253143310546875;
        float _643 = (_620.x - _620.y) * 0.4290426075458526611328125;
        float3 _649 = float3(0.0);
        _649.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _641) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _642)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _643);
        float3 _655 = _649;
        _655.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _641) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _642)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _643);
        float3 _661 = _655;
        _661.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _641) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _642)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _643);
        _663 = fast::max(float3(0.0), _661);
    }
    else
    {
        _663 = float3(0.0);
    }
    float _689;
    float _690;
    float3 _691;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _679;
        float _680;
        if (_491)
        {
            _679 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _680 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _679 = _481;
            _680 = 1.0;
        }
        float _681 = 1.0 - _680;
        float _683 = 1.0 - (_681 * _681);
        _689 = mix(fast::clamp(dot(_679, _481), 0.0, 1.0), 1.0, _683);
        _690 = _680;
        _691 = mix(_679, _481, float3(_683));
    }
    else
    {
        _689 = 1.0;
        _690 = 1.0;
        _691 = _481;
    }
    float4 _695 = float4(_691, 1.0);
    float3 _699 = _183;
    _699.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _695);
    float3 _703 = _699;
    _703.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _695);
    float3 _707 = _703;
    _707.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _695);
    float4 _710 = _695.xyzz * _695.yzzx;
    float3 _714 = _183;
    _714.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _710);
    float3 _718 = _714;
    _718.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _710);
    float3 _722 = _718;
    _722.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _710);
    float3 _737 = (_663 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_707 + _722) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_691.x * _691.x) - (_691.y * _691.y)))) * View.View_SkyLightColor.xyz) * (_690 * _689));
    float3 _759 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _788;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _787;
        if (any(abs(_255 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _428 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _428 + 19u)].xyz + float3(1.0))))
        {
            _787 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_255, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _787 = _759;
        }
        _788 = _787;
    }
    else
    {
        _788 = _759;
    }
    float4 _795 = float4(((mix(float3(0.0), _573 + (_575 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_737 * _573) * fast::max(float3(1.0), ((((((_480 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_480 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_480 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _788) * 1.0, 0.0);
    float4 _802;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _801 = _795;
        _801.w = 0.0;
        _802 = _801;
    }
    else
    {
        _802 = _795;
    }
    float2 _806 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _814 = (_481 * 0.5) + float3(0.5);
    float4 _816 = float4(_814.x, _814.y, _814.z, float4(0.0).w);
    _816.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _429)].y;
    float4 _817 = float4(0.0);
    _817.x = _479;
    float4 _818 = _817;
    _818.y = _478;
    float4 _819 = _818;
    _819.z = _477;
    float4 _820 = _819;
    _820.w = 0.50588238239288330078125;
    float4 _832 = float4(_480.x, _480.y, _480.z, float4(0.0).w);
    _832.w = ((log2(((dot(_737, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_577 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_577 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_577 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_806.xyx * _806.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _802 * View.View_PreExposure;
    out.out_var_SV_Target1 = _816;
    out.out_var_SV_Target2 = _820;
    out.out_var_SV_Target3 = _832;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_544, 1.0, 1.0, 1.0);
    return out;
}

