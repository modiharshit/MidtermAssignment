

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

struct type_Globals
{
    float4 OutputViewRect;
    int bBlendCloudColor;
    int TargetCubeFace;
};

constant float _160 = {};
constant float3 _162 = {};
constant uint3 _163 = {};
constant float2 _164 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000b647_bf63c3d6(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_TransmittanceLutTexture [[texture(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(6)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(7)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], texture3d<float> Material_VolumeTexture_0 [[texture(11)]], texture3d<float> Material_VolumeTexture_1 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(4)]], sampler Material_Texture2D_0Sampler [[sampler(5)]], sampler Material_Texture2D_1Sampler [[sampler(6)]], sampler Material_VolumeTexture_0Sampler [[sampler(7)]], sampler Material_VolumeTexture_1Sampler [[sampler(8)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _201 = float(gl_GlobalInvocationID.x) + 0.5;
        float _204 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _205 = float4(_201, _204, 0.5, 1.0);
        float2 _1345;
        float4 _1346;
        switch (0u)
        {
            default:
            {
                float _266;
                float _272;
                float4 _244 = View.View_SVPositionToTranslatedWorld * _205;
                float3 _251 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _252 = -normalize(-(_244.xyz / float3(_244.w)));
                float2 _286;
                bool _287;
                switch (0u)
                {
                    default:
                    {
                        float3 _264 = _251 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _266 = dot(_252, _252);
                        float _267 = dot(_252, _264);
                        float _268 = 2.0 * _267;
                        _272 = 4.0 * _266;
                        float _274 = (_268 * _268) - (_272 * (dot(_264, _264) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_274 >= 0.0)
                        {
                            _286 = (float2(_267 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_274))) / float2(2.0 * _266);
                            _287 = true;
                            break;
                        }
                        _286 = float2(0.0);
                        _287 = false;
                        break;
                    }
                }
                float _292;
                float _344;
                float _345;
                if (_287)
                {
                    _292 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _317;
                    bool _318;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _297 = _251 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _292).xyz;
                            float _299 = dot(_252, _297);
                            float _300 = 2.0 * _299;
                            float _305 = (_300 * _300) - (_272 * (dot(_297, _297) - (_292 * _292)));
                            if (_305 >= 0.0)
                            {
                                _317 = (float2(_299 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_305))) / float2(2.0 * _266);
                                _318 = true;
                                break;
                            }
                            _317 = float2(0.0);
                            _318 = false;
                            break;
                        }
                    }
                    if (_318)
                    {
                        float _328 = fast::min(_286.x, _286.y);
                        bool _332 = all(_317 > float2(0.0));
                        float _337 = _332 ? fast::min(_317.x, _317.y) : fast::max(_317.x, _317.y);
                        float _341;
                        if (_332)
                        {
                            _341 = fast::max(0.0, _328);
                        }
                        else
                        {
                            _341 = all(_286 > float2(0.0)) ? _328 : fast::max(_286.x, _286.y);
                        }
                        _344 = fast::max(_337, _341);
                        _345 = fast::min(_337, _341);
                    }
                    else
                    {
                        _344 = _286.y;
                        _345 = _286.x;
                    }
                }
                else
                {
                    _1345 = float2(65504.0);
                    _1346 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _347 = fast::max(0.0, _345) * 100000.0;
                float _349 = fast::max(0.0, _344) * 100000.0;
                if ((_349 <= _347) || (_347 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1345 = float2(65504.0);
                    _1346 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _369 = int3(uint3((uint2(_205.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _377 = View.View_SVPositionToTranslatedWorld * float4(_201, _204, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_369.xy), _369.z).x), 1.0);
                float _386 = length(((_377.xyz / float3(_377.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _388 = float2(65504.0);
                _388.y = _386 * 9.9999997473787516355514526367188e-06;
                bool _391 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_391 && (_386 < _347))
                {
                    _1345 = _388;
                    _1346 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _399;
                if (_391)
                {
                    _399 = fast::min(_349, _386);
                }
                else
                {
                    _399 = _349;
                }
                float3 _409 = View.View_AtmosphereLightColor[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
                float _416 = _347 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _399 - _347);
                float _423 = _416 - _347;
                uint _430 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_423 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _432 = _423 / float(_430);
                float _433 = _432 * 0.00999999977648258209228515625;
                float3 _461;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _460;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _460 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _445 = _162;
                        _445.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _449 = _445;
                        _449.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _453 = _449;
                        _453.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _460 = fast::max(float3(0.0), _453);
                    }
                    _461 = _460;
                }
                else
                {
                    _461 = float3(0.0);
                }
                float _467 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _478 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _479 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _481 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _252);
                float _482 = _478 * _478;
                float _487 = (1.0 + _482) + ((2.0 * _478) * _481);
                float _491 = (1.0 - _482) / ((12.56637096405029296875 * _487) * sqrt(_487));
                float _492 = _479 * _479;
                float _497 = (1.0 + _492) + ((2.0 * _479) * _481);
                float _504 = _491 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _492) / ((12.56637096405029296875 * _497) * sqrt(_497))) - _491));
                float3 _506 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _507 = _292 * 100000.0;
                float _510 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _507);
                float _546;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _526 = (uint3(int3(int(_201), int(_204), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _527 = _526.y;
                    uint _528 = _526.z;
                    uint _531 = _526.x + (_527 * _528);
                    uint _533 = _527 + (_528 * _531);
                    uint3 _538 = _163;
                    _538.x = _531 + (_533 * (_528 + (_531 * _533)));
                    _546 = _347 + ((float((_538 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _432);
                }
                else
                {
                    _546 = _347 + (0.5 * _432);
                }
                float3 _548;
                float3 _551;
                _548 = float3(1.0);
                _551 = float3(0.0);
                float3 _549;
                float3 _552;
                float _554;
                float _556;
                float _558;
                uint _984;
                float3 _985;
                float3 _986;
                float _987;
                float _988;
                float _553 = 0.0;
                float _555 = 0.0;
                float _557 = _546;
                uint _559 = 0u;
                for (;;)
                {
                    if (_559 < _430)
                    {
                        float3 _564 = _252 * _557;
                        float3 _565 = View.View_WorldCameraOrigin + _564;
                        float _570 = fast::clamp((length(_565 - _506) - _507) * _510, 0.0, 1.0);
                        float4 _580 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_565 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _581 = _580.y;
                        float _597 = ((_570 < 0.0500000007450580596923828125) || (_570 > 0.949999988079071044921875)) ? 0.0 : (_580.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_581 <= 0.0) ? 0.0 : pow(_581, 0.25), 1.0 - _570), level(-1.0)).x);
                        if (_597 <= 0.0)
                        {
                            _549 = _548;
                            _552 = _551;
                            _554 = _553;
                            _556 = _555;
                            _558 = _557 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _432);
                            _984 = _559 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _560 = _984 + 1u;
                            _548 = _549;
                            _551 = _552;
                            _553 = _554;
                            _555 = _556;
                            _557 = _558;
                            _559 = _560;
                            continue;
                        }
                        float3 _615 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _616 = _615 * 0.1500000059604644775390625;
                        float3 _619 = _565 * Material.Material_ScalarExpressions[0].x;
                        float4 _627 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_616 + _619) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _630 = _627.x;
                        float _634 = _627.y;
                        float _638 = _627.z;
                        float3 _644 = float3(_597) * fast::clamp(float3((_630 <= 0.0) ? 0.0 : pow(_630, Material.Material_ScalarExpressions[0].z), (_634 <= 0.0) ? 0.0 : pow(_634, Material.Material_ScalarExpressions[0].z), (_638 <= 0.0) ? 0.0 : pow(_638, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _645 = _615 * (-0.100000001490116119384765625);
                        float4 _653 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_619 + _645) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _654 = _653.x;
                        float _662 = ((_654 <= 0.0) ? 0.0 : pow(_654, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _667 = float3(Material.Material_ScalarExpressions[1].w);
                        float _674 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _680 = fast::clamp(_570 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _689 = mix(_644, float3((_667 + (fast::clamp((_644 - float3(_662)) / float3(Material.Material_ScalarExpressions[1].z - _662), float3(0.0), float3(1.0)) * _674)).x), float3((_680 <= 0.0) ? 0.0 : pow(_680, Material.Material_ScalarExpressions[2].y)));
                        float3 _697 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _689) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _700 = _697.x;
                        float _704 = _697.y;
                        float _708 = _697.z;
                        float3 _722 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _689, _160).xyz, float3(0.0), float3(65000.0));
                        float3 _727 = (_565 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                        float3 _795;
                        switch (0u)
                        {
                            default:
                            {
                                float3 _734 = _727 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                                float _736 = dot(View.View_AtmosphereLightDirection[0u].xyz, View.View_AtmosphereLightDirection[0u].xyz);
                                float _737 = dot(View.View_AtmosphereLightDirection[0u].xyz, _734);
                                float _738 = 2.0 * _737;
                                float _739 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                                float _744 = (_738 * _738) - ((4.0 * _736) * (dot(_734, _734) - _739));
                                float2 _756;
                                if (_744 >= 0.0)
                                {
                                    _756 = (float2(_737 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_744))) / float2(2.0 * _736);
                                }
                                else
                                {
                                    _756 = float2(-1.0);
                                }
                                if ((_756.x > 0.0) || (_756.y > 0.0))
                                {
                                    _795 = float3(0.0);
                                    break;
                                }
                                float _764 = length(_727);
                                float _767 = dot(View.View_AtmosphereLightDirection[0u].xyz, _727 / float3(_764));
                                float _768 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                                float _771 = sqrt(fast::max(0.0, _768 - _739));
                                float _772 = _764 * _764;
                                float _775 = sqrt(fast::max(0.0, _772 - _739));
                                float _785 = View.View_SkyAtmosphereTopRadiusKm - _764;
                                _795 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_764) * _767) + sqrt((_772 * ((_767 * _767) - 1.0)) + _768)) - _785) / ((_775 + _771) - _785), _775 / _771), level(0.0)).xyz;
                                break;
                            }
                        }
                        float3 _796 = fast::clamp(fast::clamp(float3((_700 <= 0.0) ? 0.0 : pow(_700, Material.Material_ScalarExpressions[2].w), (_704 <= 0.0) ? 0.0 : pow(_704, Material.Material_ScalarExpressions[2].w), (_708 <= 0.0) ? 0.0 : pow(_708, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _722;
                        float3 _930;
                        float3 _931;
                        if (any(_796 > float3(0.0)))
                        {
                            float _813 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _814 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _816;
                            float3 _819;
                            _816 = float3(0.0);
                            _819 = float3(0.0);
                            float _822;
                            float3 _817;
                            float3 _820;
                            for (float _821 = 0.0, _823 = _813; _823 <= 1.0; _816 = _817, _819 = _820, _821 = _822, _823 += _813)
                            {
                                _822 = _823 * _823;
                                float _828 = _822 - _821;
                                float3 _833 = _565 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_821 + (_828 * 0.5))));
                                float _838 = fast::clamp((length(_833 - _506) - _507) * _510, 0.0, 1.0);
                                float4 _844 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_833 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _845 = _844.y;
                                float _859 = ((_838 < 0.0500000007450580596923828125) || (_838 > 0.949999988079071044921875)) ? 0.0 : (_844.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_845 <= 0.0) ? 0.0 : pow(_845, 0.25), 1.0 - _838), level(-1.0)).x);
                                if (_859 <= 0.0)
                                {
                                    _817 = _816;
                                    _820 = _819;
                                    continue;
                                }
                                float3 _864 = _833 * Material.Material_ScalarExpressions[0].x;
                                float4 _868 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_616 + _864) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _869 = _868.x;
                                float _873 = _868.y;
                                float _877 = _868.z;
                                float3 _883 = float3(_859) * fast::clamp(float3((_869 <= 0.0) ? 0.0 : pow(_869, Material.Material_ScalarExpressions[0].z), (_873 <= 0.0) ? 0.0 : pow(_873, Material.Material_ScalarExpressions[0].z), (_877 <= 0.0) ? 0.0 : pow(_877, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _887 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_864 + _645) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _888 = _887.x;
                                float _892 = ((_888 <= 0.0) ? 0.0 : pow(_888, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _902 = fast::clamp(_838 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _916 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_883, float3((_667 + (fast::clamp((_883 - float3(_892)) / float3(Material.Material_ScalarExpressions[1].z - _892), float3(0.0), float3(1.0)) * _674)).x), float3((_902 <= 0.0) ? 0.0 : pow(_902, Material.Material_ScalarExpressions[2].y))), _160).xyz, float3(0.0), float3(65000.0));
                                _817 = _816 + ((_916 * _467) * _828);
                                _820 = _819 + (_916 * _828);
                            }
                            _930 = _795 * exp((-_819) * _814);
                            _931 = _795 * exp((-_816) * _814);
                        }
                        else
                        {
                            _930 = _795;
                            _931 = _795;
                        }
                        float _944;
                        float _945;
                        if (any(_722 > float3(0.0)))
                        {
                            float _940 = fast::min(_548.x, fast::min(_548.y, _548.z));
                            _944 = _555 + (_557 * _940);
                            _945 = _553 + _940;
                        }
                        else
                        {
                            _944 = _555;
                            _945 = _553;
                        }
                        float3 _950 = (((_931 * _409) * mix(0.079577468335628509521484375, _504, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_796 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _951 = fast::max(float3(9.9999999747524270787835121154785e-07), _722 * _467);
                        float3 _964 = (((_930 * _409) * _504) + (_461 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _570, 0.0, 1.0)).xyz) * _796;
                        float3 _965 = fast::max(float3(9.9999999747524270787835121154785e-07), _722);
                        float3 _968 = exp((-_965) * _433);
                        float3 _973 = (_551 + (_548 * ((_950 - (_950 * exp((-_951) * _433))) / _951))) + (_548 * ((_964 - (_964 * _968)) / _965));
                        float3 _974 = _548 * _968;
                        if (all(_974 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _985 = _974;
                            _986 = _973;
                            _987 = _944;
                            _988 = _945;
                            break;
                        }
                        _549 = _974;
                        _552 = _973;
                        _554 = _945;
                        _556 = _944;
                        _558 = _557 + _432;
                        _984 = _559;
                        uint _560 = _984 + 1u;
                        _548 = _549;
                        _551 = _552;
                        _553 = _554;
                        _555 = _556;
                        _557 = _558;
                        _559 = _560;
                        continue;
                    }
                    else
                    {
                        _985 = _548;
                        _986 = _551;
                        _987 = _555;
                        _988 = _553;
                        break;
                    }
                }
                bool _989 = View.View_RealTimeReflectionCapture != 0.0;
                float _994 = (_988 == 0.0) ? _416 : (_987 / fast::max(1.0000000133514319600180897396058e-10, _988));
                float3 _996 = View.View_WorldCameraOrigin + (_252 * _994);
                float4 _1001 = View.View_WorldToClip * float4(_996, 1.0);
                float _1002 = dot(_985, float3(0.3333333432674407958984375));
                bool _1006 = _988 > 0.0;
                float3 _1079;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1006)
                {
                    float3 _1018 = (_996 * 9.9999997473787516355514526367188e-06) - _251;
                    float _1024 = sqrt((fast::max(0.0, length(_1018) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                    float _1025 = _1024 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                    float _1032;
                    if (_1025 < 0.707106769084930419921875)
                    {
                        _1032 = fast::clamp((_1025 * _1025) * 2.0, 0.0, 1.0);
                    }
                    else
                    {
                        _1032 = 1.0;
                    }
                    float2 _1060;
                    if (_989)
                    {
                        float3 _1035 = normalize(_1018);
                        float _1036 = _1035.z;
                        float _1039 = sqrt(1.0 - (_1036 * _1036));
                        float2 _1042 = _164;
                        _1042.y = (_1036 * 0.5) + 0.5;
                        float _1047 = acos(_1035.x / _1039);
                        float2 _1052 = _1042;
                        _1052.x = (((_1035.y / _1039) < 0.0) ? (6.283185482025146484375 - _1047) : _1047) * 0.15915493667125701904296875;
                        _1060 = (_1052 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                    }
                    else
                    {
                        _1060 = ((_1001.xy / _1001.ww) * float2(0.5, -0.5)) + float2(0.5);
                    }
                    float4 _1065 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1060, _1024), level(0.0));
                    _1079 = (((_1065.xyz * _1032).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1002)) + (_986 * (1.0 - (_1032 * (1.0 - _1065.w))));
                }
                else
                {
                    _1079 = _986;
                }
                float3 _1326;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1006)
                {
                    float3 _1086 = _996 - View.View_WorldCameraOrigin;
                    float _1103 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                    float _1106 = _1086.z + (View.View_WorldCameraOrigin.z - _1103);
                    float3 _1107 = _1086;
                    _1107.z = _1106;
                    float _1108 = dot(_1107, _1107);
                    float _1109 = rsqrt(_1108);
                    float _1110 = _1108 * _1109;
                    float _1118 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1086) / dot(_1086, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                    float _1152;
                    float _1153;
                    float _1154;
                    float _1155;
                    if (_1118 > 0.0)
                    {
                        float _1122 = _1118 * _1109;
                        float _1123 = _1122 * _1106;
                        float _1124 = _1103 + _1123;
                        _1152 = (1.0 - _1122) * _1110;
                        _1153 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1124 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                        _1154 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1124 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                        _1155 = _1106 - _1123;
                    }
                    else
                    {
                        _1152 = _1110;
                        _1153 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                        _1154 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                        _1155 = _1106;
                    }
                    float _1159 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1155);
                    float _1173 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1155);
                    float _1184 = (_1154 * ((abs(_1159) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1159)) / _1159) : (0.693147182464599609375 - (0.2402265071868896484375 * _1159)))) + (_1153 * ((abs(_1173) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1173)) / _1173) : (0.693147182464599609375 - (0.2402265071868896484375 * _1173))));
                    float3 _1226;
                    if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                    {
                        float2 _1211 = float2(dot(_1107.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1107.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                        float3 _1212 = float3(_1211.x, _1211.y, _1107.z);
                        _1226 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1212, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1212, level(0.0)).xyz, float3(fast::clamp((_1110 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                    }
                    else
                    {
                        _1226 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                    }
                    float3 _1254;
                    if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                    {
                        _1254 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1107 * _1109, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1184 * fast::max(_1152 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                    }
                    else
                    {
                        _1254 = float3(0.0);
                    }
                    bool _1263 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1110 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                    float _1266 = _1263 ? 1.0 : fast::max(fast::clamp(exp2(-(_1184 * _1152)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                    float4 _1273 = float4((_1226 * (1.0 - _1266)) + select(_1254, float3(0.0), bool3(_1263)), _1266);
                    bool _1276 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                    float4 _1319;
                    if (_1276)
                    {
                        float _1279 = _1001.w;
                        float4 _1308;
                        if (_1276)
                        {
                            _1308 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1001.xy / float2(_1279)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1279 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                        }
                        else
                        {
                            _1308 = float4(0.0, 0.0, 0.0, 1.0);
                        }
                        _1319 = float4(_1308.xyz + (_1273.xyz * _1308.w), _1308.w * _1266);
                    }
                    else
                    {
                        _1319 = _1273;
                    }
                    _1326 = (_1319.xyz * (1.0 - _1002)) + (_1079 * _1319.w);
                }
                else
                {
                    _1326 = _1079;
                }
                float _1330 = (_1002 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1002;
                float2 _1336 = _388;
                _1336.x = 65504.0;
                float2 _1344;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1343 = _1336;
                    _1343.x = ((_1330 > 0.9900000095367431640625) ? _416 : _994) * 9.9999997473787516355514526367188e-06;
                    _1344 = _1343;
                }
                else
                {
                    _1344 = _1336;
                }
                _1345 = _1344;
                _1346 = float4(_1326 * (_989 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1330);
                break;
            }
        }
        if (_Globals.TargetCubeFace >= 0)
        {
            uint3 _1375 = uint3(gl_GlobalInvocationID.xy, uint(_Globals.TargetCubeFace));
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1384 = OutCloudColorCube.read(uint2(_1375.xy), uint(_1375.z));
                OutCloudColorCube.write(spvIdentity(float4((_1384.xyz * _1346.w) + _1346.xyz, _1384.w * _1346.w)), uint2(_1375.xy), uint(_1375.z));
            }
            else
            {
                OutCloudColorCube.write(spvIdentity(_1346), uint2(_1375.xy), uint(_1375.z));
            }
        }
        else
        {
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1361 = OutCloudColor.read(uint2(gl_GlobalInvocationID.xy));
                OutCloudColor.write(spvIdentity(float4((_1361.xyz * _1346.w) + _1346.xyz, _1361.w * _1346.w)), uint2(gl_GlobalInvocationID.xy));
            }
            else
            {
                OutCloudColor.write(spvIdentity(_1346), uint2(gl_GlobalInvocationID.xy));
            }
        }
        OutCloudDepth.write(spvIdentity(_1345.xyyy), uint2(gl_GlobalInvocationID.xy));
    }
}

