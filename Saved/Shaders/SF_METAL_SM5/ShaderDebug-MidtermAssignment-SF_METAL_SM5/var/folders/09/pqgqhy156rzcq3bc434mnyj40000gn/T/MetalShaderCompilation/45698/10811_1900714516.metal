

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
    char _m14_pad[16];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float3 _113 = {};
constant float _114 = {};

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

fragment MainPS_out Main_00002a3b_714a9a14(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _144 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _149 = (_144.xyz / float3(_144.w)) - View.View_PreViewTranslation;
    float3 _159 = fast::clamp((_149 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _170 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_159.x), int(_159.y), int(_159.z), 0).xyz), 0));
    float3 _195 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _198 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _203;
    if (_198)
    {
        _203 = View.View_DiffuseOverrideParameter.xyz + (_195 * 0.449999988079071044921875);
    }
    else
    {
        _203 = View.View_DiffuseOverrideParameter.xyz;
    }
    float4 _209 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_170.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_159 / float3(_170.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _214 = _113;
    _214.x = _209.x * 0.886227548122406005859375;
    float3 _216 = _214;
    _216.y = _209.y * 0.886227548122406005859375;
    float3 _218 = _216;
    _218.z = _209.z * 0.886227548122406005859375;
    bool _227 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _268;
    if (_227)
    {
        float4 _234 = View.View_WorldToClip * float4(_149, 1.0);
        float _235 = _234.w;
        float4 _263;
        if (_227)
        {
            _263 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_234.xy / float2(_235)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_235 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _263 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _268 = float4(_114, _114, _114, _263.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _268 = in.in_var_TEXCOORD7;
    }
    float3 _276 = (_149 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _289 = fast::clamp((float3(0.5) - abs(_276 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _302 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_149 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _276, level(0.0)), float4((_289.x * _289.y) * _289.z));
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
        _377 = _203 * fast::max(_311 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _309) * (float3(1.0) - select(fast::clamp(exp((float3((((_333.x * _330) * 0.5) + dot((sin(_337) * _333.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_337)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _329, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_362.x || _364.x, _362.y || _364.y)))))), float3(0.0));
    }
    else
    {
        _377 = _203 * _311;
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
    float4 _422 = float4((((mix(_377, _203 + (select(_195, float3(0.0), bool3(_198)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((fast::max(float3(0.0), _218) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _203)) + _413) * _268.w) * 1.0, 0.0);
    float3 _426 = _422.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_426.x, _426.y, _426.z, _422.w);
    return out;
}

