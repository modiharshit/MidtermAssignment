

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
    float4 View_NormalOverrideParameter;
    char _m7_pad[16];
    float View_OutOfBoundsMask;
    char _m8_pad[80];
    float View_UnlitViewmodeMask;
    char _m9_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m16_pad[80];
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
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

constant float3 _130 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD1 [[user(locn2)]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_COLOR1 [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003637_34e66b34(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _170 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _175 = (_170.xyz / float3(_170.w)) - View.View_PreViewTranslation;
    float3 _183 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _194 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _196 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float3 _203 = fast::clamp(in.in_var_COLOR1.xyz, float3(0.0), float3(1.0));
    float _204 = fast::clamp(in.in_var_COLOR1.w * mix(_194, _196, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    float3 _220 = ((_203 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _223 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _238;
    if (_223)
    {
        float3 _233 = _130;
        _233.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _235 = _233;
        _235.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _237 = _235;
        _237.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _238 = _237;
    }
    else
    {
        _238 = float3(0.0);
    }
    float _256;
    float3 _257;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _254;
        float3 _255;
        if (_223)
        {
            _254 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _255 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _254 = 1.0;
            _255 = _183;
        }
        _256 = _254;
        _257 = _255;
    }
    else
    {
        _256 = 1.0;
        _257 = _183;
    }
    float4 _261 = float4(_257, 1.0);
    float3 _265 = _130;
    _265.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _261);
    float3 _269 = _265;
    _269.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _261);
    float3 _273 = _269;
    _273.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _261);
    float4 _276 = _261.xyzz * _261.yzzx;
    float3 _280 = _130;
    _280.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _276);
    float3 _284 = _280;
    _284.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _276);
    float3 _288 = _284;
    _288.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _276);
    bool _319 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _368;
    if (_319)
    {
        float4 _326 = View.View_WorldToClip * float4(_175, 1.0);
        float _327 = _326.w;
        float4 _356;
        if (_319)
        {
            _356 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_326.xy / float2(_327)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_327 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _356 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _368 = float4(_356.xyz + (in.in_var_TEXCOORD7.xyz * _356.w), _356.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _368 = in.in_var_TEXCOORD7;
    }
    float3 _376 = (_175 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _389 = fast::clamp((float3(0.5) - abs(_376 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _403 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_175 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _376, level(0.0)), float4((_389.x * _389.y) * _389.z));
    float _410 = _403.w;
    float3 _412 = float4(_403.x * 0.886227548122406005859375, _403.y * 0.886227548122406005859375, _403.z * 0.886227548122406005859375, _410).xyz;
    float3 _478;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _426 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_175, 1.0);
        float2 _430 = _426.xy / float2(_426.w);
        float _431 = _426.z;
        float4 _434 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _430, level(0.0));
        float3 _438 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _431;
        bool2 _463 = _430 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _465 = _430 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _478 = _220 * fast::max(_412 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _410) * (float3(1.0) - select(fast::clamp(exp((float3((((_434.x * _431) * 0.5) + dot((sin(_438) * _434.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_438)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _430, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_463.x || _465.x, _463.y || _465.y)))))), float3(0.0));
    }
    else
    {
        _478 = _220 * _412;
    }
    float3 _483 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _510;
    float3 _511;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _498 = any(abs(_175 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _508;
        if (_498)
        {
            _508 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_175, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _508 = _483;
        }
        _510 = _498 ? 1.0 : _204;
        _511 = _508;
    }
    else
    {
        _510 = _204;
        _511 = _483;
    }
    float4 _521 = float4((((mix(_478, _220, float3(View.View_UnlitViewmodeMask)) + ((((_238 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_273 + _288) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_257.x * _257.x) - (_257.y * _257.y)))) * View.View_SkyLightColor.xyz) * _256)) * _220) * fast::max(float3(1.0), ((((((_203 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_203 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_203 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _511) * _368.w) + _368.xyz, _510);
    float3 _525 = _521.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_525.x, _525.y, _525.z, _521.w);
    return out;
}

