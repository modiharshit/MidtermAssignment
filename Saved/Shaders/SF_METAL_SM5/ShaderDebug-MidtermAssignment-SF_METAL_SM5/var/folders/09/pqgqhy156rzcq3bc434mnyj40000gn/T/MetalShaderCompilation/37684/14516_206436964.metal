

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

constant float4 _134 = {};
constant float3 _135 = {};

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

fragment MainPS_out Main_000038b4_0c4dfa64(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _196 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _200 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _205 = (_200.xyz / float3(_200.w)) - View.View_PreViewTranslation;
    float3 _213 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _231 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _233 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _235 = mix(_231, _233, float4(in.in_var_TEXCOORD10.w));
    float _247 = _196.w;
    float4 _257 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_196.xy / float2(_247)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _258 = _257.x;
    float _288;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _288 = _247;
                break;
            }
            else
            {
                float _281 = _196.z;
                _288 = ((_281 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_281 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _295 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _235.w, 0.0), 1.0) * fast::min(fast::max(((((_258 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_258 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _288) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _302 = (fast::clamp((_227.xyz + _235.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _309 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _312 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _317;
    if (_312)
    {
        _317 = _302 + (_309 * 0.449999988079071044921875);
    }
    else
    {
        _317 = _302;
    }
    bool _322 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _371;
    if (_322)
    {
        float4 _329 = View.View_WorldToClip * float4(_205, 1.0);
        float _330 = _329.w;
        float4 _359;
        if (_322)
        {
            _359 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_329.xy / float2(_330)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_330 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _359 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _371 = float4(_359.xyz + (in.in_var_TEXCOORD7.xyz * _359.w), _359.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _371 = in.in_var_TEXCOORD7;
    }
    float3 _372 = _205 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _380 = (_372 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _388 = (_372 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _393 = fast::clamp((float3(0.5) - abs(_380 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _398 = (_393.x * _393.y) * _393.z;
    float4 _407 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _388, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _380, level(0.0)), float4(_398));
    float3 _418 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _388, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _380, level(0.0)).xyz, float3(_398)) * 1.0;
    float4 _420 = _134;
    _420.x = _407.x;
    float4 _422 = _134;
    _422.x = _407.y;
    float4 _424 = _134;
    _424.x = _407.z;
    float3 _425 = _407.xyz;
    float3 _429 = _425 / float3(dot(_425, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _431 = _418 * _429.x;
    float3 _434 = _418 * _429.y;
    float3 _437 = _418 * _429.z;
    float4 _441 = _134;
    _441.y = (-0.48860299587249755859375) * _213.y;
    float4 _444 = _441;
    _444.z = 0.48860299587249755859375 * _213.z;
    float4 _447 = _444;
    _447.w = (-0.48860299587249755859375) * _213.x;
    float4 _448 = _447;
    _448.x = 0.886227548122406005859375;
    float3 _450 = _448.yzw * 2.094395160675048828125;
    float4 _451 = float4(_448.x, _450.x, _450.y, _450.z);
    float3 _453 = _135;
    _453.x = dot(float4(_420.x, _431.x, _431.y, _431.z), _451);
    float3 _455 = _453;
    _455.y = dot(float4(_422.x, _434.x, _434.y, _434.z), _451);
    float3 _457 = _455;
    _457.z = dot(float4(_424.x, _437.x, _437.y, _437.z), _451);
    float _459 = _407.w;
    float3 _464 = float4(fast::max(float3(0.0), _457), _459).xyz;
    float3 _530;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _478 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_372, 1.0);
        float2 _482 = _478.xy / float2(_478.w);
        float _483 = _478.z;
        float4 _486 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _482, level(0.0));
        float3 _490 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _483;
        bool2 _515 = _482 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _517 = _482 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _530 = _317 * fast::max(_464 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _459) * (float3(1.0) - select(fast::clamp(exp((float3((((_486.x * _483) * 0.5) + dot((sin(_490) * _486.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_490)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _482, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_515.x || _517.x, _515.y || _517.y)))))), float3(0.0));
    }
    else
    {
        _530 = _317 * _464;
    }
    float3 _537 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _564;
    float3 _565;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _552 = any(abs(_205 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _562;
        if (_552)
        {
            _562 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_205, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _562 = _537;
        }
        _564 = _552 ? 1.0 : _295;
        _565 = _562;
    }
    else
    {
        _564 = _295;
        _565 = _537;
    }
    float4 _574 = float4(((mix(_530, _317 + (select(_309, float3(0.0), bool3(_312)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _565) * _371.w) + _371.xyz, _564);
    float3 _578 = _574.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_578.x, _578.y, _578.z, _574.w);
    return out;
}

