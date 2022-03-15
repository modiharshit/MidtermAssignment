

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

constant float _113 = {};
constant float3 _114 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 in_var_TEXCOORD4 [[user(locn1)]];
    float4 in_var_TEXCOORD5 [[user(locn2)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 in_var_TANGENTX [[user(locn4)]];
    float4 in_var_TANGENTZ [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002e4a_4d31cc96(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _155 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _160 = (_155.xyz / float3(_155.w)) - View.View_PreViewTranslation;
    float3 _168 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _179 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _181 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _188 = fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _189 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_179, _181, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _205 = ((_188 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _208 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _223;
    if (_208)
    {
        float3 _218 = _114;
        _218.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _220 = _218;
        _220.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _222 = _220;
        _222.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _223 = _222;
    }
    else
    {
        _223 = float3(0.0);
    }
    float _241;
    float3 _242;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _239;
        float3 _240;
        if (_208)
        {
            _239 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _240 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _239 = 1.0;
            _240 = _168;
        }
        _241 = _239;
        _242 = _240;
    }
    else
    {
        _241 = 1.0;
        _242 = _168;
    }
    float4 _246 = float4(_242, 1.0);
    float3 _250 = _114;
    _250.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _246);
    float3 _254 = _250;
    _254.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _246);
    float3 _258 = _254;
    _258.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _246);
    float4 _261 = _246.xyzz * _246.yzzx;
    float3 _265 = _114;
    _265.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _261);
    float3 _269 = _265;
    _269.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _261);
    float3 _273 = _269;
    _273.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _261);
    bool _304 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _353;
    if (_304)
    {
        float4 _311 = View.View_WorldToClip * float4(_160, 1.0);
        float _312 = _311.w;
        float4 _341;
        if (_304)
        {
            _341 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_311.xy / float2(_312)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_312 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _341 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _353 = float4(_341.xyz + (in.in_var_TEXCOORD7.xyz * _341.w), _341.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _353 = in.in_var_TEXCOORD7;
    }
    float3 _354 = _160 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _362 = (_354 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _375 = fast::clamp((float3(0.5) - abs(_362 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _389 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_354 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _362, level(0.0)), float4((_375.x * _375.y) * _375.z));
    float3 _403 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _430;
    float3 _431;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _418 = any(abs(_160 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _428;
        if (_418)
        {
            _428 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_160, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _428 = _403;
        }
        _430 = _418 ? 1.0 : _189;
        _431 = _428;
    }
    else
    {
        _430 = _189;
        _431 = _403;
    }
    float4 _441 = float4((((mix(_205 * float4(_389.x * 0.886227548122406005859375, _389.y * 0.886227548122406005859375, _389.z * 0.886227548122406005859375, _113).xyz, _205, float3(View.View_UnlitViewmodeMask)) + ((((_223 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_258 + _273) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_242.x * _242.x) - (_242.y * _242.y)))) * View.View_SkyLightColor.xyz) * _241)) * _205) * fast::max(float3(1.0), ((((((_188 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_188 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_188 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _431) * _353.w) + _353.xyz, _430);
    float3 _445 = _441.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_445.x, _445.y, _445.z, _441.w);
    return out;
}

