

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

constant float4 _151 = {};
constant float3 _152 = {};
constant float _154 = {};
constant float4 _155 = {};

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

fragment MainPS_out Main_0000414c_669a4678(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _154, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _237 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _238 = in.in_var_PRIMITIVE_ID * 36u;
    uint _239 = _238 + 20u;
    float _287;
    float _288;
    float _289;
    float3 _290;
    float3 _291;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _257 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _261 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _257, level(0.0));
        float4 _264 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _257, level(0.0));
        float4 _267 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _257, level(0.0));
        float _277 = _267.w;
        _287 = (_237 * _277) + _267.z;
        _288 = (0.5 * _277) + _267.y;
        _289 = _267.x;
        _290 = (float3(0.180000007152557373046875) * _261.w) + _261.xyz;
        _291 = normalize((_226 * _264.w) + ((_264.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _287 = _237;
        _288 = 0.5;
        _289 = 0.0;
        _290 = float3(0.180000007152557373046875);
        _291 = _226;
    }
    bool _301 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _307;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 18u)].w > 0.0) && _301)
    {
        _307 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _307 = 1.0;
    }
    float _354;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239)].z > 0.0)
    {
        float3 _322 = fast::clamp((_218 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _333 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_322.x), int(_322.y), int(_322.z), 0).xyz), 0));
        _354 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_333.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_322 / float3(_333.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _354 = _307;
    }
    float3 _368 = ((_290 - (_290 * _289)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _375 = (mix(float3(0.07999999821186065673828125 * _288), _290, float3(_289)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _378 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _383;
    if (_378)
    {
        _383 = _368 + (_375 * 0.449999988079071044921875);
    }
    else
    {
        _383 = _368;
    }
    float3 _385 = select(_375, float3(0.0), bool3(_378));
    float3 _387 = float3(dot(_385, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _473;
    if (_301)
    {
        float4 _423 = _155;
        _423.y = (-0.48860299587249755859375) * _291.y;
        float4 _426 = _423;
        _426.z = 0.48860299587249755859375 * _291.z;
        float4 _429 = _426;
        _429.w = (-0.48860299587249755859375) * _291.x;
        float3 _430 = _291 * _291;
        float4 _433 = _151;
        _433.x = (1.09254801273345947265625 * _291.x) * _291.y;
        float4 _436 = _433;
        _436.y = ((-1.09254801273345947265625) * _291.y) * _291.z;
        float4 _441 = _436;
        _441.z = 0.3153919875621795654296875 * ((3.0 * _430.z) - 1.0);
        float4 _444 = _441;
        _444.w = ((-1.09254801273345947265625) * _291.x) * _291.z;
        float4 _448 = _429;
        _448.x = 0.886227548122406005859375;
        float3 _450 = _448.yzw * 2.094395160675048828125;
        float4 _451 = float4(_448.x, _450.x, _450.y, _450.z);
        float4 _452 = _444 * 0.785398185253143310546875;
        float _453 = (_430.x - _430.y) * 0.4290426075458526611328125;
        float3 _459 = float3(0.0);
        _459.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _451) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _452)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _453);
        float3 _465 = _459;
        _465.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _451) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _452)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _453);
        float3 _471 = _465;
        _471.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _451) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _452)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _453);
        _473 = fast::max(float3(0.0), _471);
    }
    else
    {
        _473 = float3(0.0);
    }
    float _499;
    float _500;
    float3 _501;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _489;
        float _490;
        if (_301)
        {
            _489 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _490 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _489 = _291;
            _490 = 1.0;
        }
        float _491 = 1.0 - _490;
        float _493 = 1.0 - (_491 * _491);
        _499 = mix(fast::clamp(dot(_489, _291), 0.0, 1.0), 1.0, _493);
        _500 = _490;
        _501 = mix(_489, _291, float3(_493));
    }
    else
    {
        _499 = 1.0;
        _500 = 1.0;
        _501 = _291;
    }
    float4 _505 = float4(_501, 1.0);
    float3 _509 = _152;
    _509.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _505);
    float3 _513 = _509;
    _513.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _505);
    float3 _517 = _513;
    _517.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _505);
    float4 _520 = _505.xyzz * _505.yzzx;
    float3 _524 = _152;
    _524.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _520);
    float3 _528 = _524;
    _528.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _520);
    float3 _532 = _528;
    _532.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _520);
    float3 _547 = (_473 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_517 + _532) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_501.x * _501.x) - (_501.y * _501.y)))) * View.View_SkyLightColor.xyz) * (_500 * _499));
    float3 _569 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _598;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _597;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 19u)].xyz + float3(1.0))))
        {
            _597 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _597 = _569;
        }
        _598 = _597;
    }
    else
    {
        _598 = _569;
    }
    float4 _605 = float4(((mix(float3(0.0), _383 + (_385 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_547 * _383) * fast::max(float3(1.0), ((((((_290 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_290 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_290 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _598) * 1.0, 0.0);
    float4 _612;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _611 = _605;
        _611.w = 0.0;
        _612 = _611;
    }
    else
    {
        _612 = _605;
    }
    float2 _616 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _624 = (_291 * 0.5) + float3(0.5);
    float4 _626 = float4(_624.x, _624.y, _624.z, float4(0.0).w);
    _626.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239)].y;
    float4 _627 = float4(0.0);
    _627.x = _289;
    float4 _628 = _627;
    _628.y = _288;
    float4 _629 = _628;
    _629.z = _287;
    float4 _630 = _629;
    _630.w = 0.50588238239288330078125;
    float4 _642 = float4(_290.x, _290.y, _290.z, float4(0.0).w);
    _642.w = ((log2(((dot(_547, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_387 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_387 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_387 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_616.xyx * _616.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _612 * View.View_PreExposure;
    out.out_var_SV_Target1 = _626;
    out.out_var_SV_Target2 = _630;
    out.out_var_SV_Target3 = _642;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_354, 1.0, 1.0, 1.0);
    return out;
}

