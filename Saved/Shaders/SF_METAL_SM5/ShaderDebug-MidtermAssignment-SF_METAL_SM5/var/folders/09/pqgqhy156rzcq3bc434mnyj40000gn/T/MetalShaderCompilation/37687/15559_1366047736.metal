

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

constant float _135 = {};
constant float4 _136 = {};
constant float4 _138 = {};
constant float3 _139 = {};

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

fragment MainPS_out Main_00003cc7_516c3bf8(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _203 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _220 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _238 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _240 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _242 = mix(_238, _240, float4(in.in_var_TEXCOORD4.x));
    float _254 = _203.w;
    float4 _264 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_203.xy / float2(_254)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _265 = _264.x;
    float _295;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _295 = _254;
                break;
            }
            else
            {
                float _288 = _203.z;
                _295 = ((_288 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_288 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _301 = fast::clamp((_234.xyz + _242.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _302 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _242.w, 0.0), 1.0) * fast::min(fast::max(((((_265 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_265 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _295) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _309 = (_301 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _316 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _319 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _324;
    if (_319)
    {
        _324 = _309 + (_316 * 0.449999988079071044921875);
    }
    else
    {
        _324 = _309;
    }
    float3 _402;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _350 = _220.y;
        float4 _352 = _138;
        _352.y = (-0.48860299587249755859375) * _350;
        float _353 = _220.z;
        float4 _355 = _352;
        _355.z = 0.48860299587249755859375 * _353;
        float _356 = _220.x;
        float4 _358 = _355;
        _358.w = (-0.48860299587249755859375) * _356;
        float3 _359 = _220 * _220;
        float4 _362 = _136;
        _362.x = (1.09254801273345947265625 * _356) * _350;
        float4 _365 = _362;
        _365.y = ((-1.09254801273345947265625) * _350) * _353;
        float4 _370 = _365;
        _370.z = 0.3153919875621795654296875 * ((3.0 * _359.z) - 1.0);
        float4 _373 = _370;
        _373.w = ((-1.09254801273345947265625) * _356) * _353;
        float4 _377 = _358;
        _377.x = 0.886227548122406005859375;
        float3 _379 = _377.yzw * 2.094395160675048828125;
        float4 _380 = float4(_377.x, _379.x, _379.y, _379.z);
        float4 _381 = _373 * 0.785398185253143310546875;
        float _382 = (_359.x - _359.y) * 0.4290426075458526611328125;
        float3 _388 = _139;
        _388.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _380) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _381)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _382);
        float3 _394 = _388;
        _394.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _380) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _381)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _382);
        float3 _400 = _394;
        _400.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _380) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _381)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _382);
        _402 = fast::max(float3(0.0), _400);
    }
    else
    {
        _402 = float3(0.0);
    }
    bool _422 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _471;
    if (_422)
    {
        float4 _429 = View.View_WorldToClip * float4(_212, 1.0);
        float _430 = _429.w;
        float4 _459;
        if (_422)
        {
            _459 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_429.xy / float2(_430)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_430 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _459 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _471 = float4(_459.xyz + (in.in_var_TEXCOORD7.xyz * _459.w), _459.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _471 = in.in_var_TEXCOORD7;
    }
    float3 _472 = _212 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _480 = (_472 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _488 = (_472 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _493 = fast::clamp((float3(0.5) - abs(_480 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _498 = (_493.x * _493.y) * _493.z;
    float4 _507 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _488, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _480, level(0.0)), float4(_498));
    float3 _518 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _488, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _480, level(0.0)).xyz, float3(_498)) * 1.0;
    float4 _520 = _138;
    _520.x = _507.x;
    float4 _522 = _138;
    _522.x = _507.y;
    float4 _524 = _138;
    _524.x = _507.z;
    float3 _525 = _507.xyz;
    float3 _529 = _525 / float3(dot(_525, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _531 = _518 * _529.x;
    float3 _534 = _518 * _529.y;
    float3 _537 = _518 * _529.z;
    float4 _541 = _138;
    _541.y = (-0.48860299587249755859375) * _220.y;
    float4 _544 = _541;
    _544.z = 0.48860299587249755859375 * _220.z;
    float4 _547 = _544;
    _547.w = (-0.48860299587249755859375) * _220.x;
    float4 _548 = _547;
    _548.x = 0.886227548122406005859375;
    float3 _550 = _548.yzw * 2.094395160675048828125;
    float4 _551 = float4(_548.x, _550.x, _550.y, _550.z);
    float3 _553 = _139;
    _553.x = dot(float4(_520.x, _531.x, _531.y, _531.z), _551);
    float3 _555 = _553;
    _555.y = dot(float4(_522.x, _534.x, _534.y, _534.z), _551);
    float3 _557 = _555;
    _557.z = dot(float4(_524.x, _537.x, _537.y, _537.z), _551);
    float3 _571 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _598;
    float3 _599;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _586 = any(abs(_212 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _596;
        if (_586)
        {
            _596 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _596 = _571;
        }
        _598 = _586 ? 1.0 : _302;
        _599 = _596;
    }
    else
    {
        _598 = _302;
        _599 = _571;
    }
    float4 _609 = float4((((mix(_324 * float4(fast::max(float3(0.0), _557), _135).xyz, _324 + (select(_316, float3(0.0), bool3(_319)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_402 * View.View_IndirectLightingColorScale) * _324) * fast::max(float3(1.0), ((((((_301 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_301 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_301 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _599) * _471.w) + _471.xyz, _598);
    float3 _613 = _609.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_613.x, _613.y, _613.z, _609.w);
    return out;
}

