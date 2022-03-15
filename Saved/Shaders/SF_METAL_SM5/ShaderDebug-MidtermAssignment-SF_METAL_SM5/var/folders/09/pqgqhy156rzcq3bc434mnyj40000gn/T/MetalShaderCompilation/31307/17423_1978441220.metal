

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float3 _154 = {};
constant float _156 = {};
constant float4 _157 = {};

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

fragment MainPS_out Main_0000440f_75ec9e04(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float3 _232 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _247 = fast::clamp(_245.xyz, float3(0.0), float3(1.0));
    float _251 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _252 = in.in_var_PRIMITIVE_ID * 36u;
    uint _253 = _252 + 20u;
    float _301;
    float _302;
    float _303;
    float3 _304;
    float3 _305;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _271 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _275 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float4 _281 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _271, level(0.0));
        float _291 = _281.w;
        _301 = (_251 * _291) + _281.z;
        _302 = (0.20000000298023223876953125 * _291) + _281.y;
        _303 = _281.x;
        _304 = (_247 * _275.w) + _275.xyz;
        _305 = normalize((_232 * _278.w) + ((_278.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _301 = _251;
        _302 = 0.20000000298023223876953125;
        _303 = 0.0;
        _304 = _247;
        _305 = _232;
    }
    bool _315 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _321;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _252 + 18u)].w > 0.0) && _315)
    {
        _321 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _321 = 1.0;
    }
    float _368;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].z > 0.0)
    {
        float3 _336 = fast::clamp((_224 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _347 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_336.x), int(_336.y), int(_336.z), 0).xyz), 0));
        _368 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_347.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_336 / float3(_347.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _368 = _321;
    }
    float3 _382 = ((_304 - (_304 * _303)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _389 = (mix(float3(0.07999999821186065673828125 * _302), _304, float3(_303)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _392 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _397;
    if (_392)
    {
        _397 = _382 + (_389 * 0.449999988079071044921875);
    }
    else
    {
        _397 = _382;
    }
    float3 _399 = select(_389, float3(0.0), bool3(_392));
    float3 _401 = float3(dot(_399, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _475;
    if (_315)
    {
        float3 _427 = fast::clamp((_224 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _431 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _427);
        float4 _435 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _427);
        float4 _438 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _427);
        float4 _456 = _157;
        _456.y = (-0.48860299587249755859375) * _305.y;
        float4 _459 = _456;
        _459.z = 0.48860299587249755859375 * _305.z;
        float4 _462 = _459;
        _462.w = (-0.48860299587249755859375) * _305.x;
        float4 _463 = _462;
        _463.x = 0.886227548122406005859375;
        float3 _465 = _463.yzw * 2.094395160675048828125;
        float4 _466 = float4(_463.x, _465.x, _465.y, _465.z);
        float3 _468 = float3(0.0);
        _468.x = dot(float4(_431.x, _435.x, _438.x, _431.w), _466);
        float3 _470 = _468;
        _470.y = dot(float4(_431.y, _435.y, _438.y, _435.w), _466);
        float3 _472 = _470;
        _472.z = dot(float4(_431.z, _435.z, _438.zw), _466);
        _475 = fast::max(float3(0.0), _472) * float3(0.3183098733425140380859375);
    }
    else
    {
        _475 = float3(0.0);
    }
    float _501;
    float _502;
    float3 _503;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _491;
        float _492;
        if (_315)
        {
            _491 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _492 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _491 = _305;
            _492 = 1.0;
        }
        float _493 = 1.0 - _492;
        float _495 = 1.0 - (_493 * _493);
        _501 = mix(fast::clamp(dot(_491, _305), 0.0, 1.0), 1.0, _495);
        _502 = _492;
        _503 = mix(_491, _305, float3(_495));
    }
    else
    {
        _501 = 1.0;
        _502 = 1.0;
        _503 = _305;
    }
    float4 _507 = float4(_503, 1.0);
    float3 _511 = _154;
    _511.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _507);
    float3 _515 = _511;
    _515.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _507);
    float3 _519 = _515;
    _519.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _507);
    float4 _522 = _507.xyzz * _507.yzzx;
    float3 _526 = _154;
    _526.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _522);
    float3 _530 = _526;
    _530.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _522);
    float3 _534 = _530;
    _534.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _522);
    float3 _549 = (_475 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_519 + _534) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_503.x * _503.x) - (_503.y * _503.y)))) * View.View_SkyLightColor.xyz) * (_502 * _501));
    float3 _571 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _600;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _599;
        if (any(abs(_224 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _252 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _252 + 19u)].xyz + float3(1.0))))
        {
            _599 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _599 = _571;
        }
        _600 = _599;
    }
    else
    {
        _600 = _571;
    }
    float4 _607 = float4(((mix(float3(0.0), _397 + (_399 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_549 * _397) * fast::max(float3(1.0), ((((((_304 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_304 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_304 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _600) * 1.0, 0.0);
    float4 _614;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _613 = _607;
        _613.w = 0.0;
        _614 = _613;
    }
    else
    {
        _614 = _607;
    }
    float2 _618 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _626 = (_305 * 0.5) + float3(0.5);
    float4 _628 = float4(_626.x, _626.y, _626.z, float4(0.0).w);
    _628.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253)].y;
    float4 _629 = float4(0.0);
    _629.x = _303;
    float4 _630 = _629;
    _630.y = _302;
    float4 _631 = _630;
    _631.z = _301;
    float4 _632 = _631;
    _632.w = 0.50588238239288330078125;
    float4 _644 = float4(_304.x, _304.y, _304.z, float4(0.0).w);
    _644.w = ((log2(((dot(_549, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_618.xyx * _618.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _614 * View.View_PreExposure;
    out.out_var_SV_Target1 = _628;
    out.out_var_SV_Target2 = _632;
    out.out_var_SV_Target3 = _644;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_368, 1.0, 1.0, 1.0);
    return out;
}

