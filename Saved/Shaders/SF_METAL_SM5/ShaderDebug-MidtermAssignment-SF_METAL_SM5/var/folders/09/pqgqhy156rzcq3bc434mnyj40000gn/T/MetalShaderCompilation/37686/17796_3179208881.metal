

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

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
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

constant float4 _153 = {};
constant float4 _155 = {};
constant float3 _156 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004584_bd7ee0b1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    float3 _230 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _256 = _213.w;
    float4 _266 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_213.xy / float2(_256)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _267 = _266.x;
    float _297;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _297 = _256;
                break;
            }
            else
            {
                float _290 = _213.z;
                _297 = ((_290 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_290 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _303 = fast::clamp(_244.xyz + _248.xyz, float3(0.0), float3(1.0));
    float _304 = fast::clamp(fast::min(fast::max(_248.w, 0.0), 1.0) * fast::min(fast::max(((((_267 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_267 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _297) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _311 = (_303 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _318 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _321 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _326;
    if (_321)
    {
        _326 = _311 + (_318 * 0.449999988079071044921875);
    }
    else
    {
        _326 = _311;
    }
    float3 _404;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _352 = _230.y;
        float4 _354 = _155;
        _354.y = (-0.48860299587249755859375) * _352;
        float _355 = _230.z;
        float4 _357 = _354;
        _357.z = 0.48860299587249755859375 * _355;
        float _358 = _230.x;
        float4 _360 = _357;
        _360.w = (-0.48860299587249755859375) * _358;
        float3 _361 = _230 * _230;
        float4 _364 = _153;
        _364.x = (1.09254801273345947265625 * _358) * _352;
        float4 _367 = _364;
        _367.y = ((-1.09254801273345947265625) * _352) * _355;
        float4 _372 = _367;
        _372.z = 0.3153919875621795654296875 * ((3.0 * _361.z) - 1.0);
        float4 _375 = _372;
        _375.w = ((-1.09254801273345947265625) * _358) * _355;
        float4 _379 = _360;
        _379.x = 0.886227548122406005859375;
        float3 _381 = _379.yzw * 2.094395160675048828125;
        float4 _382 = float4(_379.x, _381.x, _381.y, _381.z);
        float4 _383 = _375 * 0.785398185253143310546875;
        float _384 = (_361.x - _361.y) * 0.4290426075458526611328125;
        float3 _390 = _156;
        _390.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _382) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _383)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _384);
        float3 _396 = _390;
        _396.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _382) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _383)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _384);
        float3 _402 = _396;
        _402.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _382) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _383)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _384);
        _404 = fast::max(float3(0.0), _402);
    }
    else
    {
        _404 = float3(0.0);
    }
    bool _424 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _473;
    if (_424)
    {
        float4 _431 = View.View_WorldToClip * float4(_222, 1.0);
        float _432 = _431.w;
        float4 _461;
        if (_424)
        {
            _461 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_431.xy / float2(_432)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_432 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _461 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _473 = float4(_461.xyz + (in.in_var_TEXCOORD7.xyz * _461.w), _461.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _473 = in.in_var_TEXCOORD7;
    }
    float3 _481 = (_222 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _489 = (_222 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _494 = fast::clamp((float3(0.5) - abs(_481 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _499 = (_494.x * _494.y) * _494.z;
    float4 _508 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _489, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _481, level(0.0)), float4(_499));
    float3 _519 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _489, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _481, level(0.0)).xyz, float3(_499)) * 1.0;
    float4 _521 = _155;
    _521.x = _508.x;
    float4 _523 = _155;
    _523.x = _508.y;
    float4 _525 = _155;
    _525.x = _508.z;
    float3 _526 = _508.xyz;
    float3 _530 = _526 / float3(dot(_526, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _532 = _519 * _530.x;
    float3 _535 = _519 * _530.y;
    float3 _538 = _519 * _530.z;
    float4 _542 = _155;
    _542.y = (-0.48860299587249755859375) * _230.y;
    float4 _545 = _542;
    _545.z = 0.48860299587249755859375 * _230.z;
    float4 _548 = _545;
    _548.w = (-0.48860299587249755859375) * _230.x;
    float4 _549 = _548;
    _549.x = 0.886227548122406005859375;
    float3 _551 = _549.yzw * 2.094395160675048828125;
    float4 _552 = float4(_549.x, _551.x, _551.y, _551.z);
    float3 _554 = _156;
    _554.x = dot(float4(_521.x, _532.x, _532.y, _532.z), _552);
    float3 _556 = _554;
    _556.y = dot(float4(_523.x, _535.x, _535.y, _535.z), _552);
    float3 _558 = _556;
    _558.z = dot(float4(_525.x, _538.x, _538.y, _538.z), _552);
    float _560 = _508.w;
    float3 _565 = float4(fast::max(float3(0.0), _558), _560).xyz;
    float3 _631;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _579 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_222, 1.0);
        float2 _583 = _579.xy / float2(_579.w);
        float _584 = _579.z;
        float4 _587 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _583, level(0.0));
        float3 _591 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _584;
        bool2 _616 = _583 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _618 = _583 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _631 = _326 * fast::max(_565 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _560) * (float3(1.0) - select(fast::clamp(exp((float3((((_587.x * _584) * 0.5) + dot((sin(_591) * _587.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_591)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _583, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_616.x || _618.x, _616.y || _618.y)))))), float3(0.0));
    }
    else
    {
        _631 = _326 * _565;
    }
    float3 _638 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _669;
    float3 _670;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _644 = in.in_var_PRIMITIVE_ID * 36u;
        bool _657 = any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _644 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _644 + 19u)].xyz + float3(1.0)));
        float3 _667;
        if (_657)
        {
            _667 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _667 = _638;
        }
        _669 = _657 ? 1.0 : _304;
        _670 = _667;
    }
    else
    {
        _669 = _304;
        _670 = _638;
    }
    float4 _680 = float4((((mix(_631, _326 + (select(_318, float3(0.0), bool3(_321)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_404 * View.View_IndirectLightingColorScale) * _326) * fast::max(float3(1.0), ((((((_303 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_303 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_303 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _670) * _473.w) + _473.xyz, _669);
    float3 _684 = _680.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_684.x, _684.y, _684.z, _680.w);
    return out;
}

