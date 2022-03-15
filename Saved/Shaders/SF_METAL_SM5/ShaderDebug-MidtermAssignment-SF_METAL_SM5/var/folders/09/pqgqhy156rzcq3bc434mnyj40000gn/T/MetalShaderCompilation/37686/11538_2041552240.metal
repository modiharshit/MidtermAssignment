

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
    char _m7_pad[80];
    float View_UnlitViewmodeMask;
    char _m8_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m10_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[800];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m13_pad[16];
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

constant float3 _128 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

fragment MainPS_out Main_00002d12_79af9d70(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _162 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _167 = (_162.xyz / float3(_162.w)) - View.View_PreViewTranslation;
    float4 _178 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _180 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _187 = fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _188 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_178, _180, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _198 = fast::clamp((_167 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _209 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_198.x), int(_198.y), int(_198.z), 0).xyz), 0));
    float3 _240 = ((_187 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _244 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_209.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_198 / float3(_209.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _249 = _128;
    _249.x = _244.x * 0.886227548122406005859375;
    float3 _251 = _249;
    _251.y = _244.y * 0.886227548122406005859375;
    float3 _253 = _251;
    _253.z = _244.z * 0.886227548122406005859375;
    bool _275 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _323;
    if (_275)
    {
        float4 _282 = View.View_WorldToClip * float4(_167, 1.0);
        float _283 = _282.w;
        float4 _311;
        if (_275)
        {
            _311 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_282.xy / float2(_283)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_283 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _311 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _323 = float4(_311.xyz + (in.in_var_TEXCOORD7.xyz * _311.w), _311.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _323 = in.in_var_TEXCOORD7;
    }
    float3 _324 = _167 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _332 = (_324 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _345 = fast::clamp((float3(0.5) - abs(_332 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _358 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_324 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _332, level(0.0)), float4((_345.x * _345.y) * _345.z));
    float _365 = _358.w;
    float3 _367 = float4(_358.x * 0.886227548122406005859375, _358.y * 0.886227548122406005859375, _358.z * 0.886227548122406005859375, _365).xyz;
    float3 _433;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _381 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_324, 1.0);
        float2 _385 = _381.xy / float2(_381.w);
        float _386 = _381.z;
        float4 _389 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _385, level(0.0));
        float3 _393 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _386;
        bool2 _418 = _385 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _420 = _385 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _433 = _240 * fast::max(_367 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _365) * (float3(1.0) - select(fast::clamp(exp((float3((((_389.x * _386) * 0.5) + dot((sin(_393) * _389.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_393)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _385, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_418.x || _420.x, _418.y || _420.y)))))), float3(0.0));
    }
    else
    {
        _433 = _240 * _367;
    }
    float3 _438 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _465;
    float3 _466;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _453 = any(abs(_167 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _463;
        if (_453)
        {
            _463 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_167, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _463 = _438;
        }
        _465 = _453 ? 1.0 : _188;
        _466 = _463;
    }
    else
    {
        _465 = _188;
        _466 = _438;
    }
    float4 _476 = float4((((mix(_433, _240, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _253) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _240) * fast::max(float3(1.0), ((((((_187 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_187 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_187 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _466) * _323.w) + _323.xyz, _465);
    float3 _480 = _476.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_480.x, _480.y, _480.z, _476.w);
    return out;
}

