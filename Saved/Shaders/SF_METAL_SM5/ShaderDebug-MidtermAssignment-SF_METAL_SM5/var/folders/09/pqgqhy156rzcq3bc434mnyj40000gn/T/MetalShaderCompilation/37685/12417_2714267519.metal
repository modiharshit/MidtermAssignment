

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

constant float _115 = {};
constant float4 _117 = {};
constant float3 _118 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_TEXCOORD3_0 [[user(locn3)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn4)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

fragment MainPS_out Main_00003081_a1c86f7f(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _179 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _183 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _188 = (_183.xyz / float3(_183.w)) - View.View_PreViewTranslation;
    float3 _196 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _210 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _214 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _216 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _218 = mix(_214, _216, float4(in.in_var_TEXCOORD10.w));
    float _230 = _179.w;
    float4 _240 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_179.xy / float2(_230)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _241 = _240.x;
    float _271;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _271 = _230;
                break;
            }
            else
            {
                float _264 = _179.z;
                _271 = ((_264 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_264 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _278 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _218.w, 0.0), 1.0) * fast::min(fast::max(((((_241 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_241 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _271) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _285 = (fast::clamp((_210.xyz + _218.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _292 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _295 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _300;
    if (_295)
    {
        _300 = _285 + (_292 * 0.449999988079071044921875);
    }
    else
    {
        _300 = _285;
    }
    bool _305 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _354;
    if (_305)
    {
        float4 _312 = View.View_WorldToClip * float4(_188, 1.0);
        float _313 = _312.w;
        float4 _342;
        if (_305)
        {
            _342 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_312.xy / float2(_313)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_313 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _342 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _354 = float4(_342.xyz + (in.in_var_TEXCOORD7.xyz * _342.w), _342.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _354 = in.in_var_TEXCOORD7;
    }
    float3 _355 = _188 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _363 = (_355 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _371 = (_355 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _376 = fast::clamp((float3(0.5) - abs(_363 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _381 = (_376.x * _376.y) * _376.z;
    float4 _390 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _371, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _363, level(0.0)), float4(_381));
    float3 _401 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _371, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _363, level(0.0)).xyz, float3(_381)) * 1.0;
    float4 _403 = _117;
    _403.x = _390.x;
    float4 _405 = _117;
    _405.x = _390.y;
    float4 _407 = _117;
    _407.x = _390.z;
    float3 _408 = _390.xyz;
    float3 _412 = _408 / float3(dot(_408, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _414 = _401 * _412.x;
    float3 _417 = _401 * _412.y;
    float3 _420 = _401 * _412.z;
    float4 _424 = _117;
    _424.y = (-0.48860299587249755859375) * _196.y;
    float4 _427 = _424;
    _427.z = 0.48860299587249755859375 * _196.z;
    float4 _430 = _427;
    _430.w = (-0.48860299587249755859375) * _196.x;
    float4 _431 = _430;
    _431.x = 0.886227548122406005859375;
    float3 _433 = _431.yzw * 2.094395160675048828125;
    float4 _434 = float4(_431.x, _433.x, _433.y, _433.z);
    float3 _436 = _118;
    _436.x = dot(float4(_403.x, _414.x, _414.y, _414.z), _434);
    float3 _438 = _436;
    _438.y = dot(float4(_405.x, _417.x, _417.y, _417.z), _434);
    float3 _440 = _438;
    _440.z = dot(float4(_407.x, _420.x, _420.y, _420.z), _434);
    float3 _454 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _481;
    float3 _482;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _469 = any(abs(_188 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _479;
        if (_469)
        {
            _479 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_188, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _479 = _454;
        }
        _481 = _469 ? 1.0 : _278;
        _482 = _479;
    }
    else
    {
        _481 = _278;
        _482 = _454;
    }
    float4 _491 = float4(((mix(_300 * float4(fast::max(float3(0.0), _440), _115).xyz, _300 + (select(_292, float3(0.0), bool3(_295)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _482) * _354.w) + _354.xyz, _481);
    float3 _495 = _491.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_495.x, _495.y, _495.z, _491.w);
    return out;
}

