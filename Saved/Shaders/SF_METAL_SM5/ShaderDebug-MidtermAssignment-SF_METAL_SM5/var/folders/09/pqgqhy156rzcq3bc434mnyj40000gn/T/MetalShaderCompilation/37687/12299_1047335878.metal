

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
    char _m16_pad[16];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _122 = {};
constant float3 _123 = {};

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

fragment MainPS_out Main_0000300b_3e6d13c6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _167 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _172 = (_167.xyz / float3(_167.w)) - View.View_PreViewTranslation;
    float4 _191 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _193 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _200 = fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _201 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_191, _193, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _211 = fast::clamp((_172 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _222 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_211.x), int(_211.y), int(_211.z), 0).xyz), 0));
    float3 _237 = (((_222.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_211 / float3(_222.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _253 = ((_200 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _257 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _237, level(0.0));
    float3 _262 = _123;
    _262.x = _257.x * 0.886227548122406005859375;
    float3 _264 = _262;
    _264.y = _257.y * 0.886227548122406005859375;
    float3 _266 = _264;
    _266.z = _257.z * 0.886227548122406005859375;
    float _287;
    float3 _288;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _282 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _237, level(0.0)).xyz * 2.0) - float3(1.0);
        float _283 = length(_282);
        _287 = _283;
        _288 = _282 / float3(fast::max(_283, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _287 = 1.0;
        _288 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _292 = float4(_288, 1.0);
    float3 _296 = _123;
    _296.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _292);
    float3 _300 = _296;
    _300.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _292);
    float3 _304 = _300;
    _304.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _292);
    float4 _307 = _292.xyzz * _292.yzzx;
    float3 _311 = _123;
    _311.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _307);
    float3 _315 = _311;
    _315.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _307);
    float3 _319 = _315;
    _319.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _307);
    bool _350 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _398;
    if (_350)
    {
        float4 _357 = View.View_WorldToClip * float4(_172, 1.0);
        float _358 = _357.w;
        float4 _386;
        if (_350)
        {
            _386 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_357.xy / float2(_358)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_358 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _386 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _398 = float4(_386.xyz + (in.in_var_TEXCOORD7.xyz * _386.w), _386.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _398 = in.in_var_TEXCOORD7;
    }
    float3 _399 = _172 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _407 = (_399 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _420 = fast::clamp((float3(0.5) - abs(_407 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _433 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_399 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _407, level(0.0)), float4((_420.x * _420.y) * _420.z));
    float3 _447 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _474;
    float3 _475;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _462 = any(abs(_172 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _472;
        if (_462)
        {
            _472 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_172, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _472 = _447;
        }
        _474 = _462 ? 1.0 : _201;
        _475 = _472;
    }
    else
    {
        _474 = _201;
        _475 = _447;
    }
    float4 _485 = float4((((mix(_253 * float4(_433.x * 0.886227548122406005859375, _433.y * 0.886227548122406005859375, _433.z * 0.886227548122406005859375, _122).xyz, _253, float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _266) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_304 + _319) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_288.x * _288.x) - (_288.y * _288.y)))) * View.View_SkyLightColor.xyz) * _287)) * _253) * fast::max(float3(1.0), ((((((_200 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_200 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_200 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _475) * _398.w) + _398.xyz, _474);
    float3 _489 = _485.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_489.x, _489.y, _489.z, _485.w);
    return out;
}

