

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
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m12_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[384];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _112 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002788_a75000d2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _151 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _156 = (_151.xyz / float3(_151.w)) - View.View_PreViewTranslation;
    float4 _170 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _191 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _194 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _199;
    if (_194)
    {
        _199 = View.View_DiffuseOverrideParameter.xyz + (_191 * 0.449999988079071044921875);
    }
    else
    {
        _199 = View.View_DiffuseOverrideParameter.xyz;
    }
    float2 _203 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _208 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _203);
    float4 _210 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_203 + float2(0.0, 0.5)));
    uint _212 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _222 = (_208.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _212 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _212 + 6u)].xyz;
    float _223 = dot(_222, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _242 = (exp2((_223 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_210 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _212 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _212 + 7u)], float4((normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0).yzx, 1.0)));
    bool _256 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _305;
    if (_256)
    {
        float4 _263 = View.View_WorldToClip * float4(_156, 1.0);
        float _264 = _263.w;
        float4 _293;
        if (_256)
        {
            _293 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_263.xy / float2(_264)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_264 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _293 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _305 = float4(_293.xyz + (in.in_var_TEXCOORD7.xyz * _293.w), _293.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _305 = in.in_var_TEXCOORD7;
    }
    float3 _313 = (_156 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _326 = fast::clamp((float3(0.5) - abs(_313 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _340 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_156 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _313, level(0.0)), float4((_326.x * _326.y) * _326.z));
    float3 _356 = fast::max(mix(float3(_170.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _386;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _362 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _385;
        if (any(abs(_156 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362 + 19u)].xyz + float3(1.0))))
        {
            _385 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_156, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _385 = _356;
        }
        _386 = _385;
    }
    else
    {
        _386 = _356;
    }
    float4 _396 = float4((((mix(_199 * float4(_340.x * 0.886227548122406005859375, _340.y * 0.886227548122406005859375, _340.z * 0.886227548122406005859375, _112).xyz, _199 + (select(_191, float3(0.0), bool3(_194)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((float4(_222 * (_242 / _223), _242).xyz * View.View_IndirectLightingColorScale) * _199)) + _386) * _305.w) + _305.xyz, 1.0);
    float3 _400 = _396.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_400.x, _400.y, _400.z, _396.w);
    return out;
}

