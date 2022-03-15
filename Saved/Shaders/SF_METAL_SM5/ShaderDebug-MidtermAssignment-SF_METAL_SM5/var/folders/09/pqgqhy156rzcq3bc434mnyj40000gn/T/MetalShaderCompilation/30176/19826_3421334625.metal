

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_LandscapeParameters
{
    char _m0_pad[144];
    float4x4 LandscapeParameters_LocalToWorldNoScaling;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

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
    float4 in_var_TEXCOORD1 [[user(locn1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004d72_cbed6c61(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> LandscapeParameters_NormalmapTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler LandscapeParameters_NormalmapTextureSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _214 = LandscapeParameters_NormalmapTexture.sample(LandscapeParameters_NormalmapTextureSampler, in.in_var_TEXCOORD1.zw);
    float2 _219 = (float2(_214.zw) * float2(2.0)) - float2(1.0);
    float _223 = sqrt(fast::max(1.0 - dot(_219, _219), 0.0));
    float _224 = _219.x;
    float3 _226 = float3(_224, _219.y, _223);
    float3 _229 = normalize(float3(_223, 0.0, -_224));
    float4 _253 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _257 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _262 = (_257.xyz / float3(_257.w)) - View.View_PreViewTranslation;
    float4 _270 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _273 = (_270.xy * float2(2.0)) - float2(1.0);
    float3 _290 = normalize((float3x3(LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[0].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[1].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[2].xyz) * float3x3(_229, cross(_226, _229), _226)) * normalize(((float4(_273, sqrt(fast::clamp(1.0 - dot(_273, _273), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _302 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _304 = mix(0.4000000059604644775390625, 1.0, _302.x);
    float4 _308 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _333;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _333 = _253.w;
                break;
            }
            else
            {
                float _317 = _253.z;
                _333 = ((_317 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_317 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _337 = fast::min(fast::max((_333 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _338 = _308.y;
    float4 _342 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _344 = _342.y;
    float3 _357 = fast::clamp(float3(mix(_304, 1.0 - _304, mix(_338, 1.0, _337)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_344 + mix(_338, 0.0, _337), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _362 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _344) + mix(mix(0.699999988079071044921875, 1.0, _338), 1.0, _337), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _409;
    float _410;
    float _411;
    float3 _412;
    float3 _413;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _379 = ((_253.xy / float2(_253.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _383 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _386 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _379, level(0.0));
        float _399 = _389.w;
        _409 = (_362 * _399) + _389.z;
        _410 = (0.5 * _399) + _389.y;
        _411 = _389.x;
        _412 = (_357 * _383.w) + _383.xyz;
        _413 = normalize((_290 * _386.w) + ((_386.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _409 = _362;
        _410 = 0.5;
        _411 = 0.0;
        _412 = _357;
        _413 = _290;
    }
    bool _421 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _427;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _421)
    {
        _427 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _427 = 1.0;
    }
    float _474;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _442 = fast::clamp((_262 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _453 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_442.x), int(_442.y), int(_442.z), 0).xyz), 0));
        _474 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_453.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_442 / float3(_453.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _474 = _427;
    }
    float3 _488 = ((_412 - (_412 * _411)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _495 = (mix(float3(0.07999999821186065673828125 * _410), _412, float3(_411)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _498 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _503;
    if (_498)
    {
        _503 = _488 + (_495 * 0.449999988079071044921875);
    }
    else
    {
        _503 = _488;
    }
    float3 _505 = select(_495, float3(0.0), bool3(_498));
    float3 _507 = float3(dot(_505, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _581;
    if (_421)
    {
        float3 _533 = fast::clamp((_262 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _537 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _533);
        float4 _541 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _533);
        float4 _544 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _533);
        float4 _562 = _169;
        _562.y = (-0.48860299587249755859375) * _413.y;
        float4 _565 = _562;
        _565.z = 0.48860299587249755859375 * _413.z;
        float4 _568 = _565;
        _568.w = (-0.48860299587249755859375) * _413.x;
        float4 _569 = _568;
        _569.x = 0.886227548122406005859375;
        float3 _571 = _569.yzw * 2.094395160675048828125;
        float4 _572 = float4(_569.x, _571.x, _571.y, _571.z);
        float3 _574 = float3(0.0);
        _574.x = dot(float4(_537.x, _541.x, _544.x, _537.w), _572);
        float3 _576 = _574;
        _576.y = dot(float4(_537.y, _541.y, _544.y, _541.w), _572);
        float3 _578 = _576;
        _578.z = dot(float4(_537.z, _541.z, _544.zw), _572);
        _581 = fast::max(float3(0.0), _578) * float3(0.3183098733425140380859375);
    }
    else
    {
        _581 = float3(0.0);
    }
    float _607;
    float _608;
    float3 _609;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _597;
        float _598;
        if (_421)
        {
            _597 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _598 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _597 = _413;
            _598 = 1.0;
        }
        float _599 = 1.0 - _598;
        float _601 = 1.0 - (_599 * _599);
        _607 = mix(fast::clamp(dot(_597, _413), 0.0, 1.0), 1.0, _601);
        _608 = _598;
        _609 = mix(_597, _413, float3(_601));
    }
    else
    {
        _607 = 1.0;
        _608 = 1.0;
        _609 = _413;
    }
    float4 _613 = float4(_609, 1.0);
    float3 _617 = _167;
    _617.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _613);
    float3 _621 = _617;
    _621.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _613);
    float3 _625 = _621;
    _625.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _613);
    float4 _628 = _613.xyzz * _613.yzzx;
    float3 _632 = _167;
    _632.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _628);
    float3 _636 = _632;
    _636.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _628);
    float3 _640 = _636;
    _640.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _628);
    float3 _655 = (_581 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_625 + _640) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_609.x * _609.x) - (_609.y * _609.y)))) * View.View_SkyLightColor.xyz) * (_608 * _607));
    float3 _677 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _703;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _702;
        if (any(abs(_262 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _702 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_262, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _702 = _677;
        }
        _703 = _702;
    }
    else
    {
        _703 = _677;
    }
    float4 _710 = float4(((mix(float3(0.0), _503 + (_505 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_655 * _503) * fast::max(float3(1.0), ((((((_412 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_412 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_412 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _703) * 1.0, 0.0);
    float4 _717;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _716 = _710;
        _716.w = 0.0;
        _717 = _716;
    }
    else
    {
        _717 = _710;
    }
    float2 _721 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _729 = (_413 * 0.5) + float3(0.5);
    float4 _731 = float4(_729.x, _729.y, _729.z, float4(0.0).w);
    _731.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _732 = float4(0.0);
    _732.x = _411;
    float4 _733 = _732;
    _733.y = _410;
    float4 _734 = _733;
    _734.z = _409;
    float4 _735 = _734;
    _735.w = 0.50588238239288330078125;
    float4 _747 = float4(_412.x, _412.y, _412.z, float4(0.0).w);
    _747.w = ((log2(((dot(_655, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_507 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_507 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_507 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_721.xyx * _721.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _717 * View.View_PreExposure;
    out.out_var_SV_Target1 = _731;
    out.out_var_SV_Target2 = _735;
    out.out_var_SV_Target3 = _747;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_474, 1.0, 1.0, 1.0);
    return out;
}

