

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

struct type_Globals
{
    char _m0_pad[16];
    float4 OutputViewRect;
    int bBlendCloudColor;
    int TargetCubeFace;
};

constant float _172 = {};
constant float3 _174 = {};
constant uint3 _175 = {};
constant float4 _176 = {};
constant float2 _177 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000d669_d715b496(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(5)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(6)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(7)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(8)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], texture3d<float> Material_VolumeTexture_0 [[texture(12)]], texture3d<float> Material_VolumeTexture_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(5)]], sampler Material_Texture2D_0Sampler [[sampler(6)]], sampler Material_Texture2D_1Sampler [[sampler(7)]], sampler Material_VolumeTexture_0Sampler [[sampler(8)]], sampler Material_VolumeTexture_1Sampler [[sampler(9)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _219 = float(gl_GlobalInvocationID.x) + 0.5;
        float _222 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _223 = float4(_219, _222, 0.5, 1.0);
        float2 _1565;
        float4 _1566;
        switch (0u)
        {
            default:
            {
                float _282;
                float _288;
                float4 _260 = View.View_SVPositionToTranslatedWorld * _223;
                float3 _267 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _268 = -normalize(-(_260.xyz / float3(_260.w)));
                float2 _302;
                bool _303;
                switch (0u)
                {
                    default:
                    {
                        float3 _280 = _267 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _282 = dot(_268, _268);
                        float _283 = dot(_268, _280);
                        float _284 = 2.0 * _283;
                        _288 = 4.0 * _282;
                        float _290 = (_284 * _284) - (_288 * (dot(_280, _280) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_290 >= 0.0)
                        {
                            _302 = (float2(_283 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_290))) / float2(2.0 * _282);
                            _303 = true;
                            break;
                        }
                        _302 = float2(0.0);
                        _303 = false;
                        break;
                    }
                }
                float _308;
                float _360;
                float _361;
                if (_303)
                {
                    _308 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _333;
                    bool _334;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _313 = _267 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _308).xyz;
                            float _315 = dot(_268, _313);
                            float _316 = 2.0 * _315;
                            float _321 = (_316 * _316) - (_288 * (dot(_313, _313) - (_308 * _308)));
                            if (_321 >= 0.0)
                            {
                                _333 = (float2(_315 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_321))) / float2(2.0 * _282);
                                _334 = true;
                                break;
                            }
                            _333 = float2(0.0);
                            _334 = false;
                            break;
                        }
                    }
                    if (_334)
                    {
                        float _344 = fast::min(_302.x, _302.y);
                        bool _348 = all(_333 > float2(0.0));
                        float _353 = _348 ? fast::min(_333.x, _333.y) : fast::max(_333.x, _333.y);
                        float _357;
                        if (_348)
                        {
                            _357 = fast::max(0.0, _344);
                        }
                        else
                        {
                            _357 = all(_302 > float2(0.0)) ? _344 : fast::max(_302.x, _302.y);
                        }
                        _360 = fast::max(_353, _357);
                        _361 = fast::min(_353, _357);
                    }
                    else
                    {
                        _360 = _302.y;
                        _361 = _302.x;
                    }
                }
                else
                {
                    _1565 = float2(65504.0);
                    _1566 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _363 = fast::max(0.0, _361) * 100000.0;
                float _365 = fast::max(0.0, _360) * 100000.0;
                if ((_365 <= _363) || (_363 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1565 = float2(65504.0);
                    _1566 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _385 = int3(uint3((uint2(_223.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _393 = View.View_SVPositionToTranslatedWorld * float4(_219, _222, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_385.xy), _385.z).x), 1.0);
                float _402 = length(((_393.xyz / float3(_393.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _404 = float2(65504.0);
                _404.y = _402 * 9.9999997473787516355514526367188e-06;
                bool _407 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_407 && (_402 < _363))
                {
                    _1565 = _404;
                    _1566 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _415;
                if (_407)
                {
                    _415 = fast::min(_365, _402);
                }
                else
                {
                    _415 = _365;
                }
                bool3 _420 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
                float3 _425 = View.View_AtmosphereLightColorGlobalPostTransmittance[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _420);
                float3 _432 = View.View_AtmosphereLightColorGlobalPostTransmittance[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _420);
                float _439 = _363 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _415 - _363);
                float _446 = _439 - _363;
                uint _453 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_446 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _455 = _446 / float(_453);
                float _456 = _455 * 0.00999999977648258209228515625;
                float3 _484;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _483;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _483 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _468 = _174;
                        _468.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _472 = _468;
                        _472.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _476 = _472;
                        _476.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _483 = fast::max(float3(0.0), _476);
                    }
                    _484 = _483;
                }
                else
                {
                    _484 = float3(0.0);
                }
                float _490 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _493 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
                float _502 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _503 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _504 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
                float _505 = -dot(View.View_AtmosphereLightDirection[0].xyz, _268);
                float _506 = _502 * _502;
                float _507 = 1.0 - _506;
                float _508 = 1.0 + _506;
                float _509 = 2.0 * _502;
                float _511 = _508 + (_509 * _505);
                float _515 = _507 / ((12.56637096405029296875 * _511) * sqrt(_511));
                float _516 = _503 * _503;
                float _517 = 1.0 - _516;
                float _518 = 1.0 + _516;
                float _519 = 2.0 * _503;
                float _521 = _518 + (_519 * _505);
                float _528 = _515 + (_504 * ((_517 / ((12.56637096405029296875 * _521) * sqrt(_521))) - _515));
                float _529 = -dot(View.View_AtmosphereLightDirection[1].xyz, _268);
                float _531 = _508 + (_509 * _529);
                float _535 = _507 / ((12.56637096405029296875 * _531) * sqrt(_531));
                float _537 = _518 + (_519 * _529);
                float _544 = _535 + (_504 * ((_517 / ((12.56637096405029296875 * _537) * sqrt(_537))) - _535));
                float3 _547 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _548 = _308 * 100000.0;
                float _551 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _548);
                float _587;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _567 = (uint3(int3(int(_219), int(_222), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _568 = _567.y;
                    uint _569 = _567.z;
                    uint _572 = _567.x + (_568 * _569);
                    uint _574 = _568 + (_569 * _572);
                    uint3 _579 = _175;
                    _579.x = _572 + (_574 * (_569 + (_572 * _574)));
                    _587 = _363 + ((float((_579 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _455);
                }
                else
                {
                    _587 = _363 + (0.5 * _455);
                }
                float3 _589;
                float3 _592;
                _589 = float3(1.0);
                _592 = float3(0.0);
                float3 _590;
                float3 _593;
                float _595;
                float _597;
                float _599;
                uint _1204;
                float3 _1205;
                float3 _1206;
                float _1207;
                float _1208;
                float _594 = 0.0;
                float _596 = 0.0;
                float _598 = _587;
                uint _600 = 0u;
                for (;;)
                {
                    if (_600 < _453)
                    {
                        float3 _605 = _268 * _598;
                        float3 _606 = View.View_WorldCameraOrigin + _605;
                        float _611 = fast::clamp((length(_606 - _547) - _548) * _551, 0.0, 1.0);
                        float4 _621 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_606 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _622 = _621.y;
                        float _638 = ((_611 < 0.0500000007450580596923828125) || (_611 > 0.949999988079071044921875)) ? 0.0 : (_621.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_622 <= 0.0) ? 0.0 : pow(_622, 0.25), 1.0 - _611), level(-1.0)).x);
                        if (_638 <= 0.0)
                        {
                            _590 = _589;
                            _593 = _592;
                            _595 = _594;
                            _597 = _596;
                            _599 = _598 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _455);
                            _1204 = _600 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _601 = _1204 + 1u;
                            _589 = _590;
                            _592 = _593;
                            _594 = _595;
                            _596 = _597;
                            _598 = _599;
                            _600 = _601;
                            continue;
                        }
                        float3 _656 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _657 = _656 * 0.1500000059604644775390625;
                        float3 _660 = _606 * Material.Material_ScalarExpressions[0].x;
                        float4 _668 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_657 + _660) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _671 = _668.x;
                        float _675 = _668.y;
                        float _679 = _668.z;
                        float3 _685 = float3(_638) * fast::clamp(float3((_671 <= 0.0) ? 0.0 : pow(_671, Material.Material_ScalarExpressions[0].z), (_675 <= 0.0) ? 0.0 : pow(_675, Material.Material_ScalarExpressions[0].z), (_679 <= 0.0) ? 0.0 : pow(_679, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _686 = _656 * (-0.100000001490116119384765625);
                        float4 _694 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_660 + _686) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _695 = _694.x;
                        float _703 = ((_695 <= 0.0) ? 0.0 : pow(_695, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _708 = float3(Material.Material_ScalarExpressions[1].w);
                        float _715 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _721 = fast::clamp(_611 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _730 = mix(_685, float3((_708 + (fast::clamp((_685 - float3(_703)) / float3(Material.Material_ScalarExpressions[1].z - _703), float3(0.0), float3(1.0)) * _715)).x), float3((_721 <= 0.0) ? 0.0 : pow(_721, Material.Material_ScalarExpressions[2].y)));
                        float3 _738 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _730) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _741 = _738.x;
                        float _745 = _738.y;
                        float _749 = _738.z;
                        float3 _763 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _730, _172).xyz, float3(0.0), float3(65000.0));
                        float3 _766 = fast::clamp(fast::clamp(float3((_741 <= 0.0) ? 0.0 : pow(_741, Material.Material_ScalarExpressions[2].w), (_745 <= 0.0) ? 0.0 : pow(_745, Material.Material_ScalarExpressions[2].w), (_749 <= 0.0) ? 0.0 : pow(_749, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _763;
                        float3 _1142;
                        float3 _1143;
                        float3 _1144;
                        float3 _1145;
                        if (any(_766 > float3(0.0)))
                        {
                            float _854;
                            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                            {
                                float4 _789 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_606, 1.0);
                                float2 _793 = _789.xy / float2(_789.w);
                                bool2 _794 = _793 >= float2(0.0);
                                bool2 _795 = _793 <= float2(1.0);
                                float _853;
                                if (all(bool2(_794.x && _795.x, _794.y && _795.y)))
                                {
                                    float2 _807 = (_793 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                    float2 _808 = fract(_807);
                                    float2 _809 = floor(_807);
                                    float4 _817 = _176;
                                    _817.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_809 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _823 = _817;
                                    _823.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_809 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _829 = _823;
                                    _829.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_809 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _834 = _829;
                                    _834.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_809 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _844 = fast::clamp(fast::clamp((_834 * 40.0) - float4((_789.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _834 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                    float2 _848 = mix(_844.wx, _844.zy, _808.xx);
                                    _853 = mix(_848.x, _848.y, _808.y);
                                }
                                else
                                {
                                    _853 = 1.0;
                                }
                                _854 = _853;
                            }
                            else
                            {
                                _854 = 1.0;
                            }
                            float4 _861 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_606, 1.0);
                            float2 _865 = _861.xy / float2(_861.w);
                            bool2 _869 = _865 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                            bool2 _871 = _865 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                            float _891;
                            if (all(bool2(_869.x && _871.x, _869.y && _871.y)))
                            {
                                float4 _879 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _865, level(0.0));
                                float _880 = _879.x;
                                _891 = fast::clamp(float(_861.z < (_880 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_880 == 1.0), 0.0, 1.0);
                            }
                            else
                            {
                                _891 = 1.0;
                            }
                            float _902 = fast::clamp((dot(_606 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                            float3 _906 = float3(1.0) * fast::min(_854, mix(_891, 1.0, _902 * _902));
                            float _912 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _913 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _915;
                            float3 _918;
                            _915 = float3(0.0);
                            _918 = float3(0.0);
                            float _921;
                            float3 _916;
                            float3 _919;
                            for (float _920 = 0.0, _922 = _912; _922 <= 1.0; _915 = _916, _918 = _919, _920 = _921, _922 += _912)
                            {
                                _921 = _922 * _922;
                                float _927 = _921 - _920;
                                float3 _932 = _606 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_920 + (_927 * 0.5))));
                                float _937 = fast::clamp((length(_932 - _547) - _548) * _551, 0.0, 1.0);
                                float4 _943 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_932 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _944 = _943.y;
                                float _958 = ((_937 < 0.0500000007450580596923828125) || (_937 > 0.949999988079071044921875)) ? 0.0 : (_943.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_944 <= 0.0) ? 0.0 : pow(_944, 0.25), 1.0 - _937), level(-1.0)).x);
                                if (_958 <= 0.0)
                                {
                                    _916 = _915;
                                    _919 = _918;
                                    continue;
                                }
                                float3 _963 = _932 * Material.Material_ScalarExpressions[0].x;
                                float4 _967 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_657 + _963) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _968 = _967.x;
                                float _972 = _967.y;
                                float _976 = _967.z;
                                float3 _982 = float3(_958) * fast::clamp(float3((_968 <= 0.0) ? 0.0 : pow(_968, Material.Material_ScalarExpressions[0].z), (_972 <= 0.0) ? 0.0 : pow(_972, Material.Material_ScalarExpressions[0].z), (_976 <= 0.0) ? 0.0 : pow(_976, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _986 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_963 + _686) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _987 = _986.x;
                                float _991 = ((_987 <= 0.0) ? 0.0 : pow(_987, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _1001 = fast::clamp(_937 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _1015 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_982, float3((_708 + (fast::clamp((_982 - float3(_991)) / float3(Material.Material_ScalarExpressions[1].z - _991), float3(0.0), float3(1.0)) * _715)).x), float3((_1001 <= 0.0) ? 0.0 : pow(_1001, Material.Material_ScalarExpressions[2].y))), _172).xyz, float3(0.0), float3(65000.0));
                                _916 = _915 + ((_1015 * _490) * _927);
                                _919 = _918 + (_1015 * _927);
                            }
                            float3 _1030;
                            float3 _1033;
                            _1030 = float3(0.0);
                            _1033 = float3(0.0);
                            float _1036;
                            float3 _1031;
                            float3 _1034;
                            for (float _1035 = 0.0, _1037 = _912; _1037 <= 1.0; _1030 = _1031, _1033 = _1034, _1035 = _1036, _1037 += _912)
                            {
                                _1036 = _1037 * _1037;
                                float _1042 = _1036 - _1035;
                                float3 _1047 = _606 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1035 + (_1042 * 0.5))));
                                float _1052 = fast::clamp((length(_1047 - _547) - _548) * _551, 0.0, 1.0);
                                float4 _1058 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1047 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _1059 = _1058.y;
                                float _1073 = ((_1052 < 0.0500000007450580596923828125) || (_1052 > 0.949999988079071044921875)) ? 0.0 : (_1058.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1059 <= 0.0) ? 0.0 : pow(_1059, 0.25), 1.0 - _1052), level(-1.0)).x);
                                if (_1073 <= 0.0)
                                {
                                    _1031 = _1030;
                                    _1034 = _1033;
                                    continue;
                                }
                                float3 _1078 = _1047 * Material.Material_ScalarExpressions[0].x;
                                float4 _1082 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_657 + _1078) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _1083 = _1082.x;
                                float _1087 = _1082.y;
                                float _1091 = _1082.z;
                                float3 _1097 = float3(_1073) * fast::clamp(float3((_1083 <= 0.0) ? 0.0 : pow(_1083, Material.Material_ScalarExpressions[0].z), (_1087 <= 0.0) ? 0.0 : pow(_1087, Material.Material_ScalarExpressions[0].z), (_1091 <= 0.0) ? 0.0 : pow(_1091, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _1101 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1078 + _686) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _1102 = _1101.x;
                                float _1106 = ((_1102 <= 0.0) ? 0.0 : pow(_1102, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _1116 = fast::clamp(_1052 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _1130 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1097, float3((_708 + (fast::clamp((_1097 - float3(_1106)) / float3(Material.Material_ScalarExpressions[1].z - _1106), float3(0.0), float3(1.0)) * _715)).x), float3((_1116 <= 0.0) ? 0.0 : pow(_1116, Material.Material_ScalarExpressions[2].y))), _172).xyz, float3(0.0), float3(65000.0));
                                _1031 = _1030 + ((_1130 * _490) * _1042);
                                _1034 = _1033 + (_1130 * _1042);
                            }
                            _1142 = exp((-_1033) * _913);
                            _1143 = _906 * exp((-_918) * _913);
                            _1144 = exp((-_1030) * _913);
                            _1145 = _906 * exp((-_915) * _913);
                        }
                        else
                        {
                            _1142 = float3(1.0);
                            _1143 = float3(1.0);
                            _1144 = float3(1.0);
                            _1145 = float3(1.0);
                        }
                        float _1158;
                        float _1159;
                        if (any(_763 > float3(0.0)))
                        {
                            float _1154 = fast::min(_589.x, fast::min(_589.y, _589.z));
                            _1158 = _596 + (_598 * _1154);
                            _1159 = _594 + _1154;
                        }
                        else
                        {
                            _1158 = _596;
                            _1159 = _594;
                        }
                        float3 _1167 = ((((_1145 * _425) * mix(0.079577468335628509521484375, _528, _493)) + ((_1144 * _432) * mix(0.079577468335628509521484375, _544, _493))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_766 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _1168 = fast::max(float3(9.9999999747524270787835121154785e-07), _763 * _490);
                        float3 _1184 = ((((_1143 * _425) * _528) + ((_1142 * _432) * _544)) + (_484 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _611, 0.0, 1.0)).xyz) * _766;
                        float3 _1185 = fast::max(float3(9.9999999747524270787835121154785e-07), _763);
                        float3 _1188 = exp((-_1185) * _456);
                        float3 _1193 = (_592 + (_589 * ((_1167 - (_1167 * exp((-_1168) * _456))) / _1168))) + (_589 * ((_1184 - (_1184 * _1188)) / _1185));
                        float3 _1194 = _589 * _1188;
                        if (all(_1194 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _1205 = _1194;
                            _1206 = _1193;
                            _1207 = _1158;
                            _1208 = _1159;
                            break;
                        }
                        _590 = _1194;
                        _593 = _1193;
                        _595 = _1159;
                        _597 = _1158;
                        _599 = _598 + _455;
                        _1204 = _600;
                        uint _601 = _1204 + 1u;
                        _589 = _590;
                        _592 = _593;
                        _594 = _595;
                        _596 = _597;
                        _598 = _599;
                        _600 = _601;
                        continue;
                    }
                    else
                    {
                        _1205 = _589;
                        _1206 = _592;
                        _1207 = _596;
                        _1208 = _594;
                        break;
                    }
                }
                bool _1209 = View.View_RealTimeReflectionCapture != 0.0;
                float _1214 = (_1208 == 0.0) ? _439 : (_1207 / fast::max(1.0000000133514319600180897396058e-10, _1208));
                float3 _1216 = View.View_WorldCameraOrigin + (_268 * _1214);
                float4 _1221 = View.View_WorldToClip * float4(_1216, 1.0);
                float _1222 = dot(_1205, float3(0.3333333432674407958984375));
                bool _1226 = _1208 > 0.0;
                float3 _1299;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1226)
                {
                    float3 _1238 = (_1216 * 9.9999997473787516355514526367188e-06) - _267;
                    float _1244 = sqrt((fast::max(0.0, length(_1238) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                    float _1245 = _1244 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                    float _1252;
                    if (_1245 < 0.707106769084930419921875)
                    {
                        _1252 = fast::clamp((_1245 * _1245) * 2.0, 0.0, 1.0);
                    }
                    else
                    {
                        _1252 = 1.0;
                    }
                    float2 _1280;
                    if (_1209)
                    {
                        float3 _1255 = normalize(_1238);
                        float _1256 = _1255.z;
                        float _1259 = sqrt(1.0 - (_1256 * _1256));
                        float2 _1262 = _177;
                        _1262.y = (_1256 * 0.5) + 0.5;
                        float _1267 = acos(_1255.x / _1259);
                        float2 _1272 = _1262;
                        _1272.x = (((_1255.y / _1259) < 0.0) ? (6.283185482025146484375 - _1267) : _1267) * 0.15915493667125701904296875;
                        _1280 = (_1272 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                    }
                    else
                    {
                        _1280 = ((_1221.xy / _1221.ww) * float2(0.5, -0.5)) + float2(0.5);
                    }
                    float4 _1285 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1280, _1244), level(0.0));
                    _1299 = (((_1285.xyz * _1252).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1222)) + (_1206 * (1.0 - (_1252 * (1.0 - _1285.w))));
                }
                else
                {
                    _1299 = _1206;
                }
                float3 _1546;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1226)
                {
                    float3 _1306 = _1216 - View.View_WorldCameraOrigin;
                    float _1323 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                    float _1326 = _1306.z + (View.View_WorldCameraOrigin.z - _1323);
                    float3 _1327 = _1306;
                    _1327.z = _1326;
                    float _1328 = dot(_1327, _1327);
                    float _1329 = rsqrt(_1328);
                    float _1330 = _1328 * _1329;
                    float _1338 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1306) / dot(_1306, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                    float _1372;
                    float _1373;
                    float _1374;
                    float _1375;
                    if (_1338 > 0.0)
                    {
                        float _1342 = _1338 * _1329;
                        float _1343 = _1342 * _1326;
                        float _1344 = _1323 + _1343;
                        _1372 = (1.0 - _1342) * _1330;
                        _1373 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1344 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                        _1374 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1344 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                        _1375 = _1326 - _1343;
                    }
                    else
                    {
                        _1372 = _1330;
                        _1373 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                        _1374 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                        _1375 = _1326;
                    }
                    float _1379 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1375);
                    float _1393 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1375);
                    float _1404 = (_1374 * ((abs(_1379) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1379)) / _1379) : (0.693147182464599609375 - (0.2402265071868896484375 * _1379)))) + (_1373 * ((abs(_1393) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1393)) / _1393) : (0.693147182464599609375 - (0.2402265071868896484375 * _1393))));
                    float3 _1446;
                    if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                    {
                        float2 _1431 = float2(dot(_1327.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1327.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                        float3 _1432 = float3(_1431.x, _1431.y, _1327.z);
                        _1446 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1432, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1432, level(0.0)).xyz, float3(fast::clamp((_1330 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                    }
                    else
                    {
                        _1446 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                    }
                    float3 _1474;
                    if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                    {
                        _1474 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1327 * _1329, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1404 * fast::max(_1372 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                    }
                    else
                    {
                        _1474 = float3(0.0);
                    }
                    bool _1483 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1330 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                    float _1486 = _1483 ? 1.0 : fast::max(fast::clamp(exp2(-(_1404 * _1372)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                    float4 _1493 = float4((_1446 * (1.0 - _1486)) + select(_1474, float3(0.0), bool3(_1483)), _1486);
                    bool _1496 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                    float4 _1539;
                    if (_1496)
                    {
                        float _1499 = _1221.w;
                        float4 _1528;
                        if (_1496)
                        {
                            _1528 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1221.xy / float2(_1499)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1499 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                        }
                        else
                        {
                            _1528 = float4(0.0, 0.0, 0.0, 1.0);
                        }
                        _1539 = float4(_1528.xyz + (_1493.xyz * _1528.w), _1528.w * _1486);
                    }
                    else
                    {
                        _1539 = _1493;
                    }
                    _1546 = (_1539.xyz * (1.0 - _1222)) + (_1299 * _1539.w);
                }
                else
                {
                    _1546 = _1299;
                }
                float _1550 = (_1222 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1222;
                float2 _1556 = _404;
                _1556.x = 65504.0;
                float2 _1564;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1563 = _1556;
                    _1563.x = ((_1550 > 0.9900000095367431640625) ? _439 : _1214) * 9.9999997473787516355514526367188e-06;
                    _1564 = _1563;
                }
                else
                {
                    _1564 = _1556;
                }
                _1565 = _1564;
                _1566 = float4(_1546 * (_1209 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1550);
                break;
            }
        }
        if (_Globals.TargetCubeFace >= 0)
        {
            uint3 _1595 = uint3(gl_GlobalInvocationID.xy, uint(_Globals.TargetCubeFace));
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1604 = OutCloudColorCube.read(uint2(_1595.xy), uint(_1595.z));
                OutCloudColorCube.write(spvIdentity(float4((_1604.xyz * _1566.w) + _1566.xyz, _1604.w * _1566.w)), uint2(_1595.xy), uint(_1595.z));
            }
            else
            {
                OutCloudColorCube.write(spvIdentity(_1566), uint2(_1595.xy), uint(_1595.z));
            }
        }
        else
        {
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1581 = OutCloudColor.read(uint2(gl_GlobalInvocationID.xy));
                OutCloudColor.write(spvIdentity(float4((_1581.xyz * _1566.w) + _1566.xyz, _1581.w * _1566.w)), uint2(gl_GlobalInvocationID.xy));
            }
            else
            {
                OutCloudColor.write(spvIdentity(_1566), uint2(gl_GlobalInvocationID.xy));
            }
        }
        OutCloudDepth.write(spvIdentity(_1565.xyyy), uint2(gl_GlobalInvocationID.xy));
    }
}

