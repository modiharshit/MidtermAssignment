

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

constant float _123 = {};
constant float3 _124 = {};

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

fragment MainPS_out Main_00003024_5d55309c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _169 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _174 = (_169.xyz / float3(_169.w)) - View.View_PreViewTranslation;
    float4 _193 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _195 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _202 = fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _203 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_193, _195, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _213 = fast::clamp((_174 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _224 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_213.x), int(_213.y), int(_213.z), 0).xyz), 0));
    float3 _239 = (((_224.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_213 / float3(_224.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _255 = ((_202 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _259 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _239, level(0.0));
    float3 _264 = _124;
    _264.x = _259.x * 0.886227548122406005859375;
    float3 _266 = _264;
    _266.y = _259.y * 0.886227548122406005859375;
    float3 _268 = _266;
    _268.z = _259.z * 0.886227548122406005859375;
    float _289;
    float3 _290;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _284 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _239, level(0.0)).xyz * 2.0) - float3(1.0);
        float _285 = length(_284);
        _289 = _285;
        _290 = _284 / float3(fast::max(_285, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _289 = 1.0;
        _290 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _294 = float4(_290, 1.0);
    float3 _298 = _124;
    _298.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _294);
    float3 _302 = _298;
    _302.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _294);
    float3 _306 = _302;
    _306.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _294);
    float4 _309 = _294.xyzz * _294.yzzx;
    float3 _313 = _124;
    _313.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _309);
    float3 _317 = _313;
    _317.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _309);
    float3 _321 = _317;
    _321.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _309);
    bool _352 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _400;
    if (_352)
    {
        float4 _359 = View.View_WorldToClip * float4(_174, 1.0);
        float _360 = _359.w;
        float4 _388;
        if (_352)
        {
            _388 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_359.xy / float2(_360)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_360 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _388 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _400 = float4(_388.xyz + (in.in_var_TEXCOORD7.xyz * _388.w), _388.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _400 = in.in_var_TEXCOORD7;
    }
    float3 _401 = _174 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _409 = (_401 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _422 = fast::clamp((float3(0.5) - abs(_409 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _435 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_401 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _409, level(0.0)), float4((_422.x * _422.y) * _422.z));
    float3 _449 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _476;
    float3 _477;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _464 = any(abs(_174 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _474;
        if (_464)
        {
            _474 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_174, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _474 = _449;
        }
        _476 = _464 ? 1.0 : _203;
        _477 = _474;
    }
    else
    {
        _476 = _203;
        _477 = _449;
    }
    float4 _487 = float4((((mix(_255 * float4(_435.x * 0.886227548122406005859375, _435.y * 0.886227548122406005859375, _435.z * 0.886227548122406005859375, _123).xyz, _255, float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _268) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_306 + _321) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_290.x * _290.x) - (_290.y * _290.y)))) * View.View_SkyLightColor.xyz) * _289)) * _255) * fast::max(float3(1.0), ((((((_202 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_202 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_202 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _477) * _400.w) + _400.xyz, _476);
    float3 _491 = _487.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_491.x, _491.y, _491.z, _487.w);
    return out;
}

