

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

constant float _109 = {};
constant float3 _110 = {};

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

fragment MainPS_out Main_00002785_6d9075ba(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _148 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _153 = (_148.xyz / float3(_148.w)) - View.View_PreViewTranslation;
    float3 _161 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _172 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _174 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _181 = fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _182 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_172, _174, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _198 = ((_181 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float _199 = _161.x;
    float _200 = _161.y;
    float4 _202 = float4(_199, _200, _161.z, 1.0);
    float3 _206 = _110;
    _206.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _202);
    float3 _210 = _206;
    _210.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _202);
    float3 _214 = _210;
    _214.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _202);
    float4 _217 = _202.xyzz * _202.yzzx;
    float3 _221 = _110;
    _221.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _217);
    float3 _225 = _221;
    _225.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _217);
    float3 _229 = _225;
    _229.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _217);
    bool _259 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _308;
    if (_259)
    {
        float4 _266 = View.View_WorldToClip * float4(_153, 1.0);
        float _267 = _266.w;
        float4 _296;
        if (_259)
        {
            _296 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_266.xy / float2(_267)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_267 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _296 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _308 = float4(_296.xyz + (in.in_var_TEXCOORD7.xyz * _296.w), _296.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _308 = in.in_var_TEXCOORD7;
    }
    float3 _309 = _153 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _317 = (_309 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _330 = fast::clamp((float3(0.5) - abs(_317 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _344 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_309 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _317, level(0.0)), float4((_330.x * _330.y) * _330.z));
    float3 _358 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _385;
    float3 _386;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _373 = any(abs(_153 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _383;
        if (_373)
        {
            _383 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_153, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _383 = _358;
        }
        _385 = _373 ? 1.0 : _182;
        _386 = _383;
    }
    else
    {
        _385 = _182;
        _386 = _358;
    }
    float4 _396 = float4((((mix(_198 * float4(_344.x * 0.886227548122406005859375, _344.y * 0.886227548122406005859375, _344.z * 0.886227548122406005859375, _109).xyz, _198, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_214 + _229) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_199 * _199) - (_200 * _200)))) * View.View_SkyLightColor.xyz) * 1.0) * _198) * fast::max(float3(1.0), ((((((_181 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_181 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_181 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _386) * _308.w) + _308.xyz, _385);
    float3 _400 = _396.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_400.x, _400.y, _400.z, _396.w);
    return out;
}

