

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
    spvUnsafeArray<float4, 2> View_AtmosphereLightColor;
    char _m11_pad[128];
    float4 View_SkyPlanetCenterAndViewHeight;
    char _m12_pad[80];
    float View_SkyAtmospherePresentInScene;
    char _m13_pad[4];
    float View_SkyAtmosphereBottomRadiusKm;
    float View_SkyAtmosphereTopRadiusKm;
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m19_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    char _m20_pad[28];
    float View_RealTimeReflectionCapture;
    float View_RealTimeReflectionCapturePreExposure;
    char _m22_pad[368];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m24_pad[8];
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
    char _m13_pad[912];
    float4x4 RenderVolumetricCloudParameters_WorldToShadowMatrix;
    float4 RenderVolumetricCloudParameters_ShadowmapMinMax;
    float4 RenderVolumetricCloudParameters_DepthBiasParameters;
    float4 RenderVolumetricCloudParameters_ShadowInjectParams;
    char _m17_pad[480];
    uint RenderVolumetricCloudParameters_bStaticallyShadowed;
    char _m18_pad[16];
    float4x4 RenderVolumetricCloudParameters_WorldToStaticShadowMatrix;
    float4 RenderVolumetricCloudParameters_StaticShadowBufferSize;
    uint4 RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias;
    char _m21_pad[4];
    int RenderVolumetricCloudParameters_OpaqueIntersectionMode;
    char _m22_pad[8];
    uint RenderVolumetricCloudParameters_IsReflectionRendering;
    char _m23_pad[76];
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
    char _m35_pad[8];
    packed_float3 RenderVolumetricCloudParameters_FogInscatteringTextureParameters;
    float RenderVolumetricCloudParameters_ApplyVolumetricFog;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _170 = {};
