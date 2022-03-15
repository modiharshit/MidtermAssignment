

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
    char _m19_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m21_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m23_pad[80];
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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
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

constant float4 _155 = {};
constant float4 _157 = {};
constant float3 _158 = {};

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

fragment MainPS_out Main_00004ef9_43998f71(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _253 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _261 = _218.w;
    float4 _271 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_218.xy / float2(_261)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _272 = _271.x;
    float _302;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _302 = _261;
                break;
            }
            else
            {
                float _295 = _218.z;
                _302 = ((_295 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_295 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _308 = fast::clamp(_249.xyz + _253.xyz, float3(0.0), float3(1.0));
    float _309 = fast::clamp(fast::min(fast::max(_253.w, 0.0), 1.0) * fast::min(fast::max(((((_272 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_272 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _302) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _316 = (_308 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _323 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _326 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _331;
    if (_326)
    {
        _331 = _316 + (_323 * 0.449999988079071044921875);
    }
    else
    {
        _331 = _316;
    }
    bool _336 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _409;
    if (_336)
    {
        float _357 = _235.y;
        float4 _359 = _157;
        _359.y = (-0.48860299587249755859375) * _357;
        float _360 = _235.z;
        float4 _362 = _359;
        _362.z = 0.48860299587249755859375 * _360;
        float _363 = _235.x;
        float4 _365 = _362;
        _365.w = (-0.48860299587249755859375) * _363;
        float3 _366 = _235 * _235;
        float4 _369 = _155;
        _369.x = (1.09254801273345947265625 * _363) * _357;
        float4 _372 = _369;
        _372.y = ((-1.09254801273345947265625) * _357) * _360;
        float4 _377 = _372;
        _377.z = 0.3153919875621795654296875 * ((3.0 * _366.z) - 1.0);
        float4 _380 = _377;
        _380.w = ((-1.09254801273345947265625) * _363) * _360;
        float4 _384 = _365;
        _384.x = 0.886227548122406005859375;
        float3 _386 = _384.yzw * 2.094395160675048828125;
        float4 _387 = float4(_384.x, _386.x, _386.y, _386.z);
        float4 _388 = _380 * 0.785398185253143310546875;
        float _389 = (_366.x - _366.y) * 0.4290426075458526611328125;
        float3 _395 = _158;
        _395.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _387) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _388)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _389);
        float3 _401 = _395;
        _401.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _387) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _388)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _389);
        float3 _407 = _401;
        _407.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _387) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _388)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _389);
        _409 = fast::max(float3(0.0), _407);
    }
    else
    {
        _409 = float3(0.0);
    }
    float _435;
    float _436;
    float3 _437;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _425;
        float _426;
        if (_336)
        {
            _425 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _426 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _425 = _235;
            _426 = 1.0;
        }
        float _427 = 1.0 - _426;
        float _429 = 1.0 - (_427 * _427);
        _435 = mix(fast::clamp(dot(_425, _235), 0.0, 1.0), 1.0, _429);
        _436 = _426;
        _437 = mix(_425, _235, float3(_429));
    }
    else
    {
        _435 = 1.0;
        _436 = 1.0;
        _437 = _235;
    }
    float4 _441 = float4(_437, 1.0);
    float3 _445 = _158;
    _445.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _441);
    float3 _449 = _445;
    _449.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _441);
    float3 _453 = _449;
    _453.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _441);
    float4 _456 = _441.xyzz * _441.yzzx;
    float3 _460 = _158;
    _460.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _456);
    float3 _464 = _460;
    _464.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _456);
    float3 _468 = _464;
    _468.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _456);
    bool _500 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _549;
    if (_500)
    {
        float4 _507 = View.View_WorldToClip * float4(_227, 1.0);
        float _508 = _507.w;
        float4 _537;
        if (_500)
        {
            _537 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_507.xy / float2(_508)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_508 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _537 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _549 = float4(_537.xyz + (in.in_var_TEXCOORD7.xyz * _537.w), _537.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _549 = in.in_var_TEXCOORD7;
    }
    float3 _557 = (_227 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _565 = (_227 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _570 = fast::clamp((float3(0.5) - abs(_557 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _575 = (_570.x * _570.y) * _570.z;
    float4 _584 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _565, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _557, level(0.0)), float4(_575));
    float3 _595 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _565, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _557, level(0.0)).xyz, float3(_575)) * 1.0;
    float4 _597 = _157;
    _597.x = _584.x;
    float4 _599 = _157;
    _599.x = _584.y;
    float4 _601 = _157;
    _601.x = _584.z;
    float3 _602 = _584.xyz;
    float3 _606 = _602 / float3(dot(_602, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _608 = _595 * _606.x;
    float3 _611 = _595 * _606.y;
    float3 _614 = _595 * _606.z;
    float4 _618 = _157;
    _618.y = (-0.48860299587249755859375) * _235.y;
    float4 _621 = _618;
    _621.z = 0.48860299587249755859375 * _235.z;
    float4 _624 = _621;
    _624.w = (-0.48860299587249755859375) * _235.x;
    float4 _625 = _624;
    _625.x = 0.886227548122406005859375;
    float3 _627 = _625.yzw * 2.094395160675048828125;
    float4 _628 = float4(_625.x, _627.x, _627.y, _627.z);
    float3 _630 = _158;
    _630.x = dot(float4(_597.x, _608.x, _608.y, _608.z), _628);
    float3 _632 = _630;
    _632.y = dot(float4(_599.x, _611.x, _611.y, _611.z), _628);
    float3 _634 = _632;
    _634.z = dot(float4(_601.x, _614.x, _614.y, _614.z), _628);
    float _636 = _584.w;
    float3 _641 = float4(fast::max(float3(0.0), _634), _636).xyz;
    float3 _707;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _655 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_227, 1.0);
        float2 _659 = _655.xy / float2(_655.w);
        float _660 = _655.z;
        float4 _663 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _659, level(0.0));
        float3 _667 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _660;
        bool2 _692 = _659 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _694 = _659 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _707 = _331 * fast::max(_641 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _636) * (float3(1.0) - select(fast::clamp(exp((float3((((_663.x * _660) * 0.5) + dot((sin(_667) * _663.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_667)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _659, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_692.x || _694.x, _692.y || _694.y)))))), float3(0.0));
    }
    else
    {
        _707 = _331 * _641;
    }
    float3 _714 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _745;
    float3 _746;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _720 = in.in_var_PRIMITIVE_ID * 36u;
        bool _733 = any(abs(_227 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _720 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _720 + 19u)].xyz + float3(1.0)));
        float3 _743;
        if (_733)
        {
            _743 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _743 = _714;
        }
        _745 = _733 ? 1.0 : _309;
        _746 = _743;
    }
    else
    {
        _745 = _309;
        _746 = _714;
    }
    float4 _756 = float4((((mix(_707, _331 + (select(_323, float3(0.0), bool3(_326)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((_409 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_453 + _468) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_437.x * _437.x) - (_437.y * _437.y)))) * View.View_SkyLightColor.xyz) * (_436 * _435))) * _331) * fast::max(float3(1.0), ((((((_308 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_308 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_308 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _746) * _549.w) + _549.xyz, _745);
    float3 _760 = _756.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_760.x, _760.y, _760.z, _756.w);
    return out;
}

