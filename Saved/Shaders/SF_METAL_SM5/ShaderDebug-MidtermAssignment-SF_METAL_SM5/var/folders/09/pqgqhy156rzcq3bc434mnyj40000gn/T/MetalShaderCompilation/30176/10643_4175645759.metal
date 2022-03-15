

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
    char _m11_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m15_pad[80];
    float View_IndirectLightingCacheShowFlag;
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
    char _m0_pad[96];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
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

constant float3 _113 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

fragment MainPS_out Main_00002993_f8e34c3f(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _140 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _145 = (_140.xyz / float3(_140.w)) - View.View_PreViewTranslation;
    float4 _151 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _172 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _175 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _180;
    if (_175)
    {
        _180 = View.View_DiffuseOverrideParameter.xyz + (_172 * 0.449999988079071044921875);
    }
    else
    {
        _180 = View.View_DiffuseOverrideParameter.xyz;
    }
    float3 _200;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _195 = _113;
        _195.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _197 = _195;
        _197.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _199 = _197;
        _199.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _200 = _199;
    }
    else
    {
        _200 = float3(0.0);
    }
    bool _207 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _256;
    if (_207)
    {
        float4 _214 = View.View_WorldToClip * float4(_145, 1.0);
        float _215 = _214.w;
        float4 _244;
        if (_207)
        {
            _244 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_214.xy / float2(_215)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_215 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _244 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _256 = float4(_244.xyz + (in.in_var_TEXCOORD7.xyz * _244.w), _244.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _256 = in.in_var_TEXCOORD7;
    }
    float3 _264 = (_145 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _277 = fast::clamp((float3(0.5) - abs(_264 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _291 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_145 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _264, level(0.0)), float4((_277.x * _277.y) * _277.z));
    float _298 = _291.w;
    float3 _300 = float4(_291.x * 0.886227548122406005859375, _291.y * 0.886227548122406005859375, _291.z * 0.886227548122406005859375, _298).xyz;
    float3 _366;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _314 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_145, 1.0);
        float2 _318 = _314.xy / float2(_314.w);
        float _319 = _314.z;
        float4 _322 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _318, level(0.0));
        float3 _326 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _319;
        bool2 _351 = _318 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _353 = _318 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _366 = _180 * fast::max(_300 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _298) * (float3(1.0) - select(fast::clamp(exp((float3((((_322.x * _319) * 0.5) + dot((sin(_326) * _322.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_326)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _318, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_351.x || _353.x, _351.y || _353.y)))))), float3(0.0));
    }
    else
    {
        _366 = _180 * _300;
    }
    float3 _373 = fast::max(mix(float3(_151.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _399;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _398;
        if (any(abs(_145 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _398 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_145, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _398 = _373;
        }
        _399 = _398;
    }
    else
    {
        _399 = _373;
    }
    float4 _409 = float4((((mix(_366, _180 + (select(_172, float3(0.0), bool3(_175)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_200 * View.View_IndirectLightingColorScale) * _180)) + _399) * _256.w) + _256.xyz, 1.0);
    float3 _413 = _409.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_413.x, _413.y, _413.z, _409.w);
    return out;
}

