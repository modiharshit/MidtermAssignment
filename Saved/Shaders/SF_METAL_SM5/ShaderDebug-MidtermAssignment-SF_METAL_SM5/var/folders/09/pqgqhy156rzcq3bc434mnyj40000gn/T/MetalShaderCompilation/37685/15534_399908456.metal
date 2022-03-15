

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
    char _m17_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m18_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m19_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m21_pad[80];
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
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _134 = {};
constant float4 _135 = {};
constant float4 _137 = {};
constant float3 _138 = {};

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

fragment MainPS_out Main_00003cae_17d61e68(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _201 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float3 _218 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _232 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _236 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _238 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _240 = mix(_236, _238, float4(in.in_var_TEXCOORD10.w));
    float _252 = _201.w;
    float4 _262 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_201.xy / float2(_252)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _263 = _262.x;
    float _293;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _293 = _252;
                break;
            }
            else
            {
                float _286 = _201.z;
                _293 = ((_286 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_286 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _299 = fast::clamp((_232.xyz + _240.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _300 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _240.w, 0.0), 1.0) * fast::min(fast::max(((((_263 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_263 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _293) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _307 = (_299 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _314 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _317 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _322;
    if (_317)
    {
        _322 = _307 + (_314 * 0.449999988079071044921875);
    }
    else
    {
        _322 = _307;
    }
    float3 _400;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _348 = _218.y;
        float4 _350 = _137;
        _350.y = (-0.48860299587249755859375) * _348;
        float _351 = _218.z;
        float4 _353 = _350;
        _353.z = 0.48860299587249755859375 * _351;
        float _354 = _218.x;
        float4 _356 = _353;
        _356.w = (-0.48860299587249755859375) * _354;
        float3 _357 = _218 * _218;
        float4 _360 = _135;
        _360.x = (1.09254801273345947265625 * _354) * _348;
        float4 _363 = _360;
        _363.y = ((-1.09254801273345947265625) * _348) * _351;
        float4 _368 = _363;
        _368.z = 0.3153919875621795654296875 * ((3.0 * _357.z) - 1.0);
        float4 _371 = _368;
        _371.w = ((-1.09254801273345947265625) * _354) * _351;
        float4 _375 = _356;
        _375.x = 0.886227548122406005859375;
        float3 _377 = _375.yzw * 2.094395160675048828125;
        float4 _378 = float4(_375.x, _377.x, _377.y, _377.z);
        float4 _379 = _371 * 0.785398185253143310546875;
        float _380 = (_357.x - _357.y) * 0.4290426075458526611328125;
        float3 _386 = _138;
        _386.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _378) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _379)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _380);
        float3 _392 = _386;
        _392.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _378) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _379)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _380);
        float3 _398 = _392;
        _398.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _378) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _379)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _380);
        _400 = fast::max(float3(0.0), _398);
    }
    else
    {
        _400 = float3(0.0);
    }
    bool _420 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _469;
    if (_420)
    {
        float4 _427 = View.View_WorldToClip * float4(_210, 1.0);
        float _428 = _427.w;
        float4 _457;
        if (_420)
        {
            _457 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_427.xy / float2(_428)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_428 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _457 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _469 = float4(_457.xyz + (in.in_var_TEXCOORD7.xyz * _457.w), _457.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _469 = in.in_var_TEXCOORD7;
    }
    float3 _470 = _210 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _478 = (_470 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _486 = (_470 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _491 = fast::clamp((float3(0.5) - abs(_478 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _496 = (_491.x * _491.y) * _491.z;
    float4 _505 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _486, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _478, level(0.0)), float4(_496));
    float3 _516 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _486, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _478, level(0.0)).xyz, float3(_496)) * 1.0;
    float4 _518 = _137;
    _518.x = _505.x;
    float4 _520 = _137;
    _520.x = _505.y;
    float4 _522 = _137;
    _522.x = _505.z;
    float3 _523 = _505.xyz;
    float3 _527 = _523 / float3(dot(_523, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _529 = _516 * _527.x;
    float3 _532 = _516 * _527.y;
    float3 _535 = _516 * _527.z;
    float4 _539 = _137;
    _539.y = (-0.48860299587249755859375) * _218.y;
    float4 _542 = _539;
    _542.z = 0.48860299587249755859375 * _218.z;
    float4 _545 = _542;
    _545.w = (-0.48860299587249755859375) * _218.x;
    float4 _546 = _545;
    _546.x = 0.886227548122406005859375;
    float3 _548 = _546.yzw * 2.094395160675048828125;
    float4 _549 = float4(_546.x, _548.x, _548.y, _548.z);
    float3 _551 = _138;
    _551.x = dot(float4(_518.x, _529.x, _529.y, _529.z), _549);
    float3 _553 = _551;
    _553.y = dot(float4(_520.x, _532.x, _532.y, _532.z), _549);
    float3 _555 = _553;
    _555.z = dot(float4(_522.x, _535.x, _535.y, _535.z), _549);
    float3 _569 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _596;
    float3 _597;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _584 = any(abs(_210 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _594;
        if (_584)
        {
            _594 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _594 = _569;
        }
        _596 = _584 ? 1.0 : _300;
        _597 = _594;
    }
    else
    {
        _596 = _300;
        _597 = _569;
    }
    float4 _607 = float4((((mix(_322 * float4(fast::max(float3(0.0), _555), _134).xyz, _322 + (select(_314, float3(0.0), bool3(_317)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_400 * View.View_IndirectLightingColorScale) * _322) * fast::max(float3(1.0), ((((((_299 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_299 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_299 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _597) * _469.w) + _469.xyz, _596);
    float3 _611 = _607.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_611.x, _611.y, _611.z, _607.w);
    return out;
}

