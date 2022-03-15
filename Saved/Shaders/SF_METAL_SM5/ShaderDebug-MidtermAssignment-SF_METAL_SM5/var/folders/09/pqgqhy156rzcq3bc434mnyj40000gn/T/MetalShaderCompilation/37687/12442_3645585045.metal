

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
    char _m1_pad[320];
    float4x4 View_ViewToClip;
    char _m2_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m5_pad[48];
    float3 View_PreViewTranslation;
    char _m6_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m8_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m12_pad[16];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m17_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
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

constant float _116 = {};
constant float4 _118 = {};
constant float3 _119 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 in_var_TEXCOORD4 [[user(locn2)]];
    float4 in_var_TEXCOORD5 [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TANGENTX [[user(locn5)]];
    float4 in_var_TANGENTZ [[user(locn6)]];
    float4 in_var_TEXCOORD7 [[user(locn7)]];
};

fragment MainPS_out Main_0000309a_d94b3695(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _181 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _185 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _190 = (_185.xyz / float3(_185.w)) - View.View_PreViewTranslation;
    float3 _198 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _212 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _216 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _218 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _220 = mix(_216, _218, float4(in.in_var_TEXCOORD4.x));
    float _232 = _181.w;
    float4 _242 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_181.xy / float2(_232)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _243 = _242.x;
    float _273;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _273 = _232;
                break;
            }
            else
            {
                float _266 = _181.z;
                _273 = ((_266 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_266 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _280 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _220.w, 0.0), 1.0) * fast::min(fast::max(((((_243 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_243 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _273) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _287 = (fast::clamp((_212.xyz + _220.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _294 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _297 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _302;
    if (_297)
    {
        _302 = _287 + (_294 * 0.449999988079071044921875);
    }
    else
    {
        _302 = _287;
    }
    bool _307 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _356;
    if (_307)
    {
        float4 _314 = View.View_WorldToClip * float4(_190, 1.0);
        float _315 = _314.w;
        float4 _344;
        if (_307)
        {
            _344 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_314.xy / float2(_315)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_315 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _344 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _356 = float4(_344.xyz + (in.in_var_TEXCOORD7.xyz * _344.w), _344.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _356 = in.in_var_TEXCOORD7;
    }
    float3 _357 = _190 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _365 = (_357 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _373 = (_357 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _378 = fast::clamp((float3(0.5) - abs(_365 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _383 = (_378.x * _378.y) * _378.z;
    float4 _392 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _373, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _365, level(0.0)), float4(_383));
    float3 _403 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _373, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _365, level(0.0)).xyz, float3(_383)) * 1.0;
    float4 _405 = _118;
    _405.x = _392.x;
    float4 _407 = _118;
    _407.x = _392.y;
    float4 _409 = _118;
    _409.x = _392.z;
    float3 _410 = _392.xyz;
    float3 _414 = _410 / float3(dot(_410, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _416 = _403 * _414.x;
    float3 _419 = _403 * _414.y;
    float3 _422 = _403 * _414.z;
    float4 _426 = _118;
    _426.y = (-0.48860299587249755859375) * _198.y;
    float4 _429 = _426;
    _429.z = 0.48860299587249755859375 * _198.z;
    float4 _432 = _429;
    _432.w = (-0.48860299587249755859375) * _198.x;
    float4 _433 = _432;
    _433.x = 0.886227548122406005859375;
    float3 _435 = _433.yzw * 2.094395160675048828125;
    float4 _436 = float4(_433.x, _435.x, _435.y, _435.z);
    float3 _438 = _119;
    _438.x = dot(float4(_405.x, _416.x, _416.y, _416.z), _436);
    float3 _440 = _438;
    _440.y = dot(float4(_407.x, _419.x, _419.y, _419.z), _436);
    float3 _442 = _440;
    _442.z = dot(float4(_409.x, _422.x, _422.y, _422.z), _436);
    float3 _456 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _483;
    float3 _484;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _471 = any(abs(_190 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _481;
        if (_471)
        {
            _481 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_190, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _481 = _456;
        }
        _483 = _471 ? 1.0 : _280;
        _484 = _481;
    }
    else
    {
        _483 = _280;
        _484 = _456;
    }
    float4 _493 = float4(((mix(_302 * float4(fast::max(float3(0.0), _442), _116).xyz, _302 + (select(_294, float3(0.0), bool3(_297)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _484) * _356.w) + _356.xyz, _483);
    float3 _497 = _493.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_497.x, _497.y, _497.z, _493.w);
    return out;
}

