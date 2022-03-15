

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

constant float3 _164 = {};
constant float4 _166 = {};

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

fragment MainPS_out Main_00004a9e_c02e404e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = (_231.xyz / float3(_231.w)) - View.View_PreViewTranslation;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0].xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _247 = (_244.xy * float2(2.0)) - float2(1.0);
    float3 _264 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_247, sqrt(fast::clamp(1.0 - dot(_247, _247), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _278 = mix(0.4000000059604644775390625, 1.0, _276.x);
    float4 _282 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _307;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _307 = _227.w;
                break;
            }
            else
            {
                float _291 = _227.z;
                _307 = ((_291 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_291 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _311 = fast::min(fast::max((_307 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _312 = _282.y;
    float4 _316 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0].xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _318 = _316.y;
    float3 _331 = fast::clamp(float3(mix(_278, 1.0 - _278, mix(_312, 1.0, _311)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_318 + mix(_312, 0.0, _311), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _336 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _318) + mix(mix(0.699999988079071044921875, 1.0, _312), 1.0, _311), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _383;
    float _384;
    float _385;
    float3 _386;
    float3 _387;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _353 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _357 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _360 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _363 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float _373 = _363.w;
        _383 = (_336 * _373) + _363.z;
        _384 = (0.5 * _373) + _363.y;
        _385 = _363.x;
        _386 = (_331 * _357.w) + _357.xyz;
        _387 = normalize((_264 * _360.w) + ((_360.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _383 = _336;
        _384 = 0.5;
        _385 = 0.0;
        _386 = _331;
        _387 = _264;
    }
    bool _395 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _401;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _395)
    {
        _401 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _401 = 1.0;
    }
    float _448;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _416 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _427 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_416.x), int(_416.y), int(_416.z), 0).xyz), 0));
        _448 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_427.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_416 / float3(_427.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _448 = _401;
    }
    float3 _462 = ((_386 - (_386 * _385)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _469 = (mix(float3(0.07999999821186065673828125 * _384), _386, float3(_385)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _472 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _477;
    if (_472)
    {
        _477 = _462 + (_469 * 0.449999988079071044921875);
    }
    else
    {
        _477 = _462;
    }
    float3 _479 = select(_469, float3(0.0), bool3(_472));
    float3 _481 = float3(dot(_479, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _555;
    if (_395)
    {
        float3 _507 = fast::clamp((_236 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _511 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _507);
        float4 _515 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _507);
        float4 _518 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _507);
        float4 _536 = _166;
        _536.y = (-0.48860299587249755859375) * _387.y;
        float4 _539 = _536;
        _539.z = 0.48860299587249755859375 * _387.z;
        float4 _542 = _539;
        _542.w = (-0.48860299587249755859375) * _387.x;
        float4 _543 = _542;
        _543.x = 0.886227548122406005859375;
        float3 _545 = _543.yzw * 2.094395160675048828125;
        float4 _546 = float4(_543.x, _545.x, _545.y, _545.z);
        float3 _548 = float3(0.0);
        _548.x = dot(float4(_511.x, _515.x, _518.x, _511.w), _546);
        float3 _550 = _548;
        _550.y = dot(float4(_511.y, _515.y, _518.y, _515.w), _546);
        float3 _552 = _550;
        _552.z = dot(float4(_511.z, _515.z, _518.zw), _546);
        _555 = fast::max(float3(0.0), _552) * float3(0.3183098733425140380859375);
    }
    else
    {
        _555 = float3(0.0);
    }
    float _581;
    float _582;
    float3 _583;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _571;
        float _572;
        if (_395)
        {
            _571 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _572 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _571 = _387;
            _572 = 1.0;
        }
        float _573 = 1.0 - _572;
        float _575 = 1.0 - (_573 * _573);
        _581 = mix(fast::clamp(dot(_571, _387), 0.0, 1.0), 1.0, _575);
        _582 = _572;
        _583 = mix(_571, _387, float3(_575));
    }
    else
    {
        _581 = 1.0;
        _582 = 1.0;
        _583 = _387;
    }
    float4 _587 = float4(_583, 1.0);
    float3 _591 = _164;
    _591.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _587);
    float3 _595 = _591;
    _595.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _587);
    float3 _599 = _595;
    _599.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _587);
    float4 _602 = _587.xyzz * _587.yzzx;
    float3 _606 = _164;
    _606.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _602);
    float3 _610 = _606;
    _610.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _602);
    float3 _614 = _610;
    _614.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _602);
    float3 _629 = (_555 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_599 + _614) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_583.x * _583.x) - (_583.y * _583.y)))) * View.View_SkyLightColor.xyz) * (_582 * _581));
    float3 _651 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _677;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _676;
        if (any(abs(_236 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _676 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _676 = _651;
        }
        _677 = _676;
    }
    else
    {
        _677 = _651;
    }
    float4 _684 = float4(((mix(float3(0.0), _477 + (_479 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_629 * _477) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _677) * 1.0, 0.0);
    float4 _691;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _690 = _684;
        _690.w = 0.0;
        _691 = _690;
    }
    else
    {
        _691 = _684;
    }
    float2 _695 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _703 = (_387 * 0.5) + float3(0.5);
    float4 _705 = float4(_703.x, _703.y, _703.z, float4(0.0).w);
    _705.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _706 = float4(0.0);
    _706.x = _385;
    float4 _707 = _706;
    _707.y = _384;
    float4 _708 = _707;
    _708.z = _383;
    float4 _709 = _708;
    _709.w = 0.50588238239288330078125;
    float4 _721 = float4(_386.x, _386.y, _386.z, float4(0.0).w);
    _721.w = ((log2(((dot(_629, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_481 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_481 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_481 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_695.xyx * _695.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _691 * View.View_PreExposure;
    out.out_var_SV_Target1 = _705;
    out.out_var_SV_Target2 = _709;
    out.out_var_SV_Target3 = _721;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_448, 1.0, 1.0, 1.0);
    return out;
}

