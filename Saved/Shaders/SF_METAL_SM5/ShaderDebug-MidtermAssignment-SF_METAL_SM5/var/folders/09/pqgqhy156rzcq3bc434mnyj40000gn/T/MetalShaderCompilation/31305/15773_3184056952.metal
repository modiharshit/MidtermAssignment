

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[124];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _149 = {};
constant float3 _150 = {};
constant float _152 = {};
constant float4 _153 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003d9d_bdc8da78(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _152, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _220 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _228 = in.in_var_PRIMITIVE_ID * 36u;
    uint _229 = _228 + 20u;
    float _276;
    float _277;
    float _278;
    float3 _279;
    float3 _280;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _247 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _251 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _247, level(0.0));
        float4 _254 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _247, level(0.0));
        float4 _257 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _247, level(0.0));
        float _267 = _257.w;
        _276 = _267 + _257.z;
        _277 = (0.5 * _267) + _257.y;
        _278 = _257.x;
        _279 = (float3(0.180000007152557373046875) * _251.w) + _251.xyz;
        _280 = normalize((_220 * _254.w) + ((_254.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _276 = 1.0;
        _277 = 0.5;
        _278 = 0.0;
        _279 = float3(0.180000007152557373046875);
        _280 = _220;
    }
    bool _290 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _296;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228 + 18u)].w > 0.0) && _290)
    {
        _296 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _296 = 1.0;
    }
    float _343;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229)].z > 0.0)
    {
        float3 _311 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _322 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_311.x), int(_311.y), int(_311.z), 0).xyz), 0));
        _343 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_322.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_311 / float3(_322.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _343 = _296;
    }
    float3 _366 = (((_279 - (_279 * _278)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _277), _279, float3(_278)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _439;
    if (_290)
    {
        float4 _389 = _153;
        _389.y = (-0.48860299587249755859375) * _280.y;
        float4 _392 = _389;
        _392.z = 0.48860299587249755859375 * _280.z;
        float4 _395 = _392;
        _395.w = (-0.48860299587249755859375) * _280.x;
        float3 _396 = _280 * _280;
        float4 _399 = _149;
        _399.x = (1.09254801273345947265625 * _280.x) * _280.y;
        float4 _402 = _399;
        _402.y = ((-1.09254801273345947265625) * _280.y) * _280.z;
        float4 _407 = _402;
        _407.z = 0.3153919875621795654296875 * ((3.0 * _396.z) - 1.0);
        float4 _410 = _407;
        _410.w = ((-1.09254801273345947265625) * _280.x) * _280.z;
        float4 _414 = _395;
        _414.x = 0.886227548122406005859375;
        float3 _416 = _414.yzw * 2.094395160675048828125;
        float4 _417 = float4(_414.x, _416.x, _416.y, _416.z);
        float4 _418 = _410 * 0.785398185253143310546875;
        float _419 = (_396.x - _396.y) * 0.4290426075458526611328125;
        float3 _425 = float3(0.0);
        _425.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _417) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _418)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _419);
        float3 _431 = _425;
        _431.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _417) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _418)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _419);
        float3 _437 = _431;
        _437.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _417) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _418)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _419);
        _439 = fast::max(float3(0.0), _437);
    }
    else
    {
        _439 = float3(0.0);
    }
    float _465;
    float _466;
    float3 _467;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _455;
        float _456;
        if (_290)
        {
            _455 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _456 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _455 = _280;
            _456 = 1.0;
        }
        float _457 = 1.0 - _456;
        float _459 = 1.0 - (_457 * _457);
        _465 = mix(fast::clamp(dot(_455, _280), 0.0, 1.0), 1.0, _459);
        _466 = _456;
        _467 = mix(_455, _280, float3(_459));
    }
    else
    {
        _465 = 1.0;
        _466 = 1.0;
        _467 = _280;
    }
    float4 _471 = float4(_467, 1.0);
    float3 _475 = _150;
    _475.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _471);
    float3 _479 = _475;
    _479.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _471);
    float3 _483 = _479;
    _483.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _471);
    float4 _486 = _471.xyzz * _471.yzzx;
    float3 _490 = _150;
    _490.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _486);
    float3 _494 = _490;
    _494.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _486);
    float3 _498 = _494;
    _498.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _486);
    float3 _513 = (_439 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_483 + _498) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_467.x * _467.x) - (_467.y * _467.y)))) * View.View_SkyLightColor.xyz) * (_466 * _465));
    float3 _533 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _562;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _561;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _228 + 19u)].xyz + float3(1.0))))
        {
            _561 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _561 = _533;
        }
        _562 = _561;
    }
    else
    {
        _562 = _533;
    }
    float4 _569 = float4(((mix(float3(0.0), _366, float3(View.View_UnlitViewmodeMask)) + ((_513 * _366) * fast::max(float3(1.0), ((((((_279 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_279 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_279 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _562) * 1.0, 0.0);
    float4 _576;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _575 = _569;
        _575.w = 0.0;
        _576 = _575;
    }
    else
    {
        _576 = _569;
    }
    float2 _580 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _588 = (_280 * 0.5) + float3(0.5);
    float4 _590 = float4(_588.x, _588.y, _588.z, float4(0.0).w);
    _590.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229)].y;
    float4 _591 = float4(0.0);
    _591.x = _278;
    float4 _592 = _591;
    _592.y = _277;
    float4 _593 = _592;
    _593.z = _276;
    float4 _594 = _593;
    _594.w = 0.50588238239288330078125;
    float4 _605 = float4(_279.x, _279.y, _279.z, float4(0.0).w);
    _605.w = ((log2((dot(_513, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_580.xyx * _580.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _576 * View.View_PreExposure;
    out.out_var_SV_Target1 = _590;
    out.out_var_SV_Target2 = _594;
    out.out_var_SV_Target3 = _605;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_343, 1.0, 1.0, 1.0);
    return out;
}

