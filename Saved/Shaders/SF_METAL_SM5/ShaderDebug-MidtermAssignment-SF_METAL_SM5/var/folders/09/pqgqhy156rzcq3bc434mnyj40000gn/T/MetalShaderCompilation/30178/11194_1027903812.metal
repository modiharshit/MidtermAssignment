

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
    char _m15_pad[16];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float3 _119 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

fragment MainPS_out Main_00002bba_3d449144(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _151 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _156 = (_151.xyz / float3(_151.w)) - View.View_PreViewTranslation;
    float4 _162 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _183 = fast::clamp((_156 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _194 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_183.x), int(_183.y), int(_183.z), 0).xyz), 0));
    float3 _219 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _222 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _227;
    if (_222)
    {
        _227 = View.View_DiffuseOverrideParameter.xyz + (_219 * 0.449999988079071044921875);
    }
    else
    {
        _227 = View.View_DiffuseOverrideParameter.xyz;
    }
    float4 _233 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_194.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_183 / float3(_194.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _238 = _119;
    _238.x = _233.x * 0.886227548122406005859375;
    float3 _240 = _238;
    _240.y = _233.y * 0.886227548122406005859375;
    float3 _242 = _240;
    _242.z = _233.z * 0.886227548122406005859375;
    bool _251 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _299;
    if (_251)
    {
        float4 _258 = View.View_WorldToClip * float4(_156, 1.0);
        float _259 = _258.w;
        float4 _287;
        if (_251)
        {
            _287 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_258.xy / float2(_259)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_259 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _287 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _299 = float4(_287.xyz + (in.in_var_TEXCOORD7.xyz * _287.w), _287.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _299 = in.in_var_TEXCOORD7;
    }
    float3 _307 = (_156 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _320 = fast::clamp((float3(0.5) - abs(_307 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _333 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_156 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _307, level(0.0)), float4((_320.x * _320.y) * _320.z));
    float _340 = _333.w;
    float3 _342 = float4(_333.x * 0.886227548122406005859375, _333.y * 0.886227548122406005859375, _333.z * 0.886227548122406005859375, _340).xyz;
    float3 _408;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _356 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_156, 1.0);
        float2 _360 = _356.xy / float2(_356.w);
        float _361 = _356.z;
        float4 _364 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _360, level(0.0));
        float3 _368 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _361;
        bool2 _393 = _360 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _395 = _360 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _408 = _227 * fast::max(_342 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _340) * (float3(1.0) - select(fast::clamp(exp((float3((((_364.x * _361) * 0.5) + dot((sin(_368) * _364.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_368)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _360, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_393.x || _395.x, _393.y || _395.y)))))), float3(0.0));
    }
    else
    {
        _408 = _227 * _342;
    }
    float3 _415 = fast::max(mix(float3(_162.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _441;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _440;
        if (any(abs(_156 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _440 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_156, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _440 = _415;
        }
        _441 = _440;
    }
    else
    {
        _441 = _415;
    }
    float4 _451 = float4((((mix(_408, _227 + (select(_219, float3(0.0), bool3(_222)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((fast::max(float3(0.0), _242) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _227)) + _441) * _299.w) + _299.xyz, 1.0);
    float3 _455 = _451.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_455.x, _455.y, _455.z, _451.w);
    return out;
}

