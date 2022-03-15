

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

constant float4 _146 = {};
constant float3 _147 = {};
constant float _149 = {};
constant float4 _150 = {};

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
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004082_5b014e3f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _209 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _214 = (_209.xyz / float3(_209.w)) - View.View_PreViewTranslation;
    float3 _222 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _233 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _281;
    float _282;
    float _283;
    float3 _284;
    float3 _285;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _250 = ((_204.xy / float2(_204.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _254 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _257 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _260 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float _270 = _260.w;
        _281 = (_233 * _270) + _260.z;
        _282 = (0.5 * _270) + _260.y;
        _283 = _270 + _260.x;
        _284 = (float3(1.0) * _254.w) + _254.xyz;
        _285 = normalize((_222 * _257.w) + ((_257.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _281 = _233;
        _282 = 0.5;
        _283 = 1.0;
        _284 = float3(1.0);
        _285 = _222;
    }
    bool _293 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _299;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _293)
    {
        _299 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _299 = 1.0;
    }
    float _346;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _314 = fast::clamp((_214 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _325 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_314.x), int(_314.y), int(_314.z), 0).xyz), 0));
        _346 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_325.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_314 / float3(_325.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _346 = _299;
    }
    float3 _360 = ((_284 - (_284 * _283)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _367 = (mix(float3(0.07999999821186065673828125 * _282), _284, float3(_283)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _370 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _375;
    if (_370)
    {
        _375 = _360 + (_367 * 0.449999988079071044921875);
    }
    else
    {
        _375 = _360;
    }
    float3 _377 = select(_367, float3(0.0), bool3(_370));
    float3 _379 = float3(dot(_377, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _465;
    if (_293)
    {
        float4 _415 = _150;
        _415.y = (-0.48860299587249755859375) * _285.y;
        float4 _418 = _415;
        _418.z = 0.48860299587249755859375 * _285.z;
        float4 _421 = _418;
        _421.w = (-0.48860299587249755859375) * _285.x;
        float3 _422 = _285 * _285;
        float4 _425 = _146;
        _425.x = (1.09254801273345947265625 * _285.x) * _285.y;
        float4 _428 = _425;
        _428.y = ((-1.09254801273345947265625) * _285.y) * _285.z;
        float4 _433 = _428;
        _433.z = 0.3153919875621795654296875 * ((3.0 * _422.z) - 1.0);
        float4 _436 = _433;
        _436.w = ((-1.09254801273345947265625) * _285.x) * _285.z;
        float4 _440 = _421;
        _440.x = 0.886227548122406005859375;
        float3 _442 = _440.yzw * 2.094395160675048828125;
        float4 _443 = float4(_440.x, _442.x, _442.y, _442.z);
        float4 _444 = _436 * 0.785398185253143310546875;
        float _445 = (_422.x - _422.y) * 0.4290426075458526611328125;
        float3 _451 = float3(0.0);
        _451.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _443) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _444)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _445);
        float3 _457 = _451;
        _457.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _443) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _444)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _445);
        float3 _463 = _457;
        _463.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _443) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _444)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _445);
        _465 = fast::max(float3(0.0), _463);
    }
    else
    {
        _465 = float3(0.0);
    }
    float _491;
    float _492;
    float3 _493;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _481;
        float _482;
        if (_293)
        {
            _481 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _482 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _481 = _285;
            _482 = 1.0;
        }
        float _483 = 1.0 - _482;
        float _485 = 1.0 - (_483 * _483);
        _491 = mix(fast::clamp(dot(_481, _285), 0.0, 1.0), 1.0, _485);
        _492 = _482;
        _493 = mix(_481, _285, float3(_485));
    }
    else
    {
        _491 = 1.0;
        _492 = 1.0;
        _493 = _285;
    }
    float4 _497 = float4(_493, 1.0);
    float3 _501 = _147;
    _501.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _497);
    float3 _505 = _501;
    _505.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _497);
    float3 _509 = _505;
    _509.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _497);
    float4 _512 = _497.xyzz * _497.yzzx;
    float3 _516 = _147;
    _516.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _512);
    float3 _520 = _516;
    _520.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _512);
    float3 _524 = _520;
    _524.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _512);
    float3 _539 = (_465 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_509 + _524) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_493.x * _493.x) - (_493.y * _493.y)))) * View.View_SkyLightColor.xyz) * (_492 * _491));
    float3 _561 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _587;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _586;
        if (any(abs(_214 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _586 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_214, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _586 = _561;
        }
        _587 = _586;
    }
    else
    {
        _587 = _561;
    }
    float4 _594 = float4(((mix(float3(0.0), _375 + (_377 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_539 * _375) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _587) * 1.0, 0.0);
    float4 _601;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _600 = _594;
        _600.w = 0.0;
        _601 = _600;
    }
    else
    {
        _601 = _594;
    }
    float2 _605 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _613 = (_285 * 0.5) + float3(0.5);
    float4 _615 = float4(_613.x, _613.y, _613.z, float4(0.0).w);
    _615.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _616 = float4(0.0);
    _616.x = _283;
    float4 _617 = _616;
    _617.y = _282;
    float4 _618 = _617;
    _618.z = _281;
    float4 _619 = _618;
    _619.w = 0.50588238239288330078125;
    float4 _631 = float4(_284.x, _284.y, _284.z, float4(0.0).w);
    _631.w = ((log2(((dot(_539, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_605.xyx * _605.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _601 * View.View_PreExposure;
    out.out_var_SV_Target1 = _615;
    out.out_var_SV_Target2 = _619;
    out.out_var_SV_Target3 = _631;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_346, 1.0, 1.0, 1.0);
    return out;
}

