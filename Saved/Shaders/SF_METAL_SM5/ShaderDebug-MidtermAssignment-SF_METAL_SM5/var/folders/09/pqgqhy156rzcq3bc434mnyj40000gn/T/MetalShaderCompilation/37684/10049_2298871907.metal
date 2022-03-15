

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
    char _m11_pad[560];
    float4 View_SkyLightColor;
    char _m12_pad[320];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _107 = {};
constant float3 _108 = {};

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

fragment MainPS_out Main_00002741_89060063(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _145 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _150 = (_145.xyz / float3(_145.w)) - View.View_PreViewTranslation;
    float3 _158 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _169 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _171 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float3 _178 = fast::clamp(in.in_var_COLOR1.xyz, float3(0.0), float3(1.0));
    float _179 = fast::clamp(in.in_var_COLOR1.w * mix(_169, _171, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    float3 _195 = ((_178 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float _196 = _158.x;
    float _197 = _158.y;
    float4 _199 = float4(_196, _197, _158.z, 1.0);
    float3 _203 = _108;
    _203.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _199);
    float3 _207 = _203;
    _207.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _199);
    float3 _211 = _207;
    _211.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _199);
    float4 _214 = _199.xyzz * _199.yzzx;
    float3 _218 = _108;
    _218.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _214);
    float3 _222 = _218;
    _222.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _214);
    float3 _226 = _222;
    _226.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _214);
    bool _256 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _305;
    if (_256)
    {
        float4 _263 = View.View_WorldToClip * float4(_150, 1.0);
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
    float3 _313 = (_150 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _326 = fast::clamp((float3(0.5) - abs(_313 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _340 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_150 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _313, level(0.0)), float4((_326.x * _326.y) * _326.z));
    float3 _354 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _381;
    float3 _382;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _369 = any(abs(_150 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _379;
        if (_369)
        {
            _379 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_150, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _379 = _354;
        }
        _381 = _369 ? 1.0 : _179;
        _382 = _379;
    }
    else
    {
        _381 = _179;
        _382 = _354;
    }
    float4 _392 = float4((((mix(_195 * float4(_340.x * 0.886227548122406005859375, _340.y * 0.886227548122406005859375, _340.z * 0.886227548122406005859375, _107).xyz, _195, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_211 + _226) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_196 * _196) - (_197 * _197)))) * View.View_SkyLightColor.xyz) * 1.0) * _195) * fast::max(float3(1.0), ((((((_178 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_178 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_178 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _382) * _305.w) + _305.xyz, _381);
    float3 _396 = _392.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_396.x, _396.y, _396.z, _392.w);
    return out;
}

