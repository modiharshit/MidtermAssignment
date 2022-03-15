

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

constant float3 _165 = {};
constant float4 _167 = {};

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
    float4 in_var_TEXCOORD3_0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004b18_1a09bffb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float3 _265 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _279 = mix(0.4000000059604644775390625, 1.0, _277.x);
    float4 _283 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _308;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _308 = _228.w;
                break;
            }
            else
            {
                float _292 = _228.z;
                _308 = ((_292 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_292 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _312 = fast::min(fast::max((_308 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _313 = _283.y;
    float4 _317 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _319 = _317.y;
    float3 _332 = fast::clamp(float3(mix(_279, 1.0 - _279, mix(_313, 1.0, _312)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_319 + mix(_313, 0.0, _312), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _337 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _319) + mix(mix(0.699999988079071044921875, 1.0, _313), 1.0, _312), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _384;
    float _385;
    float _386;
    float3 _387;
    float3 _388;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _354 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _358 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float4 _364 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _354, level(0.0));
        float _374 = _364.w;
        _384 = (_337 * _374) + _364.z;
        _385 = (0.5 * _374) + _364.y;
        _386 = _364.x;
        _387 = (_332 * _358.w) + _358.xyz;
        _388 = normalize((_265 * _361.w) + ((_361.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _384 = _337;
        _385 = 0.5;
        _386 = 0.0;
        _387 = _332;
        _388 = _265;
    }
    bool _396 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _402;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _396)
    {
        _402 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _402 = 1.0;
    }
    float _449;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _417 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _428 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_417.x), int(_417.y), int(_417.z), 0).xyz), 0));
        _449 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_428.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_417 / float3(_428.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _449 = _402;
    }
    float3 _463 = ((_387 - (_387 * _386)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _470 = (mix(float3(0.07999999821186065673828125 * _385), _387, float3(_386)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _473 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _478;
    if (_473)
    {
        _478 = _463 + (_470 * 0.449999988079071044921875);
    }
    else
    {
        _478 = _463;
    }
    float3 _480 = select(_470, float3(0.0), bool3(_473));
    float3 _482 = float3(dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _556;
    if (_396)
    {
        float3 _508 = fast::clamp((_237 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _512 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _508);
        float4 _516 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _508);
        float4 _519 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _508);
        float4 _537 = _167;
        _537.y = (-0.48860299587249755859375) * _388.y;
        float4 _540 = _537;
        _540.z = 0.48860299587249755859375 * _388.z;
        float4 _543 = _540;
        _543.w = (-0.48860299587249755859375) * _388.x;
        float4 _544 = _543;
        _544.x = 0.886227548122406005859375;
        float3 _546 = _544.yzw * 2.094395160675048828125;
        float4 _547 = float4(_544.x, _546.x, _546.y, _546.z);
        float3 _549 = float3(0.0);
        _549.x = dot(float4(_512.x, _516.x, _519.x, _512.w), _547);
        float3 _551 = _549;
        _551.y = dot(float4(_512.y, _516.y, _519.y, _516.w), _547);
        float3 _553 = _551;
        _553.z = dot(float4(_512.z, _516.z, _519.zw), _547);
        _556 = fast::max(float3(0.0), _553) * float3(0.3183098733425140380859375);
    }
    else
    {
        _556 = float3(0.0);
    }
    float _582;
    float _583;
    float3 _584;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _572;
        float _573;
        if (_396)
        {
            _572 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _573 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _572 = _388;
            _573 = 1.0;
        }
        float _574 = 1.0 - _573;
        float _576 = 1.0 - (_574 * _574);
        _582 = mix(fast::clamp(dot(_572, _388), 0.0, 1.0), 1.0, _576);
        _583 = _573;
        _584 = mix(_572, _388, float3(_576));
    }
    else
    {
        _582 = 1.0;
        _583 = 1.0;
        _584 = _388;
    }
    float4 _588 = float4(_584, 1.0);
    float3 _592 = _165;
    _592.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _588);
    float3 _596 = _592;
    _596.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _588);
    float3 _600 = _596;
    _600.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _588);
    float4 _603 = _588.xyzz * _588.yzzx;
    float3 _607 = _165;
    _607.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _603);
    float3 _611 = _607;
    _611.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _603);
    float3 _615 = _611;
    _615.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _603);
    float3 _630 = (_556 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_600 + _615) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_584.x * _584.x) - (_584.y * _584.y)))) * View.View_SkyLightColor.xyz) * (_583 * _582));
    float3 _652 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _678;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _677;
        if (any(abs(_237 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _677 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _677 = _652;
        }
        _678 = _677;
    }
    else
    {
        _678 = _652;
    }
    float4 _685 = float4(((mix(float3(0.0), _478 + (_480 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_630 * _478) * fast::max(float3(1.0), ((((((_387 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_387 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_387 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _678) * 1.0, 0.0);
    float4 _692;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _691 = _685;
        _691.w = 0.0;
        _692 = _691;
    }
    else
    {
        _692 = _685;
    }
    float2 _696 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _704 = (_388 * 0.5) + float3(0.5);
    float4 _706 = float4(_704.x, _704.y, _704.z, float4(0.0).w);
    _706.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _707 = float4(0.0);
    _707.x = _386;
    float4 _708 = _707;
    _708.y = _385;
    float4 _709 = _708;
    _709.z = _384;
    float4 _710 = _709;
    _710.w = 0.50588238239288330078125;
    float4 _722 = float4(_387.x, _387.y, _387.z, float4(0.0).w);
    _722.w = ((log2(((dot(_630, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_482 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_482 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_482 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_696.xyx * _696.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _692 * View.View_PreExposure;
    out.out_var_SV_Target1 = _706;
    out.out_var_SV_Target2 = _710;
    out.out_var_SV_Target3 = _722;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_449, 1.0, 1.0, 1.0);
    return out;
}

