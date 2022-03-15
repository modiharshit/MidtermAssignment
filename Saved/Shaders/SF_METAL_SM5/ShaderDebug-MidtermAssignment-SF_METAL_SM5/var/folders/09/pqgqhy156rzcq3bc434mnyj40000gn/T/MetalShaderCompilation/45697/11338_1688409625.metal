

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
    char _m17_pad[16];
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

constant float _101 = {};
constant float3 _102 = {};
constant float _103 = {};

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

fragment MainPS_out Main_00002c4a_64a31619(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _143 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _148 = (_143.xyz / float3(_143.w)) - View.View_PreViewTranslation;
    float3 _166 = fast::clamp((_148 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _177 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_166.x), int(_166.y), int(_166.z), 0).xyz), 0));
    float3 _192 = (((_177.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_166 / float3(_177.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _202 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _205 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _210;
    if (_205)
    {
        _210 = View.View_DiffuseOverrideParameter.xyz + (_202 * 0.449999988079071044921875);
    }
    else
    {
        _210 = View.View_DiffuseOverrideParameter.xyz;
    }
    float4 _216 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _192, level(0.0));
    float3 _221 = _102;
    _221.x = _216.x * 0.886227548122406005859375;
    float3 _223 = _221;
    _223.y = _216.y * 0.886227548122406005859375;
    float3 _225 = _223;
    _225.z = _216.z * 0.886227548122406005859375;
    float _246;
    float3 _247;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _241 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _192, level(0.0)).xyz * 2.0) - float3(1.0);
        float _242 = length(_241);
        _246 = _242;
        _247 = _241 / float3(fast::max(_242, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _246 = 1.0;
        _247 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _251 = float4(_247, 1.0);
    float3 _255 = _102;
    _255.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _251);
    float3 _259 = _255;
    _259.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _251);
    float3 _263 = _259;
    _263.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _251);
    float4 _266 = _251.xyzz * _251.yzzx;
    float3 _270 = _102;
    _270.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _266);
    float3 _274 = _270;
    _274.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _266);
    float3 _278 = _274;
    _278.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _266);
    bool _296 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _337;
    if (_296)
    {
        float4 _303 = View.View_WorldToClip * float4(_148, 1.0);
        float _304 = _303.w;
        float4 _332;
        if (_296)
        {
            _332 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_303.xy / float2(_304)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_304 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _332 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _337 = float4(_103, _103, _103, _332.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _337 = in.in_var_TEXCOORD7;
    }
    float3 _345 = (_148 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _358 = fast::clamp((float3(0.5) - abs(_345 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _371 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_148 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _345, level(0.0)), float4((_358.x * _358.y) * _358.z));
    float3 _416;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _392 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _415;
        if (any(abs(_148 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _392 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _392 + 19u)].xyz + float3(1.0))))
        {
            _415 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_148, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _415 = float3(0.0);
        }
        _416 = _415;
    }
    else
    {
        _416 = float3(0.0);
    }
    float4 _425 = float4((((mix(_210 * float4(_371.x * 0.886227548122406005859375, _371.y * 0.886227548122406005859375, _371.z * 0.886227548122406005859375, _101).xyz, _210 + (select(_202, float3(0.0), bool3(_205)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _225) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_263 + _278) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_247.x * _247.x) - (_247.y * _247.y)))) * View.View_SkyLightColor.xyz) * _246)) * _210)) + _416) * _337.w) * 1.0, 0.0);
    float3 _429 = _425.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_429.x, _429.y, _429.z, _425.w);
    return out;
}

