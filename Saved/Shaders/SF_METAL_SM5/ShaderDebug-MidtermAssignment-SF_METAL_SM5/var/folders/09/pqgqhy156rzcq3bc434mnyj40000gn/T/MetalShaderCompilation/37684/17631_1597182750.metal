

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

constant float4 _152 = {};
constant float4 _154 = {};
constant float3 _155 = {};

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

fragment MainPS_out Main_000044df_5f33131e(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _257 = mix(_253, _255, float4(in.in_var_TEXCOORD10.w));
    float _269 = _218.w;
    float4 _279 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_218.xy / float2(_269)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _280 = _279.x;
    float _310;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _310 = _269;
                break;
            }
            else
            {
                float _303 = _218.z;
                _310 = ((_303 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_303 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _316 = fast::clamp((_249.xyz + _257.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _317 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _257.w, 0.0), 1.0) * fast::min(fast::max(((((_280 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_280 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _310) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _324 = (_316 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _331 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _334 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _339;
    if (_334)
    {
        _339 = _324 + (_331 * 0.449999988079071044921875);
    }
    else
    {
        _339 = _324;
    }
    float3 _417;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _365 = _235.y;
        float4 _367 = _154;
        _367.y = (-0.48860299587249755859375) * _365;
        float _368 = _235.z;
        float4 _370 = _367;
        _370.z = 0.48860299587249755859375 * _368;
        float _371 = _235.x;
        float4 _373 = _370;
        _373.w = (-0.48860299587249755859375) * _371;
        float3 _374 = _235 * _235;
        float4 _377 = _152;
        _377.x = (1.09254801273345947265625 * _371) * _365;
        float4 _380 = _377;
        _380.y = ((-1.09254801273345947265625) * _365) * _368;
        float4 _385 = _380;
        _385.z = 0.3153919875621795654296875 * ((3.0 * _374.z) - 1.0);
        float4 _388 = _385;
        _388.w = ((-1.09254801273345947265625) * _371) * _368;
        float4 _392 = _373;
        _392.x = 0.886227548122406005859375;
        float3 _394 = _392.yzw * 2.094395160675048828125;
        float4 _395 = float4(_392.x, _394.x, _394.y, _394.z);
        float4 _396 = _388 * 0.785398185253143310546875;
        float _397 = (_374.x - _374.y) * 0.4290426075458526611328125;
        float3 _403 = _155;
        _403.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _395) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _396)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _397);
        float3 _409 = _403;
        _409.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _395) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _396)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _397);
        float3 _415 = _409;
        _415.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _395) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _396)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _397);
        _417 = fast::max(float3(0.0), _415);
    }
    else
    {
        _417 = float3(0.0);
    }
    bool _437 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _486;
    if (_437)
    {
        float4 _444 = View.View_WorldToClip * float4(_227, 1.0);
        float _445 = _444.w;
        float4 _474;
        if (_437)
        {
            _474 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_444.xy / float2(_445)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_445 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _474 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _486 = float4(_474.xyz + (in.in_var_TEXCOORD7.xyz * _474.w), _474.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _486 = in.in_var_TEXCOORD7;
    }
    float3 _487 = _227 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _495 = (_487 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _503 = (_487 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _508 = fast::clamp((float3(0.5) - abs(_495 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _513 = (_508.x * _508.y) * _508.z;
    float4 _522 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _503, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _495, level(0.0)), float4(_513));
    float3 _533 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _503, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _495, level(0.0)).xyz, float3(_513)) * 1.0;
    float4 _535 = _154;
    _535.x = _522.x;
    float4 _537 = _154;
    _537.x = _522.y;
    float4 _539 = _154;
    _539.x = _522.z;
    float3 _540 = _522.xyz;
    float3 _544 = _540 / float3(dot(_540, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _546 = _533 * _544.x;
    float3 _549 = _533 * _544.y;
    float3 _552 = _533 * _544.z;
    float4 _556 = _154;
    _556.y = (-0.48860299587249755859375) * _235.y;
    float4 _559 = _556;
    _559.z = 0.48860299587249755859375 * _235.z;
    float4 _562 = _559;
    _562.w = (-0.48860299587249755859375) * _235.x;
    float4 _563 = _562;
    _563.x = 0.886227548122406005859375;
    float3 _565 = _563.yzw * 2.094395160675048828125;
    float4 _566 = float4(_563.x, _565.x, _565.y, _565.z);
    float3 _568 = _155;
    _568.x = dot(float4(_535.x, _546.x, _546.y, _546.z), _566);
    float3 _570 = _568;
    _570.y = dot(float4(_537.x, _549.x, _549.y, _549.z), _566);
    float3 _572 = _570;
    _572.z = dot(float4(_539.x, _552.x, _552.y, _552.z), _566);
    float _574 = _522.w;
    float3 _579 = float4(fast::max(float3(0.0), _572), _574).xyz;
    float3 _645;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _593 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_487, 1.0);
        float2 _597 = _593.xy / float2(_593.w);
        float _598 = _593.z;
        float4 _601 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _597, level(0.0));
        float3 _605 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _598;
        bool2 _630 = _597 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _632 = _597 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _645 = _339 * fast::max(_579 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _574) * (float3(1.0) - select(fast::clamp(exp((float3((((_601.x * _598) * 0.5) + dot((sin(_605) * _601.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_605)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _597, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_630.x || _632.x, _630.y || _632.y)))))), float3(0.0));
    }
    else
    {
        _645 = _339 * _579;
    }
    float3 _652 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _679;
    float3 _680;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _667 = any(abs(_227 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _677;
        if (_667)
        {
            _677 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _677 = _652;
        }
        _679 = _667 ? 1.0 : _317;
        _680 = _677;
    }
    else
    {
        _679 = _317;
        _680 = _652;
    }
    float4 _690 = float4((((mix(_645, _339 + (select(_331, float3(0.0), bool3(_334)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_417 * View.View_IndirectLightingColorScale) * _339) * fast::max(float3(1.0), ((((((_316 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_316 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_316 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _680) * _486.w) + _486.xyz, _679);
    float3 _694 = _690.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_694.x, _694.y, _694.z, _690.w);
    return out;
}

