

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002718_eeb7fb32(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _141 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _146 = (_141.xyz / float3(_141.w)) - View.View_PreViewTranslation;
    float4 _157 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _162 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _163 = dfdx(_162);
    float _164 = dot(_163, _163);
    float3 _165 = dfdy(_162);
    float _166 = dot(_165, _165);
    float _174 = 1.0 / sqrt((abs(_164 - _166) > 9.9999997473787516355514526367188e-06) ? ((_164 >= _166) ? _164 : _166) : _166);
    float3 _183 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _184 = fast::clamp((((_157.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _174)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _174), 0.0), 1.0), 0.0, 1.0);
    float3 _191 = (_183 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _198 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _201 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _206;
    if (_201)
    {
        _206 = _191 + (_198 * 0.449999988079071044921875);
    }
    else
    {
        _206 = _191;
    }
    float3 _226;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _221 = _113;
        _221.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _223 = _221;
        _223.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _225 = _223;
        _225.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _226 = _225;
    }
    else
    {
        _226 = float3(0.0);
    }
    bool _246 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _295;
    if (_246)
    {
        float4 _253 = View.View_WorldToClip * float4(_146, 1.0);
        float _254 = _253.w;
        float4 _283;
        if (_246)
        {
            _283 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_253.xy / float2(_254)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_254 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _283 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _295 = float4(_283.xyz + (in.in_var_TEXCOORD7.xyz * _283.w), _283.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _295 = in.in_var_TEXCOORD7;
    }
    float3 _303 = (_146 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _316 = fast::clamp((float3(0.5) - abs(_303 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _330 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_146 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _303, level(0.0)), float4((_316.x * _316.y) * _316.z));
    float3 _346 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _377;
    float3 _378;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _352 = in.in_var_PRIMITIVE_ID * 36u;
        bool _365 = any(abs(_146 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 19u)].xyz + float3(1.0)));
        float3 _375;
        if (_365)
        {
            _375 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_146, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _375 = _346;
        }
        _377 = _365 ? 1.0 : _184;
        _378 = _375;
    }
    else
    {
        _377 = _184;
        _378 = _346;
    }
    float4 _388 = float4((((mix(_206 * float4(_330.x * 0.886227548122406005859375, _330.y * 0.886227548122406005859375, _330.z * 0.886227548122406005859375, _112).xyz, _206 + (select(_198, float3(0.0), bool3(_201)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_226 * View.View_IndirectLightingColorScale) * _206) * fast::max(float3(1.0), ((((((_183 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_183 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_183 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _378) * _295.w) + _295.xyz, _377);
    float3 _392 = _388.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_392.x, _392.y, _392.z, _388.w);
    return out;
}

