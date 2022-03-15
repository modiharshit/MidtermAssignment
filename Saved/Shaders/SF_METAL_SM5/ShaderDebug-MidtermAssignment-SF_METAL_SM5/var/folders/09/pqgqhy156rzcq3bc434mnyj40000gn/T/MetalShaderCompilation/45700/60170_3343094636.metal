

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

constant float _175 = {};
constant float3 _177 = {};
constant uint3 _178 = {};
constant float4 _179 = {};
constant float2 _180 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000eb0a_c743936c(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_TransmittanceLutTexture [[texture(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(6)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(7)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(8)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(9)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(10)]], texture2d<float> Material_Texture2D_0 [[texture(11)]], texture2d<float> Material_Texture2D_1 [[texture(12)]], texture3d<float> Material_VolumeTexture_0 [[texture(13)]], texture3d<float> Material_VolumeTexture_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(5)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(6)]], sampler Material_Texture2D_0Sampler [[sampler(7)]], sampler Material_Texture2D_1Sampler [[sampler(8)]], sampler Material_VolumeTexture_0Sampler [[sampler(9)]], sampler Material_VolumeTexture_1Sampler [[sampler(10)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _222 = float(gl_GlobalInvocationID.x) + 0.5;
        float _225 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _226 = float4(_222, _225, 0.5, 1.0);
        float2 _1707;
        float4 _1708;
        switch (0u)
        {
            default:
            {
                float _291;
                float _297;
                float4 _269 = View.View_SVPositionToTranslatedWorld * _226;
                float3 _276 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _277 = -normalize(-(_269.xyz / float3(_269.w)));
                float2 _311;
                bool _312;
                switch (0u)
                {
                    default:
                    {
                        float3 _289 = _276 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _291 = dot(_277, _277);
                        float _292 = dot(_277, _289);
                        float _293 = 2.0 * _292;
                        _297 = 4.0 * _291;
                        float _299 = (_293 * _293) - (_297 * (dot(_289, _289) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_299 >= 0.0)
                        {
                            _311 = (float2(_292 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_299))) / float2(2.0 * _291);
                            _312 = true;
                            break;
                        }
                        _311 = float2(0.0);
                        _312 = false;
                        break;
                    }
                }
                float _317;
                float _369;
                float _370;
                if (_312)
                {
                    _317 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _342;
                    bool _343;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _322 = _276 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _317).xyz;
                            float _324 = dot(_277, _322);
                            float _325 = 2.0 * _324;
                            float _330 = (_325 * _325) - (_297 * (dot(_322, _322) - (_317 * _317)));
                            if (_330 >= 0.0)
                            {
                                _342 = (float2(_324 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_330))) / float2(2.0 * _291);
                                _343 = true;
                                break;
                            }
                            _342 = float2(0.0);
                            _343 = false;
                            break;
                        }
                    }
                    if (_343)
                    {
                        float _353 = fast::min(_311.x, _311.y);
                        bool _357 = all(_342 > float2(0.0));
                        float _362 = _357 ? fast::min(_342.x, _342.y) : fast::max(_342.x, _342.y);
                        float _366;
                        if (_357)
                        {
                            _366 = fast::max(0.0, _353);
                        }
                        else
                        {
                            _366 = all(_311 > float2(0.0)) ? _353 : fast::max(_311.x, _311.y);
                        }
                        _369 = fast::max(_362, _366);
                        _370 = fast::min(_362, _366);
                    }
                    else
                    {
                        _369 = _311.y;
                        _370 = _311.x;
                    }
                }
                else
                {
                    _1707 = float2(65504.0);
                    _1708 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _372 = fast::max(0.0, _370) * 100000.0;
                float _374 = fast::max(0.0, _369) * 100000.0;
                if ((_374 <= _372) || (_372 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1707 = float2(65504.0);
                    _1708 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _394 = int3(uint3((uint2(_226.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _402 = View.View_SVPositionToTranslatedWorld * float4(_222, _225, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_394.xy), _394.z).x), 1.0);
                float _411 = length(((_402.xyz / float3(_402.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _413 = float2(65504.0);
                _413.y = _411 * 9.9999997473787516355514526367188e-06;
                bool _416 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_416 && (_411 < _372))
                {
                    _1707 = _413;
                    _1708 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _424;
                if (_416)
                {
                    _424 = fast::min(_374, _411);
                }
                else
                {
                    _424 = _374;
                }
                bool3 _429 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
                float3 _434 = View.View_AtmosphereLightColor[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _429);
                float3 _441 = View.View_AtmosphereLightColor[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _429);
                float _448 = _372 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _424 - _372);
                float _455 = _448 - _372;
                uint _462 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_455 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _464 = _455 / float(_462);
                float _465 = _464 * 0.00999999977648258209228515625;
                float3 _493;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _492;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _492 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _477 = _177;
                        _477.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _481 = _477;
                        _481.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _485 = _481;
                        _485.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _492 = fast::max(float3(0.0), _485);
                    }
                    _493 = _492;
                }
                else
                {
                    _493 = float3(0.0);
                }
                float _499 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _502 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
                float _511 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _512 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _513 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
                float _514 = -dot(View.View_AtmosphereLightDirection[0].xyz, _277);
                float _515 = _511 * _511;
                float _516 = 1.0 - _515;
                float _517 = 1.0 + _515;
                float _518 = 2.0 * _511;
                float _520 = _517 + (_518 * _514);
                float _524 = _516 / ((12.56637096405029296875 * _520) * sqrt(_520));
                float _525 = _512 * _512;
                float _526 = 1.0 - _525;
                float _527 = 1.0 + _525;
                float _528 = 2.0 * _512;
                float _530 = _527 + (_528 * _514);
                float _537 = _524 + (_513 * ((_526 / ((12.56637096405029296875 * _530) * sqrt(_530))) - _524));
                float _538 = -dot(View.View_AtmosphereLightDirection[1].xyz, _277);
                float _540 = _517 + (_518 * _538);
                float _544 = _516 / ((12.56637096405029296875 * _540) * sqrt(_540));
                float _546 = _527 + (_528 * _538);
                float _553 = _544 + (_513 * ((_526 / ((12.56637096405029296875 * _546) * sqrt(_546))) - _544));
                float3 _556 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _557 = _317 * 100000.0;
                float _560 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _557);
                float _596;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _576 = (uint3(int3(int(_222), int(_225), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _577 = _576.y;
                    uint _578 = _576.z;
                    uint _581 = _576.x + (_577 * _578);
                    uint _583 = _577 + (_578 * _581);
                    uint3 _588 = _178;
                    _588.x = _581 + (_583 * (_578 + (_581 * _583)));
                    _596 = _372 + ((float((_588 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _464);
                }
                else
                {
                    _596 = _372 + (0.5 * _464);
                }
                float3 _598;
                float3 _601;
                _598 = float3(1.0);
                _601 = float3(0.0);
                float3 _599;
                float3 _602;
                float _604;
                float _606;
                float _608;
                uint _1346;
                float3 _1347;
                float3 _1348;
                float _1349;
                float _1350;
                float _603 = 0.0;
                float _605 = 0.0;
                float _607 = _596;
                uint _609 = 0u;
                for (;;)
                {
                    if (_609 < _462)
                    {
                        float3 _614 = _277 * _607;
                        float3 _615 = View.View_WorldCameraOrigin + _614;
                        float _620 = fast::clamp((length(_615 - _556) - _557) * _560, 0.0, 1.0);
                        float4 _630 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_615 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _631 = _630.y;
                        float _647 = ((_620 < 0.0500000007450580596923828125) || (_620 > 0.949999988079071044921875)) ? 0.0 : (_630.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_631 <= 0.0) ? 0.0 : pow(_631, 0.25), 1.0 - _620), level(-1.0)).x);
                        if (_647 <= 0.0)
                        {
                            _599 = _598;
                            _602 = _601;
                            _604 = _603;
                            _606 = _605;
                            _608 = _607 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _464);
                            _1346 = _609 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _610 = _1346 + 1u;
                            _598 = _599;
                            _601 = _602;
                            _603 = _604;
                            _605 = _606;
                            _607 = _608;
                            _609 = _610;
                            continue;
                        }
                        float3 _784;
                        float _789;
                        float _790;
                        float3 _665 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _666 = _665 * 0.1500000059604644775390625;
                        float3 _669 = _615 * Material.Material_ScalarExpressions[0].x;
                        float4 _677 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_666 + _669) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _680 = _677.x;
                        float _684 = _677.y;
                        float _688 = _677.z;
                        float3 _694 = float3(_647) * fast::clamp(float3((_680 <= 0.0) ? 0.0 : pow(_680, Material.Material_ScalarExpressions[0].z), (_684 <= 0.0) ? 0.0 : pow(_684, Material.Material_ScalarExpressions[0].z), (_688 <= 0.0) ? 0.0 : pow(_688, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _695 = _665 * (-0.100000001490116119384765625);
                        float4 _703 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_669 + _695) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _704 = _703.x;
                        float _712 = ((_704 <= 0.0) ? 0.0 : pow(_704, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _717 = float3(Material.Material_ScalarExpressions[1].w);
                        float _724 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _730 = fast::clamp(_620 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _739 = mix(_694, float3((_717 + (fast::clamp((_694 - float3(_712)) / float3(Material.Material_ScalarExpressions[1].z - _712), float3(0.0), float3(1.0)) * _724)).x), float3((_730 <= 0.0) ? 0.0 : pow(_730, Material.Material_ScalarExpressions[2].y)));
                        float3 _747 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _739) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _750 = _747.x;
                        float _754 = _747.y;
                        float _758 = _747.z;
                        float3 _772 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _739, _175).xyz, float3(0.0), float3(65000.0));
                        float3 _777 = (_615 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                        float3 _845;
                        switch (0u)
                        {
                            default:
                            {
                                _784 = _777 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                                float _786 = dot(View.View_AtmosphereLightDirection[0].xyz, View.View_AtmosphereLightDirection[0].xyz);
                                float _787 = dot(View.View_AtmosphereLightDirection[0].xyz, _784);
                                float _788 = 2.0 * _787;
                                _789 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                                _790 = dot(_784, _784) - _789;
                                float _794 = (_788 * _788) - ((4.0 * _786) * _790);
                                float2 _806;
                                if (_794 >= 0.0)
                                {
                                    _806 = (float2(_787 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_794))) / float2(2.0 * _786);
                                }
                                else
                                {
                                    _806 = float2(-1.0);
                                }
                                if ((_806.x > 0.0) || (_806.y > 0.0))
                                {
                                    _845 = float3(0.0);
                                    break;
                                }
                                float _814 = length(_777);
                                float _817 = dot(View.View_AtmosphereLightDirection[0].xyz, _777 / float3(_814));
                                float _818 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                                float _821 = sqrt(fast::max(0.0, _818 - _789));
                                float _822 = _814 * _814;
                                float _825 = sqrt(fast::max(0.0, _822 - _789));
                                float _835 = View.View_SkyAtmosphereTopRadiusKm - _814;
                                _845 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_814) * _817) + sqrt((_822 * ((_817 * _817) - 1.0)) + _818)) - _835) / ((_825 + _821) - _835), _825 / _821), level(0.0)).xyz;
                                break;
                            }
                        }
                        float3 _905;
                        switch (0u)
                        {
                            default:
                            {
                                float _848 = dot(View.View_AtmosphereLightDirection[1].xyz, View.View_AtmosphereLightDirection[1].xyz);
                                float _849 = dot(View.View_AtmosphereLightDirection[1].xyz, _784);
                                float _850 = 2.0 * _849;
                                float _854 = (_850 * _850) - ((4.0 * _848) * _790);
                                float2 _866;
                                if (_854 >= 0.0)
                                {
                                    _866 = (float2(_849 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_854))) / float2(2.0 * _848);
                                }
                                else
                                {
                                    _866 = float2(-1.0);
                                }
                                if ((_866.x > 0.0) || (_866.y > 0.0))
                                {
                                    _905 = float3(0.0);
                                    break;
                                }
                                float _874 = length(_777);
                                float _877 = dot(View.View_AtmosphereLightDirection[1].xyz, _777 / float3(_874));
                                float _878 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                                float _881 = sqrt(fast::max(0.0, _878 - _789));
                                float _882 = _874 * _874;
                                float _885 = sqrt(fast::max(0.0, _882 - _789));
                                float _895 = View.View_SkyAtmosphereTopRadiusKm - _874;
                                _905 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_874) * _877) + sqrt((_882 * ((_877 * _877) - 1.0)) + _878)) - _895) / ((_885 + _881) - _895), _885 / _881), level(0.0)).xyz;
                                break;
                            }
                        }
                        float3 _906 = fast::clamp(fast::clamp(float3((_750 <= 0.0) ? 0.0 : pow(_750, Material.Material_ScalarExpressions[2].w), (_754 <= 0.0) ? 0.0 : pow(_754, Material.Material_ScalarExpressions[2].w), (_758 <= 0.0) ? 0.0 : pow(_758, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _772;
                        float3 _1284;
                        float3 _1285;
                        float3 _1286;
                        float3 _1287;
                        if (any(_906 > float3(0.0)))
                        {
                            float _994;
                            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                            {
                                float4 _929 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_615, 1.0);
                                float2 _933 = _929.xy / float2(_929.w);
                                bool2 _934 = _933 >= float2(0.0);
                                bool2 _935 = _933 <= float2(1.0);
                                float _993;
                                if (all(bool2(_934.x && _935.x, _934.y && _935.y)))
                                {
                                    float2 _947 = (_933 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                    float2 _948 = fract(_947);
                                    float2 _949 = floor(_947);
                                    float4 _957 = _179;
                                    _957.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_949 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _963 = _957;
                                    _963.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_949 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _969 = _963;
                                    _969.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_949 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _974 = _969;
                                    _974.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_949 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _984 = fast::clamp(fast::clamp((_974 * 40.0) - float4((_929.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _974 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                    float2 _988 = mix(_984.wx, _984.zy, _948.xx);
                                    _993 = mix(_988.x, _988.y, _948.y);
                                }
                                else
                                {
                                    _993 = 1.0;
                                }
                                _994 = _993;
                            }
                            else
                            {
                                _994 = 1.0;
                            }
                            float4 _1001 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_615, 1.0);
                            float2 _1005 = _1001.xy / float2(_1001.w);
                            bool2 _1009 = _1005 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                            bool2 _1011 = _1005 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                            float _1031;
                            if (all(bool2(_1009.x && _1011.x, _1009.y && _1011.y)))
                            {
                                float4 _1019 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _1005, level(0.0));
                                float _1020 = _1019.x;
                                _1031 = fast::clamp(float(_1001.z < (_1020 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_1020 == 1.0), 0.0, 1.0);
                            }
                            else
                            {
                                _1031 = 1.0;
                            }
                            float _1042 = fast::clamp((dot(_615 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                            float3 _1046 = _845 * fast::min(_994, mix(_1031, 1.0, _1042 * _1042));
                            float _1052 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _1053 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _1055;
                            float3 _1058;
                            _1055 = float3(0.0);
                            _1058 = float3(0.0);
                            float _1061;
                            float3 _1056;
                            float3 _1059;
                            for (float _1060 = 0.0, _1062 = _1052; _1062 <= 1.0; _1055 = _1056, _1058 = _1059, _1060 = _1061, _1062 += _1052)
                            {
                                _1061 = _1062 * _1062;
                                float _1067 = _1061 - _1060;
                                float3 _1072 = _615 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1060 + (_1067 * 0.5))));
                                float _1077 = fast::clamp((length(_1072 - _556) - _557) * _560, 0.0, 1.0);
                                float4 _1083 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1072 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _1084 = _1083.y;
                                float _1098 = ((_1077 < 0.0500000007450580596923828125) || (_1077 > 0.949999988079071044921875)) ? 0.0 : (_1083.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1084 <= 0.0) ? 0.0 : pow(_1084, 0.25), 1.0 - _1077), level(-1.0)).x);
                                if (_1098 <= 0.0)
                                {
                                    _1056 = _1055;
                                    _1059 = _1058;
                                    continue;
                                }
                                float3 _1103 = _1072 * Material.Material_ScalarExpressions[0].x;
                                float4 _1107 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_666 + _1103) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _1108 = _1107.x;
                                float _1112 = _1107.y;
                                float _1116 = _1107.z;
                                float3 _1122 = float3(_1098) * fast::clamp(float3((_1108 <= 0.0) ? 0.0 : pow(_1108, Material.Material_ScalarExpressions[0].z), (_1112 <= 0.0) ? 0.0 : pow(_1112, Material.Material_ScalarExpressions[0].z), (_1116 <= 0.0) ? 0.0 : pow(_1116, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _1126 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1103 + _695) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _1127 = _1126.x;
                                float _1131 = ((_1127 <= 0.0) ? 0.0 : pow(_1127, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _1141 = fast::clamp(_1077 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _1155 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1122, float3((_717 + (fast::clamp((_1122 - float3(_1131)) / float3(Material.Material_ScalarExpressions[1].z - _1131), float3(0.0), float3(1.0)) * _724)).x), float3((_1141 <= 0.0) ? 0.0 : pow(_1141, Material.Material_ScalarExpressions[2].y))), _175).xyz, float3(0.0), float3(65000.0));
                                _1056 = _1055 + ((_1155 * _499) * _1067);
                                _1059 = _1058 + (_1155 * _1067);
                            }
                            float3 _1170;
                            float3 _1173;
                            _1170 = float3(0.0);
                            _1173 = float3(0.0);
                            float _1176;
                            float3 _1171;
                            float3 _1174;
                            for (float _1175 = 0.0, _1177 = _1052; _1177 <= 1.0; _1170 = _1171, _1173 = _1174, _1175 = _1176, _1177 += _1052)
                            {
                                _1176 = _1177 * _1177;
                                float _1182 = _1176 - _1175;
                                float3 _1187 = _615 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1175 + (_1182 * 0.5))));
                                float _1192 = fast::clamp((length(_1187 - _556) - _557) * _560, 0.0, 1.0);
                                float4 _1198 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1187 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _1199 = _1198.y;
                                float _1213 = ((_1192 < 0.0500000007450580596923828125) || (_1192 > 0.949999988079071044921875)) ? 0.0 : (_1198.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1199 <= 0.0) ? 0.0 : pow(_1199, 0.25), 1.0 - _1192), level(-1.0)).x);
                                if (_1213 <= 0.0)
                                {
                                    _1171 = _1170;
                                    _1174 = _1173;
                                    continue;
                                }
                                float3 _1218 = _1187 * Material.Material_ScalarExpressions[0].x;
                                float4 _1222 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_666 + _1218) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _1223 = _1222.x;
                                float _1227 = _1222.y;
                                float _1231 = _1222.z;
                                float3 _1237 = float3(_1213) * fast::clamp(float3((_1223 <= 0.0) ? 0.0 : pow(_1223, Material.Material_ScalarExpressions[0].z), (_1227 <= 0.0) ? 0.0 : pow(_1227, Material.Material_ScalarExpressions[0].z), (_1231 <= 0.0) ? 0.0 : pow(_1231, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _1241 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1218 + _695) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _1242 = _1241.x;
                                float _1246 = ((_1242 <= 0.0) ? 0.0 : pow(_1242, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _1256 = fast::clamp(_1192 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _1270 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1237, float3((_717 + (fast::clamp((_1237 - float3(_1246)) / float3(Material.Material_ScalarExpressions[1].z - _1246), float3(0.0), float3(1.0)) * _724)).x), float3((_1256 <= 0.0) ? 0.0 : pow(_1256, Material.Material_ScalarExpressions[2].y))), _175).xyz, float3(0.0), float3(65000.0));
                                _1171 = _1170 + ((_1270 * _499) * _1182);
                                _1174 = _1173 + (_1270 * _1182);
                            }
                            _1284 = _905 * exp((-_1173) * _1053);
                            _1285 = _1046 * exp((-_1058) * _1053);
                            _1286 = _905 * exp((-_1170) * _1053);
                            _1287 = _1046 * exp((-_1055) * _1053);
                        }
                        else
                        {
                            _1284 = _905;
                            _1285 = _845;
                            _1286 = _905;
                            _1287 = _845;
                        }
                        float _1300;
                        float _1301;
                        if (any(_772 > float3(0.0)))
                        {
                            float _1296 = fast::min(_598.x, fast::min(_598.y, _598.z));
                            _1300 = _605 + (_607 * _1296);
                            _1301 = _603 + _1296;
                        }
                        else
                        {
                            _1300 = _605;
                            _1301 = _603;
                        }
                        float3 _1309 = ((((_1287 * _434) * mix(0.079577468335628509521484375, _537, _502)) + ((_1286 * _441) * mix(0.079577468335628509521484375, _553, _502))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_906 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _1310 = fast::max(float3(9.9999999747524270787835121154785e-07), _772 * _499);
                        float3 _1326 = ((((_1285 * _434) * _537) + ((_1284 * _441) * _553)) + (_493 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _620, 0.0, 1.0)).xyz) * _906;
                        float3 _1327 = fast::max(float3(9.9999999747524270787835121154785e-07), _772);
                        float3 _1330 = exp((-_1327) * _465);
                        float3 _1335 = (_601 + (_598 * ((_1309 - (_1309 * exp((-_1310) * _465))) / _1310))) + (_598 * ((_1326 - (_1326 * _1330)) / _1327));
                        float3 _1336 = _598 * _1330;
                        if (all(_1336 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _1347 = _1336;
                            _1348 = _1335;
                            _1349 = _1300;
                            _1350 = _1301;
                            break;
                        }
                        _599 = _1336;
                        _602 = _1335;
                        _604 = _1301;
                        _606 = _1300;
                        _608 = _607 + _464;
                        _1346 = _609;
                        uint _610 = _1346 + 1u;
                        _598 = _599;
                        _601 = _602;
                        _603 = _604;
                        _605 = _606;
                        _607 = _608;
                        _609 = _610;
                        continue;
                    }
                    else
                    {
                        _1347 = _598;
                        _1348 = _601;
                        _1349 = _605;
                        _1350 = _603;
                        break;
                    }
                }
                bool _1351 = View.View_RealTimeReflectionCapture != 0.0;
                float _1356 = (_1350 == 0.0) ? _448 : (_1349 / fast::max(1.0000000133514319600180897396058e-10, _1350));
                float3 _1358 = View.View_WorldCameraOrigin + (_277 * _1356);
                float4 _1363 = View.View_WorldToClip * float4(_1358, 1.0);
                float _1364 = dot(_1347, float3(0.3333333432674407958984375));
                bool _1368 = _1350 > 0.0;
                float3 _1441;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1368)
                {
                    float3 _1380 = (_1358 * 9.9999997473787516355514526367188e-06) - _276;
                    float _1386 = sqrt((fast::max(0.0, length(_1380) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                    float _1387 = _1386 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                    float _1394;
                    if (_1387 < 0.707106769084930419921875)
                    {
                        _1394 = fast::clamp((_1387 * _1387) * 2.0, 0.0, 1.0);
                    }
                    else
                    {
                        _1394 = 1.0;
                    }
                    float2 _1422;
                    if (_1351)
                    {
                        float3 _1397 = normalize(_1380);
                        float _1398 = _1397.z;
                        float _1401 = sqrt(1.0 - (_1398 * _1398));
                        float2 _1404 = _180;
                        _1404.y = (_1398 * 0.5) + 0.5;
                        float _1409 = acos(_1397.x / _1401);
                        float2 _1414 = _1404;
                        _1414.x = (((_1397.y / _1401) < 0.0) ? (6.283185482025146484375 - _1409) : _1409) * 0.15915493667125701904296875;
                        _1422 = (_1414 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                    }
                    else
                    {
                        _1422 = ((_1363.xy / _1363.ww) * float2(0.5, -0.5)) + float2(0.5);
                    }
                    float4 _1427 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1422, _1386), level(0.0));
                    _1441 = (((_1427.xyz * _1394).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1364)) + (_1348 * (1.0 - (_1394 * (1.0 - _1427.w))));
                }
                else
                {
                    _1441 = _1348;
                }
                float3 _1688;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1368)
                {
                    float3 _1448 = _1358 - View.View_WorldCameraOrigin;
                    float _1465 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                    float _1468 = _1448.z + (View.View_WorldCameraOrigin.z - _1465);
                    float3 _1469 = _1448;
                    _1469.z = _1468;
                    float _1470 = dot(_1469, _1469);
                    float _1471 = rsqrt(_1470);
                    float _1472 = _1470 * _1471;
                    float _1480 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1448) / dot(_1448, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                    float _1514;
                    float _1515;
                    float _1516;
                    float _1517;
                    if (_1480 > 0.0)
                    {
                        float _1484 = _1480 * _1471;
                        float _1485 = _1484 * _1468;
                        float _1486 = _1465 + _1485;
                        _1514 = (1.0 - _1484) * _1472;
                        _1515 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1486 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                        _1516 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1486 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                        _1517 = _1468 - _1485;
                    }
                    else
                    {
                        _1514 = _1472;
                        _1515 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                        _1516 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                        _1517 = _1468;
                    }
                    float _1521 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1517);
                    float _1535 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1517);
                    float _1546 = (_1516 * ((abs(_1521) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1521)) / _1521) : (0.693147182464599609375 - (0.2402265071868896484375 * _1521)))) + (_1515 * ((abs(_1535) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1535)) / _1535) : (0.693147182464599609375 - (0.2402265071868896484375 * _1535))));
                    float3 _1588;
                    if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                    {
                        float2 _1573 = float2(dot(_1469.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1469.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                        float3 _1574 = float3(_1573.x, _1573.y, _1469.z);
                        _1588 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1574, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1574, level(0.0)).xyz, float3(fast::clamp((_1472 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                    }
                    else
                    {
                        _1588 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                    }
                    float3 _1616;
                    if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                    {
                        _1616 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1469 * _1471, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1546 * fast::max(_1514 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                    }
                    else
                    {
                        _1616 = float3(0.0);
                    }
                    bool _1625 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1472 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                    float _1628 = _1625 ? 1.0 : fast::max(fast::clamp(exp2(-(_1546 * _1514)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                    float4 _1635 = float4((_1588 * (1.0 - _1628)) + select(_1616, float3(0.0), bool3(_1625)), _1628);
                    bool _1638 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                    float4 _1681;
                    if (_1638)
                    {
                        float _1641 = _1363.w;
                        float4 _1670;
                        if (_1638)
                        {
                            _1670 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1363.xy / float2(_1641)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1641 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                        }
                        else
                        {
                            _1670 = float4(0.0, 0.0, 0.0, 1.0);
                        }
                        _1681 = float4(_1670.xyz + (_1635.xyz * _1670.w), _1670.w * _1628);
                    }
                    else
                    {
                        _1681 = _1635;
                    }
                    _1688 = (_1681.xyz * (1.0 - _1364)) + (_1441 * _1681.w);
                }
                else
                {
                    _1688 = _1441;
                }
                float _1692 = (_1364 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1364;
                float2 _1698 = _413;
                _1698.x = 65504.0;
                float2 _1706;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1705 = _1698;
                    _1705.x = ((_1692 > 0.9900000095367431640625) ? _448 : _1356) * 9.9999997473787516355514526367188e-06;
                    _1706 = _1705;
                }
                else
                {
                    _1706 = _1698;
                }
                _1707 = _1706;
                _1708 = float4(_1688 * (_1351 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1692);
                break;
            }
        }
        if (_Globals.TargetCubeFace >= 0)
        {
            uint3 _1737 = uint3(gl_GlobalInvocationID.xy, uint(_Globals.TargetCubeFace));
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1746 = OutCloudColorCube.read(uint2(_1737.xy), uint(_1737.z));
                OutCloudColorCube.write(spvIdentity(float4((_1746.xyz * _1708.w) + _1708.xyz, _1746.w * _1708.w)), uint2(_1737.xy), uint(_1737.z));
            }
            else
            {
                OutCloudColorCube.write(spvIdentity(_1708), uint2(_1737.xy), uint(_1737.z));
            }
        }
        else
        {
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1723 = OutCloudColor.read(uint2(gl_GlobalInvocationID.xy));
                OutCloudColor.write(spvIdentity(float4((_1723.xyz * _1708.w) + _1708.xyz, _1723.w * _1708.w)), uint2(gl_GlobalInvocationID.xy));
            }
            else
            {
                OutCloudColor.write(spvIdentity(_1708), uint2(gl_GlobalInvocationID.xy));
            }
        }
        OutCloudDepth.write(spvIdentity(_1707.xyyy), uint2(gl_GlobalInvocationID.xy));
    }
}

