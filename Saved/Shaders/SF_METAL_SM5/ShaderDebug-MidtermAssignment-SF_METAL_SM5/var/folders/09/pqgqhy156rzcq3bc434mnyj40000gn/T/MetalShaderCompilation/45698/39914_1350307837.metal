

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
    char _m2_pad[192];
    float3 View_ViewForward;
    char _m3_pad[96];
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
    float3 View_PreViewTranslation;
    char _m5_pad[1028];
    float View_PreExposure;
    float View_OneOverPreExposure;
    char _m7_pad[108];
    float View_GameTime;
    char _m8_pad[24];
    uint View_StateFrameIndexMod8;
    char _m9_pad[256];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDirection;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightColorGlobalPostTransmittance;
    char _m11_pad[192];
    float View_SkyAtmospherePresentInScene;
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m16_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    char _m17_pad[28];
    float View_RealTimeReflectionCapture;
    float View_RealTimeReflectionCapturePreExposure;
    char _m19_pad[368];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m21_pad[8];
    float View_VolumetricFogMaxDistance;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_RenderVolumetricCloudParameters
{
    char _m0_pad[16];
    float3 RenderVolumetricCloudParameters_CloudLayerCenterKm;
    float RenderVolumetricCloudParameters_BottomRadiusKm;
    float RenderVolumetricCloudParameters_TopRadiusKm;
    float RenderVolumetricCloudParameters_TracingStartMaxDistance;
    float RenderVolumetricCloudParameters_TracingMaxDistance;
    int RenderVolumetricCloudParameters_SampleCountMin;
    int RenderVolumetricCloudParameters_SampleCountMax;
    float RenderVolumetricCloudParameters_InvDistanceToSampleCountMax;
    int RenderVolumetricCloudParameters_ShadowSampleCountMax;
    float RenderVolumetricCloudParameters_ShadowTracingMaxDistance;
    float RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold;
    float RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility;
    spvUnsafeArray<float4, 2> RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale;
    char _m13_pad[1616];
    uint4 RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias;
    char _m14_pad[4];
    int RenderVolumetricCloudParameters_OpaqueIntersectionMode;
    char _m15_pad[8];
    uint RenderVolumetricCloudParameters_IsReflectionRendering;
    char _m16_pad[76];
    int RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity;
    int RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling;
    int RenderVolumetricCloudParameters_EnableDistantSkyLightSampling;
    int RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling;
    int RenderVolumetricCloudParameters_EnableHeightFog;
    float4 RenderVolumetricCloudParameters_ExponentialFogParameters;
    float4 RenderVolumetricCloudParameters_ExponentialFogParameters2;
    float4 RenderVolumetricCloudParameters_ExponentialFogColorParameter;
    float4 RenderVolumetricCloudParameters_ExponentialFogParameters3;
    float4 RenderVolumetricCloudParameters_InscatteringLightDirection;
    float4 RenderVolumetricCloudParameters_DirectionalInscatteringColor;
    float2 RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation;
    char _m28_pad[8];
    packed_float3 RenderVolumetricCloudParameters_FogInscatteringTextureParameters;
    float RenderVolumetricCloudParameters_ApplyVolumetricFog;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _153 = {};
constant float3 _155 = {};
constant uint3 _156 = {};
constant float2 _157 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00009bea_507c0ffd(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(2)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(3)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture3d<float> Material_VolumeTexture_0 [[texture(7)]], texture3d<float> Material_VolumeTexture_1 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], sampler Material_VolumeTexture_0Sampler [[sampler(6)]], sampler Material_VolumeTexture_1Sampler [[sampler(7)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1247;
    float4 _1248;
    switch (0u)
    {
        default:
        {
            float _241;
            float _247;
            float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
            float3 _226 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
            float3 _227 = -normalize(-(_219.xyz / float3(_219.w)));
            float2 _261;
            bool _262;
            switch (0u)
            {
                default:
                {
                    float3 _239 = _226 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _241 = dot(_227, _227);
                    float _242 = dot(_227, _239);
                    float _243 = 2.0 * _242;
                    _247 = 4.0 * _241;
                    float _249 = (_243 * _243) - (_247 * (dot(_239, _239) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_249 >= 0.0)
                    {
                        _261 = (float2(_242 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_249))) / float2(2.0 * _241);
                        _262 = true;
                        break;
                    }
                    _261 = float2(0.0);
                    _262 = false;
                    break;
                }
            }
            float _267;
            float _319;
            float _320;
            if (_262)
            {
                _267 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                float2 _292;
                bool _293;
                switch (0u)
                {
                    default:
                    {
                        float3 _272 = _226 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _267).xyz;
                        float _274 = dot(_227, _272);
                        float _275 = 2.0 * _274;
                        float _280 = (_275 * _275) - (_247 * (dot(_272, _272) - (_267 * _267)));
                        if (_280 >= 0.0)
                        {
                            _292 = (float2(_274 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_280))) / float2(2.0 * _241);
                            _293 = true;
                            break;
                        }
                        _292 = float2(0.0);
                        _293 = false;
                        break;
                    }
                }
                if (_293)
                {
                    float _303 = fast::min(_261.x, _261.y);
                    bool _307 = all(_292 > float2(0.0));
                    float _312 = _307 ? fast::min(_292.x, _292.y) : fast::max(_292.x, _292.y);
                    float _316;
                    if (_307)
                    {
                        _316 = fast::max(0.0, _303);
                    }
                    else
                    {
                        _316 = all(_261 > float2(0.0)) ? _303 : fast::max(_261.x, _261.y);
                    }
                    _319 = fast::max(_312, _316);
                    _320 = fast::min(_312, _316);
                }
                else
                {
                    _319 = _261.y;
                    _320 = _261.x;
                }
            }
            else
            {
                _1247 = float2(65504.0);
                _1248 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _322 = fast::max(0.0, _320) * 100000.0;
            float _324 = fast::max(0.0, _319) * 100000.0;
            if ((_324 <= _322) || (_322 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1247 = float2(65504.0);
                _1248 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _344 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _352 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_344.xy), _344.z).x), 1.0);
            float _361 = length(((_352.xyz / float3(_352.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _363 = float2(65504.0);
            _363.y = _361 * 9.9999997473787516355514526367188e-06;
            bool _366 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_366 && (_361 < _322))
            {
                _1247 = _363;
                _1248 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _374;
            if (_366)
            {
                _374 = fast::min(_324, _361);
            }
            else
            {
                _374 = _324;
            }
            float3 _384 = View.View_AtmosphereLightColorGlobalPostTransmittance[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
            float _391 = _322 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _374 - _322);
            float _398 = _391 - _322;
            uint _405 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_398 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _407 = _398 / float(_405);
            float _408 = _407 * 0.00999999977648258209228515625;
            float3 _436;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _435;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _435 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _420 = _155;
                    _420.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _424 = _420;
                    _424.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _428 = _424;
                    _428.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _435 = fast::max(float3(0.0), _428);
                }
                _436 = _435;
            }
            else
            {
                _436 = float3(0.0);
            }
            float _442 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _453 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _454 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _456 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _227);
            float _457 = _453 * _453;
            float _462 = (1.0 + _457) + ((2.0 * _453) * _456);
            float _466 = (1.0 - _457) / ((12.56637096405029296875 * _462) * sqrt(_462));
            float _467 = _454 * _454;
            float _472 = (1.0 + _467) + ((2.0 * _454) * _456);
            float _479 = _466 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _467) / ((12.56637096405029296875 * _472) * sqrt(_472))) - _466));
            float3 _481 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _482 = _267 * 100000.0;
            float _485 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _482);
            float _521;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _501 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _502 = _501.y;
                uint _503 = _501.z;
                uint _506 = _501.x + (_502 * _503);
                uint _508 = _502 + (_503 * _506);
                uint3 _513 = _156;
                _513.x = _506 + (_508 * (_503 + (_506 * _508)));
                _521 = _322 + ((float((_513 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _407);
            }
            else
            {
                _521 = _322 + (0.5 * _407);
            }
            float3 _523;
            float3 _526;
            _523 = float3(1.0);
            _526 = float3(0.0);
            float3 _524;
            float3 _527;
            float _529;
            float _531;
            float _533;
            uint _886;
            float3 _887;
            float3 _888;
            float _889;
            float _890;
            float _528 = 0.0;
            float _530 = 0.0;
            float _532 = _521;
            uint _534 = 0u;
            for (;;)
            {
                if (_534 < _405)
                {
                    float3 _539 = _227 * _532;
                    float3 _540 = View.View_WorldCameraOrigin + _539;
                    float _545 = fast::clamp((length(_540 - _481) - _482) * _485, 0.0, 1.0);
                    float4 _555 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_540 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _556 = _555.y;
                    float _572 = ((_545 < 0.0500000007450580596923828125) || (_545 > 0.949999988079071044921875)) ? 0.0 : (_555.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_556 <= 0.0) ? 0.0 : pow(_556, 0.25), 1.0 - _545), level(-1.0)).x);
                    if (_572 <= 0.0)
                    {
                        _524 = _523;
                        _527 = _526;
                        _529 = _528;
                        _531 = _530;
                        _533 = _532 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _407);
                        _886 = _534 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _535 = _886 + 1u;
                        _523 = _524;
                        _526 = _527;
                        _528 = _529;
                        _530 = _531;
                        _532 = _533;
                        _534 = _535;
                        continue;
                    }
                    float3 _590 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _591 = _590 * 0.1500000059604644775390625;
                    float3 _594 = _540 * Material.Material_ScalarExpressions[0].x;
                    float4 _602 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_591 + _594) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _605 = _602.x;
                    float _609 = _602.y;
                    float _613 = _602.z;
                    float3 _619 = float3(_572) * fast::clamp(float3((_605 <= 0.0) ? 0.0 : pow(_605, Material.Material_ScalarExpressions[0].z), (_609 <= 0.0) ? 0.0 : pow(_609, Material.Material_ScalarExpressions[0].z), (_613 <= 0.0) ? 0.0 : pow(_613, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _620 = _590 * (-0.100000001490116119384765625);
                    float4 _628 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_594 + _620) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _629 = _628.x;
                    float _637 = ((_629 <= 0.0) ? 0.0 : pow(_629, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _642 = float3(Material.Material_ScalarExpressions[1].w);
                    float _649 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _655 = fast::clamp(_545 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _664 = mix(_619, float3((_642 + (fast::clamp((_619 - float3(_637)) / float3(Material.Material_ScalarExpressions[1].z - _637), float3(0.0), float3(1.0)) * _649)).x), float3((_655 <= 0.0) ? 0.0 : pow(_655, Material.Material_ScalarExpressions[2].y)));
                    float3 _672 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _664) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _675 = _672.x;
                    float _679 = _672.y;
                    float _683 = _672.z;
                    float3 _697 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _664, _153).xyz, float3(0.0), float3(65000.0));
                    float3 _700 = fast::clamp(fast::clamp(float3((_675 <= 0.0) ? 0.0 : pow(_675, Material.Material_ScalarExpressions[2].w), (_679 <= 0.0) ? 0.0 : pow(_679, Material.Material_ScalarExpressions[2].w), (_683 <= 0.0) ? 0.0 : pow(_683, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _697;
                    float3 _832;
                    float3 _833;
                    if (any(_700 > float3(0.0)))
                    {
                        float _717 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _718 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _720;
                        float3 _723;
                        _720 = float3(0.0);
                        _723 = float3(0.0);
                        float _726;
                        float3 _721;
                        float3 _724;
                        for (float _725 = 0.0, _727 = _717; _727 <= 1.0; _720 = _721, _723 = _724, _725 = _726, _727 += _717)
                        {
                            _726 = _727 * _727;
                            float _732 = _726 - _725;
                            float3 _737 = _540 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_725 + (_732 * 0.5))));
                            float _742 = fast::clamp((length(_737 - _481) - _482) * _485, 0.0, 1.0);
                            float4 _748 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_737 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _749 = _748.y;
                            float _763 = ((_742 < 0.0500000007450580596923828125) || (_742 > 0.949999988079071044921875)) ? 0.0 : (_748.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_749 <= 0.0) ? 0.0 : pow(_749, 0.25), 1.0 - _742), level(-1.0)).x);
                            if (_763 <= 0.0)
                            {
                                _721 = _720;
                                _724 = _723;
                                continue;
                            }
                            float3 _768 = _737 * Material.Material_ScalarExpressions[0].x;
                            float4 _772 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_591 + _768) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _773 = _772.x;
                            float _777 = _772.y;
                            float _781 = _772.z;
                            float3 _787 = float3(_763) * fast::clamp(float3((_773 <= 0.0) ? 0.0 : pow(_773, Material.Material_ScalarExpressions[0].z), (_777 <= 0.0) ? 0.0 : pow(_777, Material.Material_ScalarExpressions[0].z), (_781 <= 0.0) ? 0.0 : pow(_781, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _791 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_768 + _620) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _792 = _791.x;
                            float _796 = ((_792 <= 0.0) ? 0.0 : pow(_792, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _806 = fast::clamp(_742 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _820 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_787, float3((_642 + (fast::clamp((_787 - float3(_796)) / float3(Material.Material_ScalarExpressions[1].z - _796), float3(0.0), float3(1.0)) * _649)).x), float3((_806 <= 0.0) ? 0.0 : pow(_806, Material.Material_ScalarExpressions[2].y))), _153).xyz, float3(0.0), float3(65000.0));
                            _721 = _720 + ((_820 * _442) * _732);
                            _724 = _723 + (_820 * _732);
                        }
                        _832 = exp((-_723) * _718);
                        _833 = exp((-_720) * _718);
                    }
                    else
                    {
                        _832 = float3(1.0);
                        _833 = float3(1.0);
                    }
                    float _846;
                    float _847;
                    if (any(_697 > float3(0.0)))
                    {
                        float _842 = fast::min(_523.x, fast::min(_523.y, _523.z));
                        _846 = _530 + (_532 * _842);
                        _847 = _528 + _842;
                    }
                    else
                    {
                        _846 = _530;
                        _847 = _528;
                    }
                    float3 _852 = (((_833 * _384) * mix(0.079577468335628509521484375, _479, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_700 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _853 = fast::max(float3(9.9999999747524270787835121154785e-07), _697 * _442);
                    float3 _866 = (((_832 * _384) * _479) + (_436 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _545, 0.0, 1.0)).xyz) * _700;
                    float3 _867 = fast::max(float3(9.9999999747524270787835121154785e-07), _697);
                    float3 _870 = exp((-_867) * _408);
                    float3 _875 = (_526 + (_523 * ((_852 - (_852 * exp((-_853) * _408))) / _853))) + (_523 * ((_866 - (_866 * _870)) / _867));
                    float3 _876 = _523 * _870;
                    if (all(_876 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _887 = _876;
                        _888 = _875;
                        _889 = _846;
                        _890 = _847;
                        break;
                    }
                    _524 = _876;
                    _527 = _875;
                    _529 = _847;
                    _531 = _846;
                    _533 = _532 + _407;
                    _886 = _534;
                    uint _535 = _886 + 1u;
                    _523 = _524;
                    _526 = _527;
                    _528 = _529;
                    _530 = _531;
                    _532 = _533;
                    _534 = _535;
                    continue;
                }
                else
                {
                    _887 = _523;
                    _888 = _526;
                    _889 = _530;
                    _890 = _528;
                    break;
                }
            }
            bool _891 = View.View_RealTimeReflectionCapture != 0.0;
            float _896 = (_890 == 0.0) ? _391 : (_889 / fast::max(1.0000000133514319600180897396058e-10, _890));
            float3 _898 = View.View_WorldCameraOrigin + (_227 * _896);
            float4 _903 = View.View_WorldToClip * float4(_898, 1.0);
            float _904 = dot(_887, float3(0.3333333432674407958984375));
            bool _908 = _890 > 0.0;
            float3 _981;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _908)
            {
                float3 _920 = (_898 * 9.9999997473787516355514526367188e-06) - _226;
                float _926 = sqrt((fast::max(0.0, length(_920) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                float _927 = _926 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                float _934;
                if (_927 < 0.707106769084930419921875)
                {
                    _934 = fast::clamp((_927 * _927) * 2.0, 0.0, 1.0);
                }
                else
                {
                    _934 = 1.0;
                }
                float2 _962;
                if (_891)
                {
                    float3 _937 = normalize(_920);
                    float _938 = _937.z;
                    float _941 = sqrt(1.0 - (_938 * _938));
                    float2 _944 = _157;
                    _944.y = (_938 * 0.5) + 0.5;
                    float _949 = acos(_937.x / _941);
                    float2 _954 = _944;
                    _954.x = (((_937.y / _941) < 0.0) ? (6.283185482025146484375 - _949) : _949) * 0.15915493667125701904296875;
                    _962 = (_954 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                }
                else
                {
                    _962 = ((_903.xy / _903.ww) * float2(0.5, -0.5)) + float2(0.5);
                }
                float4 _967 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_962, _926), level(0.0));
                _981 = (((_967.xyz * _934).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _904)) + (_888 * (1.0 - (_934 * (1.0 - _967.w))));
            }
            else
            {
                _981 = _888;
            }
            float3 _1228;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _908)
            {
                float3 _988 = _898 - View.View_WorldCameraOrigin;
                float _1005 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                float _1008 = _988.z + (View.View_WorldCameraOrigin.z - _1005);
                float3 _1009 = _988;
                _1009.z = _1008;
                float _1010 = dot(_1009, _1009);
                float _1011 = rsqrt(_1010);
                float _1012 = _1010 * _1011;
                float _1020 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_988) / dot(_988, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                float _1054;
                float _1055;
                float _1056;
                float _1057;
                if (_1020 > 0.0)
                {
                    float _1024 = _1020 * _1011;
                    float _1025 = _1024 * _1008;
                    float _1026 = _1005 + _1025;
                    _1054 = (1.0 - _1024) * _1012;
                    _1055 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1026 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                    _1056 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1026 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                    _1057 = _1008 - _1025;
                }
                else
                {
                    _1054 = _1012;
                    _1055 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                    _1056 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                    _1057 = _1008;
                }
                float _1061 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1057);
                float _1075 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1057);
                float _1086 = (_1056 * ((abs(_1061) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1061)) / _1061) : (0.693147182464599609375 - (0.2402265071868896484375 * _1061)))) + (_1055 * ((abs(_1075) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1075)) / _1075) : (0.693147182464599609375 - (0.2402265071868896484375 * _1075))));
                float3 _1128;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                {
                    float2 _1113 = float2(dot(_1009.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1009.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                    float3 _1114 = float3(_1113.x, _1113.y, _1009.z);
                    _1128 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1114, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1114, level(0.0)).xyz, float3(fast::clamp((_1012 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                }
                else
                {
                    _1128 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                }
                float3 _1156;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                {
                    _1156 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1009 * _1011, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1086 * fast::max(_1054 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                }
                else
                {
                    _1156 = float3(0.0);
                }
                bool _1165 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1012 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                float _1168 = _1165 ? 1.0 : fast::max(fast::clamp(exp2(-(_1086 * _1054)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                float4 _1175 = float4((_1128 * (1.0 - _1168)) + select(_1156, float3(0.0), bool3(_1165)), _1168);
                bool _1178 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                float4 _1221;
                if (_1178)
                {
                    float _1181 = _903.w;
                    float4 _1210;
                    if (_1178)
                    {
                        _1210 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_903.xy / float2(_1181)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1181 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                    }
                    else
                    {
                        _1210 = float4(0.0, 0.0, 0.0, 1.0);
                    }
                    _1221 = float4(_1210.xyz + (_1175.xyz * _1210.w), _1210.w * _1168);
                }
                else
                {
                    _1221 = _1175;
                }
                _1228 = (_1221.xyz * (1.0 - _904)) + (_981 * _1221.w);
            }
            else
            {
                _1228 = _981;
            }
            float _1232 = (_904 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _904;
            float2 _1238 = _363;
            _1238.x = 65504.0;
            float2 _1246;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1245 = _1238;
                _1245.x = ((_1232 > 0.9900000095367431640625) ? _391 : _896) * 9.9999997473787516355514526367188e-06;
                _1246 = _1245;
            }
            else
            {
                _1246 = _1238;
            }
            _1247 = _1246;
            _1248 = float4(_1228 * (_891 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1232);
            break;
        }
    }
    out.out_var_SV_Target0 = _1248;
    out.out_var_SV_Target1 = _1247;
    return out;
}

