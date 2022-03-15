

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
    char _m7_pad[48];
    float View_MaterialTextureMipBias;
    char _m8_pad[28];
    float View_UnlitViewmodeMask;
    char _m9_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[384];
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

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

fragment MainPS_out Main_00002545_2af834a1(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _133 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _138 = (_133.xyz / float3(_133.w)) - View.View_PreViewTranslation;
    float4 _144 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _165 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _168 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _173;
    if (_168)
    {
        _173 = View.View_DiffuseOverrideParameter.xyz + (_165 * 0.449999988079071044921875);
    }
    else
    {
        _173 = View.View_DiffuseOverrideParameter.xyz;
    }
    bool _178 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _227;
    if (_178)
    {
        float4 _185 = View.View_WorldToClip * float4(_138, 1.0);
        float _186 = _185.w;
        float4 _215;
        if (_178)
        {
            _215 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_185.xy / float2(_186)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_186 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _215 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _227 = float4(_215.xyz + (in.in_var_TEXCOORD7.xyz * _215.w), _215.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _227 = in.in_var_TEXCOORD7;
    }
    float3 _235 = (_138 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _248 = fast::clamp((float3(0.5) - abs(_235 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _262 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_138 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _235, level(0.0)), float4((_248.x * _248.y) * _248.z));
    float _269 = _262.w;
    float3 _271 = float4(_262.x * 0.886227548122406005859375, _262.y * 0.886227548122406005859375, _262.z * 0.886227548122406005859375, _269).xyz;
    float3 _337;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _285 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_138, 1.0);
        float2 _289 = _285.xy / float2(_285.w);
        float _290 = _285.z;
        float4 _293 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _289, level(0.0));
        float3 _297 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _290;
        bool2 _322 = _289 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _324 = _289 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _337 = _173 * fast::max(_271 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _269) * (float3(1.0) - select(fast::clamp(exp((float3((((_293.x * _290) * 0.5) + dot((sin(_297) * _293.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_297)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _289, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_322.x || _324.x, _322.y || _324.y)))))), float3(0.0));
    }
    else
    {
        _337 = _173 * _271;
    }
    float3 _344 = fast::max(mix(float3(_144.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _370;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _369;
        if (any(abs(_138 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _369 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_138, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _369 = _344;
        }
        _370 = _369;
    }
    else
    {
        _370 = _344;
    }
    float4 _379 = float4(((mix(_337, _173 + (select(_165, float3(0.0), bool3(_168)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _370) * _227.w) + _227.xyz, 1.0);
    float3 _383 = _379.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_383.x, _383.y, _383.z, _379.w);
    return out;
}

