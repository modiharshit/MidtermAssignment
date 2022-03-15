

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _108 = {};
constant float3 _109 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD1 [[user(locn2)]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_COLOR1 [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

fragment MainPS_out Main_0000245c_0677701c(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _142 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _147 = (_142.xyz / float3(_142.w)) - View.View_PreViewTranslation;
    float4 _158 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _160 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float3 _167 = fast::clamp(in.in_var_COLOR1.xyz, float3(0.0), float3(1.0));
    float _168 = fast::clamp(in.in_var_COLOR1.w * mix(_158, _160, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    float3 _178 = fast::clamp((_147 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _189 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_178.x), int(_178.y), int(_178.z), 0).xyz), 0));
    float3 _220 = ((_167 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _224 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, ((((_189.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_178 / float3(_189.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0));
    float3 _229 = _109;
    _229.x = _224.x * 0.886227548122406005859375;
    float3 _231 = _229;
    _231.y = _224.y * 0.886227548122406005859375;
    float3 _233 = _231;
    _233.z = _224.z * 0.886227548122406005859375;
    bool _255 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _303;
    if (_255)
    {
        float4 _262 = View.View_WorldToClip * float4(_147, 1.0);
        float _263 = _262.w;
        float4 _291;
        if (_255)
        {
            _291 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_262.xy / float2(_263)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_263 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _291 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _303 = float4(_291.xyz + (in.in_var_TEXCOORD7.xyz * _291.w), _291.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _303 = in.in_var_TEXCOORD7;
    }
    float3 _311 = (_147 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _324 = fast::clamp((float3(0.5) - abs(_311 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _337 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_147 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _311, level(0.0)), float4((_324.x * _324.y) * _324.z));
    float3 _351 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _378;
    float3 _379;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _366 = any(abs(_147 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _376;
        if (_366)
        {
            _376 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_147, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _376 = _351;
        }
        _378 = _366 ? 1.0 : _168;
        _379 = _376;
    }
    else
    {
        _378 = _168;
        _379 = _351;
    }
    float4 _389 = float4((((mix(_220 * float4(_337.x * 0.886227548122406005859375, _337.y * 0.886227548122406005859375, _337.z * 0.886227548122406005859375, _108).xyz, _220, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _233) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _220) * fast::max(float3(1.0), ((((((_167 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_167 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_167 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _379) * _303.w) + _303.xyz, _378);
    float3 _393 = _389.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_393.x, _393.y, _393.z, _389.w);
    return out;
}

