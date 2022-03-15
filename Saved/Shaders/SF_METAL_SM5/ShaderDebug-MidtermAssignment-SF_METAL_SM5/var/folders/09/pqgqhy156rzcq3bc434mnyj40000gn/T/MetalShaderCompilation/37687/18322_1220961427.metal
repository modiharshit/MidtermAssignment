

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _141 = {};
constant float4 _142 = {};
constant float4 _144 = {};
constant float3 _145 = {};

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

fragment MainPS_out Main_00004792_48c66493(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float3 _228 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _246 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _250 = mix(_246, _248, float4(in.in_var_TEXCOORD4.x));
    float _262 = _211.w;
    float4 _272 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_211.xy / float2(_262)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _273 = _272.x;
    float _303;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _303 = _262;
                break;
            }
            else
            {
                float _296 = _211.z;
                _303 = ((_296 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_296 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _309 = fast::clamp((_242.xyz + _250.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _310 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _250.w, 0.0), 1.0) * fast::min(fast::max(((((_273 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_273 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _303) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _317 = (_309 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _324 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _327 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _332;
    if (_327)
    {
        _332 = _317 + (_324 * 0.449999988079071044921875);
    }
    else
    {
        _332 = _317;
    }
    bool _337 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _410;
    if (_337)
    {
        float _358 = _228.y;
        float4 _360 = _144;
        _360.y = (-0.48860299587249755859375) * _358;
        float _361 = _228.z;
        float4 _363 = _360;
        _363.z = 0.48860299587249755859375 * _361;
        float _364 = _228.x;
        float4 _366 = _363;
        _366.w = (-0.48860299587249755859375) * _364;
        float3 _367 = _228 * _228;
        float4 _370 = _142;
        _370.x = (1.09254801273345947265625 * _364) * _358;
        float4 _373 = _370;
        _373.y = ((-1.09254801273345947265625) * _358) * _361;
        float4 _378 = _373;
        _378.z = 0.3153919875621795654296875 * ((3.0 * _367.z) - 1.0);
        float4 _381 = _378;
        _381.w = ((-1.09254801273345947265625) * _364) * _361;
        float4 _385 = _366;
        _385.x = 0.886227548122406005859375;
        float3 _387 = _385.yzw * 2.094395160675048828125;
        float4 _388 = float4(_385.x, _387.x, _387.y, _387.z);
        float4 _389 = _381 * 0.785398185253143310546875;
        float _390 = (_367.x - _367.y) * 0.4290426075458526611328125;
        float3 _396 = _145;
        _396.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _388) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _389)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _390);
        float3 _402 = _396;
        _402.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _388) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _389)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _390);
        float3 _408 = _402;
        _408.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _388) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _389)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _390);
        _410 = fast::max(float3(0.0), _408);
    }
    else
    {
        _410 = float3(0.0);
    }
    float _436;
    float _437;
    float3 _438;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _426;
        float _427;
        if (_337)
        {
            _426 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _427 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _426 = _228;
            _427 = 1.0;
        }
        float _428 = 1.0 - _427;
        float _430 = 1.0 - (_428 * _428);
        _436 = mix(fast::clamp(dot(_426, _228), 0.0, 1.0), 1.0, _430);
        _437 = _427;
        _438 = mix(_426, _228, float3(_430));
    }
    else
    {
        _436 = 1.0;
        _437 = 1.0;
        _438 = _228;
    }
    float4 _442 = float4(_438, 1.0);
    float3 _446 = _145;
    _446.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _442);
    float3 _450 = _446;
    _450.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _442);
    float3 _454 = _450;
    _454.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _442);
    float4 _457 = _442.xyzz * _442.yzzx;
    float3 _461 = _145;
    _461.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _457);
    float3 _465 = _461;
    _465.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _457);
    float3 _469 = _465;
    _469.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _457);
    bool _501 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _550;
    if (_501)
    {
        float4 _508 = View.View_WorldToClip * float4(_220, 1.0);
        float _509 = _508.w;
        float4 _538;
        if (_501)
        {
            _538 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_508.xy / float2(_509)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_509 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _538 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _550 = float4(_538.xyz + (in.in_var_TEXCOORD7.xyz * _538.w), _538.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _550 = in.in_var_TEXCOORD7;
    }
    float3 _551 = _220 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _559 = (_551 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _567 = (_551 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _572 = fast::clamp((float3(0.5) - abs(_559 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _577 = (_572.x * _572.y) * _572.z;
    float4 _586 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _567, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _559, level(0.0)), float4(_577));
    float3 _597 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _567, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _559, level(0.0)).xyz, float3(_577)) * 1.0;
    float4 _599 = _144;
    _599.x = _586.x;
    float4 _601 = _144;
    _601.x = _586.y;
    float4 _603 = _144;
    _603.x = _586.z;
    float3 _604 = _586.xyz;
    float3 _608 = _604 / float3(dot(_604, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _610 = _597 * _608.x;
    float3 _613 = _597 * _608.y;
    float3 _616 = _597 * _608.z;
    float4 _620 = _144;
    _620.y = (-0.48860299587249755859375) * _228.y;
    float4 _623 = _620;
    _623.z = 0.48860299587249755859375 * _228.z;
    float4 _626 = _623;
    _626.w = (-0.48860299587249755859375) * _228.x;
    float4 _627 = _626;
    _627.x = 0.886227548122406005859375;
    float3 _629 = _627.yzw * 2.094395160675048828125;
    float4 _630 = float4(_627.x, _629.x, _629.y, _629.z);
    float3 _632 = _145;
    _632.x = dot(float4(_599.x, _610.x, _610.y, _610.z), _630);
    float3 _634 = _632;
    _634.y = dot(float4(_601.x, _613.x, _613.y, _613.z), _630);
    float3 _636 = _634;
    _636.z = dot(float4(_603.x, _616.x, _616.y, _616.z), _630);
    float3 _650 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _677;
    float3 _678;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _665 = any(abs(_220 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _675;
        if (_665)
        {
            _675 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _675 = _650;
        }
        _677 = _665 ? 1.0 : _310;
        _678 = _675;
    }
    else
    {
        _677 = _310;
        _678 = _650;
    }
    float4 _688 = float4((((mix(_332 * float4(fast::max(float3(0.0), _636), _141).xyz, _332 + (select(_324, float3(0.0), bool3(_327)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((_410 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_454 + _469) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_438.x * _438.x) - (_438.y * _438.y)))) * View.View_SkyLightColor.xyz) * (_437 * _436))) * _332) * fast::max(float3(1.0), ((((((_309 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_309 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_309 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _678) * _550.w) + _550.xyz, _677);
    float3 _692 = _688.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_692.x, _692.y, _692.z, _688.w);
    return out;
}

