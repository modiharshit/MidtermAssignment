

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

struct type_Globals
{
    float4 OutputViewRect;
    int bBlendCloudColor;
    int TargetCubeFace;
};

constant float _157 = {};
constant float3 _159 = {};
constant uint3 _160 = {};
constant float2 _161 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000aac7_6b813ebd(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(5)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(6)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture3d<float> Material_VolumeTexture_0 [[texture(10)]], texture3d<float> Material_VolumeTexture_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], sampler Material_VolumeTexture_0Sampler [[sampler(6)]], sampler Material_VolumeTexture_1Sampler [[sampler(7)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _198 = float(gl_GlobalInvocationID.x) + 0.5;
        float _201 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _202 = float4(_198, _201, 0.5, 1.0);
        float2 _1263;
        float4 _1264;
        switch (0u)
        {
            default:
            {
                float _257;
                float _263;
                float4 _235 = View.View_SVPositionToTranslatedWorld * _202;
                float3 _242 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _243 = -normalize(-(_235.xyz / float3(_235.w)));
                float2 _277;
                bool _278;
                switch (0u)
                {
                    default:
                    {
                        float3 _255 = _242 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _257 = dot(_243, _243);
                        float _258 = dot(_243, _255);
                        float _259 = 2.0 * _258;
                        _263 = 4.0 * _257;
                        float _265 = (_259 * _259) - (_263 * (dot(_255, _255) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_265 >= 0.0)
                        {
                            _277 = (float2(_258 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_265))) / float2(2.0 * _257);
                            _278 = true;
                            break;
                        }
                        _277 = float2(0.0);
                        _278 = false;
                        break;
                    }
                }
                float _283;
                float _335;
                float _336;
                if (_278)
                {
                    _283 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _308;
                    bool _309;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _288 = _242 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _283).xyz;
                            float _290 = dot(_243, _288);
                            float _291 = 2.0 * _290;
                            float _296 = (_291 * _291) - (_263 * (dot(_288, _288) - (_283 * _283)));
                            if (_296 >= 0.0)
                            {
                                _308 = (float2(_290 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_296))) / float2(2.0 * _257);
                                _309 = true;
                                break;
                            }
                            _308 = float2(0.0);
                            _309 = false;
                            break;
                        }
                    }
                    if (_309)
                    {
                        float _319 = fast::min(_277.x, _277.y);
                        bool _323 = all(_308 > float2(0.0));
                        float _328 = _323 ? fast::min(_308.x, _308.y) : fast::max(_308.x, _308.y);
                        float _332;
                        if (_323)
                        {
                            _332 = fast::max(0.0, _319);
                        }
                        else
                        {
                            _332 = all(_277 > float2(0.0)) ? _319 : fast::max(_277.x, _277.y);
                        }
                        _335 = fast::max(_328, _332);
                        _336 = fast::min(_328, _332);
                    }
                    else
                    {
                        _335 = _277.y;
                        _336 = _277.x;
                    }
                }
                else
                {
                    _1263 = float2(65504.0);
                    _1264 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _338 = fast::max(0.0, _336) * 100000.0;
                float _340 = fast::max(0.0, _335) * 100000.0;
                if ((_340 <= _338) || (_338 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1263 = float2(65504.0);
                    _1264 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _360 = int3(uint3((uint2(_202.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _368 = View.View_SVPositionToTranslatedWorld * float4(_198, _201, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_360.xy), _360.z).x), 1.0);
                float _377 = length(((_368.xyz / float3(_368.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _379 = float2(65504.0);
                _379.y = _377 * 9.9999997473787516355514526367188e-06;
                bool _382 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_382 && (_377 < _338))
                {
                    _1263 = _379;
                    _1264 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _390;
                if (_382)
                {
                    _390 = fast::min(_340, _377);
                }
                else
                {
                    _390 = _340;
                }
                float3 _400 = View.View_AtmosphereLightColorGlobalPostTransmittance[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
                float _407 = _338 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _390 - _338);
                float _414 = _407 - _338;
                uint _421 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_414 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _423 = _414 / float(_421);
                float _424 = _423 * 0.00999999977648258209228515625;
                float3 _452;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _451;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _451 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _436 = _159;
                        _436.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _440 = _436;
                        _440.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _444 = _440;
                        _444.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _451 = fast::max(float3(0.0), _444);
                    }
                    _452 = _451;
                }
                else
                {
                    _452 = float3(0.0);
                }
                float _458 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _469 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _470 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _472 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _243);
                float _473 = _469 * _469;
                float _478 = (1.0 + _473) + ((2.0 * _469) * _472);
                float _482 = (1.0 - _473) / ((12.56637096405029296875 * _478) * sqrt(_478));
                float _483 = _470 * _470;
                float _488 = (1.0 + _483) + ((2.0 * _470) * _472);
                float _495 = _482 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _483) / ((12.56637096405029296875 * _488) * sqrt(_488))) - _482));
                float3 _497 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _498 = _283 * 100000.0;
                float _501 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _498);
                float _537;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _517 = (uint3(int3(int(_198), int(_201), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _518 = _517.y;
                    uint _519 = _517.z;
                    uint _522 = _517.x + (_518 * _519);
                    uint _524 = _518 + (_519 * _522);
                    uint3 _529 = _160;
                    _529.x = _522 + (_524 * (_519 + (_522 * _524)));
                    _537 = _338 + ((float((_529 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _423);
                }
                else
                {
                    _537 = _338 + (0.5 * _423);
                }
                float3 _539;
                float3 _542;
                _539 = float3(1.0);
                _542 = float3(0.0);
                float3 _540;
                float3 _543;
                float _545;
                float _547;
                float _549;
                uint _902;
                float3 _903;
                float3 _904;
                float _905;
                float _906;
                float _544 = 0.0;
                float _546 = 0.0;
                float _548 = _537;
                uint _550 = 0u;
                for (;;)
                {
                    if (_550 < _421)
                    {
                        float3 _555 = _243 * _548;
                        float3 _556 = View.View_WorldCameraOrigin + _555;
                        float _561 = fast::clamp((length(_556 - _497) - _498) * _501, 0.0, 1.0);
                        float4 _571 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_556 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _572 = _571.y;
                        float _588 = ((_561 < 0.0500000007450580596923828125) || (_561 > 0.949999988079071044921875)) ? 0.0 : (_571.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_572 <= 0.0) ? 0.0 : pow(_572, 0.25), 1.0 - _561), level(-1.0)).x);
                        if (_588 <= 0.0)
                        {
                            _540 = _539;
                            _543 = _542;
                            _545 = _544;
                            _547 = _546;
                            _549 = _548 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _423);
                            _902 = _550 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _551 = _902 + 1u;
                            _539 = _540;
                            _542 = _543;
                            _544 = _545;
                            _546 = _547;
                            _548 = _549;
                            _550 = _551;
                            continue;
                        }
                        float3 _606 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _607 = _606 * 0.1500000059604644775390625;
                        float3 _610 = _556 * Material.Material_ScalarExpressions[0].x;
                        float4 _618 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_607 + _610) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _621 = _618.x;
                        float _625 = _618.y;
                        float _629 = _618.z;
                        float3 _635 = float3(_588) * fast::clamp(float3((_621 <= 0.0) ? 0.0 : pow(_621, Material.Material_ScalarExpressions[0].z), (_625 <= 0.0) ? 0.0 : pow(_625, Material.Material_ScalarExpressions[0].z), (_629 <= 0.0) ? 0.0 : pow(_629, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _636 = _606 * (-0.100000001490116119384765625);
                        float4 _644 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_610 + _636) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _645 = _644.x;
                        float _653 = ((_645 <= 0.0) ? 0.0 : pow(_645, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _658 = float3(Material.Material_ScalarExpressions[1].w);
                        float _665 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _671 = fast::clamp(_561 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _680 = mix(_635, float3((_658 + (fast::clamp((_635 - float3(_653)) / float3(Material.Material_ScalarExpressions[1].z - _653), float3(0.0), float3(1.0)) * _665)).x), float3((_671 <= 0.0) ? 0.0 : pow(_671, Material.Material_ScalarExpressions[2].y)));
                        float3 _688 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _680) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _691 = _688.x;
                        float _695 = _688.y;
                        float _699 = _688.z;
                        float3 _713 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _680, _157).xyz, float3(0.0), float3(65000.0));
                        float3 _716 = fast::clamp(fast::clamp(float3((_691 <= 0.0) ? 0.0 : pow(_691, Material.Material_ScalarExpressions[2].w), (_695 <= 0.0) ? 0.0 : pow(_695, Material.Material_ScalarExpressions[2].w), (_699 <= 0.0) ? 0.0 : pow(_699, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _713;
                        float3 _848;
                        float3 _849;
                        if (any(_716 > float3(0.0)))
                        {
                            float _733 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _734 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _736;
                            float3 _739;
                            _736 = float3(0.0);
                            _739 = float3(0.0);
                            float _742;
                            float3 _737;
                            float3 _740;
                            for (float _741 = 0.0, _743 = _733; _743 <= 1.0; _736 = _737, _739 = _740, _741 = _742, _743 += _733)
                            {
                                _742 = _743 * _743;
                                float _748 = _742 - _741;
                                float3 _753 = _556 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_741 + (_748 * 0.5))));
                                float _758 = fast::clamp((length(_753 - _497) - _498) * _501, 0.0, 1.0);
                                float4 _764 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_753 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _765 = _764.y;
                                float _779 = ((_758 < 0.0500000007450580596923828125) || (_758 > 0.949999988079071044921875)) ? 0.0 : (_764.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_765 <= 0.0) ? 0.0 : pow(_765, 0.25), 1.0 - _758), level(-1.0)).x);
                                if (_779 <= 0.0)
                                {
                                    _737 = _736;
                                    _740 = _739;
                                    continue;
                                }
                                float3 _784 = _753 * Material.Material_ScalarExpressions[0].x;
                                float4 _788 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_607 + _784) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _789 = _788.x;
                                float _793 = _788.y;
                                float _797 = _788.z;
                                float3 _803 = float3(_779) * fast::clamp(float3((_789 <= 0.0) ? 0.0 : pow(_789, Material.Material_ScalarExpressions[0].z), (_793 <= 0.0) ? 0.0 : pow(_793, Material.Material_ScalarExpressions[0].z), (_797 <= 0.0) ? 0.0 : pow(_797, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _807 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_784 + _636) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _808 = _807.x;
                                float _812 = ((_808 <= 0.0) ? 0.0 : pow(_808, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _822 = fast::clamp(_758 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _836 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_803, float3((_658 + (fast::clamp((_803 - float3(_812)) / float3(Material.Material_ScalarExpressions[1].z - _812), float3(0.0), float3(1.0)) * _665)).x), float3((_822 <= 0.0) ? 0.0 : pow(_822, Material.Material_ScalarExpressions[2].y))), _157).xyz, float3(0.0), float3(65000.0));
                                _737 = _736 + ((_836 * _458) * _748);
                                _740 = _739 + (_836 * _748);
                            }
                            _848 = exp((-_739) * _734);
                            _849 = exp((-_736) * _734);
                        }
                        else
                        {
                            _848 = float3(1.0);
                            _849 = float3(1.0);
                        }
                        float _862;
                        float _863;
                        if (any(_713 > float3(0.0)))
                        {
                            float _858 = fast::min(_539.x, fast::min(_539.y, _539.z));
                            _862 = _546 + (_548 * _858);
                            _863 = _544 + _858;
                        }
                        else
                        {
                            _862 = _546;
                            _863 = _544;
                        }
                        float3 _868 = (((_849 * _400) * mix(0.079577468335628509521484375, _495, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_716 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _869 = fast::max(float3(9.9999999747524270787835121154785e-07), _713 * _458);
                        float3 _882 = (((_848 * _400) * _495) + (_452 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _561, 0.0, 1.0)).xyz) * _716;
                        float3 _883 = fast::max(float3(9.9999999747524270787835121154785e-07), _713);
                        float3 _886 = exp((-_883) * _424);
                        float3 _891 = (_542 + (_539 * ((_868 - (_868 * exp((-_869) * _424))) / _869))) + (_539 * ((_882 - (_882 * _886)) / _883));
                        float3 _892 = _539 * _886;
                        if (all(_892 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _903 = _892;
                            _904 = _891;
                            _905 = _862;
                            _906 = _863;
                            break;
                        }
                        _540 = _892;
                        _543 = _891;
                        _545 = _863;
                        _547 = _862;
                        _549 = _548 + _423;
                        _902 = _550;
                        uint _551 = _902 + 1u;
                        _539 = _540;
                        _542 = _543;
                        _544 = _545;
                        _546 = _547;
                        _548 = _549;
                        _550 = _551;
                        continue;
                    }
                    else
                    {
                        _903 = _539;
                        _904 = _542;
                        _905 = _546;
                        _906 = _544;
                        break;
                    }
                }
                bool _907 = View.View_RealTimeReflectionCapture != 0.0;
                float _912 = (_906 == 0.0) ? _407 : (_905 / fast::max(1.0000000133514319600180897396058e-10, _906));
                float3 _914 = View.View_WorldCameraOrigin + (_243 * _912);
                float4 _919 = View.View_WorldToClip * float4(_914, 1.0);
                float _920 = dot(_903, float3(0.3333333432674407958984375));
                bool _924 = _906 > 0.0;
                float3 _997;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _924)
                {
                    float3 _936 = (_914 * 9.9999997473787516355514526367188e-06) - _242;
                    float _942 = sqrt((fast::max(0.0, length(_936) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                    float _943 = _942 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                    float _950;
                    if (_943 < 0.707106769084930419921875)
                    {
                        _950 = fast::clamp((_943 * _943) * 2.0, 0.0, 1.0);
                    }
                    else
                    {
                        _950 = 1.0;
                    }
                    float2 _978;
                    if (_907)
                    {
                        float3 _953 = normalize(_936);
                        float _954 = _953.z;
                        float _957 = sqrt(1.0 - (_954 * _954));
                        float2 _960 = _161;
                        _960.y = (_954 * 0.5) + 0.5;
                        float _965 = acos(_953.x / _957);
                        float2 _970 = _960;
                        _970.x = (((_953.y / _957) < 0.0) ? (6.283185482025146484375 - _965) : _965) * 0.15915493667125701904296875;
                        _978 = (_970 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                    }
                    else
                    {
                        _978 = ((_919.xy / _919.ww) * float2(0.5, -0.5)) + float2(0.5);
                    }
                    float4 _983 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_978, _942), level(0.0));
                    _997 = (((_983.xyz * _950).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _920)) + (_904 * (1.0 - (_950 * (1.0 - _983.w))));
                }
                else
                {
                    _997 = _904;
                }
                float3 _1244;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _924)
                {
                    float3 _1004 = _914 - View.View_WorldCameraOrigin;
                    float _1021 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                    float _1024 = _1004.z + (View.View_WorldCameraOrigin.z - _1021);
                    float3 _1025 = _1004;
                    _1025.z = _1024;
                    float _1026 = dot(_1025, _1025);
                    float _1027 = rsqrt(_1026);
                    float _1028 = _1026 * _1027;
                    float _1036 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1004) / dot(_1004, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                    float _1070;
                    float _1071;
                    float _1072;
                    float _1073;
                    if (_1036 > 0.0)
                    {
                        float _1040 = _1036 * _1027;
                        float _1041 = _1040 * _1024;
                        float _1042 = _1021 + _1041;
                        _1070 = (1.0 - _1040) * _1028;
                        _1071 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1042 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                        _1072 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1042 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                        _1073 = _1024 - _1041;
                    }
                    else
                    {
                        _1070 = _1028;
                        _1071 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                        _1072 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                        _1073 = _1024;
                    }
                    float _1077 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1073);
                    float _1091 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1073);
                    float _1102 = (_1072 * ((abs(_1077) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1077)) / _1077) : (0.693147182464599609375 - (0.2402265071868896484375 * _1077)))) + (_1071 * ((abs(_1091) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1091)) / _1091) : (0.693147182464599609375 - (0.2402265071868896484375 * _1091))));
                    float3 _1144;
                    if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                    {
                        float2 _1129 = float2(dot(_1025.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1025.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                        float3 _1130 = float3(_1129.x, _1129.y, _1025.z);
                        _1144 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1130, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1130, level(0.0)).xyz, float3(fast::clamp((_1028 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                    }
                    else
                    {
                        _1144 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                    }
                    float3 _1172;
                    if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                    {
                        _1172 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1025 * _1027, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1102 * fast::max(_1070 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                    }
                    else
                    {
                        _1172 = float3(0.0);
                    }
                    bool _1181 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1028 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                    float _1184 = _1181 ? 1.0 : fast::max(fast::clamp(exp2(-(_1102 * _1070)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                    float4 _1191 = float4((_1144 * (1.0 - _1184)) + select(_1172, float3(0.0), bool3(_1181)), _1184);
                    bool _1194 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                    float4 _1237;
                    if (_1194)
                    {
                        float _1197 = _919.w;
                        float4 _1226;
                        if (_1194)
                        {
                            _1226 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_919.xy / float2(_1197)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1197 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                        }
                        else
                        {
                            _1226 = float4(0.0, 0.0, 0.0, 1.0);
                        }
                        _1237 = float4(_1226.xyz + (_1191.xyz * _1226.w), _1226.w * _1184);
                    }
                    else
                    {
                        _1237 = _1191;
                    }
                    _1244 = (_1237.xyz * (1.0 - _920)) + (_997 * _1237.w);
                }
                else
                {
                    _1244 = _997;
                }
                float _1248 = (_920 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _920;
                float2 _1254 = _379;
                _1254.x = 65504.0;
                float2 _1262;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1261 = _1254;
                    _1261.x = ((_1248 > 0.9900000095367431640625) ? _407 : _912) * 9.9999997473787516355514526367188e-06;
                    _1262 = _1261;
                }
                else
                {
                    _1262 = _1254;
                }
                _1263 = _1262;
                _1264 = float4(_1244 * (_907 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1248);
                break;
            }
        }
        if (_Globals.TargetCubeFace >= 0)
        {
            uint3 _1293 = uint3(gl_GlobalInvocationID.xy, uint(_Globals.TargetCubeFace));
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1302 = OutCloudColorCube.read(uint2(_1293.xy), uint(_1293.z));
                OutCloudColorCube.write(spvIdentity(float4((_1302.xyz * _1264.w) + _1264.xyz, _1302.w * _1264.w)), uint2(_1293.xy), uint(_1293.z));
            }
            else
            {
                OutCloudColorCube.write(spvIdentity(_1264), uint2(_1293.xy), uint(_1293.z));
            }
        }
        else
        {
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1279 = OutCloudColor.read(uint2(gl_GlobalInvocationID.xy));
                OutCloudColor.write(spvIdentity(float4((_1279.xyz * _1264.w) + _1264.xyz, _1279.w * _1264.w)), uint2(gl_GlobalInvocationID.xy));
            }
            else
            {
                OutCloudColor.write(spvIdentity(_1264), uint2(gl_GlobalInvocationID.xy));
            }
        }
        OutCloudDepth.write(spvIdentity(_1263.xyyy), uint2(gl_GlobalInvocationID.xy));
    }
}

