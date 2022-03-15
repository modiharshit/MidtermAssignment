

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _105 = {};
constant float3 _106 = {};

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

fragment MainPS_out Main_000025a4_6822b2ab(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _138 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _143 = (_138.xyz / float3(_138.w)) - View.View_PreViewTranslation;
    float4 _149 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _170 = fast::clamp((_143 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _181 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_170.x), int(_170.y), int(_170.z), 0).xyz), 0));
    float3 _206 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _209 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _214;
    if (_209)
    {
        _214 = View.View_DiffuseOverrideParameter.xyz + (_206 * 0.449999988079071044921875);
    }
    else
    {
        _214 = View.View_DiffuseOverrideParameter.xyz;
    }
    float4 _220 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_181.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_170 / float3(_181.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _225 = _106;
    _225.x = _220.x * 0.886227548122406005859375;
    float3 _227 = _225;
    _227.y = _220.y * 0.886227548122406005859375;
    float3 _229 = _227;
    _229.z = _220.z * 0.886227548122406005859375;
    bool _238 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _286;
    if (_238)
    {
        float4 _245 = View.View_WorldToClip * float4(_143, 1.0);
        float _246 = _245.w;
        float4 _274;
        if (_238)
        {
            _274 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_245.xy / float2(_246)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_246 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _274 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _286 = float4(_274.xyz + (in.in_var_TEXCOORD7.xyz * _274.w), _274.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _286 = in.in_var_TEXCOORD7;
    }
    float3 _294 = (_143 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _307 = fast::clamp((float3(0.5) - abs(_294 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _320 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_143 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _294, level(0.0)), float4((_307.x * _307.y) * _307.z));
    float3 _336 = fast::max(mix(float3(_149.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _366;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _342 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _365;
        if (any(abs(_143 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 19u)].xyz + float3(1.0))))
        {
            _365 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_143, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _365 = _336;
        }
        _366 = _365;
    }
    else
    {
        _366 = _336;
    }
    float4 _376 = float4((((mix(_214 * float4(_320.x * 0.886227548122406005859375, _320.y * 0.886227548122406005859375, _320.z * 0.886227548122406005859375, _105).xyz, _214 + (select(_206, float3(0.0), bool3(_209)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((fast::max(float3(0.0), _229) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _214)) + _366) * _286.w) + _286.xyz, 1.0);
    float3 _380 = _376.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_380.x, _380.y, _380.z, _376.w);
    return out;
}

