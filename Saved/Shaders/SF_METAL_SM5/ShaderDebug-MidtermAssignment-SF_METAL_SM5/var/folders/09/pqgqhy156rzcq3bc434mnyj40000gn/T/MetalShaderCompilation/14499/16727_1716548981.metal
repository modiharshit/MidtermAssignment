

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _145 = {};
constant float3 _146 = {};
constant float _148 = {};
constant float4 _149 = {};

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

fragment MainPS_out Main_00004157_66507575(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _203 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = (_208.xyz / float3(_208.w)) - View.View_PreViewTranslation;
    float3 _221 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _236 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _237 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _242 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _291;
    float _292;
    float _293;
    float3 _294;
    float3 _295;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _259 = ((_203.xy / float2(_203.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _263 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _259, level(0.0));
        float4 _266 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _259, level(0.0));
        float4 _269 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _259, level(0.0));
        float _279 = _269.w;
        _291 = (_242 * _279) + _269.z;
        _292 = (0.5 * _279) + _269.y;
        _293 = (_237 * _279) + _269.x;
        _294 = (_236 * _263.w) + _263.xyz;
        _295 = normalize((_221 * _266.w) + ((_266.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _291 = _242;
        _292 = 0.5;
        _293 = _237;
        _294 = _236;
        _295 = _221;
    }
    bool _303 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _309;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _303)
    {
        _309 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _309 = 1.0;
    }
    float _356;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _324 = fast::clamp((_213 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _335 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_324.x), int(_324.y), int(_324.z), 0).xyz), 0));
        _356 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_335.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_324 / float3(_335.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _356 = _309;
    }
    float3 _370 = ((_294 - (_294 * _293)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _377 = (mix(float3(0.07999999821186065673828125 * _292), _294, float3(_293)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _380 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _385;
    if (_380)
    {
        _385 = _370 + (_377 * 0.449999988079071044921875);
    }
    else
    {
        _385 = _370;
    }
    float3 _387 = select(_377, float3(0.0), bool3(_380));
    float3 _389 = float3(dot(_387, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _475;
    if (_303)
    {
        float4 _425 = _149;
        _425.y = (-0.48860299587249755859375) * _295.y;
        float4 _428 = _425;
        _428.z = 0.48860299587249755859375 * _295.z;
        float4 _431 = _428;
        _431.w = (-0.48860299587249755859375) * _295.x;
        float3 _432 = _295 * _295;
        float4 _435 = _145;
        _435.x = (1.09254801273345947265625 * _295.x) * _295.y;
        float4 _438 = _435;
        _438.y = ((-1.09254801273345947265625) * _295.y) * _295.z;
        float4 _443 = _438;
        _443.z = 0.3153919875621795654296875 * ((3.0 * _432.z) - 1.0);
        float4 _446 = _443;
        _446.w = ((-1.09254801273345947265625) * _295.x) * _295.z;
        float4 _450 = _431;
        _450.x = 0.886227548122406005859375;
        float3 _452 = _450.yzw * 2.094395160675048828125;
        float4 _453 = float4(_450.x, _452.x, _452.y, _452.z);
        float4 _454 = _446 * 0.785398185253143310546875;
        float _455 = (_432.x - _432.y) * 0.4290426075458526611328125;
        float3 _461 = float3(0.0);
        _461.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _453) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _454)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _455);
        float3 _467 = _461;
        _467.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _453) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _454)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _455);
        float3 _473 = _467;
        _473.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _453) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _454)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _455);
        _475 = fast::max(float3(0.0), _473);
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
        if (_303)
        {
            _491 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _492 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _491 = _295;
            _492 = 1.0;
        }
        float _493 = 1.0 - _492;
        float _495 = 1.0 - (_493 * _493);
        _501 = mix(fast::clamp(dot(_491, _295), 0.0, 1.0), 1.0, _495);
        _502 = _492;
        _503 = mix(_491, _295, float3(_495));
    }
    else
    {
        _501 = 1.0;
        _502 = 1.0;
        _503 = _295;
    }
    float4 _507 = float4(_503, 1.0);
    float3 _511 = _146;
    _511.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _507);
    float3 _515 = _511;
    _515.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _507);
    float3 _519 = _515;
    _519.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _507);
    float4 _522 = _507.xyzz * _507.yzzx;
    float3 _526 = _146;
    _526.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _522);
    float3 _530 = _526;
    _530.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _522);
    float3 _534 = _530;
    _534.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _522);
    float3 _549 = (_475 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_519 + _534) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_503.x * _503.x) - (_503.y * _503.y)))) * View.View_SkyLightColor.xyz) * (_502 * _501));
    float3 _571 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _597;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _596;
        if (any(abs(_213 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _596 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _596 = _571;
        }
        _597 = _596;
    }
    else
    {
        _597 = _571;
    }
    float4 _604 = float4(((mix(float3(0.0), _385 + (_387 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_549 * _385) * fast::max(float3(1.0), ((((((_294 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_294 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_294 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _597) * 1.0, 0.0);
    float4 _611;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _610 = _604;
        _610.w = 0.0;
        _611 = _610;
    }
    else
    {
        _611 = _604;
    }
    float2 _615 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _623 = (_295 * 0.5) + float3(0.5);
    float4 _625 = float4(_623.x, _623.y, _623.z, float4(0.0).w);
    _625.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _626 = float4(0.0);
    _626.x = _293;
    float4 _627 = _626;
    _627.y = _292;
    float4 _628 = _627;
    _628.z = _291;
    float4 _629 = _628;
    _629.w = 0.50588238239288330078125;
    float4 _641 = float4(_294.x, _294.y, _294.z, float4(0.0).w);
    _641.w = ((log2(((dot(_549, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_615.xyx * _615.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _611 * View.View_PreExposure;
    out.out_var_SV_Target1 = _625;
    out.out_var_SV_Target2 = _629;
    out.out_var_SV_Target3 = _641;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_356, 1.0, 1.0, 1.0);
    return out;
}

