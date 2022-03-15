

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
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003d53_f353269f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _196 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _200 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _205 = (_200.xyz / float3(_200.w)) - View.View_PreViewTranslation;
    float3 _213 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _231 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _239 = _196.w;
    float4 _249 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_196.xy / float2(_239)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _250 = _249.x;
    float _280;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _280 = _239;
                break;
            }
            else
            {
                float _273 = _196.z;
                _280 = ((_273 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_273 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _286 = fast::clamp(_227.xyz + _231.xyz, float3(0.0), float3(1.0));
    float _287 = fast::clamp(fast::min(fast::max(_231.w, 0.0), 1.0) * fast::min(fast::max(((((_250 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_250 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _280) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _294 = (_286 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _301 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _304 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _309;
    if (_304)
    {
        _309 = _294 + (_301 * 0.449999988079071044921875);
    }
    else
    {
        _309 = _294;
    }
    float3 _387;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _335 = _213.y;
        float4 _337 = _138;
        _337.y = (-0.48860299587249755859375) * _335;
        float _338 = _213.z;
        float4 _340 = _337;
        _340.z = 0.48860299587249755859375 * _338;
        float _341 = _213.x;
        float4 _343 = _340;
        _343.w = (-0.48860299587249755859375) * _341;
        float3 _344 = _213 * _213;
        float4 _347 = _136;
        _347.x = (1.09254801273345947265625 * _341) * _335;
        float4 _350 = _347;
        _350.y = ((-1.09254801273345947265625) * _335) * _338;
        float4 _355 = _350;
        _355.z = 0.3153919875621795654296875 * ((3.0 * _344.z) - 1.0);
        float4 _358 = _355;
        _358.w = ((-1.09254801273345947265625) * _341) * _338;
        float4 _362 = _343;
        _362.x = 0.886227548122406005859375;
        float3 _364 = _362.yzw * 2.094395160675048828125;
        float4 _365 = float4(_362.x, _364.x, _364.y, _364.z);
        float4 _366 = _358 * 0.785398185253143310546875;
        float _367 = (_344.x - _344.y) * 0.4290426075458526611328125;
        float3 _373 = _139;
        _373.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _365) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _366)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _367);
        float3 _379 = _373;
        _379.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _365) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _366)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _367);
        float3 _385 = _379;
        _385.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _365) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _366)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _367);
        _387 = fast::max(float3(0.0), _385);
    }
    else
    {
        _387 = float3(0.0);
    }
    bool _407 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _456;
    if (_407)
    {
        float4 _414 = View.View_WorldToClip * float4(_205, 1.0);
        float _415 = _414.w;
        float4 _444;
        if (_407)
        {
            _444 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_414.xy / float2(_415)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_415 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _444 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _456 = float4(_444.xyz + (in.in_var_TEXCOORD7.xyz * _444.w), _444.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _456 = in.in_var_TEXCOORD7;
    }
    float3 _464 = (_205 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _472 = (_205 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _477 = fast::clamp((float3(0.5) - abs(_464 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _482 = (_477.x * _477.y) * _477.z;
    float4 _491 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _472, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _464, level(0.0)), float4(_482));
    float3 _502 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _472, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _464, level(0.0)).xyz, float3(_482)) * 1.0;
    float4 _504 = _138;
    _504.x = _491.x;
    float4 _506 = _138;
    _506.x = _491.y;
    float4 _508 = _138;
    _508.x = _491.z;
    float3 _509 = _491.xyz;
    float3 _513 = _509 / float3(dot(_509, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _515 = _502 * _513.x;
    float3 _518 = _502 * _513.y;
    float3 _521 = _502 * _513.z;
    float4 _525 = _138;
    _525.y = (-0.48860299587249755859375) * _213.y;
    float4 _528 = _525;
    _528.z = 0.48860299587249755859375 * _213.z;
    float4 _531 = _528;
    _531.w = (-0.48860299587249755859375) * _213.x;
    float4 _532 = _531;
    _532.x = 0.886227548122406005859375;
    float3 _534 = _532.yzw * 2.094395160675048828125;
    float4 _535 = float4(_532.x, _534.x, _534.y, _534.z);
    float3 _537 = _139;
    _537.x = dot(float4(_504.x, _515.x, _515.y, _515.z), _535);
    float3 _539 = _537;
    _539.y = dot(float4(_506.x, _518.x, _518.y, _518.z), _535);
    float3 _541 = _539;
    _541.z = dot(float4(_508.x, _521.x, _521.y, _521.z), _535);
    float3 _555 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _586;
    float3 _587;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _561 = in.in_var_PRIMITIVE_ID * 36u;
        bool _574 = any(abs(_205 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _561 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _561 + 19u)].xyz + float3(1.0)));
        float3 _584;
        if (_574)
        {
            _584 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_205, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _584 = _555;
        }
        _586 = _574 ? 1.0 : _287;
        _587 = _584;
    }
    else
    {
        _586 = _287;
        _587 = _555;
    }
    float4 _597 = float4((((mix(_309 * float4(fast::max(float3(0.0), _541), _135).xyz, _309 + (select(_301, float3(0.0), bool3(_304)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_387 * View.View_IndirectLightingColorScale) * _309) * fast::max(float3(1.0), ((((((_286 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_286 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_286 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _587) * _456.w) + _456.xyz, _586);
    float3 _601 = _597.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_601.x, _601.y, _601.z, _597.w);
    return out;
}

