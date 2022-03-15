

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
    char _m6_pad[32];
    float View_OutOfBoundsMask;
    char _m7_pad[80];
    float View_UnlitViewmodeMask;
    char _m8_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m10_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m14_pad[80];
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
    char _m0_pad[96];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
};

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

constant float3 _107 = {};
constant float _108 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002818_e4df3788(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _133 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _138 = (_133.xyz / float3(_133.w)) - View.View_PreViewTranslation;
    float3 _148 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _151 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _156;
    if (_151)
    {
        _156 = View.View_DiffuseOverrideParameter.xyz + (_148 * 0.449999988079071044921875);
    }
    else
    {
        _156 = View.View_DiffuseOverrideParameter.xyz;
    }
    float3 _176;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _171 = _107;
        _171.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _173 = _171;
        _173.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _175 = _173;
        _175.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _176 = _175;
    }
    else
    {
        _176 = float3(0.0);
    }
    bool _183 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _225;
    if (_183)
    {
        float4 _190 = View.View_WorldToClip * float4(_138, 1.0);
        float _191 = _190.w;
        float4 _220;
        if (_183)
        {
            _220 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_190.xy / float2(_191)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_191 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _220 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _225 = float4(_108, _108, _108, _220.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _225 = in.in_var_TEXCOORD7;
    }
    float3 _233 = (_138 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _246 = fast::clamp((float3(0.5) - abs(_233 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _260 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_138 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _233, level(0.0)), float4((_246.x * _246.y) * _246.z));
    float _267 = _260.w;
    float3 _269 = float4(_260.x * 0.886227548122406005859375, _260.y * 0.886227548122406005859375, _260.z * 0.886227548122406005859375, _267).xyz;
    float3 _335;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _283 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_138, 1.0);
        float2 _287 = _283.xy / float2(_283.w);
        float _288 = _283.z;
        float4 _291 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _287, level(0.0));
        float3 _295 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _288;
        bool2 _320 = _287 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _322 = _287 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _335 = _156 * fast::max(_269 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _267) * (float3(1.0) - select(fast::clamp(exp((float3((((_291.x * _288) * 0.5) + dot((sin(_295) * _291.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_295)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _287, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_320.x || _322.x, _320.y || _322.y)))))), float3(0.0));
    }
    else
    {
        _335 = _156 * _269;
    }
    float3 _371;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _347 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _370;
        if (any(abs(_138 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347 + 19u)].xyz + float3(1.0))))
        {
            _370 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_138, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _370 = float3(0.0);
        }
        _371 = _370;
    }
    else
    {
        _371 = float3(0.0);
    }
    float4 _380 = float4((((mix(_335, _156 + (select(_148, float3(0.0), bool3(_151)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_176 * View.View_IndirectLightingColorScale) * _156)) + _371) * _225.w) * 1.0, 0.0);
    float3 _384 = _380.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_384.x, _384.y, _384.z, _380.w);
    return out;
}