constant float3 _172 = {};
constant uint3 _173 = {};
constant float4 _174 = {};
constant float2 _175 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000bdf0_dd3b42a0(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(3)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(4)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(5)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(6)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture3d<float> Material_VolumeTexture_0 [[texture(10)]], texture3d<float> Material_VolumeTexture_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(5)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(6)]], sampler Material_Texture2D_0Sampler [[sampler(7)]], sampler Material_Texture2D_1Sampler [[sampler(8)]], sampler Material_VolumeTexture_0Sampler [[sampler(9)]], sampler Material_VolumeTexture_1Sampler [[sampler(10)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1478;
    float4 _1479;
    switch (0u)
    {
        default:
        {
            float _270;
            float _276;
            float4 _248 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
            float3 _255 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
            float3 _256 = -normalize(-(_248.xyz / float3(_248.w)));
            float2 _290;
            bool _291;
            switch (0u)
            {
                default:
                {
                    float3 _268 = _255 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _270 = dot(_256, _256);
                    float _271 = dot(_256, _268);
                    float _272 = 2.0 * _271;
                    _276 = 4.0 * _270;
                    float _278 = (_272 * _272) - (_276 * (dot(_268, _268) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_278 >= 0.0)
                    {
                        _290 = (float2(_271 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_278))) / float2(2.0 * _270);
                        _291 = true;
                        break;
                    }
                    _290 = float2(0.0);
                    _291 = false;
                    break;
                }
            }
            float _296;
            float _348;
            float _349;
            if (_291)
            {
                _296 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                float2 _321;
                bool _322;
                switch (0u)
                {
                    default:
                    {
                        float3 _301 = _255 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _296).xyz;
                        float _303 = dot(_256, _301);
                        float _304 = 2.0 * _303;
                        float _309 = (_304 * _304) - (_276 * (dot(_301, _301) - (_296 * _296)));
                        if (_309 >= 0.0)
                        {
                            _321 = (float2(_303 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_309))) / float2(2.0 * _270);
                            _322 = true;
                            break;
                        }
                        _321 = float2(0.0);
                        _322 = false;
                        break;
                    }
                }
                if (_322)
                {
                    float _332 = fast::min(_290.x, _290.y);
                    bool _336 = all(_321 > float2(0.0));
                    float _341 = _336 ? fast::min(_321.x, _321.y) : fast::max(_321.x, _321.y);
                    float _345;
                    if (_336)
                    {
                        _345 = fast::max(0.0, _332);
                    }
                    else
                    {
                        _345 = all(_290 > float2(0.0)) ? _332 : fast::max(_290.x, _290.y);
                    }
                    _348 = fast::max(_341, _345);
                    _349 = fast::min(_341, _345);
                }
                else
                {
                    _348 = _290.y;
                    _349 = _290.x;
                }
            }
            else
            {
                _1478 = float2(65504.0);
                _1479 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _351 = fast::max(0.0, _349) * 100000.0;
            float _353 = fast::max(0.0, _348) * 100000.0;
            if ((_353 <= _351) || (_351 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1478 = float2(65504.0);
                _1479 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _373 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _381 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_373.xy), _373.z).x), 1.0);
            float _390 = length(((_381.xyz / float3(_381.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _392 = float2(65504.0);
            _392.y = _390 * 9.9999997473787516355514526367188e-06;
            bool _395 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_395 && (_390 < _351))
            {
                _1478 = _392;
                _1479 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _403;
            if (_395)
            {
                _403 = fast::min(_353, _390);
            }
            else
            {
                _403 = _353;
            }
            float3 _413 = View.View_AtmosphereLightColor[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
            float _420 = _351 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _403 - _351);
            float _427 = _420 - _351;
            uint _434 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_427 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _436 = _427 / float(_434);
            float _437 = _436 * 0.00999999977648258209228515625;
            float3 _465;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _464;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _464 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _449 = _172;
                    _449.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _453 = _449;
                    _453.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _457 = _453;
                    _457.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _464 = fast::max(float3(0.0), _457);
                }
                _465 = _464;
            }
            else
            {
                _465 = float3(0.0);
            }
            float _471 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _482 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _483 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _485 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _256);
            float _486 = _482 * _482;
            float _491 = (1.0 + _486) + ((2.0 * _482) * _485);
            float _495 = (1.0 - _486) / ((12.56637096405029296875 * _491) * sqrt(_491));
            float _496 = _483 * _483;
            float _501 = (1.0 + _496) + ((2.0 * _483) * _485);
            float _508 = _495 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _496) / ((12.56637096405029296875 * _501) * sqrt(_501))) - _495));
            float3 _510 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _511 = _296 * 100000.0;
            float _514 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _511);
            float _550;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _530 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _531 = _530.y;
                uint _532 = _530.z;
                uint _535 = _530.x + (_531 * _532);
                uint _537 = _531 + (_532 * _535);
                uint3 _542 = _173;
                _542.x = _535 + (_537 * (_532 + (_535 * _537)));
                _550 = _351 + ((float((_542 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _436);
            }
            else
            {
                _550 = _351 + (0.5 * _436);
            }
            float3 _552;
            float3 _555;
            _552 = float3(1.0);
            _555 = float3(0.0);
            float3 _553;
            float3 _556;
            float _558;
            float _560;
            float _562;
            uint _1117;
            float3 _1118;
            float3 _1119;
            float _1120;
            float _1121;
            float _557 = 0.0;
            float _559 = 0.0;
            float _561 = _550;
            uint _563 = 0u;
            for (;;)
            {
                if (_563 < _434)
                {
                    float3 _568 = _256 * _561;
                    float3 _569 = View.View_WorldCameraOrigin + _568;
                    float _574 = fast::clamp((length(_569 - _510) - _511) * _514, 0.0, 1.0);
                    float4 _584 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_569 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _585 = _584.y;
                    float _601 = ((_574 < 0.0500000007450580596923828125) || (_574 > 0.949999988079071044921875)) ? 0.0 : (_584.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_585 <= 0.0) ? 0.0 : pow(_585, 0.25), 1.0 - _574), level(-1.0)).x);
                    if (_601 <= 0.0)
                    {
                        _553 = _552;
                        _556 = _555;
                        _558 = _557;
                        _560 = _559;
                        _562 = _561 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _436);
                        _1117 = _563 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _564 = _1117 + 1u;
                        _552 = _553;
                        _555 = _556;
                        _557 = _558;
                        _559 = _560;
                        _561 = _562;
                        _563 = _564;
                        continue;
                    }
                    float3 _619 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _620 = _619 * 0.1500000059604644775390625;
                    float3 _623 = _569 * Material.Material_ScalarExpressions[0].x;
                    float4 _631 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_620 + _623) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _634 = _631.x;
                    float _638 = _631.y;
                    float _642 = _631.z;
                    float3 _648 = float3(_601) * fast::clamp(float3((_634 <= 0.0) ? 0.0 : pow(_634, Material.Material_ScalarExpressions[0].z), (_638 <= 0.0) ? 0.0 : pow(_638, Material.Material_ScalarExpressions[0].z), (_642 <= 0.0) ? 0.0 : pow(_642, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _649 = _619 * (-0.100000001490116119384765625);
                    float4 _657 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_623 + _649) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _658 = _657.x;
                    float _666 = ((_658 <= 0.0) ? 0.0 : pow(_658, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _671 = float3(Material.Material_ScalarExpressions[1].w);
                    float _678 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _684 = fast::clamp(_574 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _693 = mix(_648, float3((_671 + (fast::clamp((_648 - float3(_666)) / float3(Material.Material_ScalarExpressions[1].z - _666), float3(0.0), float3(1.0)) * _678)).x), float3((_684 <= 0.0) ? 0.0 : pow(_684, Material.Material_ScalarExpressions[2].y)));
                    float3 _701 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _693) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _704 = _701.x;
                    float _708 = _701.y;
                    float _712 = _701.z;
                    float3 _726 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _693, _170).xyz, float3(0.0), float3(65000.0));
                    float3 _731 = (_569 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                    float3 _799;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _738 = _731 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                            float _740 = dot(View.View_AtmosphereLightDirection[0u].xyz, View.View_AtmosphereLightDirection[0u].xyz);
                            float _741 = dot(View.View_AtmosphereLightDirection[0u].xyz, _738);
                            float _742 = 2.0 * _741;
                            float _743 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                            float _748 = (_742 * _742) - ((4.0 * _740) * (dot(_738, _738) - _743));
                            float2 _760;
                            if (_748 >= 0.0)
                            {
                                _760 = (float2(_741 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_748))) / float2(2.0 * _740);
                            }
                            else
                            {
                                _760 = float2(-1.0);
                            }
                            if ((_760.x > 0.0) || (_760.y > 0.0))
                            {
                                _799 = float3(0.0);
                                break;
                            }
                            float _768 = length(_731);
                            float _771 = dot(View.View_AtmosphereLightDirection[0u].xyz, _731 / float3(_768));
                            float _772 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                            float _775 = sqrt(fast::max(0.0, _772 - _743));
                            float _776 = _768 * _768;
                            float _779 = sqrt(fast::max(0.0, _776 - _743));
                            float _789 = View.View_SkyAtmosphereTopRadiusKm - _768;
                            _799 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_768) * _771) + sqrt((_776 * ((_771 * _771) - 1.0)) + _772)) - _789) / ((_779 + _775) - _789), _779 / _775), level(0.0)).xyz;
                            break;
                        }
                    }
                    float3 _800 = fast::clamp(fast::clamp(float3((_704 <= 0.0) ? 0.0 : pow(_704, Material.Material_ScalarExpressions[2].w), (_708 <= 0.0) ? 0.0 : pow(_708, Material.Material_ScalarExpressions[2].w), (_712 <= 0.0) ? 0.0 : pow(_712, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _726;
                    float3 _1063;
                    float3 _1064;
                    if (any(_800 > float3(0.0)))
                    {
                        float _888;
                        if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                        {
                            float4 _823 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_569, 1.0);
                            float2 _827 = _823.xy / float2(_823.w);
                            bool2 _828 = _827 >= float2(0.0);
                            bool2 _829 = _827 <= float2(1.0);
                            float _887;
                            if (all(bool2(_828.x && _829.x, _828.y && _829.y)))
                            {
                                float2 _841 = (_827 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                float2 _842 = fract(_841);
                                float2 _843 = floor(_841);
                                float4 _851 = _174;
                                _851.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_843 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _857 = _851;
                                _857.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_843 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _863 = _857;
                                _863.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_843 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _868 = _863;
                                _868.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_843 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _878 = fast::clamp(fast::clamp((_868 * 40.0) - float4((_823.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _868 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                float2 _882 = mix(_878.wx, _878.zy, _842.xx);
                                _887 = mix(_882.x, _882.y, _842.y);
                            }
                            else
                            {
                                _887 = 1.0;
                            }
                            _888 = _887;
                        }
                        else
                        {
                            _888 = 1.0;
                        }
                        float4 _895 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_569, 1.0);
                        float2 _899 = _895.xy / float2(_895.w);
                        bool2 _903 = _899 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                        bool2 _905 = _899 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                        float _925;
                        if (all(bool2(_903.x && _905.x, _903.y && _905.y)))
                        {
                            float4 _913 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _899, level(0.0));
                            float _914 = _913.x;
                            _925 = fast::clamp(float(_895.z < (_914 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_914 == 1.0), 0.0, 1.0);
                        }
                        else
                        {
                            _925 = 1.0;
                        }
                        float _936 = fast::clamp((dot(_569 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                        float3 _940 = _799 * fast::min(_888, mix(_925, 1.0, _936 * _936));
                        float _946 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _947 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _949;
                        float3 _952;
                        _949 = float3(0.0);
                        _952 = float3(0.0);
                        float _955;
                        float3 _950;
                        float3 _953;
                        for (float _954 = 0.0, _956 = _946; _956 <= 1.0; _949 = _950, _952 = _953, _954 = _955, _956 += _946)
                        {
                            _955 = _956 * _956;
                            float _961 = _955 - _954;
                            float3 _966 = _569 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_954 + (_961 * 0.5))));
                            float _971 = fast::clamp((length(_966 - _510) - _511) * _514, 0.0, 1.0);
                            float4 _977 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_966 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _978 = _977.y;
                            float _992 = ((_971 < 0.0500000007450580596923828125) || (_971 > 0.949999988079071044921875)) ? 0.0 : (_977.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_978 <= 0.0) ? 0.0 : pow(_978, 0.25), 1.0 - _971), level(-1.0)).x);
                            if (_992 <= 0.0)
                            {
                                _950 = _949;
                                _953 = _952;
                                continue;
                            }
                            float3 _997 = _966 * Material.Material_ScalarExpressions[0].x;
                            float4 _1001 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_620 + _997) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _1002 = _1001.x;
                            float _1006 = _1001.y;
                            float _1010 = _1001.z;
                            float3 _1016 = float3(_992) * fast::clamp(float3((_1002 <= 0.0) ? 0.0 : pow(_1002, Material.Material_ScalarExpressions[0].z), (_1006 <= 0.0) ? 0.0 : pow(_1006, Material.Material_ScalarExpressions[0].z), (_1010 <= 0.0) ? 0.0 : pow(_1010, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _1020 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_997 + _649) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _1021 = _1020.x;
                            float _1025 = ((_1021 <= 0.0) ? 0.0 : pow(_1021, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _1035 = fast::clamp(_971 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _1049 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1016, float3((_671 + (fast::clamp((_1016 - float3(_1025)) / float3(Material.Material_ScalarExpressions[1].z - _1025), float3(0.0), float3(1.0)) * _678)).x), float3((_1035 <= 0.0) ? 0.0 : pow(_1035, Material.Material_ScalarExpressions[2].y))), _170).xyz, float3(0.0), float3(65000.0));
                            _950 = _949 + ((_1049 * _471) * _961);
                            _953 = _952 + (_1049 * _961);
                        }
                        _1063 = _940 * exp((-_952) * _947);
                        _1064 = _940 * exp((-_949) * _947);
                    }
                    else
                    {
                        _1063 = _799;
                        _1064 = _799;
                    }
                    float _1077;
                    float _1078;
                    if (any(_726 > float3(0.0)))
                    {
                        float _1073 = fast::min(_552.x, fast::min(_552.y, _552.z));
                        _1077 = _559 + (_561 * _1073);
                        _1078 = _557 + _1073;
                    }
                    else
                    {
                        _1077 = _559;
                        _1078 = _557;
                    }
                    float3 _1083 = (((_1064 * _413) * mix(0.079577468335628509521484375, _508, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_800 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _1084 = fast::max(float3(9.9999999747524270787835121154785e-07), _726 * _471);
                    float3 _1097 = (((_1063 * _413) * _508) + (_465 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _574, 0.0, 1.0)).xyz) * _800;
                    float3 _1098 = fast::max(float3(9.9999999747524270787835121154785e-07), _726);
                    float3 _1101 = exp((-_1098) * _437);
                    float3 _1106 = (_555 + (_552 * ((_1083 - (_1083 * exp((-_1084) * _437))) / _1084))) + (_552 * ((_1097 - (_1097 * _1101)) / _1098));
                    float3 _1107 = _552 * _1101;
                    if (all(_1107 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _1118 = _1107;
                        _1119 = _1106;
                        _1120 = _1077;
                        _1121 = _1078;
                        break;
                    }
                    _553 = _1107;
                    _556 = _1106;
                    _558 = _1078;
                    _560 = _1077;
                    _562 = _561 + _436;
                    _1117 = _563;
                    uint _564 = _1117 + 1u;
                    _552 = _553;
                    _555 = _556;
                    _557 = _558;
                    _559 = _560;
                    _561 = _562;
                    _563 = _564;
                    continue;
                }
                else
                {
                    _1118 = _552;
                    _1119 = _555;
                    _1120 = _559;
                    _1121 = _557;
                    break;
                }
            }
            bool _1122 = View.View_RealTimeReflectionCapture != 0.0;
            float _1127 = (_1121 == 0.0) ? _420 : (_1120 / fast::max(1.0000000133514319600180897396058e-10, _1121));
            float3 _1129 = View.View_WorldCameraOrigin + (_256 * _1127);
            float4 _1134 = View.View_WorldToClip * float4(_1129, 1.0);
            float _1135 = dot(_1118, float3(0.3333333432674407958984375));
            bool _1139 = _1121 > 0.0;
            float3 _1212;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1139)
            {
                float3 _1151 = (_1129 * 9.9999997473787516355514526367188e-06) - _255;
                float _1157 = sqrt((fast::max(0.0, length(_1151) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                float _1158 = _1157 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                float _1165;
                if (_1158 < 0.707106769084930419921875)
                {
                    _1165 = fast::clamp((_1158 * _1158) * 2.0, 0.0, 1.0);
                }
                else
                {
                    _1165 = 1.0;
                }
                float2 _1193;
                if (_1122)
                {
                    float3 _1168 = normalize(_1151);
                    float _1169 = _1168.z;
                    float _1172 = sqrt(1.0 - (_1169 * _1169));
                    float2 _1175 = _175;
                    _1175.y = (_1169 * 0.5) + 0.5;
                    float _1180 = acos(_1168.x / _1172);
                    float2 _1185 = _1175;
                    _1185.x = (((_1168.y / _1172) < 0.0) ? (6.283185482025146484375 - _1180) : _1180) * 0.15915493667125701904296875;
                    _1193 = (_1185 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                }
                else
                {
                    _1193 = ((_1134.xy / _1134.ww) * float2(0.5, -0.5)) + float2(0.5);
                }
                float4 _1198 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1193, _1157), level(0.0));
                _1212 = (((_1198.xyz * _1165).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1135)) + (_1119 * (1.0 - (_1165 * (1.0 - _1198.w))));
            }
            else
            {
                _1212 = _1119;
            }
            float3 _1459;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1139)
            {
                float3 _1219 = _1129 - View.View_WorldCameraOrigin;
                float _1236 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                float _1239 = _1219.z + (View.View_WorldCameraOrigin.z - _1236);
                float3 _1240 = _1219;
                _1240.z = _1239;
                float _1241 = dot(_1240, _1240);
                float _1242 = rsqrt(_1241);
                float _1243 = _1241 * _1242;
                float _1251 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1219) / dot(_1219, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                float _1285;
                float _1286;
                float _1287;
                float _1288;
                if (_1251 > 0.0)
                {
                    float _1255 = _1251 * _1242;
                    float _1256 = _1255 * _1239;
                    float _1257 = _1236 + _1256;
                    _1285 = (1.0 - _1255) * _1243;
                    _1286 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1257 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                    _1287 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1257 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                    _1288 = _1239 - _1256;
                }
                else
                {
                    _1285 = _1243;
                    _1286 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                    _1287 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                    _1288 = _1239;
                }
                float _1292 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1288);
                float _1306 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1288);
                float _1317 = (_1287 * ((abs(_1292) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1292)) / _1292) : (0.693147182464599609375 - (0.2402265071868896484375 * _1292)))) + (_1286 * ((abs(_1306) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1306)) / _1306) : (0.693147182464599609375 - (0.2402265071868896484375 * _1306))));
                float3 _1359;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                {
                    float2 _1344 = float2(dot(_1240.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1240.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                    float3 _1345 = float3(_1344.x, _1344.y, _1240.z);
                    _1359 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1345, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1345, level(0.0)).xyz, float3(fast::clamp((_1243 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                }
                else
                {
                    _1359 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                }
                float3 _1387;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                {
                    _1387 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1240 * _1242, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1317 * fast::max(_1285 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                }
                else
                {
                    _1387 = float3(0.0);
                }
                bool _1396 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1243 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                float _1399 = _1396 ? 1.0 : fast::max(fast::clamp(exp2(-(_1317 * _1285)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                float4 _1406 = float4((_1359 * (1.0 - _1399)) + select(_1387, float3(0.0), bool3(_1396)), _1399);
                bool _1409 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                float4 _1452;
                if (_1409)
                {
                    float _1412 = _1134.w;
                    float4 _1441;
                    if (_1409)
                    {
                        _1441 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1134.xy / float2(_1412)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1412 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                    }
                    else
                    {
                        _1441 = float4(0.0, 0.0, 0.0, 1.0);
                    }
                    _1452 = float4(_1441.xyz + (_1406.xyz * _1441.w), _1441.w * _1399);
                }
                else
                {
                    _1452 = _1406;
                }
                _1459 = (_1452.xyz * (1.0 - _1135)) + (_1212 * _1452.w);
            }
            else
            {
                _1459 = _1212;
            }
            float _1463 = (_1135 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1135;
            float2 _1469 = _392;
            _1469.x = 65504.0;
            float2 _1477;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1476 = _1469;
                _1476.x = ((_1463 > 0.9900000095367431640625) ? _420 : _1127) * 9.9999997473787516355514526367188e-06;
                _1477 = _1476;
            }
            else
            {
                _1477 = _1469;
            }
            _1478 = _1477;
            _1479 = float4(_1459 * (_1122 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1463);
            break;
        }
    }
    out.out_var_SV_Target0 = _1479;
    out.out_var_SV_Target1 = _1478;
    return out;
}

