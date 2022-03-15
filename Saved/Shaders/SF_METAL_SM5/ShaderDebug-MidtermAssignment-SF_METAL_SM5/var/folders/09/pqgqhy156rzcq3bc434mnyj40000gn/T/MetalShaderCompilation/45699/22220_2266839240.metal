

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
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _167 = {};
constant float3 _168 = {};
constant float _170 = {};
constant float4 _171 = {};
constant float3 _172 = {};

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

fragment MainPS_out Main_000056cc_871d38c8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float3x3 _228 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _240 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _170, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _245 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _250 = (_245.xyz / float3(_245.w)) - View.View_PreViewTranslation;
    float3 _255 = (Primitive.Primitive_LocalToWorld * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _267 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _270 = (float3(-0.5) + _267.xyz) * 2.0;
    float3 _286 = ((((_255 / float3(sqrt(dot(_255, _255)))) * _228) * (-1.0)) * _270.z) + (float3(_270.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _228));
    float3 _298 = normalize(_228 * normalize(((_286 / float3(sqrt(dot(_286, _286)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _309 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _316 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _332 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _332) : (in.in_var_COLOR1.w < _332)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((_309.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _347 = fast::clamp(_309.xyz, float3(0.0), float3(1.0));
    float _352 = (fast::clamp(_267.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _362 = (fast::clamp(float4(_316.xyz, _167).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _410;
    float _411;
    float _412;
    float _413;
    float3 _414;
    float3 _415;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _379 = ((_240.xy / float2(_240.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _383 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _386 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float _391 = _383.w;
        float _399 = _389.w;
        _410 = _362 * _391;
        _411 = (_352 * _399) + _389.z;
        _412 = (0.5 * _399) + _389.y;
        _413 = _389.x;
        _414 = (_347 * _391) + _383.xyz;
        _415 = normalize((_298 * _386.w) + ((_386.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _410 = _362;
        _411 = _352;
        _412 = 0.5;
        _413 = 0.0;
        _414 = _347;
        _415 = _298;
    }
    bool _423 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _429;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _423)
    {
        _429 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _429 = 1.0;
    }
    float _476;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _444 = fast::clamp((_250 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _455 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_444.x), int(_444.y), int(_444.z), 0).xyz), 0));
        _476 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_455.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_444 / float3(_455.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _476 = _429;
    }
    float3 _479 = sqrt(fast::clamp(_410, float3(0.0), float3(1.0)));
    float4 _481 = float4(_479.x, _479.y, _479.z, float4(0.0).w);
    _481.w = 1.0;
    float3 _486 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _487 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _505 = ((_414 - (_414 * _413)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _512 = (mix(float3(0.07999999821186065673828125 * _412), _414, float3(_413)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _515 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _520;
    if (_515)
    {
        _520 = _505 + (_512 * 0.449999988079071044921875);
    }
    else
    {
        _520 = _505;
    }
    float3 _522 = select(_512, float3(0.0), bool3(_515));
    float3 _524 = float3(dot(_522, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _620;
    float3 _621;
    if (_423)
    {
        float3 _550 = fast::clamp((_250 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _554 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _550);
        float4 _558 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _550);
        float4 _561 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _550);
        float4 _566 = float4(_554.x, _558.x, _561.x, _554.w);
        float4 _571 = float4(_554.y, _558.y, _561.y, _558.w);
        float4 _576 = float4(_554.z, _558.z, _561.zw);
        float4 _579 = _171;
        _579.y = (-0.48860299587249755859375) * _415.y;
        float4 _582 = _579;
        _582.z = 0.48860299587249755859375 * _415.z;
        float4 _585 = _582;
        _585.w = (-0.48860299587249755859375) * _415.x;
        float4 _586 = _585;
        _586.x = 0.886227548122406005859375;
        float3 _588 = _586.yzw * 2.094395160675048828125;
        float4 _589 = float4(_586.x, _588.x, _588.y, _588.z);
        float3 _591 = float3(0.0);
        _591.x = dot(_566, _589);
        float3 _593 = _591;
        _593.y = dot(_571, _589);
        float3 _595 = _593;
        _595.z = dot(_576, _589);
        float3 _598 = -_415;
        float4 _601 = _171;
        _601.y = (-0.48860299587249755859375) * _598.y;
        float4 _604 = _601;
        _604.z = 0.48860299587249755859375 * _598.z;
        float4 _607 = _604;
        _607.w = (-0.48860299587249755859375) * _598.x;
        float4 _608 = _607;
        _608.x = 0.886227548122406005859375;
        float3 _610 = _608.yzw * 2.094395160675048828125;
        float4 _611 = float4(_608.x, _610.x, _610.y, _610.z);
        float3 _613 = _172;
        _613.x = dot(_566, _611);
        float3 _615 = _613;
        _615.y = dot(_571, _611);
        float3 _617 = _615;
        _617.z = dot(_576, _611);
        _620 = fast::max(float3(0.0), _617) * float3(0.3183098733425140380859375);
        _621 = fast::max(float3(0.0), _595) * float3(0.3183098733425140380859375);
    }
    else
    {
        _620 = float3(0.0);
        _621 = float3(0.0);
    }
    float _648;
    float _649;
    float3 _650;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _638;
        float _639;
        if (_423)
        {
            _638 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _639 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _638 = _415;
            _639 = 1.0;
        }
        float _640 = 1.0 - _639;
        float _642 = 1.0 - (_640 * _640);
        _648 = mix(fast::clamp(dot(_638, _415), 0.0, 1.0), 1.0, _642);
        _649 = _639;
        _650 = mix(_638, _415, float3(_642));
    }
    else
    {
        _648 = 1.0;
        _649 = 1.0;
        _650 = _415;
    }
    float4 _654 = float4(_650, 1.0);
    float3 _658 = _168;
    _658.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _654);
    float3 _662 = _658;
    _662.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _654);
    float3 _666 = _662;
    _666.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _654);
    float4 _669 = _654.xyzz * _654.yzzx;
    float3 _673 = _168;
    _673.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _669);
    float3 _677 = _673;
    _677.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _669);
    float3 _681 = _677;
    _681.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _669);
    float3 _696 = -_415;
    float _697 = _696.x;
    float _698 = _696.y;
    float4 _700 = float4(_697, _698, _696.z, 1.0);
    float3 _703 = _172;
    _703.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _700);
    float3 _706 = _703;
    _706.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _700);
    float3 _709 = _706;
    _709.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _700);
    float4 _712 = _700.xyzz * _700.yzzx;
    float3 _715 = _172;
    _715.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _712);
    float3 _718 = _715;
    _718.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _712);
    float3 _721 = _718;
    _721.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _712);
    float3 _734 = (_621 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_666 + _681) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_650.x * _650.x) - (_650.y * _650.y)))) * View.View_SkyLightColor.xyz) * (_649 * _648));
    float3 _758 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _784;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _783;
        if (any(abs(_250 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _783 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_250, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _783 = _758;
        }
        _784 = _783;
    }
    else
    {
        _784 = _758;
    }
    float4 _791 = float4(((mix(float3(0.0), _520 + (_522 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_734 * _520) + (((_620 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_709 + _721) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_697 * _697) - (_698 * _698)))) * View.View_SkyLightColor.xyz) * _649)) * _410)) * fast::max(float3(1.0), ((((((_414 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_414 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_414 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _784) * 1.0, 0.0);
    float4 _798;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _797 = _791;
        _797.w = 0.0;
        _798 = _797;
    }
    else
    {
        _798 = _791;
    }
    float2 _802 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _810 = (_415 * 0.5) + float3(0.5);
    float4 _812 = float4(_810.x, _810.y, _810.z, float4(0.0).w);
    _812.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _813 = float4(0.0);
    _813.x = _413;
    float4 _814 = _813;
    _814.y = _412;
    float4 _815 = _814;
    _815.z = fast::max(_411, fast::clamp((pow(fast::max(dot(_486, _486), dot(_487, _487)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _816 = _815;
    _816.w = 0.525490224361419677734375;
    float4 _828 = float4(_414.x, _414.y, _414.z, float4(0.0).w);
    _828.w = ((log2(((dot(_734, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_524 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_524 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_524 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_802.xyx * _802.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _798 * View.View_PreExposure;
    out.out_var_SV_Target1 = _812;
    out.out_var_SV_Target2 = _816;
    out.out_var_SV_Target3 = _828;
    out.out_var_SV_Target4 = _481;
    out.out_var_SV_Target5 = float4(_476, 1.0, 1.0, 1.0);
    return out;
}

