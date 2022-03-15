

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD1_0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004adb_b97cb2f4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD1 = {};
    in_var_TEXCOORD1[0] = in.in_var_TEXCOORD1_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float4 _247 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _250 = (_247.xy * float2(2.0)) - float2(1.0);
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_250, sqrt(fast::clamp(1.0 - dot(_250, _250), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _281 = mix(0.4000000059604644775390625, 1.0, _279.x);
    float4 _285 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
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
    float4 _319 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
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
    float3 _558;
    if (_398)
    {
        float3 _510 = fast::clamp((_239 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _514 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _510);
        float4 _518 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _510);
        float4 _521 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _510);
        float4 _539 = _169;
        _539.y = (-0.48860299587249755859375) * _390.y;
        float4 _542 = _539;
        _542.z = 0.48860299587249755859375 * _390.z;
        float4 _545 = _542;
        _545.w = (-0.48860299587249755859375) * _390.x;
        float4 _546 = _545;
        _546.x = 0.886227548122406005859375;
        float3 _548 = _546.yzw * 2.094395160675048828125;
        float4 _549 = float4(_546.x, _548.x, _548.y, _548.z);
        float3 _551 = float3(0.0);
        _551.x = dot(float4(_514.x, _518.x, _521.x, _514.w), _549);
        float3 _553 = _551;
        _553.y = dot(float4(_514.y, _518.y, _521.y, _518.w), _549);
        float3 _555 = _553;
        _555.z = dot(float4(_514.z, _518.z, _521.zw), _549);
        _558 = fast::max(float3(0.0), _555) * float3(0.3183098733425140380859375);
    }
    else
    {
        _558 = float3(0.0);
    }
    float _584;
    float _585;
    float3 _586;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _574;
        float _575;
        if (_398)
        {
            _574 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _575 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _574 = _390;
            _575 = 1.0;
        }
        float _576 = 1.0 - _575;
        float _578 = 1.0 - (_576 * _576);
        _584 = mix(fast::clamp(dot(_574, _390), 0.0, 1.0), 1.0, _578);
        _585 = _575;
        _586 = mix(_574, _390, float3(_578));
    }
    else
    {
        _584 = 1.0;
        _585 = 1.0;
        _586 = _390;
    }
    float4 _590 = float4(_586, 1.0);
    float3 _594 = _167;
    _594.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _590);
    float3 _598 = _594;
    _598.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _590);
    float3 _602 = _598;
    _602.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _590);
    float4 _605 = _590.xyzz * _590.yzzx;
    float3 _609 = _167;
    _609.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _605);
    float3 _613 = _609;
    _613.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _605);
    float3 _617 = _613;
    _617.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _605);
    float3 _632 = (_558 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_602 + _617) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_586.x * _586.x) - (_586.y * _586.y)))) * View.View_SkyLightColor.xyz) * (_585 * _584));
    float3 _654 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _680;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _679;
        if (any(abs(_239 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _679 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _679 = _654;
        }
        _680 = _679;
    }
    else
    {
        _680 = _654;
    }
    float4 _687 = float4(((mix(float3(0.0), _480 + (_482 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_632 * _480) * fast::max(float3(1.0), ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _680) * 1.0, 0.0);
    float4 _694;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _693 = _687;
        _693.w = 0.0;
        _694 = _693;
    }
    else
    {
        _694 = _687;
    }
    float2 _698 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _706 = (_390 * 0.5) + float3(0.5);
    float4 _708 = float4(_706.x, _706.y, _706.z, float4(0.0).w);
    _708.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _709 = float4(0.0);
    _709.x = _388;
    float4 _710 = _709;
    _710.y = _387;
    float4 _711 = _710;
    _711.z = _386;
    float4 _712 = _711;
    _712.w = 0.50588238239288330078125;
    float4 _724 = float4(_389.x, _389.y, _389.z, float4(0.0).w);
    _724.w = ((log2(((dot(_632, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_484 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_484 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_484 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_698.xyx * _698.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _694 * View.View_PreExposure;
    out.out_var_SV_Target1 = _708;
    out.out_var_SV_Target2 = _712;
    out.out_var_SV_Target3 = _724;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_451, 1.0, 1.0, 1.0);
    return out;
}

