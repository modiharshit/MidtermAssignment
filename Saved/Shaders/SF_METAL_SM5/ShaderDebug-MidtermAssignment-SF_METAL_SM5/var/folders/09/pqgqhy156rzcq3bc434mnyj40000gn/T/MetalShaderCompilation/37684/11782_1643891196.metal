

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

constant float _111 = {};
constant float3 _112 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD1 [[user(locn2)]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_COLOR1 [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002e06_61fbc9fc(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _152 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _157 = (_152.xyz / float3(_152.w)) - View.View_PreViewTranslation;
    float3 _165 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _176 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _178 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float3 _185 = fast::clamp(in.in_var_COLOR1.xyz, float3(0.0), float3(1.0));
    float _186 = fast::clamp(in.in_var_COLOR1.w * mix(_176, _178, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    float3 _202 = ((_185 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _205 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _220;
    if (_205)
    {
        float3 _215 = _112;
        _215.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _217 = _215;
        _217.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _219 = _217;
        _219.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _220 = _219;
    }
    else
    {
        _220 = float3(0.0);
    }
    float _238;
    float3 _239;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _236;
        float3 _237;
        if (_205)
        {
            _236 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _237 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _236 = 1.0;
            _237 = _165;
        }
        _238 = _236;
        _239 = _237;
    }
    else
    {
        _238 = 1.0;
        _239 = _165;
    }
    float4 _243 = float4(_239, 1.0);
    float3 _247 = _112;
    _247.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _243);
    float3 _251 = _247;
    _251.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _243);
    float3 _255 = _251;
    _255.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _243);
    float4 _258 = _243.xyzz * _243.yzzx;
    float3 _262 = _112;
    _262.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _258);
    float3 _266 = _262;
    _266.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _258);
    float3 _270 = _266;
    _270.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _258);
    bool _301 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _350;
    if (_301)
    {
        float4 _308 = View.View_WorldToClip * float4(_157, 1.0);
        float _309 = _308.w;
        float4 _338;
        if (_301)
        {
            _338 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_308.xy / float2(_309)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_309 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _338 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _350 = float4(_338.xyz + (in.in_var_TEXCOORD7.xyz * _338.w), _338.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _350 = in.in_var_TEXCOORD7;
    }
    float3 _358 = (_157 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _371 = fast::clamp((float3(0.5) - abs(_358 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _385 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_157 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _358, level(0.0)), float4((_371.x * _371.y) * _371.z));
    float3 _399 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _426;
    float3 _427;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _414 = any(abs(_157 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _424;
        if (_414)
        {
            _424 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_157, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _424 = _399;
        }
        _426 = _414 ? 1.0 : _186;
        _427 = _424;
    }
    else
    {
        _426 = _186;
        _427 = _399;
    }
    float4 _437 = float4((((mix(_202 * float4(_385.x * 0.886227548122406005859375, _385.y * 0.886227548122406005859375, _385.z * 0.886227548122406005859375, _111).xyz, _202, float3(View.View_UnlitViewmodeMask)) + ((((_220 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_255 + _270) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_239.x * _239.x) - (_239.y * _239.y)))) * View.View_SkyLightColor.xyz) * _238)) * _202) * fast::max(float3(1.0), ((((((_185 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_185 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_185 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _427) * _350.w) + _350.xyz, _426);
    float3 _441 = _437.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_441.x, _441.y, _441.z, _437.w);
    return out;
}

