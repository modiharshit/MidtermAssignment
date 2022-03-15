

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

constant float4 _135 = {};
constant float3 _136 = {};

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

fragment MainPS_out Main_000038cd_d043d284(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _202 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = (_202.xyz / float3(_202.w)) - View.View_PreViewTranslation;
    float3 _215 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _233 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _235 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _237 = mix(_233, _235, float4(in.in_var_TEXCOORD4.x));
    float _249 = _198.w;
    float4 _259 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_198.xy / float2(_249)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _260 = _259.x;
    float _290;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _290 = _249;
                break;
            }
            else
            {
                float _283 = _198.z;
                _290 = ((_283 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_283 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _297 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _237.w, 0.0), 1.0) * fast::min(fast::max(((((_260 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_260 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _290) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _304 = (fast::clamp((_229.xyz + _237.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _311 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _314 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _319;
    if (_314)
    {
        _319 = _304 + (_311 * 0.449999988079071044921875);
    }
    else
    {
        _319 = _304;
    }
    bool _324 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _373;
    if (_324)
    {
        float4 _331 = View.View_WorldToClip * float4(_207, 1.0);
        float _332 = _331.w;
        float4 _361;
        if (_324)
        {
            _361 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_331.xy / float2(_332)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_332 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _361 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _373 = float4(_361.xyz + (in.in_var_TEXCOORD7.xyz * _361.w), _361.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _373 = in.in_var_TEXCOORD7;
    }
    float3 _374 = _207 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _382 = (_374 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _390 = (_374 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _395 = fast::clamp((float3(0.5) - abs(_382 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _400 = (_395.x * _395.y) * _395.z;
    float4 _409 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _390, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _382, level(0.0)), float4(_400));
    float3 _420 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _390, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _382, level(0.0)).xyz, float3(_400)) * 1.0;
    float4 _422 = _135;
    _422.x = _409.x;
    float4 _424 = _135;
    _424.x = _409.y;
    float4 _426 = _135;
    _426.x = _409.z;
    float3 _427 = _409.xyz;
    float3 _431 = _427 / float3(dot(_427, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _433 = _420 * _431.x;
    float3 _436 = _420 * _431.y;
    float3 _439 = _420 * _431.z;
    float4 _443 = _135;
    _443.y = (-0.48860299587249755859375) * _215.y;
    float4 _446 = _443;
    _446.z = 0.48860299587249755859375 * _215.z;
    float4 _449 = _446;
    _449.w = (-0.48860299587249755859375) * _215.x;
    float4 _450 = _449;
    _450.x = 0.886227548122406005859375;
    float3 _452 = _450.yzw * 2.094395160675048828125;
    float4 _453 = float4(_450.x, _452.x, _452.y, _452.z);
    float3 _455 = _136;
    _455.x = dot(float4(_422.x, _433.x, _433.y, _433.z), _453);
    float3 _457 = _455;
    _457.y = dot(float4(_424.x, _436.x, _436.y, _436.z), _453);
    float3 _459 = _457;
    _459.z = dot(float4(_426.x, _439.x, _439.y, _439.z), _453);
    float _461 = _409.w;
    float3 _466 = float4(fast::max(float3(0.0), _459), _461).xyz;
    float3 _532;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _480 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_374, 1.0);
        float2 _484 = _480.xy / float2(_480.w);
        float _485 = _480.z;
        float4 _488 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _484, level(0.0));
        float3 _492 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _485;
        bool2 _517 = _484 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _519 = _484 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _532 = _319 * fast::max(_466 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _461) * (float3(1.0) - select(fast::clamp(exp((float3((((_488.x * _485) * 0.5) + dot((sin(_492) * _488.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_492)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _484, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_517.x || _519.x, _517.y || _519.y)))))), float3(0.0));
    }
    else
    {
        _532 = _319 * _466;
    }
    float3 _539 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _566;
    float3 _567;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _554 = any(abs(_207 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _564;
        if (_554)
        {
            _564 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _564 = _539;
        }
        _566 = _554 ? 1.0 : _297;
        _567 = _564;
    }
    else
    {
        _566 = _297;
        _567 = _539;
    }
    float4 _576 = float4(((mix(_532, _319 + (select(_311, float3(0.0), bool3(_314)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _567) * _373.w) + _373.xyz, _566);
    float3 _580 = _576.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_580.x, _580.y, _580.z, _576.w);
    return out;
}

