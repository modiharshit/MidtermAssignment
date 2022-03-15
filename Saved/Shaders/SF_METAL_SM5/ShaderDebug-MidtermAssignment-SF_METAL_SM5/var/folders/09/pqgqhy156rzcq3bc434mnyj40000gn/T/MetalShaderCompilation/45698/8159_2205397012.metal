

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

constant float _85 = {};
constant float3 _86 = {};
constant float _87 = {};

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

fragment MainPS_out Main_00001fdf_8373b014(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _112 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _117 = (_112.xyz / float3(_112.w)) - View.View_PreViewTranslation;
    float3 _127 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _130 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _135;
    if (_130)
    {
        _135 = View.View_DiffuseOverrideParameter.xyz + (_127 * 0.449999988079071044921875);
    }
    else
    {
        _135 = View.View_DiffuseOverrideParameter.xyz;
    }
    float3 _155;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _150 = _86;
        _150.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _152 = _150;
        _152.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _154 = _152;
        _154.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _155 = _154;
    }
    else
    {
        _155 = float3(0.0);
    }
    bool _162 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _204;
    if (_162)
    {
        float4 _169 = View.View_WorldToClip * float4(_117, 1.0);
        float _170 = _169.w;
        float4 _199;
        if (_162)
        {
            _199 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_169.xy / float2(_170)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_170 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _199 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _204 = float4(_87, _87, _87, _199.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _204 = in.in_var_TEXCOORD7;
    }
    float3 _212 = (_117 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _225 = fast::clamp((float3(0.5) - abs(_212 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _239 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_117 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _212, level(0.0)), float4((_225.x * _225.y) * _225.z));
    float3 _284;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _260 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _283;
        if (any(abs(_117 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _260 + 19u)].xyz + float3(1.0))))
        {
            _283 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_117, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _283 = float3(0.0);
        }
        _284 = _283;
    }
    else
    {
        _284 = float3(0.0);
    }
    float4 _293 = float4((((mix(_135 * float4(_239.x * 0.886227548122406005859375, _239.y * 0.886227548122406005859375, _239.z * 0.886227548122406005859375, _85).xyz, _135 + (select(_127, float3(0.0), bool3(_130)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_155 * View.View_IndirectLightingColorScale) * _135)) + _284) * _204.w) * 1.0, 0.0);
    float3 _297 = _293.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_297.x, _297.y, _297.z, _293.w);
    return out;
}

