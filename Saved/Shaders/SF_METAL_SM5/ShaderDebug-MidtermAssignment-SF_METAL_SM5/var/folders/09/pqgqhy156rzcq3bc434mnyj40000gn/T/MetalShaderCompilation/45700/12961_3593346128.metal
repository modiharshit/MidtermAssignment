

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
    char _m1_pad[576];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[352];
    float3 View_PreViewTranslation;
    char _m3_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m7_pad[16];
    float View_OutOfBoundsMask;
    char _m8_pad[80];
    float View_UnlitViewmodeMask;
    char _m9_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m15_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m17_pad[80];
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
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
};

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

constant float3 _113 = {};
constant float _114 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000032a1_d62e1c50(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _151 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _156 = (_151.xyz / float3(_151.w)) - View.View_PreViewTranslation;
    float3 _164 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _174 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _177 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _182;
    if (_177)
    {
        _182 = View.View_DiffuseOverrideParameter.xyz + (_174 * 0.449999988079071044921875);
    }
    else
    {
        _182 = View.View_DiffuseOverrideParameter.xyz;
    }
    bool _187 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _202;
    if (_187)
    {
        float3 _197 = _113;
        _197.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _199 = _197;
        _199.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _201 = _199;
        _201.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _202 = _201;
    }
    else
    {
        _202 = float3(0.0);
    }
    float _220;
    float3 _221;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _218;
        float3 _219;
        if (_187)
        {
            _218 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _219 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _218 = 1.0;
            _219 = _164;
        }
        _220 = _218;
        _221 = _219;
    }
    else
    {
        _220 = 1.0;
        _221 = _164;
    }
    float4 _225 = float4(_221, 1.0);
    float3 _229 = _113;
    _229.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _225);
    float3 _233 = _229;
    _233.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _225);
    float3 _237 = _233;
    _237.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _225);
    float4 _240 = _225.xyzz * _225.yzzx;
    float3 _244 = _113;
    _244.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _240);
    float3 _248 = _244;
    _248.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _240);
    float3 _252 = _248;
    _252.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _240);
    bool _270 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _312;
    if (_270)
    {
        float4 _277 = View.View_WorldToClip * float4(_156, 1.0);
        float _278 = _277.w;
        float4 _307;
        if (_270)
        {
            _307 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_277.xy / float2(_278)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_278 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _307 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _312 = float4(_114, _114, _114, _307.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _312 = in.in_var_TEXCOORD7;
    }
    float3 _320 = (_156 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _333 = fast::clamp((float3(0.5) - abs(_320 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _347 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_156 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _320, level(0.0)), float4((_333.x * _333.y) * _333.z));
    float _354 = _347.w;
    float3 _356 = float4(_347.x * 0.886227548122406005859375, _347.y * 0.886227548122406005859375, _347.z * 0.886227548122406005859375, _354).xyz;
    float3 _422;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _370 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_156, 1.0);
        float2 _374 = _370.xy / float2(_370.w);
        float _375 = _370.z;
        float4 _378 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _374, level(0.0));
        float3 _382 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _375;
        bool2 _407 = _374 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _409 = _374 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _422 = _182 * fast::max(_356 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _354) * (float3(1.0) - select(fast::clamp(exp((float3((((_378.x * _375) * 0.5) + dot((sin(_382) * _378.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_382)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _374, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_407.x || _409.x, _407.y || _409.y)))))), float3(0.0));
    }
    else
    {
        _422 = _182 * _356;
    }
    float3 _458;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _434 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _457;
        if (any(abs(_156 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _434 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _434 + 19u)].xyz + float3(1.0))))
        {
            _457 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_156, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _457 = float3(0.0);
        }
        _458 = _457;
    }
    else
    {
        _458 = float3(0.0);
    }
    float4 _467 = float4((((mix(_422, _182 + (select(_174, float3(0.0), bool3(_177)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_202 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_237 + _252) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_221.x * _221.x) - (_221.y * _221.y)))) * View.View_SkyLightColor.xyz) * _220)) * _182)) + _458) * _312.w) * 1.0, 0.0);
    float3 _471 = _467.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_471.x, _471.y, _471.z, _467.w);
    return out;
}

