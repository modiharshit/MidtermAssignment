

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

struct type_Globals
{
    char _m0_pad[16];
    float4 OutputViewRect;
    int bBlendCloudColor;
    int TargetCubeFace;
};

constant float _174 = {};
constant float3 _176 = {};
constant uint3 _177 = {};
constant float4 _178 = {};
constant float2 _179 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000ce4a_70ef263b(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_TransmittanceLutTexture [[texture(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(6)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(7)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(8)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(9)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(10)]], texture2d<float> Material_Texture2D_0 [[texture(11)]], texture2d<float> Material_Texture2D_1 [[texture(12)]], texture3d<float> Material_VolumeTexture_0 [[texture(13)]], texture3d<float> Material_VolumeTexture_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(5)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(6)]], sampler Material_Texture2D_0Sampler [[sampler(7)]], sampler Material_Texture2D_1Sampler [[sampler(8)]], sampler Material_VolumeTexture_0Sampler [[sampler(9)]], sampler Material_VolumeTexture_1Sampler [[sampler(10)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _221 = float(gl_GlobalInvocationID.x) + 0.5;
        float _224 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _225 = float4(_221, _224, 0.5, 1.0);
        float2 _1494;
        float4 _1495;
        switch (0u)
        {
            default:
            {
                float _286;
                float _292;
                float4 _264 = View.View_SVPositionToTranslatedWorld * _225;
                float3 _271 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _272 = -normalize(-(_264.xyz / float3(_264.w)));
                float2 _306;
                bool _307;
                switch (0u)
                {
                    default:
                    {
                        float3 _284 = _271 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _286 = dot(_272, _272);
                        float _287 = dot(_272, _284);
                        float _288 = 2.0 * _287;
                        _292 = 4.0 * _286;
                        float _294 = (_288 * _288) - (_292 * (dot(_284, _284) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_294 >= 0.0)
                        {
                            _306 = (float2(_287 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_294))) / float2(2.0 * _286);
                            _307 = true;
                            break;
                        }
                        _306 = float2(0.0);
                        _307 = false;
                        break;
                    }
                }
                float _312;
                float _364;
                float _365;
                if (_307)
                {
                    _312 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _337;
                    bool _338;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _317 = _271 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _312).xyz;
                            float _319 = dot(_272, _317);
                            float _320 = 2.0 * _319;
                            float _325 = (_320 * _320) - (_292 * (dot(_317, _317) - (_312 * _312)));
                            if (_325 >= 0.0)
                            {
                                _337 = (float2(_319 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_325))) / float2(2.0 * _286);
                                _338 = true;
                                break;
                            }
                            _337 = float2(0.0);
                            _338 = false;
                            break;
                        }
                    }
                    if (_338)
                    {
                        float _348 = fast::min(_306.x, _306.y);
                        bool _352 = all(_337 > float2(0.0));
                        float _357 = _352 ? fast::min(_337.x, _337.y) : fast::max(_337.x, _337.y);
                        float _361;
                        if (_352)
                        {
                            _361 = fast::max(0.0, _348);
                        }
                        else
                        {
                            _361 = all(_306 > float2(0.0)) ? _348 : fast::max(_306.x, _306.y);
                        }
                        _364 = fast::max(_357, _361);
                        _365 = fast::min(_357, _361);
                    }
                    else
                    {
                        _364 = _306.y;
                        _365 = _306.x;
                    }
                }
                else
                {
                    _1494 = float2(65504.0);
                    _1495 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _367 = fast::max(0.0, _365) * 100000.0;
                float _369 = fast::max(0.0, _364) * 100000.0;
                if ((_369 <= _367) || (_367 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1494 = float2(65504.0);
                    _1495 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _389 = int3(uint3((uint2(_225.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _397 = View.View_SVPositionToTranslatedWorld * float4(_221, _224, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_389.xy), _389.z).x), 1.0);
                float _406 = length(((_397.xyz / float3(_397.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _408 = float2(65504.0);
                _408.y = _406 * 9.9999997473787516355514526367188e-06;
                bool _411 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_411 && (_406 < _367))
                {
                    _1494 = _408;
                    _1495 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _419;
                if (_411)
                {
                    _419 = fast::min(_369, _406);
                }
                else
                {
                    _419 = _369;
                }
                float3 _429 = View.View_AtmosphereLightColor[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
                float _436 = _367 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _419 - _367);
                float _443 = _436 - _367;
                uint _450 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_443 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _452 = _443 / float(_450);
                float _453 = _452 * 0.00999999977648258209228515625;
                float3 _481;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _480;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _480 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _465 = _176;
                        _465.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _469 = _465;
                        _469.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _473 = _469;
                        _473.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _480 = fast::max(float3(0.0), _473);
                    }
                    _481 = _480;
                }
                else
                {
                    _481 = float3(0.0);
                }
                float _487 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _498 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _499 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _501 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _272);
                float _502 = _498 * _498;
                float _507 = (1.0 + _502) + ((2.0 * _498) * _501);
                float _511 = (1.0 - _502) / ((12.56637096405029296875 * _507) * sqrt(_507));
                float _512 = _499 * _499;
                float _517 = (1.0 + _512) + ((2.0 * _499) * _501);
                float _524 = _511 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _512) / ((12.56637096405029296875 * _517) * sqrt(_517))) - _511));
                float3 _526 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _527 = _312 * 100000.0;
                float _530 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _527);
                float _566;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _546 = (uint3(int3(int(_221), int(_224), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _547 = _546.y;
                    uint _548 = _546.z;
                    uint _551 = _546.x + (_547 * _548);
                    uint _553 = _547 + (_548 * _551);
                    uint3 _558 = _177;
                    _558.x = _551 + (_553 * (_548 + (_551 * _553)));
                    _566 = _367 + ((float((_558 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _452);
                }
                else
                {
                    _566 = _367 + (0.5 * _452);
                }
                float3 _568;
                float3 _571;
                _568 = float3(1.0);
                _571 = float3(0.0);
                float3 _569;
                float3 _572;
                float _574;
                float _576;
                float _578;
                uint _1133;
                float3 _1134;
                float3 _1135;
                float _1136;
                float _1137;
                float _573 = 0.0;
                float _575 = 0.0;
                float _577 = _566;
                uint _579 = 0u;
                for (;;)
                {
                    if (_579 < _450)
                    {
                        float3 _584 = _272 * _577;
                        float3 _585 = View.View_WorldCameraOrigin + _584;
                        float _590 = fast::clamp((length(_585 - _526) - _527) * _530, 0.0, 1.0);
                        float4 _600 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_585 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _601 = _600.y;
                        float _617 = ((_590 < 0.0500000007450580596923828125) || (_590 > 0.949999988079071044921875)) ? 0.0 : (_600.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_601 <= 0.0) ? 0.0 : pow(_601, 0.25), 1.0 - _590), level(-1.0)).x);
                        if (_617 <= 0.0)
                        {
                            _569 = _568;
                            _572 = _571;
                            _574 = _573;
                            _576 = _575;
                            _578 = _577 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _452);
                            _1133 = _579 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _580 = _1133 + 1u;
                            _568 = _569;
                            _571 = _572;
                            _573 = _574;
                            _575 = _576;
                            _577 = _578;
                            _579 = _580;
                            continue;
                        }
                        float3 _635 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _636 = _635 * 0.1500000059604644775390625;
                        float3 _639 = _585 * Material.Material_ScalarExpressions[0].x;
                        float4 _647 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_636 + _639) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _650 = _647.x;
                        float _654 = _647.y;
                        float _658 = _647.z;
                        float3 _664 = float3(_617) * fast::clamp(float3((_650 <= 0.0) ? 0.0 : pow(_650, Material.Material_ScalarExpressions[0].z), (_654 <= 0.0) ? 0.0 : pow(_654, Material.Material_ScalarExpressions[0].z), (_658 <= 0.0) ? 0.0 : pow(_658, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _665 = _635 * (-0.100000001490116119384765625);
                        float4 _673 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_639 + _665) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _674 = _673.x;
                        float _682 = ((_674 <= 0.0) ? 0.0 : pow(_674, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _687 = float3(Material.Material_ScalarExpressions[1].w);
                        float _694 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _700 = fast::clamp(_590 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _709 = mix(_664, float3((_687 + (fast::clamp((_664 - float3(_682)) / float3(Material.Material_ScalarExpressions[1].z - _682), float3(0.0), float3(1.0)) * _694)).x), float3((_700 <= 0.0) ? 0.0 : pow(_700, Material.Material_ScalarExpressions[2].y)));
                        float3 _717 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _709) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _720 = _717.x;
                        float _724 = _717.y;
                        float _728 = _717.z;
                        float3 _742 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _709, _174).xyz, float3(0.0), float3(65000.0));
                        float3 _747 = (_585 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                        float3 _815;
                        switch (0u)
                        {
                            default:
                            {
                                float3 _754 = _747 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                                float _756 = dot(View.View_AtmosphereLightDirection[0u].xyz, View.View_AtmosphereLightDirection[0u].xyz);
                                float _757 = dot(View.View_AtmosphereLightDirection[0u].xyz, _754);
                                float _758 = 2.0 * _757;
                                float _759 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                                float _764 = (_758 * _758) - ((4.0 * _756) * (dot(_754, _754) - _759));
                                float2 _776;
                                if (_764 >= 0.0)
                                {
                                    _776 = (float2(_757 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_764))) / float2(2.0 * _756);
                                }
                                else
                                {
                                    _776 = float2(-1.0);
                                }
                                if ((_776.x > 0.0) || (_776.y > 0.0))
                                {
                                    _815 = float3(0.0);
                                    break;
                                }
                                float _784 = length(_747);
                                float _787 = dot(View.View_AtmosphereLightDirection[0u].xyz, _747 / float3(_784));
                                float _788 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                                float _791 = sqrt(fast::max(0.0, _788 - _759));
                                float _792 = _784 * _784;
                                float _795 = sqrt(fast::max(0.0, _792 - _759));
                                float _805 = View.View_SkyAtmosphereTopRadiusKm - _784;
                                _815 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_784) * _787) + sqrt((_792 * ((_787 * _787) - 1.0)) + _788)) - _805) / ((_795 + _791) - _805), _795 / _791), level(0.0)).xyz;
                                break;
                            }
                        }
                        float3 _816 = fast::clamp(fast::clamp(float3((_720 <= 0.0) ? 0.0 : pow(_720, Material.Material_ScalarExpressions[2].w), (_724 <= 0.0) ? 0.0 : pow(_724, Material.Material_ScalarExpressions[2].w), (_728 <= 0.0) ? 0.0 : pow(_728, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _742;
                        float3 _1079;
                        float3 _1080;
                        if (any(_816 > float3(0.0)))
                        {
                            float _904;
                            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                            {
                                float4 _839 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_585, 1.0);
                                float2 _843 = _839.xy / float2(_839.w);
                                bool2 _844 = _843 >= float2(0.0);
                                bool2 _845 = _843 <= float2(1.0);
                                float _903;
                                if (all(bool2(_844.x && _845.x, _844.y && _845.y)))
                                {
                                    float2 _857 = (_843 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                    float2 _858 = fract(_857);
                                    float2 _859 = floor(_857);
                                    float4 _867 = _178;
                                    _867.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_859 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _873 = _867;
                                    _873.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_859 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _879 = _873;
                                    _879.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_859 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _884 = _879;
                                    _884.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_859 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _894 = fast::clamp(fast::clamp((_884 * 40.0) - float4((_839.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _884 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                    float2 _898 = mix(_894.wx, _894.zy, _858.xx);
                                    _903 = mix(_898.x, _898.y, _858.y);
                                }
                                else
                                {
                                    _903 = 1.0;
                                }
                                _904 = _903;
                            }
                            else
                            {
                                _904 = 1.0;
                            }
                            float4 _911 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_585, 1.0);
                            float2 _915 = _911.xy / float2(_911.w);
                            bool2 _919 = _915 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                            bool2 _921 = _915 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                            float _941;
                            if (all(bool2(_919.x && _921.x, _919.y && _921.y)))
                            {
                                float4 _929 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _915, level(0.0));
                                float _930 = _929.x;
                                _941 = fast::clamp(float(_911.z < (_930 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_930 == 1.0), 0.0, 1.0);
                            }
                            else
                            {
                                _941 = 1.0;
                            }
                            float _952 = fast::clamp((dot(_585 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                            float3 _956 = _815 * fast::min(_904, mix(_941, 1.0, _952 * _952));
                            float _962 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _963 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _965;
                            float3 _968;
                            _965 = float3(0.0);
                            _968 = float3(0.0);
                            float _971;
                            float3 _966;
                            float3 _969;
                            for (float _970 = 0.0, _972 = _962; _972 <= 1.0; _965 = _966, _968 = _969, _970 = _971, _972 += _962)
                            {
                                _971 = _972 * _972;
                                float _977 = _971 - _970;
                                float3 _982 = _585 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_970 + (_977 * 0.5))));
                                float _987 = fast::clamp((length(_982 - _526) - _527) * _530, 0.0, 1.0);
                                float4 _993 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_982 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _994 = _993.y;
                                float _1008 = ((_987 < 0.0500000007450580596923828125) || (_987 > 0.949999988079071044921875)) ? 0.0 : (_993.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_994 <= 0.0) ? 0.0 : pow(_994, 0.25), 1.0 - _987), level(-1.0)).x);
                                if (_1008 <= 0.0)
                                {
                                    _966 = _965;
                                    _969 = _968;
                                    continue;
                                }
                                float3 _1013 = _982 * Material.Material_ScalarExpressions[0].x;
                                float4 _1017 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_636 + _1013) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _1018 = _1017.x;
                                float _1022 = _1017.y;
                                float _1026 = _1017.z;
                                float3 _1032 = float3(_1008) * fast::clamp(float3((_1018 <= 0.0) ? 0.0 : pow(_1018, Material.Material_ScalarExpressions[0].z), (_1022 <= 0.0) ? 0.0 : pow(_1022, Material.Material_ScalarExpressions[0].z), (_1026 <= 0.0) ? 0.0 : pow(_1026, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _1036 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1013 + _665) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _1037 = _1036.x;
                                float _1041 = ((_1037 <= 0.0) ? 0.0 : pow(_1037, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _1051 = fast::clamp(_987 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _1065 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1032, float3((_687 + (fast::clamp((_1032 - float3(_1041)) / float3(Material.Material_ScalarExpressions[1].z - _1041), float3(0.0), float3(1.0)) * _694)).x), float3((_1051 <= 0.0) ? 0.0 : pow(_1051, Material.Material_ScalarExpressions[2].y))), _174).xyz, float3(0.0), float3(65000.0));
                                _966 = _965 + ((_1065 * _487) * _977);
                                _969 = _968 + (_1065 * _977);
                            }
                            _1079 = _956 * exp((-_968) * _963);
                            _1080 = _956 * exp((-_965) * _963);
                        }
                        else
                        {
                            _1079 = _815;
                            _1080 = _815;
                        }
                        float _1093;
                        float _1094;
                        if (any(_742 > float3(0.0)))
                        {
                            float _1089 = fast::min(_568.x, fast::min(_568.y, _568.z));
                            _1093 = _575 + (_577 * _1089);
                            _1094 = _573 + _1089;
                        }
                        else
                        {
                            _1093 = _575;
                            _1094 = _573;
                        }
                        float3 _1099 = (((_1080 * _429) * mix(0.079577468335628509521484375, _524, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_816 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _1100 = fast::max(float3(9.9999999747524270787835121154785e-07), _742 * _487);
                        float3 _1113 = (((_1079 * _429) * _524) + (_481 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _590, 0.0, 1.0)).xyz) * _816;
                        float3 _1114 = fast::max(float3(9.9999999747524270787835121154785e-07), _742);
                        float3 _1117 = exp((-_1114) * _453);
                        float3 _1122 = (_571 + (_568 * ((_1099 - (_1099 * exp((-_1100) * _453))) / _1100))) + (_568 * ((_1113 - (_1113 * _1117)) / _1114));
                        float3 _1123 = _568 * _1117;
                        if (all(_1123 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _1134 = _1123;
                            _1135 = _1122;
                            _1136 = _1093;
                            _1137 = _1094;
                            break;
                        }
                        _569 = _1123;
                        _572 = _1122;
                        _574 = _1094;
                        _576 = _1093;
                        _578 = _577 + _452;
                        _1133 = _579;
                        uint _580 = _1133 + 1u;
                        _568 = _569;
                        _571 = _572;
                        _573 = _574;
                        _575 = _576;
                        _577 = _578;
                        _579 = _580;
                        continue;
                    }
                    else
                    {
                        _1134 = _568;
                        _1135 = _571;
                        _1136 = _575;
                        _1137 = _573;
                        break;
                    }
                }
                bool _1138 = View.View_RealTimeReflectionCapture != 0.0;
                float _1143 = (_1137 == 0.0) ? _436 : (_1136 / fast::max(1.0000000133514319600180897396058e-10, _1137));
                float3 _1145 = View.View_WorldCameraOrigin + (_272 * _1143);
                float4 _1150 = View.View_WorldToClip * float4(_1145, 1.0);
                float _1151 = dot(_1134, float3(0.3333333432674407958984375));
                bool _1155 = _1137 > 0.0;
                float3 _1228;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1155)
                {
                    float3 _1167 = (_1145 * 9.9999997473787516355514526367188e-06) - _271;
                    float _1173 = sqrt((fast::max(0.0, length(_1167) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                    float _1174 = _1173 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                    float _1181;
                    if (_1174 < 0.707106769084930419921875)
                    {
                        _1181 = fast::clamp((_1174 * _1174) * 2.0, 0.0, 1.0);
                    }
                    else
                    {
                        _1181 = 1.0;
                    }
                    float2 _1209;
                    if (_1138)
                    {
                        float3 _1184 = normalize(_1167);
                        float _1185 = _1184.z;
                        float _1188 = sqrt(1.0 - (_1185 * _1185));
                        float2 _1191 = _179;
                        _1191.y = (_1185 * 0.5) + 0.5;
                        float _1196 = acos(_1184.x / _1188);
                        float2 _1201 = _1191;
                        _1201.x = (((_1184.y / _1188) < 0.0) ? (6.283185482025146484375 - _1196) : _1196) * 0.15915493667125701904296875;
                        _1209 = (_1201 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                    }
                    else
                    {
                        _1209 = ((_1150.xy / _1150.ww) * float2(0.5, -0.5)) + float2(0.5);
                    }
                    float4 _1214 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1209, _1173), level(0.0));
                    _1228 = (((_1214.xyz * _1181).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1151)) + (_1135 * (1.0 - (_1181 * (1.0 - _1214.w))));
                }
                else
                {
                    _1228 = _1135;
                }
                float3 _1475;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1155)
                {
                    float3 _1235 = _1145 - View.View_WorldCameraOrigin;
                    float _1252 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                    float _1255 = _1235.z + (View.View_WorldCameraOrigin.z - _1252);
                    float3 _1256 = _1235;
                    _1256.z = _1255;
                    float _1257 = dot(_1256, _1256);
                    float _1258 = rsqrt(_1257);
                    float _1259 = _1257 * _1258;
                    float _1267 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1235) / dot(_1235, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                    float _1301;
                    float _1302;
                    float _1303;
                    float _1304;
                    if (_1267 > 0.0)
                    {
                        float _1271 = _1267 * _1258;
                        float _1272 = _1271 * _1255;
                        float _1273 = _1252 + _1272;
                        _1301 = (1.0 - _1271) * _1259;
                        _1302 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1273 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                        _1303 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1273 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                        _1304 = _1255 - _1272;
                    }
                    else
                    {
                        _1301 = _1259;
                        _1302 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                        _1303 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                        _1304 = _1255;
                    }
                    float _1308 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1304);
                    float _1322 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1304);
                    float _1333 = (_1303 * ((abs(_1308) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1308)) / _1308) : (0.693147182464599609375 - (0.2402265071868896484375 * _1308)))) + (_1302 * ((abs(_1322) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1322)) / _1322) : (0.693147182464599609375 - (0.2402265071868896484375 * _1322))));
                    float3 _1375;
                    if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                    {
                        float2 _1360 = float2(dot(_1256.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1256.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                        float3 _1361 = float3(_1360.x, _1360.y, _1256.z);
                        _1375 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1361, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1361, level(0.0)).xyz, float3(fast::clamp((_1259 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                    }
                    else
                    {
                        _1375 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                    }
                    float3 _1403;
                    if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                    {
                        _1403 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1256 * _1258, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1333 * fast::max(_1301 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                    }
                    else
                    {
                        _1403 = float3(0.0);
                    }
                    bool _1412 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1259 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                    float _1415 = _1412 ? 1.0 : fast::max(fast::clamp(exp2(-(_1333 * _1301)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                    float4 _1422 = float4((_1375 * (1.0 - _1415)) + select(_1403, float3(0.0), bool3(_1412)), _1415);
                    bool _1425 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                    float4 _1468;
                    if (_1425)
                    {
                        float _1428 = _1150.w;
                        float4 _1457;
                        if (_1425)
                        {
                            _1457 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1150.xy / float2(_1428)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1428 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                        }
                        else
                        {
                            _1457 = float4(0.0, 0.0, 0.0, 1.0);
                        }
                        _1468 = float4(_1457.xyz + (_1422.xyz * _1457.w), _1457.w * _1415);
                    }
                    else
                    {
                        _1468 = _1422;
                    }
                    _1475 = (_1468.xyz * (1.0 - _1151)) + (_1228 * _1468.w);
                }
                else
                {
                    _1475 = _1228;
                }
                float _1479 = (_1151 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1151;
                float2 _1485 = _408;
                _1485.x = 65504.0;
                float2 _1493;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1492 = _1485;
                    _1492.x = ((_1479 > 0.9900000095367431640625) ? _436 : _1143) * 9.9999997473787516355514526367188e-06;
                    _1493 = _1492;
                }
                else
                {
                    _1493 = _1485;
                }
                _1494 = _1493;
                _1495 = float4(_1475 * (_1138 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1479);
                break;
            }
        }
        if (_Globals.TargetCubeFace >= 0)
        {
            uint3 _1524 = uint3(gl_GlobalInvocationID.xy, uint(_Globals.TargetCubeFace));
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1533 = OutCloudColorCube.read(uint2(_1524.xy), uint(_1524.z));
                OutCloudColorCube.write(spvIdentity(float4((_1533.xyz * _1495.w) + _1495.xyz, _1533.w * _1495.w)), uint2(_1524.xy), uint(_1524.z));
            }
            else
            {
                OutCloudColorCube.write(spvIdentity(_1495), uint2(_1524.xy), uint(_1524.z));
            }
        }
        else
        {
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1510 = OutCloudColor.read(uint2(gl_GlobalInvocationID.xy));
                OutCloudColor.write(spvIdentity(float4((_1510.xyz * _1495.w) + _1495.xyz, _1510.w * _1495.w)), uint2(gl_GlobalInvocationID.xy));
            }
            else
            {
                OutCloudColor.write(spvIdentity(_1495), uint2(gl_GlobalInvocationID.xy));
            }
        }
        OutCloudDepth.write(spvIdentity(_1494.xyyy), uint2(gl_GlobalInvocationID.xy));
    }
}

