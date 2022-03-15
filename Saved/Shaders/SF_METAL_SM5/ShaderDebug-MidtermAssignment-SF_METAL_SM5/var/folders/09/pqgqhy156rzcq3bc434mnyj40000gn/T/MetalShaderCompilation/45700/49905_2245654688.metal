

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

constant float _171 = {};
constant float3 _173 = {};
constant uint3 _174 = {};
constant float4 _175 = {};
constant float2 _176 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000c2f1_85d9f8a0(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(5)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(6)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(7)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(8)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], texture3d<float> Material_VolumeTexture_0 [[texture(12)]], texture3d<float> Material_VolumeTexture_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(5)]], sampler Material_Texture2D_0Sampler [[sampler(6)]], sampler Material_Texture2D_1Sampler [[sampler(7)]], sampler Material_VolumeTexture_0Sampler [[sampler(8)]], sampler Material_VolumeTexture_1Sampler [[sampler(9)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _218 = float(gl_GlobalInvocationID.x) + 0.5;
        float _221 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _222 = float4(_218, _221, 0.5, 1.0);
        float2 _1414;
        float4 _1415;
        switch (0u)
        {
            default:
            {
                float _277;
                float _283;
                float4 _255 = View.View_SVPositionToTranslatedWorld * _222;
                float3 _262 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _263 = -normalize(-(_255.xyz / float3(_255.w)));
                float2 _297;
                bool _298;
                switch (0u)
                {
                    default:
                    {
                        float3 _275 = _262 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _277 = dot(_263, _263);
                        float _278 = dot(_263, _275);
                        float _279 = 2.0 * _278;
                        _283 = 4.0 * _277;
                        float _285 = (_279 * _279) - (_283 * (dot(_275, _275) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_285 >= 0.0)
                        {
                            _297 = (float2(_278 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_285))) / float2(2.0 * _277);
                            _298 = true;
                            break;
                        }
                        _297 = float2(0.0);
                        _298 = false;
                        break;
                    }
                }
                float _303;
                float _355;
                float _356;
                if (_298)
                {
                    _303 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _328;
                    bool _329;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _308 = _262 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _303).xyz;
                            float _310 = dot(_263, _308);
                            float _311 = 2.0 * _310;
                            float _316 = (_311 * _311) - (_283 * (dot(_308, _308) - (_303 * _303)));
                            if (_316 >= 0.0)
                            {
                                _328 = (float2(_310 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_316))) / float2(2.0 * _277);
                                _329 = true;
                                break;
                            }
                            _328 = float2(0.0);
                            _329 = false;
                            break;
                        }
                    }
                    if (_329)
                    {
                        float _339 = fast::min(_297.x, _297.y);
                        bool _343 = all(_328 > float2(0.0));
                        float _348 = _343 ? fast::min(_328.x, _328.y) : fast::max(_328.x, _328.y);
                        float _352;
                        if (_343)
                        {
                            _352 = fast::max(0.0, _339);
                        }
                        else
                        {
                            _352 = all(_297 > float2(0.0)) ? _339 : fast::max(_297.x, _297.y);
                        }
                        _355 = fast::max(_348, _352);
                        _356 = fast::min(_348, _352);
                    }
                    else
                    {
                        _355 = _297.y;
                        _356 = _297.x;
                    }
                }
                else
                {
                    _1414 = float2(65504.0);
                    _1415 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _358 = fast::max(0.0, _356) * 100000.0;
                float _360 = fast::max(0.0, _355) * 100000.0;
                if ((_360 <= _358) || (_358 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1414 = float2(65504.0);
                    _1415 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _380 = int3(uint3((uint2(_222.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _388 = View.View_SVPositionToTranslatedWorld * float4(_218, _221, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_380.xy), _380.z).x), 1.0);
                float _397 = length(((_388.xyz / float3(_388.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _399 = float2(65504.0);
                _399.y = _397 * 9.9999997473787516355514526367188e-06;
                bool _402 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_402 && (_397 < _358))
                {
                    _1414 = _399;
                    _1415 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _410;
                if (_402)
                {
                    _410 = fast::min(_360, _397);
                }
                else
                {
                    _410 = _360;
                }
                float3 _420 = View.View_AtmosphereLightColorGlobalPostTransmittance[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
                float _427 = _358 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _410 - _358);
                float _434 = _427 - _358;
                uint _441 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_434 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _443 = _434 / float(_441);
                float _444 = _443 * 0.00999999977648258209228515625;
                float3 _472;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _471;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _471 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _456 = _173;
                        _456.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _460 = _456;
                        _460.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _464 = _460;
                        _464.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _471 = fast::max(float3(0.0), _464);
                    }
                    _472 = _471;
                }
                else
                {
                    _472 = float3(0.0);
                }
                float _478 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _489 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _490 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _492 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _263);
                float _493 = _489 * _489;
                float _498 = (1.0 + _493) + ((2.0 * _489) * _492);
                float _502 = (1.0 - _493) / ((12.56637096405029296875 * _498) * sqrt(_498));
                float _503 = _490 * _490;
                float _508 = (1.0 + _503) + ((2.0 * _490) * _492);
                float _515 = _502 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _503) / ((12.56637096405029296875 * _508) * sqrt(_508))) - _502));
                float3 _517 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _518 = _303 * 100000.0;
                float _521 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _518);
                float _557;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _537 = (uint3(int3(int(_218), int(_221), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _538 = _537.y;
                    uint _539 = _537.z;
                    uint _542 = _537.x + (_538 * _539);
                    uint _544 = _538 + (_539 * _542);
                    uint3 _549 = _174;
                    _549.x = _542 + (_544 * (_539 + (_542 * _544)));
                    _557 = _358 + ((float((_549 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _443);
                }
                else
                {
                    _557 = _358 + (0.5 * _443);
                }
                float3 _559;
                float3 _562;
                _559 = float3(1.0);
                _562 = float3(0.0);
                float3 _560;
                float3 _563;
                float _565;
                float _567;
                float _569;
                uint _1053;
                float3 _1054;
                float3 _1055;
                float _1056;
                float _1057;
                float _564 = 0.0;
                float _566 = 0.0;
                float _568 = _557;
                uint _570 = 0u;
                for (;;)
                {
                    if (_570 < _441)
                    {
                        float3 _575 = _263 * _568;
                        float3 _576 = View.View_WorldCameraOrigin + _575;
                        float _581 = fast::clamp((length(_576 - _517) - _518) * _521, 0.0, 1.0);
                        float4 _591 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_576 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _592 = _591.y;
                        float _608 = ((_581 < 0.0500000007450580596923828125) || (_581 > 0.949999988079071044921875)) ? 0.0 : (_591.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_592 <= 0.0) ? 0.0 : pow(_592, 0.25), 1.0 - _581), level(-1.0)).x);
                        if (_608 <= 0.0)
                        {
                            _560 = _559;
                            _563 = _562;
                            _565 = _564;
                            _567 = _566;
                            _569 = _568 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _443);
                            _1053 = _570 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _571 = _1053 + 1u;
                            _559 = _560;
                            _562 = _563;
                            _564 = _565;
                            _566 = _567;
                            _568 = _569;
                            _570 = _571;
                            continue;
                        }
                        float3 _626 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _627 = _626 * 0.1500000059604644775390625;
                        float3 _630 = _576 * Material.Material_ScalarExpressions[0].x;
                        float4 _638 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_627 + _630) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _641 = _638.x;
                        float _645 = _638.y;
                        float _649 = _638.z;
                        float3 _655 = float3(_608) * fast::clamp(float3((_641 <= 0.0) ? 0.0 : pow(_641, Material.Material_ScalarExpressions[0].z), (_645 <= 0.0) ? 0.0 : pow(_645, Material.Material_ScalarExpressions[0].z), (_649 <= 0.0) ? 0.0 : pow(_649, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _656 = _626 * (-0.100000001490116119384765625);
                        float4 _664 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_630 + _656) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _665 = _664.x;
                        float _673 = ((_665 <= 0.0) ? 0.0 : pow(_665, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _678 = float3(Material.Material_ScalarExpressions[1].w);
                        float _685 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _691 = fast::clamp(_581 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _700 = mix(_655, float3((_678 + (fast::clamp((_655 - float3(_673)) / float3(Material.Material_ScalarExpressions[1].z - _673), float3(0.0), float3(1.0)) * _685)).x), float3((_691 <= 0.0) ? 0.0 : pow(_691, Material.Material_ScalarExpressions[2].y)));
                        float3 _708 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _700) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _711 = _708.x;
                        float _715 = _708.y;
                        float _719 = _708.z;
                        float3 _733 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _700, _171).xyz, float3(0.0), float3(65000.0));
                        float3 _736 = fast::clamp(fast::clamp(float3((_711 <= 0.0) ? 0.0 : pow(_711, Material.Material_ScalarExpressions[2].w), (_715 <= 0.0) ? 0.0 : pow(_715, Material.Material_ScalarExpressions[2].w), (_719 <= 0.0) ? 0.0 : pow(_719, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _733;
                        float3 _999;
                        float3 _1000;
                        if (any(_736 > float3(0.0)))
                        {
                            float _824;
                            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                            {
                                float4 _759 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_576, 1.0);
                                float2 _763 = _759.xy / float2(_759.w);
                                bool2 _764 = _763 >= float2(0.0);
                                bool2 _765 = _763 <= float2(1.0);
                                float _823;
                                if (all(bool2(_764.x && _765.x, _764.y && _765.y)))
                                {
                                    float2 _777 = (_763 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                    float2 _778 = fract(_777);
                                    float2 _779 = floor(_777);
                                    float4 _787 = _175;
                                    _787.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_779 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _793 = _787;
                                    _793.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_779 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _799 = _793;
                                    _799.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_779 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _804 = _799;
                                    _804.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_779 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                    float4 _814 = fast::clamp(fast::clamp((_804 * 40.0) - float4((_759.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _804 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                    float2 _818 = mix(_814.wx, _814.zy, _778.xx);
                                    _823 = mix(_818.x, _818.y, _778.y);
                                }
                                else
                                {
                                    _823 = 1.0;
                                }
                                _824 = _823;
                            }
                            else
                            {
                                _824 = 1.0;
                            }
                            float4 _831 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_576, 1.0);
                            float2 _835 = _831.xy / float2(_831.w);
                            bool2 _839 = _835 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                            bool2 _841 = _835 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                            float _861;
                            if (all(bool2(_839.x && _841.x, _839.y && _841.y)))
                            {
                                float4 _849 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _835, level(0.0));
                                float _850 = _849.x;
                                _861 = fast::clamp(float(_831.z < (_850 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_850 == 1.0), 0.0, 1.0);
                            }
                            else
                            {
                                _861 = 1.0;
                            }
                            float _872 = fast::clamp((dot(_576 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                            float3 _876 = float3(1.0) * fast::min(_824, mix(_861, 1.0, _872 * _872));
                            float _882 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _883 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _885;
                            float3 _888;
                            _885 = float3(0.0);
                            _888 = float3(0.0);
                            float _891;
                            float3 _886;
                            float3 _889;
                            for (float _890 = 0.0, _892 = _882; _892 <= 1.0; _885 = _886, _888 = _889, _890 = _891, _892 += _882)
                            {
                                _891 = _892 * _892;
                                float _897 = _891 - _890;
                                float3 _902 = _576 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_890 + (_897 * 0.5))));
                                float _907 = fast::clamp((length(_902 - _517) - _518) * _521, 0.0, 1.0);
                                float4 _913 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_902 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _914 = _913.y;
                                float _928 = ((_907 < 0.0500000007450580596923828125) || (_907 > 0.949999988079071044921875)) ? 0.0 : (_913.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_914 <= 0.0) ? 0.0 : pow(_914, 0.25), 1.0 - _907), level(-1.0)).x);
                                if (_928 <= 0.0)
                                {
                                    _886 = _885;
                                    _889 = _888;
                                    continue;
                                }
                                float3 _933 = _902 * Material.Material_ScalarExpressions[0].x;
                                float4 _937 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_627 + _933) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _938 = _937.x;
                                float _942 = _937.y;
                                float _946 = _937.z;
                                float3 _952 = float3(_928) * fast::clamp(float3((_938 <= 0.0) ? 0.0 : pow(_938, Material.Material_ScalarExpressions[0].z), (_942 <= 0.0) ? 0.0 : pow(_942, Material.Material_ScalarExpressions[0].z), (_946 <= 0.0) ? 0.0 : pow(_946, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _956 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_933 + _656) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _957 = _956.x;
                                float _961 = ((_957 <= 0.0) ? 0.0 : pow(_957, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _971 = fast::clamp(_907 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _985 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_952, float3((_678 + (fast::clamp((_952 - float3(_961)) / float3(Material.Material_ScalarExpressions[1].z - _961), float3(0.0), float3(1.0)) * _685)).x), float3((_971 <= 0.0) ? 0.0 : pow(_971, Material.Material_ScalarExpressions[2].y))), _171).xyz, float3(0.0), float3(65000.0));
                                _886 = _885 + ((_985 * _478) * _897);
                                _889 = _888 + (_985 * _897);
                            }
                            _999 = _876 * exp((-_888) * _883);
                            _1000 = _876 * exp((-_885) * _883);
                        }
                        else
                        {
                            _999 = float3(1.0);
                            _1000 = float3(1.0);
                        }
                        float _1013;
                        float _1014;
                        if (any(_733 > float3(0.0)))
                        {
                            float _1009 = fast::min(_559.x, fast::min(_559.y, _559.z));
                            _1013 = _566 + (_568 * _1009);
                            _1014 = _564 + _1009;
                        }
                        else
                        {
                            _1013 = _566;
                            _1014 = _564;
                        }
                        float3 _1019 = (((_1000 * _420) * mix(0.079577468335628509521484375, _515, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_736 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _1020 = fast::max(float3(9.9999999747524270787835121154785e-07), _733 * _478);
                        float3 _1033 = (((_999 * _420) * _515) + (_472 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _581, 0.0, 1.0)).xyz) * _736;
                        float3 _1034 = fast::max(float3(9.9999999747524270787835121154785e-07), _733);
                        float3 _1037 = exp((-_1034) * _444);
                        float3 _1042 = (_562 + (_559 * ((_1019 - (_1019 * exp((-_1020) * _444))) / _1020))) + (_559 * ((_1033 - (_1033 * _1037)) / _1034));
                        float3 _1043 = _559 * _1037;
                        if (all(_1043 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _1054 = _1043;
                            _1055 = _1042;
                            _1056 = _1013;
                            _1057 = _1014;
                            break;
                        }
                        _560 = _1043;
                        _563 = _1042;
                        _565 = _1014;
                        _567 = _1013;
                        _569 = _568 + _443;
                        _1053 = _570;
                        uint _571 = _1053 + 1u;
                        _559 = _560;
                        _562 = _563;
                        _564 = _565;
                        _566 = _567;
                        _568 = _569;
                        _570 = _571;
                        continue;
                    }
                    else
                    {
                        _1054 = _559;
                        _1055 = _562;
                        _1056 = _566;
                        _1057 = _564;
                        break;
                    }
                }
                bool _1058 = View.View_RealTimeReflectionCapture != 0.0;
                float _1063 = (_1057 == 0.0) ? _427 : (_1056 / fast::max(1.0000000133514319600180897396058e-10, _1057));
                float3 _1065 = View.View_WorldCameraOrigin + (_263 * _1063);
                float4 _1070 = View.View_WorldToClip * float4(_1065, 1.0);
                float _1071 = dot(_1054, float3(0.3333333432674407958984375));
                bool _1075 = _1057 > 0.0;
                float3 _1148;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1075)
                {
                    float3 _1087 = (_1065 * 9.9999997473787516355514526367188e-06) - _262;
                    float _1093 = sqrt((fast::max(0.0, length(_1087) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                    float _1094 = _1093 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                    float _1101;
                    if (_1094 < 0.707106769084930419921875)
                    {
                        _1101 = fast::clamp((_1094 * _1094) * 2.0, 0.0, 1.0);
                    }
                    else
                    {
                        _1101 = 1.0;
                    }
                    float2 _1129;
                    if (_1058)
                    {
                        float3 _1104 = normalize(_1087);
                        float _1105 = _1104.z;
                        float _1108 = sqrt(1.0 - (_1105 * _1105));
                        float2 _1111 = _176;
                        _1111.y = (_1105 * 0.5) + 0.5;
                        float _1116 = acos(_1104.x / _1108);
                        float2 _1121 = _1111;
                        _1121.x = (((_1104.y / _1108) < 0.0) ? (6.283185482025146484375 - _1116) : _1116) * 0.15915493667125701904296875;
                        _1129 = (_1121 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                    }
                    else
                    {
                        _1129 = ((_1070.xy / _1070.ww) * float2(0.5, -0.5)) + float2(0.5);
                    }
                    float4 _1134 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1129, _1093), level(0.0));
                    _1148 = (((_1134.xyz * _1101).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1071)) + (_1055 * (1.0 - (_1101 * (1.0 - _1134.w))));
                }
                else
                {
                    _1148 = _1055;
                }
                float3 _1395;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1075)
                {
                    float3 _1155 = _1065 - View.View_WorldCameraOrigin;
                    float _1172 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                    float _1175 = _1155.z + (View.View_WorldCameraOrigin.z - _1172);
                    float3 _1176 = _1155;
                    _1176.z = _1175;
                    float _1177 = dot(_1176, _1176);
                    float _1178 = rsqrt(_1177);
                    float _1179 = _1177 * _1178;
                    float _1187 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1155) / dot(_1155, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                    float _1221;
                    float _1222;
                    float _1223;
                    float _1224;
                    if (_1187 > 0.0)
                    {
                        float _1191 = _1187 * _1178;
                        float _1192 = _1191 * _1175;
                        float _1193 = _1172 + _1192;
                        _1221 = (1.0 - _1191) * _1179;
                        _1222 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1193 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                        _1223 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1193 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                        _1224 = _1175 - _1192;
                    }
                    else
                    {
                        _1221 = _1179;
                        _1222 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                        _1223 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                        _1224 = _1175;
                    }
                    float _1228 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1224);
                    float _1242 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1224);
                    float _1253 = (_1223 * ((abs(_1228) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1228)) / _1228) : (0.693147182464599609375 - (0.2402265071868896484375 * _1228)))) + (_1222 * ((abs(_1242) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1242)) / _1242) : (0.693147182464599609375 - (0.2402265071868896484375 * _1242))));
                    float3 _1295;
                    if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                    {
                        float2 _1280 = float2(dot(_1176.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1176.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                        float3 _1281 = float3(_1280.x, _1280.y, _1176.z);
                        _1295 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1281, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1281, level(0.0)).xyz, float3(fast::clamp((_1179 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                    }
                    else
                    {
                        _1295 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                    }
                    float3 _1323;
                    if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                    {
                        _1323 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1176 * _1178, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1253 * fast::max(_1221 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                    }
                    else
                    {
                        _1323 = float3(0.0);
                    }
                    bool _1332 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1179 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                    float _1335 = _1332 ? 1.0 : fast::max(fast::clamp(exp2(-(_1253 * _1221)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                    float4 _1342 = float4((_1295 * (1.0 - _1335)) + select(_1323, float3(0.0), bool3(_1332)), _1335);
                    bool _1345 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                    float4 _1388;
                    if (_1345)
                    {
                        float _1348 = _1070.w;
                        float4 _1377;
                        if (_1345)
                        {
                            _1377 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1070.xy / float2(_1348)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1348 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                        }
                        else
                        {
                            _1377 = float4(0.0, 0.0, 0.0, 1.0);
                        }
                        _1388 = float4(_1377.xyz + (_1342.xyz * _1377.w), _1377.w * _1335);
                    }
                    else
                    {
                        _1388 = _1342;
                    }
                    _1395 = (_1388.xyz * (1.0 - _1071)) + (_1148 * _1388.w);
                }
                else
                {
                    _1395 = _1148;
                }
                float _1399 = (_1071 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1071;
                float2 _1405 = _399;
                _1405.x = 65504.0;
                float2 _1413;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1412 = _1405;
                    _1412.x = ((_1399 > 0.9900000095367431640625) ? _427 : _1063) * 9.9999997473787516355514526367188e-06;
                    _1413 = _1412;
                }
                else
                {
                    _1413 = _1405;
                }
                _1414 = _1413;
                _1415 = float4(_1395 * (_1058 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1399);
                break;
            }
        }
        if (_Globals.TargetCubeFace >= 0)
        {
            uint3 _1444 = uint3(gl_GlobalInvocationID.xy, uint(_Globals.TargetCubeFace));
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1453 = OutCloudColorCube.read(uint2(_1444.xy), uint(_1444.z));
                OutCloudColorCube.write(spvIdentity(float4((_1453.xyz * _1415.w) + _1415.xyz, _1453.w * _1415.w)), uint2(_1444.xy), uint(_1444.z));
            }
            else
            {
                OutCloudColorCube.write(spvIdentity(_1415), uint2(_1444.xy), uint(_1444.z));
            }
        }
        else
        {
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1430 = OutCloudColor.read(uint2(gl_GlobalInvocationID.xy));
                OutCloudColor.write(spvIdentity(float4((_1430.xyz * _1415.w) + _1415.xyz, _1430.w * _1415.w)), uint2(gl_GlobalInvocationID.xy));
            }
            else
            {
                OutCloudColor.write(spvIdentity(_1415), uint2(gl_GlobalInvocationID.xy));
            }
        }
        OutCloudDepth.write(spvIdentity(_1414.xyyy), uint2(gl_GlobalInvocationID.xy));
    }
}

