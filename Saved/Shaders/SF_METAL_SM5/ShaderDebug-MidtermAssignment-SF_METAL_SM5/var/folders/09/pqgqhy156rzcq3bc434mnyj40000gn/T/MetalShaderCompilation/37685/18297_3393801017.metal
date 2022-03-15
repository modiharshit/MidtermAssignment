

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
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _140 = {};
constant float4 _141 = {};
constant float4 _143 = {};
constant float3 _144 = {};

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

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004779_ca494b39(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _244 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _246 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _248 = mix(_244, _246, float4(in.in_var_TEXCOORD10.w));
    float _260 = _209.w;
    float4 _270 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_209.xy / float2(_260)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _271 = _270.x;
    float _301;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _301 = _260;
                break;
            }
            else
            {
                float _294 = _209.z;
                _301 = ((_294 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_294 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _307 = fast::clamp((_240.xyz + _248.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _308 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _248.w, 0.0), 1.0) * fast::min(fast::max(((((_271 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_271 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _301) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _315 = (_307 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _322 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _325 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _330;
    if (_325)
    {
        _330 = _315 + (_322 * 0.449999988079071044921875);
    }
    else
    {
        _330 = _315;
    }
    bool _335 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _408;
    if (_335)
    {
        float _356 = _226.y;
        float4 _358 = _143;
        _358.y = (-0.48860299587249755859375) * _356;
        float _359 = _226.z;
        float4 _361 = _358;
        _361.z = 0.48860299587249755859375 * _359;
        float _362 = _226.x;
        float4 _364 = _361;
        _364.w = (-0.48860299587249755859375) * _362;
        float3 _365 = _226 * _226;
        float4 _368 = _141;
        _368.x = (1.09254801273345947265625 * _362) * _356;
        float4 _371 = _368;
        _371.y = ((-1.09254801273345947265625) * _356) * _359;
        float4 _376 = _371;
        _376.z = 0.3153919875621795654296875 * ((3.0 * _365.z) - 1.0);
        float4 _379 = _376;
        _379.w = ((-1.09254801273345947265625) * _362) * _359;
        float4 _383 = _364;
        _383.x = 0.886227548122406005859375;
        float3 _385 = _383.yzw * 2.094395160675048828125;
        float4 _386 = float4(_383.x, _385.x, _385.y, _385.z);
        float4 _387 = _379 * 0.785398185253143310546875;
        float _388 = (_365.x - _365.y) * 0.4290426075458526611328125;
        float3 _394 = _144;
        _394.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _386) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _387)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _388);
        float3 _400 = _394;
        _400.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _386) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _387)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _388);
        float3 _406 = _400;
        _406.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _386) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _387)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _388);
        _408 = fast::max(float3(0.0), _406);
    }
    else
    {
        _408 = float3(0.0);
    }
    float _434;
    float _435;
    float3 _436;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _424;
        float _425;
        if (_335)
        {
            _424 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _425 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _424 = _226;
            _425 = 1.0;
        }
        float _426 = 1.0 - _425;
        float _428 = 1.0 - (_426 * _426);
        _434 = mix(fast::clamp(dot(_424, _226), 0.0, 1.0), 1.0, _428);
        _435 = _425;
        _436 = mix(_424, _226, float3(_428));
    }
    else
    {
        _434 = 1.0;
        _435 = 1.0;
        _436 = _226;
    }
    float4 _440 = float4(_436, 1.0);
    float3 _444 = _144;
    _444.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _440);
    float3 _448 = _444;
    _448.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _440);
    float3 _452 = _448;
    _452.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _440);
    float4 _455 = _440.xyzz * _440.yzzx;
    float3 _459 = _144;
    _459.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _455);
    float3 _463 = _459;
    _463.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _455);
    float3 _467 = _463;
    _467.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _455);
    bool _499 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _548;
    if (_499)
    {
        float4 _506 = View.View_WorldToClip * float4(_218, 1.0);
        float _507 = _506.w;
        float4 _536;
        if (_499)
        {
            _536 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_506.xy / float2(_507)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_507 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _536 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _548 = float4(_536.xyz + (in.in_var_TEXCOORD7.xyz * _536.w), _536.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _548 = in.in_var_TEXCOORD7;
    }
    float3 _549 = _218 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _557 = (_549 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _565 = (_549 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _570 = fast::clamp((float3(0.5) - abs(_557 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _575 = (_570.x * _570.y) * _570.z;
    float4 _584 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _565, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _557, level(0.0)), float4(_575));
    float3 _595 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _565, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _557, level(0.0)).xyz, float3(_575)) * 1.0;
    float4 _597 = _143;
    _597.x = _584.x;
    float4 _599 = _143;
    _599.x = _584.y;
    float4 _601 = _143;
    _601.x = _584.z;
    float3 _602 = _584.xyz;
    float3 _606 = _602 / float3(dot(_602, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _608 = _595 * _606.x;
    float3 _611 = _595 * _606.y;
    float3 _614 = _595 * _606.z;
    float4 _618 = _143;
    _618.y = (-0.48860299587249755859375) * _226.y;
    float4 _621 = _618;
    _621.z = 0.48860299587249755859375 * _226.z;
    float4 _624 = _621;
    _624.w = (-0.48860299587249755859375) * _226.x;
    float4 _625 = _624;
    _625.x = 0.886227548122406005859375;
    float3 _627 = _625.yzw * 2.094395160675048828125;
    float4 _628 = float4(_625.x, _627.x, _627.y, _627.z);
    float3 _630 = _144;
    _630.x = dot(float4(_597.x, _608.x, _608.y, _608.z), _628);
    float3 _632 = _630;
    _632.y = dot(float4(_599.x, _611.x, _611.y, _611.z), _628);
    float3 _634 = _632;
    _634.z = dot(float4(_601.x, _614.x, _614.y, _614.z), _628);
    float3 _648 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _675;
    float3 _676;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _663 = any(abs(_218 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _673;
        if (_663)
        {
            _673 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _673 = _648;
        }
        _675 = _663 ? 1.0 : _308;
        _676 = _673;
    }
    else
    {
        _675 = _308;
        _676 = _648;
    }
    float4 _686 = float4((((mix(_330 * float4(fast::max(float3(0.0), _634), _140).xyz, _330 + (select(_322, float3(0.0), bool3(_325)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((_408 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_452 + _467) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_436.x * _436.x) - (_436.y * _436.y)))) * View.View_SkyLightColor.xyz) * (_435 * _434))) * _330) * fast::max(float3(1.0), ((((((_307 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_307 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_307 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _676) * _548.w) + _548.xyz, _675);
    float3 _690 = _686.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_690.x, _690.y, _690.z, _686.w);
    return out;
}

