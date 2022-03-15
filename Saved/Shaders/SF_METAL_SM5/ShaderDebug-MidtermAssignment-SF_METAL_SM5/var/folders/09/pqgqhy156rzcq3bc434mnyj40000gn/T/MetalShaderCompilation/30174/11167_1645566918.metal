

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
    char _m7_pad[48];
    float View_MaterialTextureMipBias;
    char _m8_pad[28];
    float View_UnlitViewmodeMask;
    char _m9_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m15_pad[80];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _118 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002b9f_62155bc6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _146 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _151 = (_146.xyz / float3(_146.w)) - View.View_PreViewTranslation;
    float4 _157 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _178 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _181 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _186;
    if (_181)
    {
        _186 = View.View_DiffuseOverrideParameter.xyz + (_178 * 0.449999988079071044921875);
    }
    else
    {
        _186 = View.View_DiffuseOverrideParameter.xyz;
    }
    float3 _206;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _201 = _118;
        _201.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _203 = _201;
        _203.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _205 = _203;
        _205.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _206 = _205;
    }
    else
    {
        _206 = float3(0.0);
    }
    bool _213 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _262;
    if (_213)
    {
        float4 _220 = View.View_WorldToClip * float4(_151, 1.0);
        float _221 = _220.w;
        float4 _250;
        if (_213)
        {
            _250 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_220.xy / float2(_221)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_221 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _250 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _262 = float4(_250.xyz + (in.in_var_TEXCOORD7.xyz * _250.w), _250.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _262 = in.in_var_TEXCOORD7;
    }
    float3 _270 = (_151 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _283 = fast::clamp((float3(0.5) - abs(_270 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _297 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_151 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _270, level(0.0)), float4((_283.x * _283.y) * _283.z));
    float _304 = _297.w;
    float3 _306 = float4(_297.x * 0.886227548122406005859375, _297.y * 0.886227548122406005859375, _297.z * 0.886227548122406005859375, _304).xyz;
    float3 _372;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _320 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_151, 1.0);
        float2 _324 = _320.xy / float2(_320.w);
        float _325 = _320.z;
        float4 _328 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _324, level(0.0));
        float3 _332 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _325;
        bool2 _357 = _324 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _359 = _324 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _372 = _186 * fast::max(_306 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _304) * (float3(1.0) - select(fast::clamp(exp((float3((((_328.x * _325) * 0.5) + dot((sin(_332) * _328.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_332)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _324, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_357.x || _359.x, _357.y || _359.y)))))), float3(0.0));
    }
    else
    {
        _372 = _186 * _306;
    }
    float3 _379 = fast::max(mix(float3(_157.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _409;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _385 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _408;
        if (any(abs(_151 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385 + 19u)].xyz + float3(1.0))))
        {
            _408 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_151, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _408 = _379;
        }
        _409 = _408;
    }
    else
    {
        _409 = _379;
    }
    float4 _419 = float4((((mix(_372, _186 + (select(_178, float3(0.0), bool3(_181)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_206 * View.View_IndirectLightingColorScale) * _186)) + _409) * _262.w) + _262.xyz, 1.0);
    float3 _423 = _419.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_423.x, _423.y, _423.z, _419.w);
    return out;
}

