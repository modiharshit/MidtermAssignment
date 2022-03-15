

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
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m16_pad[80];
    float View_IndirectLightingCacheShowFlag;
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

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002e31_4e813912(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _153 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _158 = (_153.xyz / float3(_153.w)) - View.View_PreViewTranslation;
    float3 _166 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _177 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _179 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _186 = fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _187 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_177, _179, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _203 = ((_186 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _206 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _221;
    if (_206)
    {
        float3 _216 = _113;
        _216.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _218 = _216;
        _218.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _220 = _218;
        _220.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _221 = _220;
    }
    else
    {
        _221 = float3(0.0);
    }
    float _239;
    float3 _240;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _237;
        float3 _238;
        if (_206)
        {
            _237 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _238 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _237 = 1.0;
            _238 = _166;
        }
        _239 = _237;
        _240 = _238;
    }
    else
    {
        _239 = 1.0;
        _240 = _166;
    }
    float4 _244 = float4(_240, 1.0);
    float3 _248 = _113;
    _248.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _244);
    float3 _252 = _248;
    _252.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _244);
    float3 _256 = _252;
    _256.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _244);
    float4 _259 = _244.xyzz * _244.yzzx;
    float3 _263 = _113;
    _263.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _259);
    float3 _267 = _263;
    _267.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _259);
    float3 _271 = _267;
    _271.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _259);
    bool _302 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _351;
    if (_302)
    {
        float4 _309 = View.View_WorldToClip * float4(_158, 1.0);
        float _310 = _309.w;
        float4 _339;
        if (_302)
        {
            _339 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_309.xy / float2(_310)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_310 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _339 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _351 = float4(_339.xyz + (in.in_var_TEXCOORD7.xyz * _339.w), _339.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _351 = in.in_var_TEXCOORD7;
    }
    float3 _352 = _158 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _360 = (_352 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _373 = fast::clamp((float3(0.5) - abs(_360 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _387 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_352 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _360, level(0.0)), float4((_373.x * _373.y) * _373.z));
    float3 _401 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _428;
    float3 _429;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _416 = any(abs(_158 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _426;
        if (_416)
        {
            _426 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_158, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _426 = _401;
        }
        _428 = _416 ? 1.0 : _187;
        _429 = _426;
    }
    else
    {
        _428 = _187;
        _429 = _401;
    }
    float4 _439 = float4((((mix(_203 * float4(_387.x * 0.886227548122406005859375, _387.y * 0.886227548122406005859375, _387.z * 0.886227548122406005859375, _112).xyz, _203, float3(View.View_UnlitViewmodeMask)) + ((((_221 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_256 + _271) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_240.x * _240.x) - (_240.y * _240.y)))) * View.View_SkyLightColor.xyz) * _239)) * _203) * fast::max(float3(1.0), ((((((_186 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_186 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_186 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _429) * _351.w) + _351.xyz, _428);
    float3 _443 = _439.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_443.x, _443.y, _443.z, _439.w);
    return out;
}

