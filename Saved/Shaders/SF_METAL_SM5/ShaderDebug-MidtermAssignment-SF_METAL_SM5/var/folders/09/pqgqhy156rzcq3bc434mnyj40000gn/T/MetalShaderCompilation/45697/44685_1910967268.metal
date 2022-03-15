

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

constant float _154 = {};
constant float3 _156 = {};
constant uint3 _157 = {};
constant float2 _158 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000ae8d_71e70be4(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(2)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(3)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture3d<float> Material_VolumeTexture_0 [[texture(7)]], texture3d<float> Material_VolumeTexture_1 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], sampler Material_VolumeTexture_0Sampler [[sampler(6)]], sampler Material_VolumeTexture_1Sampler [[sampler(7)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1398;
    float4 _1399;
    switch (0u)
    {
        default:
        {
            float _246;
            float _252;
            float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
            float3 _231 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
            float3 _232 = -normalize(-(_224.xyz / float3(_224.w)));
            float2 _266;
            bool _267;
            switch (0u)
            {
                default:
                {
                    float3 _244 = _231 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _246 = dot(_232, _232);
                    float _247 = dot(_232, _244);
                    float _248 = 2.0 * _247;
                    _252 = 4.0 * _246;
                    float _254 = (_248 * _248) - (_252 * (dot(_244, _244) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_254 >= 0.0)
                    {
                        _266 = (float2(_247 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_254))) / float2(2.0 * _246);
                        _267 = true;
                        break;
                    }
                    _266 = float2(0.0);
                    _267 = false;
                    break;
                }
            }
            float _272;
            float _324;
            float _325;
            if (_267)
            {
                _272 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                float2 _297;
                bool _298;
                switch (0u)
                {
                    default:
                    {
                        float3 _277 = _231 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _272).xyz;
                        float _279 = dot(_232, _277);
                        float _280 = 2.0 * _279;
                        float _285 = (_280 * _280) - (_252 * (dot(_277, _277) - (_272 * _272)));
                        if (_285 >= 0.0)
                        {
                            _297 = (float2(_279 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_285))) / float2(2.0 * _246);
                            _298 = true;
                            break;
                        }
                        _297 = float2(0.0);
                        _298 = false;
                        break;
                    }
                }
                if (_298)
                {
                    float _308 = fast::min(_266.x, _266.y);
                    bool _312 = all(_297 > float2(0.0));
                    float _317 = _312 ? fast::min(_297.x, _297.y) : fast::max(_297.x, _297.y);
                    float _321;
                    if (_312)
                    {
                        _321 = fast::max(0.0, _308);
                    }
                    else
                    {
                        _321 = all(_266 > float2(0.0)) ? _308 : fast::max(_266.x, _266.y);
                    }
                    _324 = fast::max(_317, _321);
                    _325 = fast::min(_317, _321);
                }
                else
                {
                    _324 = _266.y;
                    _325 = _266.x;
                }
            }
            else
            {
                _1398 = float2(65504.0);
                _1399 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _327 = fast::max(0.0, _325) * 100000.0;
            float _329 = fast::max(0.0, _324) * 100000.0;
            if ((_329 <= _327) || (_327 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1398 = float2(65504.0);
                _1399 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _349 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _357 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_349.xy), _349.z).x), 1.0);
            float _366 = length(((_357.xyz / float3(_357.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _368 = float2(65504.0);
            _368.y = _366 * 9.9999997473787516355514526367188e-06;
            bool _371 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_371 && (_366 < _327))
            {
                _1398 = _368;
                _1399 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _379;
            if (_371)
            {
                _379 = fast::min(_329, _366);
            }
            else
            {
                _379 = _329;
            }
            bool3 _384 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
            float3 _389 = View.View_AtmosphereLightColorGlobalPostTransmittance[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _384);
            float3 _396 = View.View_AtmosphereLightColorGlobalPostTransmittance[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _384);
            float _403 = _327 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _379 - _327);
            float _410 = _403 - _327;
            uint _417 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_410 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _419 = _410 / float(_417);
            float _420 = _419 * 0.00999999977648258209228515625;
            float3 _448;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _447;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _447 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _432 = _156;
                    _432.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _436 = _432;
                    _436.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _440 = _436;
                    _440.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _447 = fast::max(float3(0.0), _440);
                }
                _448 = _447;
            }
            else
            {
                _448 = float3(0.0);
            }
            float _454 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _457 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
            float _466 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _467 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _468 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
            float _469 = -dot(View.View_AtmosphereLightDirection[0].xyz, _232);
            float _470 = _466 * _466;
            float _471 = 1.0 - _470;
            float _472 = 1.0 + _470;
            float _473 = 2.0 * _466;
            float _475 = _472 + (_473 * _469);
            float _479 = _471 / ((12.56637096405029296875 * _475) * sqrt(_475));
            float _480 = _467 * _467;
            float _481 = 1.0 - _480;
            float _482 = 1.0 + _480;
            float _483 = 2.0 * _467;
            float _485 = _482 + (_483 * _469);
            float _492 = _479 + (_468 * ((_481 / ((12.56637096405029296875 * _485) * sqrt(_485))) - _479));
            float _493 = -dot(View.View_AtmosphereLightDirection[1].xyz, _232);
            float _495 = _472 + (_473 * _493);
            float _499 = _471 / ((12.56637096405029296875 * _495) * sqrt(_495));
            float _501 = _482 + (_483 * _493);
            float _508 = _499 + (_468 * ((_481 / ((12.56637096405029296875 * _501) * sqrt(_501))) - _499));
            float3 _511 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _512 = _272 * 100000.0;
            float _515 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _512);
            float _551;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _531 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _532 = _531.y;
                uint _533 = _531.z;
                uint _536 = _531.x + (_532 * _533);
                uint _538 = _532 + (_533 * _536);
                uint3 _543 = _157;
                _543.x = _536 + (_538 * (_533 + (_536 * _538)));
                _551 = _327 + ((float((_543 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _419);
            }
            else
            {
                _551 = _327 + (0.5 * _419);
            }
            float3 _553;
            float3 _556;
            _553 = float3(1.0);
            _556 = float3(0.0);
            float3 _554;
            float3 _557;
            float _559;
            float _561;
            float _563;
            uint _1037;
            float3 _1038;
            float3 _1039;
            float _1040;
            float _1041;
            float _558 = 0.0;
            float _560 = 0.0;
            float _562 = _551;
            uint _564 = 0u;
            for (;;)
            {
                if (_564 < _417)
                {
                    float3 _569 = _232 * _562;
                    float3 _570 = View.View_WorldCameraOrigin + _569;
                    float _575 = fast::clamp((length(_570 - _511) - _512) * _515, 0.0, 1.0);
                    float4 _585 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_570 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _586 = _585.y;
                    float _602 = ((_575 < 0.0500000007450580596923828125) || (_575 > 0.949999988079071044921875)) ? 0.0 : (_585.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_586 <= 0.0) ? 0.0 : pow(_586, 0.25), 1.0 - _575), level(-1.0)).x);
                    if (_602 <= 0.0)
                    {
                        _554 = _553;
                        _557 = _556;
                        _559 = _558;
                        _561 = _560;
                        _563 = _562 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _419);
                        _1037 = _564 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _565 = _1037 + 1u;
                        _553 = _554;
                        _556 = _557;
                        _558 = _559;
                        _560 = _561;
                        _562 = _563;
                        _564 = _565;
                        continue;
                    }
                    float3 _620 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _621 = _620 * 0.1500000059604644775390625;
                    float3 _624 = _570 * Material.Material_ScalarExpressions[0].x;
                    float4 _632 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_621 + _624) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _635 = _632.x;
                    float _639 = _632.y;
                    float _643 = _632.z;
                    float3 _649 = float3(_602) * fast::clamp(float3((_635 <= 0.0) ? 0.0 : pow(_635, Material.Material_ScalarExpressions[0].z), (_639 <= 0.0) ? 0.0 : pow(_639, Material.Material_ScalarExpressions[0].z), (_643 <= 0.0) ? 0.0 : pow(_643, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _650 = _620 * (-0.100000001490116119384765625);
                    float4 _658 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_624 + _650) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _659 = _658.x;
                    float _667 = ((_659 <= 0.0) ? 0.0 : pow(_659, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _672 = float3(Material.Material_ScalarExpressions[1].w);
                    float _679 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _685 = fast::clamp(_575 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _694 = mix(_649, float3((_672 + (fast::clamp((_649 - float3(_667)) / float3(Material.Material_ScalarExpressions[1].z - _667), float3(0.0), float3(1.0)) * _679)).x), float3((_685 <= 0.0) ? 0.0 : pow(_685, Material.Material_ScalarExpressions[2].y)));
                    float3 _702 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _694) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _705 = _702.x;
                    float _709 = _702.y;
                    float _713 = _702.z;
                    float3 _727 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _694, _154).xyz, float3(0.0), float3(65000.0));
                    float3 _730 = fast::clamp(fast::clamp(float3((_705 <= 0.0) ? 0.0 : pow(_705, Material.Material_ScalarExpressions[2].w), (_709 <= 0.0) ? 0.0 : pow(_709, Material.Material_ScalarExpressions[2].w), (_713 <= 0.0) ? 0.0 : pow(_713, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _727;
                    float3 _975;
                    float3 _976;
                    float3 _977;
                    float3 _978;
                    if (any(_730 > float3(0.0)))
                    {
                        float _747 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _748 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _750;
                        float3 _753;
                        _750 = float3(0.0);
                        _753 = float3(0.0);
                        float _756;
                        float3 _751;
                        float3 _754;
                        for (float _755 = 0.0, _757 = _747; _757 <= 1.0; _750 = _751, _753 = _754, _755 = _756, _757 += _747)
                        {
                            _756 = _757 * _757;
                            float _762 = _756 - _755;
                            float3 _767 = _570 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_755 + (_762 * 0.5))));
                            float _772 = fast::clamp((length(_767 - _511) - _512) * _515, 0.0, 1.0);
                            float4 _778 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_767 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _779 = _778.y;
                            float _793 = ((_772 < 0.0500000007450580596923828125) || (_772 > 0.949999988079071044921875)) ? 0.0 : (_778.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_779 <= 0.0) ? 0.0 : pow(_779, 0.25), 1.0 - _772), level(-1.0)).x);
                            if (_793 <= 0.0)
                            {
                                _751 = _750;
                                _754 = _753;
                                continue;
                            }
                            float3 _798 = _767 * Material.Material_ScalarExpressions[0].x;
                            float4 _802 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_621 + _798) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _803 = _802.x;
                            float _807 = _802.y;
                            float _811 = _802.z;
                            float3 _817 = float3(_793) * fast::clamp(float3((_803 <= 0.0) ? 0.0 : pow(_803, Material.Material_ScalarExpressions[0].z), (_807 <= 0.0) ? 0.0 : pow(_807, Material.Material_ScalarExpressions[0].z), (_811 <= 0.0) ? 0.0 : pow(_811, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _821 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_798 + _650) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _822 = _821.x;
                            float _826 = ((_822 <= 0.0) ? 0.0 : pow(_822, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _836 = fast::clamp(_772 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _850 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_817, float3((_672 + (fast::clamp((_817 - float3(_826)) / float3(Material.Material_ScalarExpressions[1].z - _826), float3(0.0), float3(1.0)) * _679)).x), float3((_836 <= 0.0) ? 0.0 : pow(_836, Material.Material_ScalarExpressions[2].y))), _154).xyz, float3(0.0), float3(65000.0));
                            _751 = _750 + ((_850 * _454) * _762);
                            _754 = _753 + (_850 * _762);
                        }
                        float3 _863;
                        float3 _866;
                        _863 = float3(0.0);
                        _866 = float3(0.0);
                        float _869;
                        float3 _864;
                        float3 _867;
                        for (float _868 = 0.0, _870 = _747; _870 <= 1.0; _863 = _864, _866 = _867, _868 = _869, _870 += _747)
                        {
                            _869 = _870 * _870;
                            float _875 = _869 - _868;
                            float3 _880 = _570 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_868 + (_875 * 0.5))));
                            float _885 = fast::clamp((length(_880 - _511) - _512) * _515, 0.0, 1.0);
                            float4 _891 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_880 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _892 = _891.y;
                            float _906 = ((_885 < 0.0500000007450580596923828125) || (_885 > 0.949999988079071044921875)) ? 0.0 : (_891.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_892 <= 0.0) ? 0.0 : pow(_892, 0.25), 1.0 - _885), level(-1.0)).x);
                            if (_906 <= 0.0)
                            {
                                _864 = _863;
                                _867 = _866;
                                continue;
                            }
                            float3 _911 = _880 * Material.Material_ScalarExpressions[0].x;
                            float4 _915 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_621 + _911) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _916 = _915.x;
                            float _920 = _915.y;
                            float _924 = _915.z;
                            float3 _930 = float3(_906) * fast::clamp(float3((_916 <= 0.0) ? 0.0 : pow(_916, Material.Material_ScalarExpressions[0].z), (_920 <= 0.0) ? 0.0 : pow(_920, Material.Material_ScalarExpressions[0].z), (_924 <= 0.0) ? 0.0 : pow(_924, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _934 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_911 + _650) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _935 = _934.x;
                            float _939 = ((_935 <= 0.0) ? 0.0 : pow(_935, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _949 = fast::clamp(_885 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _963 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_930, float3((_672 + (fast::clamp((_930 - float3(_939)) / float3(Material.Material_ScalarExpressions[1].z - _939), float3(0.0), float3(1.0)) * _679)).x), float3((_949 <= 0.0) ? 0.0 : pow(_949, Material.Material_ScalarExpressions[2].y))), _154).xyz, float3(0.0), float3(65000.0));
                            _864 = _863 + ((_963 * _454) * _875);
                            _867 = _866 + (_963 * _875);
                        }
                        _975 = exp((-_866) * _748);
                        _976 = exp((-_753) * _748);
                        _977 = exp((-_863) * _748);
                        _978 = exp((-_750) * _748);
                    }
                    else
                    {
                        _975 = float3(1.0);
                        _976 = float3(1.0);
                        _977 = float3(1.0);
                        _978 = float3(1.0);
                    }
                    float _991;
                    float _992;
                    if (any(_727 > float3(0.0)))
                    {
                        float _987 = fast::min(_553.x, fast::min(_553.y, _553.z));
                        _991 = _560 + (_562 * _987);
                        _992 = _558 + _987;
                    }
                    else
                    {
                        _991 = _560;
                        _992 = _558;
                    }
                    float3 _1000 = ((((_978 * _389) * mix(0.079577468335628509521484375, _492, _457)) + ((_977 * _396) * mix(0.079577468335628509521484375, _508, _457))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_730 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _1001 = fast::max(float3(9.9999999747524270787835121154785e-07), _727 * _454);
                    float3 _1017 = ((((_976 * _389) * _492) + ((_975 * _396) * _508)) + (_448 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _575, 0.0, 1.0)).xyz) * _730;
                    float3 _1018 = fast::max(float3(9.9999999747524270787835121154785e-07), _727);
                    float3 _1021 = exp((-_1018) * _420);
                    float3 _1026 = (_556 + (_553 * ((_1000 - (_1000 * exp((-_1001) * _420))) / _1001))) + (_553 * ((_1017 - (_1017 * _1021)) / _1018));
                    float3 _1027 = _553 * _1021;
                    if (all(_1027 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _1038 = _1027;
                        _1039 = _1026;
                        _1040 = _991;
                        _1041 = _992;
                        break;
                    }
                    _554 = _1027;
                    _557 = _1026;
                    _559 = _992;
                    _561 = _991;
                    _563 = _562 + _419;
                    _1037 = _564;
                    uint _565 = _1037 + 1u;
                    _553 = _554;
                    _556 = _557;
                    _558 = _559;
                    _560 = _561;
                    _562 = _563;
                    _564 = _565;
                    continue;
                }
                else
                {
                    _1038 = _553;
                    _1039 = _556;
                    _1040 = _560;
                    _1041 = _558;
                    break;
                }
            }
            bool _1042 = View.View_RealTimeReflectionCapture != 0.0;
            float _1047 = (_1041 == 0.0) ? _403 : (_1040 / fast::max(1.0000000133514319600180897396058e-10, _1041));
            float3 _1049 = View.View_WorldCameraOrigin + (_232 * _1047);
            float4 _1054 = View.View_WorldToClip * float4(_1049, 1.0);
            float _1055 = dot(_1038, float3(0.3333333432674407958984375));
            bool _1059 = _1041 > 0.0;
            float3 _1132;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1059)
            {
                float3 _1071 = (_1049 * 9.9999997473787516355514526367188e-06) - _231;
                float _1077 = sqrt((fast::max(0.0, length(_1071) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                float _1078 = _1077 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                float _1085;
                if (_1078 < 0.707106769084930419921875)
                {
                    _1085 = fast::clamp((_1078 * _1078) * 2.0, 0.0, 1.0);
                }
                else
                {
                    _1085 = 1.0;
                }
                float2 _1113;
                if (_1042)
                {
                    float3 _1088 = normalize(_1071);
                    float _1089 = _1088.z;
                    float _1092 = sqrt(1.0 - (_1089 * _1089));
                    float2 _1095 = _158;
                    _1095.y = (_1089 * 0.5) + 0.5;
                    float _1100 = acos(_1088.x / _1092);
                    float2 _1105 = _1095;
                    _1105.x = (((_1088.y / _1092) < 0.0) ? (6.283185482025146484375 - _1100) : _1100) * 0.15915493667125701904296875;
                    _1113 = (_1105 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                }
                else
                {
                    _1113 = ((_1054.xy / _1054.ww) * float2(0.5, -0.5)) + float2(0.5);
                }
                float4 _1118 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1113, _1077), level(0.0));
                _1132 = (((_1118.xyz * _1085).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1055)) + (_1039 * (1.0 - (_1085 * (1.0 - _1118.w))));
            }
            else
            {
                _1132 = _1039;
            }
            float3 _1379;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1059)
            {
                float3 _1139 = _1049 - View.View_WorldCameraOrigin;
                float _1156 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                float _1159 = _1139.z + (View.View_WorldCameraOrigin.z - _1156);
                float3 _1160 = _1139;
                _1160.z = _1159;
                float _1161 = dot(_1160, _1160);
                float _1162 = rsqrt(_1161);
                float _1163 = _1161 * _1162;
                float _1171 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1139) / dot(_1139, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                float _1205;
                float _1206;
                float _1207;
                float _1208;
                if (_1171 > 0.0)
                {
                    float _1175 = _1171 * _1162;
                    float _1176 = _1175 * _1159;
                    float _1177 = _1156 + _1176;
                    _1205 = (1.0 - _1175) * _1163;
                    _1206 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1177 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                    _1207 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1177 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                    _1208 = _1159 - _1176;
                }
                else
                {
                    _1205 = _1163;
                    _1206 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                    _1207 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                    _1208 = _1159;
                }
                float _1212 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1208);
                float _1226 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1208);
                float _1237 = (_1207 * ((abs(_1212) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1212)) / _1212) : (0.693147182464599609375 - (0.2402265071868896484375 * _1212)))) + (_1206 * ((abs(_1226) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1226)) / _1226) : (0.693147182464599609375 - (0.2402265071868896484375 * _1226))));
                float3 _1279;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                {
                    float2 _1264 = float2(dot(_1160.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1160.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                    float3 _1265 = float3(_1264.x, _1264.y, _1160.z);
                    _1279 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1265, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1265, level(0.0)).xyz, float3(fast::clamp((_1163 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                }
                else
                {
                    _1279 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                }
                float3 _1307;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                {
                    _1307 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1160 * _1162, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1237 * fast::max(_1205 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                }
                else
                {
                    _1307 = float3(0.0);
                }
                bool _1316 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1163 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                float _1319 = _1316 ? 1.0 : fast::max(fast::clamp(exp2(-(_1237 * _1205)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                float4 _1326 = float4((_1279 * (1.0 - _1319)) + select(_1307, float3(0.0), bool3(_1316)), _1319);
                bool _1329 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                float4 _1372;
                if (_1329)
                {
                    float _1332 = _1054.w;
                    float4 _1361;
                    if (_1329)
                    {
                        _1361 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1054.xy / float2(_1332)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1332 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                    }
                    else
                    {
                        _1361 = float4(0.0, 0.0, 0.0, 1.0);
                    }
                    _1372 = float4(_1361.xyz + (_1326.xyz * _1361.w), _1361.w * _1319);
                }
                else
                {
                    _1372 = _1326;
                }
                _1379 = (_1372.xyz * (1.0 - _1055)) + (_1132 * _1372.w);
            }
            else
            {
                _1379 = _1132;
            }
            float _1383 = (_1055 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1055;
            float2 _1389 = _368;
            _1389.x = 65504.0;
            float2 _1397;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1396 = _1389;
                _1396.x = ((_1383 > 0.9900000095367431640625) ? _403 : _1047) * 9.9999997473787516355514526367188e-06;
                _1397 = _1396;
            }
            else
            {
                _1397 = _1389;
            }
            _1398 = _1397;
            _1399 = float4(_1379 * (_1042 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1383);
            break;
        }
    }
    out.out_var_SV_Target0 = _1399;
    out.out_var_SV_Target1 = _1398;
    return out;
}

