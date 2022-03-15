

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
    char _m15_pad[16];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _124 = {};

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

fragment MainPS_out Main_00002dc2_466e04d4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _156 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _161 = (_156.xyz / float3(_156.w)) - View.View_PreViewTranslation;
    float4 _167 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _188 = fast::clamp((_161 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _199 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_188.x), int(_188.y), int(_188.z), 0).xyz), 0));
    float3 _224 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _227 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _232;
    if (_227)
    {
        _232 = View.View_DiffuseOverrideParameter.xyz + (_224 * 0.449999988079071044921875);
    }
    else
    {
        _232 = View.View_DiffuseOverrideParameter.xyz;
    }
    float4 _238 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_199.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_188 / float3(_199.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _243 = _124;
    _243.x = _238.x * 0.886227548122406005859375;
    float3 _245 = _243;
    _245.y = _238.y * 0.886227548122406005859375;
    float3 _247 = _245;
    _247.z = _238.z * 0.886227548122406005859375;
    bool _256 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _304;
    if (_256)
    {
        float4 _263 = View.View_WorldToClip * float4(_161, 1.0);
        float _264 = _263.w;
        float4 _292;
        if (_256)
        {
            _292 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_263.xy / float2(_264)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_264 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _292 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _304 = float4(_292.xyz + (in.in_var_TEXCOORD7.xyz * _292.w), _292.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _304 = in.in_var_TEXCOORD7;
    }
    float3 _312 = (_161 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _325 = fast::clamp((float3(0.5) - abs(_312 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _338 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_161 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _312, level(0.0)), float4((_325.x * _325.y) * _325.z));
    float _345 = _338.w;
    float3 _347 = float4(_338.x * 0.886227548122406005859375, _338.y * 0.886227548122406005859375, _338.z * 0.886227548122406005859375, _345).xyz;
    float3 _413;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _361 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_161, 1.0);
        float2 _365 = _361.xy / float2(_361.w);
        float _366 = _361.z;
        float4 _369 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _365, level(0.0));
        float3 _373 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _366;
        bool2 _398 = _365 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _400 = _365 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _413 = _232 * fast::max(_347 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _345) * (float3(1.0) - select(fast::clamp(exp((float3((((_369.x * _366) * 0.5) + dot((sin(_373) * _369.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_373)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _365, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_398.x || _400.x, _398.y || _400.y)))))), float3(0.0));
    }
    else
    {
        _413 = _232 * _347;
    }
    float3 _420 = fast::max(mix(float3(_167.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _450;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _426 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _449;
        if (any(abs(_161 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _426 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _426 + 19u)].xyz + float3(1.0))))
        {
            _449 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_161, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _449 = _420;
        }
        _450 = _449;
    }
    else
    {
        _450 = _420;
    }
    float4 _460 = float4((((mix(_413, _232 + (select(_224, float3(0.0), bool3(_227)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((fast::max(float3(0.0), _247) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _232)) + _450) * _304.w) + _304.xyz, 1.0);
    float3 _464 = _460.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_464.x, _464.y, _464.z, _460.w);
    return out;
}

