

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
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[64];
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapScale;
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapAdd;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _112 = {};
constant float3 _113 = {};

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
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002f4b_4adfc399(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _152 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _157 = (_152.xyz / float3(_152.w)) - View.View_PreViewTranslation;
    float3 _165 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _171 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _192 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _195 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _200;
    if (_195)
    {
        _200 = View.View_DiffuseOverrideParameter.xyz + (_192 * 0.449999988079071044921875);
    }
    else
    {
        _200 = View.View_DiffuseOverrideParameter.xyz;
    }
    float2 _204 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _209 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _204);
    float4 _211 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_204 + float2(0.0, 0.5)));
    float3 _225 = _209.xyz;
    float _267;
    float3 _268;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _259 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _263 = _259.w;
        _267 = _263 * _263;
        _268 = normalize(((_259.xyz * 2.0) - float3(1.0)).xyz);
    }
    else
    {
        _267 = 1.0;
        _268 = _165;
    }
    float4 _272 = float4(_268, 1.0);
    float3 _276 = _113;
    _276.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _272);
    float3 _280 = _276;
    _280.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _272);
    float3 _284 = _280;
    _284.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _272);
    float4 _287 = _272.xyzz * _272.yzzx;
    float3 _291 = _113;
    _291.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _287);
    float3 _295 = _291;
    _295.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _287);
    float3 _299 = _295;
    _299.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _287);
    bool _317 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _366;
    if (_317)
    {
        float4 _324 = View.View_WorldToClip * float4(_157, 1.0);
        float _325 = _324.w;
        float4 _354;
        if (_317)
        {
            _354 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_324.xy / float2(_325)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_325 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _354 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _366 = float4(_354.xyz + (in.in_var_TEXCOORD7.xyz * _354.w), _354.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _366 = in.in_var_TEXCOORD7;
    }
    float3 _374 = (_157 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _387 = fast::clamp((float3(0.5) - abs(_374 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _401 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_157 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _374, level(0.0)), float4((_387.x * _387.y) * _387.z));
    float3 _417 = fast::max(mix(float3(_171.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _443;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _442;
        if (any(abs(_157 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _442 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_157, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _442 = _417;
        }
        _443 = _442;
    }
    else
    {
        _443 = _417;
    }
    float4 _453 = float4((((mix(_200 * float4(_401.x * 0.886227548122406005859375, _401.y * 0.886227548122406005859375, _401.z * 0.886227548122406005859375, _112).xyz, _200 + (select(_192, float3(0.0), bool3(_195)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((((_225 * _225) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz) * ((exp2(((_209.w + ((_211.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].w) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_211 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1], float4(_165.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_284 + _299) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_268.x * _268.x) - (_268.y * _268.y)))) * View.View_SkyLightColor.xyz) * _267)) * _200)) + _443) * _366.w) + _366.xyz, 1.0);
    float3 _457 = _453.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_457.x, _457.y, _457.z, _453.w);
    return out;
}

