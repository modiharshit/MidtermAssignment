

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
    char _m0_pad[64];
    float4x4 View_WorldToClip;
    char _m1_pad[320];
    float4x4 View_ViewToClip;
    char _m2_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m5_pad[48];
    float3 View_PreViewTranslation;
    char _m6_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m8_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m12_pad[16];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m17_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m18_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m19_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m21_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m23_pad[80];
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
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _159 = {};
constant float4 _161 = {};
constant float3 _162 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 in_var_TEXCOORD4 [[user(locn2)]];
    float4 in_var_TEXCOORD5 [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TANGENTX [[user(locn5)]];
    float4 in_var_TANGENTZ [[user(locn6)]];
    float4 in_var_TEXCOORD7 [[user(locn7)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004fc3_75eeefc2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float3 _245 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _267 = mix(_263, _265, float4(in.in_var_TEXCOORD4.x));
    float _279 = _228.w;
    float4 _289 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_228.xy / float2(_279)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _290 = _289.x;
    float _320;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _320 = _279;
                break;
            }
            else
            {
                float _313 = _228.z;
                _320 = ((_313 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_313 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _326 = fast::clamp((_259.xyz + _267.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _327 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _267.w, 0.0), 1.0) * fast::min(fast::max(((((_290 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_290 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _320) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _334 = (_326 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _341 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _344 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _349;
    if (_344)
    {
        _349 = _334 + (_341 * 0.449999988079071044921875);
    }
    else
    {
        _349 = _334;
    }
    bool _354 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _427;
    if (_354)
    {
        float _375 = _245.y;
        float4 _377 = _161;
        _377.y = (-0.48860299587249755859375) * _375;
        float _378 = _245.z;
        float4 _380 = _377;
        _380.z = 0.48860299587249755859375 * _378;
        float _381 = _245.x;
        float4 _383 = _380;
        _383.w = (-0.48860299587249755859375) * _381;
        float3 _384 = _245 * _245;
        float4 _387 = _159;
        _387.x = (1.09254801273345947265625 * _381) * _375;
        float4 _390 = _387;
        _390.y = ((-1.09254801273345947265625) * _375) * _378;
        float4 _395 = _390;
        _395.z = 0.3153919875621795654296875 * ((3.0 * _384.z) - 1.0);
        float4 _398 = _395;
        _398.w = ((-1.09254801273345947265625) * _381) * _378;
        float4 _402 = _383;
        _402.x = 0.886227548122406005859375;
        float3 _404 = _402.yzw * 2.094395160675048828125;
        float4 _405 = float4(_402.x, _404.x, _404.y, _404.z);
        float4 _406 = _398 * 0.785398185253143310546875;
        float _407 = (_384.x - _384.y) * 0.4290426075458526611328125;
        float3 _413 = _162;
        _413.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _405) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _406)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _407);
        float3 _419 = _413;
        _419.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _405) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _406)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _407);
        float3 _425 = _419;
        _425.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _405) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _406)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _407);
        _427 = fast::max(float3(0.0), _425);
    }
    else
    {
        _427 = float3(0.0);
    }
    float _453;
    float _454;
    float3 _455;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _443;
        float _444;
        if (_354)
        {
            _443 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _444 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _443 = _245;
            _444 = 1.0;
        }
        float _445 = 1.0 - _444;
        float _447 = 1.0 - (_445 * _445);
        _453 = mix(fast::clamp(dot(_443, _245), 0.0, 1.0), 1.0, _447);
        _454 = _444;
        _455 = mix(_443, _245, float3(_447));
    }
    else
    {
        _453 = 1.0;
        _454 = 1.0;
        _455 = _245;
    }
    float4 _459 = float4(_455, 1.0);
    float3 _463 = _162;
    _463.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _459);
    float3 _467 = _463;
    _467.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _459);
    float3 _471 = _467;
    _471.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _459);
    float4 _474 = _459.xyzz * _459.yzzx;
    float3 _478 = _162;
    _478.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _474);
    float3 _482 = _478;
    _482.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _474);
    float3 _486 = _482;
    _486.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _474);
    bool _518 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _567;
    if (_518)
    {
        float4 _525 = View.View_WorldToClip * float4(_237, 1.0);
        float _526 = _525.w;
        float4 _555;
        if (_518)
        {
            _555 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_525.xy / float2(_526)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_526 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _555 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _567 = float4(_555.xyz + (in.in_var_TEXCOORD7.xyz * _555.w), _555.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _567 = in.in_var_TEXCOORD7;
    }
    float3 _568 = _237 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _576 = (_568 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _584 = (_568 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _589 = fast::clamp((float3(0.5) - abs(_576 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _594 = (_589.x * _589.y) * _589.z;
    float4 _603 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _584, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _576, level(0.0)), float4(_594));
    float3 _614 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _584, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _576, level(0.0)).xyz, float3(_594)) * 1.0;
    float4 _616 = _161;
    _616.x = _603.x;
    float4 _618 = _161;
    _618.x = _603.y;
    float4 _620 = _161;
    _620.x = _603.z;
    float3 _621 = _603.xyz;
    float3 _625 = _621 / float3(dot(_621, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _627 = _614 * _625.x;
    float3 _630 = _614 * _625.y;
    float3 _633 = _614 * _625.z;
    float4 _637 = _161;
    _637.y = (-0.48860299587249755859375) * _245.y;
    float4 _640 = _637;
    _640.z = 0.48860299587249755859375 * _245.z;
    float4 _643 = _640;
    _643.w = (-0.48860299587249755859375) * _245.x;
    float4 _644 = _643;
    _644.x = 0.886227548122406005859375;
    float3 _646 = _644.yzw * 2.094395160675048828125;
    float4 _647 = float4(_644.x, _646.x, _646.y, _646.z);
    float3 _649 = _162;
    _649.x = dot(float4(_616.x, _627.x, _627.y, _627.z), _647);
    float3 _651 = _649;
    _651.y = dot(float4(_618.x, _630.x, _630.y, _630.z), _647);
    float3 _653 = _651;
    _653.z = dot(float4(_620.x, _633.x, _633.y, _633.z), _647);
    float _655 = _603.w;
    float3 _660 = float4(fast::max(float3(0.0), _653), _655).xyz;
    float3 _726;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _674 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_568, 1.0);
        float2 _678 = _674.xy / float2(_674.w);
        float _679 = _674.z;
        float4 _682 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _678, level(0.0));
        float3 _686 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _679;
        bool2 _711 = _678 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _713 = _678 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _726 = _349 * fast::max(_660 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _655) * (float3(1.0) - select(fast::clamp(exp((float3((((_682.x * _679) * 0.5) + dot((sin(_686) * _682.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_686)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _678, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_711.x || _713.x, _711.y || _713.y)))))), float3(0.0));
    }
    else
    {
        _726 = _349 * _660;
    }
    float3 _733 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _760;
    float3 _761;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _748 = any(abs(_237 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _758;
        if (_748)
        {
            _758 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _758 = _733;
        }
        _760 = _748 ? 1.0 : _327;
        _761 = _758;
    }
    else
    {
        _760 = _327;
        _761 = _733;
    }
    float4 _771 = float4((((mix(_726, _349 + (select(_341, float3(0.0), bool3(_344)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((_427 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_471 + _486) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_455.x * _455.x) - (_455.y * _455.y)))) * View.View_SkyLightColor.xyz) * (_454 * _453))) * _349) * fast::max(float3(1.0), ((((((_326 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_326 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_326 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _761) * _567.w) + _567.xyz, _760);
    float3 _775 = _771.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_775.x, _775.y, _775.z, _771.w);
    return out;
}

