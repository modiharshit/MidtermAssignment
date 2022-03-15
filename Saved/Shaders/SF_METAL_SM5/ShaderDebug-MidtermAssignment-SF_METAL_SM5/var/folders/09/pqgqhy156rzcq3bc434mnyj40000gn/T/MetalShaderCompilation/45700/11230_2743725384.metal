

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
    char _m11_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[48];
    float4 View_SkyLightColor;
    char _m13_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
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

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

constant float3 _109 = {};
constant float _110 = {};

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

fragment MainPS_out Main_00002bde_a389ed48(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _144 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _149 = (_144.xyz / float3(_144.w)) - View.View_PreViewTranslation;
    float3 _157 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _167 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _170 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _175;
    if (_170)
    {
        _175 = View.View_DiffuseOverrideParameter.xyz + (_167 * 0.449999988079071044921875);
    }
    else
    {
        _175 = View.View_DiffuseOverrideParameter.xyz;
    }
    float _178 = _157.x;
    float _179 = _157.y;
    float4 _181 = float4(_178, _179, _157.z, 1.0);
    float3 _185 = _109;
    _185.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _181);
    float3 _189 = _185;
    _189.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _181);
    float3 _193 = _189;
    _193.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _181);
    float4 _196 = _181.xyzz * _181.yzzx;
    float3 _200 = _109;
    _200.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _196);
    float3 _204 = _200;
    _204.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _196);
    float3 _208 = _204;
    _208.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _196);
    bool _225 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _267;
    if (_225)
    {
        float4 _232 = View.View_WorldToClip * float4(_149, 1.0);
        float _233 = _232.w;
        float4 _262;
        if (_225)
        {
            _262 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_232.xy / float2(_233)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_233 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _262 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _267 = float4(_110, _110, _110, _262.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _267 = in.in_var_TEXCOORD7;
    }
    float3 _275 = (_149 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _288 = fast::clamp((float3(0.5) - abs(_275 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _302 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_149 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _275, level(0.0)), float4((_288.x * _288.y) * _288.z));
    float _309 = _302.w;
    float3 _311 = float4(_302.x * 0.886227548122406005859375, _302.y * 0.886227548122406005859375, _302.z * 0.886227548122406005859375, _309).xyz;
    float3 _377;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _325 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_149, 1.0);
        float2 _329 = _325.xy / float2(_325.w);
        float _330 = _325.z;
        float4 _333 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _329, level(0.0));
        float3 _337 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _330;
        bool2 _362 = _329 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _364 = _329 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _377 = _175 * fast::max(_311 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _309) * (float3(1.0) - select(fast::clamp(exp((float3((((_333.x * _330) * 0.5) + dot((sin(_337) * _333.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_337)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _329, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_362.x || _364.x, _362.y || _364.y)))))), float3(0.0));
    }
    else
    {
        _377 = _175 * _311;
    }
    float3 _413;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _389 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _412;
        if (any(abs(_149 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _389 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _389 + 19u)].xyz + float3(1.0))))
        {
            _412 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_149, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _412 = float3(0.0);
        }
        _413 = _412;
    }
    else
    {
        _413 = float3(0.0);
    }
    float4 _422 = float4((((mix(_377, _175 + (select(_167, float3(0.0), bool3(_170)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((fast::max(float3(0.0), (_193 + _208) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_178 * _178) - (_179 * _179)))) * View.View_SkyLightColor.xyz) * 1.0) * _175)) + _413) * _267.w) * 1.0, 0.0);
    float3 _426 = _422.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_426.x, _426.y, _426.z, _422.w);
    return out;
}

