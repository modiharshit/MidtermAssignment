

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

constant float _161 = {};
constant float3 _163 = {};
constant uint3 _164 = {};
constant float2 _165 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000d2fc_79a90c8c(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_TransmittanceLutTexture [[texture(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(6)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(7)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], texture3d<float> Material_VolumeTexture_0 [[texture(11)]], texture3d<float> Material_VolumeTexture_1 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(4)]], sampler Material_Texture2D_0Sampler [[sampler(5)]], sampler Material_Texture2D_1Sampler [[sampler(6)]], sampler Material_VolumeTexture_0Sampler [[sampler(7)]], sampler Material_VolumeTexture_1Sampler [[sampler(8)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _202 = float(gl_GlobalInvocationID.x) + 0.5;
        float _205 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _206 = float4(_202, _205, 0.5, 1.0);
        float2 _1558;
        float4 _1559;
        switch (0u)
        {
            default:
            {
                float _271;
                float _277;
                float4 _249 = View.View_SVPositionToTranslatedWorld * _206;
                float3 _256 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _257 = -normalize(-(_249.xyz / float3(_249.w)));
                float2 _291;
                bool _292;
                switch (0u)
                {
                    default:
                    {
                        float3 _269 = _256 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _271 = dot(_257, _257);
                        float _272 = dot(_257, _269);
                        float _273 = 2.0 * _272;
                        _277 = 4.0 * _271;
                        float _279 = (_273 * _273) - (_277 * (dot(_269, _269) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_279 >= 0.0)
                        {
                            _291 = (float2(_272 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_279))) / float2(2.0 * _271);
                            _292 = true;
                            break;
                        }
                        _291 = float2(0.0);
                        _292 = false;
                        break;
                    }
                }
                float _297;
                float _349;
                float _350;
                if (_292)
                {
                    _297 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _322;
                    bool _323;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _302 = _256 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _297).xyz;
                            float _304 = dot(_257, _302);
                            float _305 = 2.0 * _304;
                            float _310 = (_305 * _305) - (_277 * (dot(_302, _302) - (_297 * _297)));
                            if (_310 >= 0.0)
                            {
                                _322 = (float2(_304 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_310))) / float2(2.0 * _271);
                                _323 = true;
                                break;
                            }
                            _322 = float2(0.0);
                            _323 = false;
                            break;
                        }
                    }
                    if (_323)
                    {
                        float _333 = fast::min(_291.x, _291.y);
                        bool _337 = all(_322 > float2(0.0));
                        float _342 = _337 ? fast::min(_322.x, _322.y) : fast::max(_322.x, _322.y);
                        float _346;
                        if (_337)
                        {
                            _346 = fast::max(0.0, _333);
                        }
                        else
                        {
                            _346 = all(_291 > float2(0.0)) ? _333 : fast::max(_291.x, _291.y);
                        }
                        _349 = fast::max(_342, _346);
                        _350 = fast::min(_342, _346);
                    }
                    else
                    {
                        _349 = _291.y;
                        _350 = _291.x;
                    }
                }
                else
                {
                    _1558 = float2(65504.0);
                    _1559 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _352 = fast::max(0.0, _350) * 100000.0;
                float _354 = fast::max(0.0, _349) * 100000.0;
                if ((_354 <= _352) || (_352 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1558 = float2(65504.0);
                    _1559 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _374 = int3(uint3((uint2(_206.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _382 = View.View_SVPositionToTranslatedWorld * float4(_202, _205, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_374.xy), _374.z).x), 1.0);
                float _391 = length(((_382.xyz / float3(_382.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _393 = float2(65504.0);
                _393.y = _391 * 9.9999997473787516355514526367188e-06;
                bool _396 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_396 && (_391 < _352))
                {
                    _1558 = _393;
                    _1559 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _404;
                if (_396)
                {
                    _404 = fast::min(_354, _391);
                }
                else
                {
                    _404 = _354;
                }
                bool3 _409 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
                float3 _414 = View.View_AtmosphereLightColor[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _409);
                float3 _421 = View.View_AtmosphereLightColor[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _409);
                float _428 = _352 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _404 - _352);
                float _435 = _428 - _352;
                uint _442 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_435 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _444 = _435 / float(_442);
                float _445 = _444 * 0.00999999977648258209228515625;
                float3 _473;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _472;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _472 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _457 = _163;
                        _457.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _461 = _457;
                        _461.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _465 = _461;
                        _465.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _472 = fast::max(float3(0.0), _465);
                    }
                    _473 = _472;
                }
                else
                {
                    _473 = float3(0.0);
                }
                float _479 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _482 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
                float _491 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _492 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _493 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
                float _494 = -dot(View.View_AtmosphereLightDirection[0].xyz, _257);
                float _495 = _491 * _491;
                float _496 = 1.0 - _495;
                float _497 = 1.0 + _495;
                float _498 = 2.0 * _491;
                float _500 = _497 + (_498 * _494);
                float _504 = _496 / ((12.56637096405029296875 * _500) * sqrt(_500));
                float _505 = _492 * _492;
                float _506 = 1.0 - _505;
                float _507 = 1.0 + _505;
                float _508 = 2.0 * _492;
                float _510 = _507 + (_508 * _494);
                float _517 = _504 + (_493 * ((_506 / ((12.56637096405029296875 * _510) * sqrt(_510))) - _504));
                float _518 = -dot(View.View_AtmosphereLightDirection[1].xyz, _257);
                float _520 = _497 + (_498 * _518);
                float _524 = _496 / ((12.56637096405029296875 * _520) * sqrt(_520));
                float _526 = _507 + (_508 * _518);
                float _533 = _524 + (_493 * ((_506 / ((12.56637096405029296875 * _526) * sqrt(_526))) - _524));
                float3 _536 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _537 = _297 * 100000.0;
                float _540 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _537);
                float _576;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _556 = (uint3(int3(int(_202), int(_205), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _557 = _556.y;
                    uint _558 = _556.z;
                    uint _561 = _556.x + (_557 * _558);
                    uint _563 = _557 + (_558 * _561);
                    uint3 _568 = _164;
                    _568.x = _561 + (_563 * (_558 + (_561 * _563)));
                    _576 = _352 + ((float((_568 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _444);
                }
                else
                {
                    _576 = _352 + (0.5 * _444);
                }
                float3 _578;
                float3 _581;
                _578 = float3(1.0);
                _581 = float3(0.0);
                float3 _579;
                float3 _582;
                float _584;
                float _586;
                float _588;
                uint _1197;
                float3 _1198;
                float3 _1199;
                float _1200;
                float _1201;
                float _583 = 0.0;
                float _585 = 0.0;
                float _587 = _576;
                uint _589 = 0u;
                for (;;)
                {
                    if (_589 < _442)
                    {
                        float3 _594 = _257 * _587;
                        float3 _595 = View.View_WorldCameraOrigin + _594;
                        float _600 = fast::clamp((length(_595 - _536) - _537) * _540, 0.0, 1.0);
                        float4 _610 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_595 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _611 = _610.y;
                        float _627 = ((_600 < 0.0500000007450580596923828125) || (_600 > 0.949999988079071044921875)) ? 0.0 : (_610.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_611 <= 0.0) ? 0.0 : pow(_611, 0.25), 1.0 - _600), level(-1.0)).x);
                        if (_627 <= 0.0)
                        {
                            _579 = _578;
                            _582 = _581;
                            _584 = _583;
                            _586 = _585;
                            _588 = _587 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _444);
                            _1197 = _589 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _590 = _1197 + 1u;
                            _578 = _579;
                            _581 = _582;
                            _583 = _584;
                            _585 = _586;
                            _587 = _588;
                            _589 = _590;
                            continue;
                        }
                        float3 _764;
                        float _769;
                        float _770;
                        float3 _645 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _646 = _645 * 0.1500000059604644775390625;
                        float3 _649 = _595 * Material.Material_ScalarExpressions[0].x;
                        float4 _657 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_646 + _649) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _660 = _657.x;
                        float _664 = _657.y;
                        float _668 = _657.z;
                        float3 _674 = float3(_627) * fast::clamp(float3((_660 <= 0.0) ? 0.0 : pow(_660, Material.Material_ScalarExpressions[0].z), (_664 <= 0.0) ? 0.0 : pow(_664, Material.Material_ScalarExpressions[0].z), (_668 <= 0.0) ? 0.0 : pow(_668, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _675 = _645 * (-0.100000001490116119384765625);
                        float4 _683 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_649 + _675) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _684 = _683.x;
                        float _692 = ((_684 <= 0.0) ? 0.0 : pow(_684, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _697 = float3(Material.Material_ScalarExpressions[1].w);
                        float _704 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _710 = fast::clamp(_600 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _719 = mix(_674, float3((_697 + (fast::clamp((_674 - float3(_692)) / float3(Material.Material_ScalarExpressions[1].z - _692), float3(0.0), float3(1.0)) * _704)).x), float3((_710 <= 0.0) ? 0.0 : pow(_710, Material.Material_ScalarExpressions[2].y)));
                        float3 _727 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _719) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _730 = _727.x;
                        float _734 = _727.y;
                        float _738 = _727.z;
                        float3 _752 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _719, _161).xyz, float3(0.0), float3(65000.0));
                        float3 _757 = (_595 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                        float3 _825;
                        switch (0u)
                        {
                            default:
                            {
                                _764 = _757 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                                float _766 = dot(View.View_AtmosphereLightDirection[0].xyz, View.View_AtmosphereLightDirection[0].xyz);
                                float _767 = dot(View.View_AtmosphereLightDirection[0].xyz, _764);
                                float _768 = 2.0 * _767;
                                _769 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                                _770 = dot(_764, _764) - _769;
                                float _774 = (_768 * _768) - ((4.0 * _766) * _770);
                                float2 _786;
                                if (_774 >= 0.0)
                                {
                                    _786 = (float2(_767 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_774))) / float2(2.0 * _766);
                                }
                                else
                                {
                                    _786 = float2(-1.0);
                                }
                                if ((_786.x > 0.0) || (_786.y > 0.0))
                                {
                                    _825 = float3(0.0);
                                    break;
                                }
                                float _794 = length(_757);
                                float _797 = dot(View.View_AtmosphereLightDirection[0].xyz, _757 / float3(_794));
                                float _798 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                                float _801 = sqrt(fast::max(0.0, _798 - _769));
                                float _802 = _794 * _794;
                                float _805 = sqrt(fast::max(0.0, _802 - _769));
                                float _815 = View.View_SkyAtmosphereTopRadiusKm - _794;
                                _825 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_794) * _797) + sqrt((_802 * ((_797 * _797) - 1.0)) + _798)) - _815) / ((_805 + _801) - _815), _805 / _801), level(0.0)).xyz;
                                break;
                            }
                        }
                        float3 _885;
                        switch (0u)
                        {
                            default:
                            {
                                float _828 = dot(View.View_AtmosphereLightDirection[1].xyz, View.View_AtmosphereLightDirection[1].xyz);
                                float _829 = dot(View.View_AtmosphereLightDirection[1].xyz, _764);
                                float _830 = 2.0 * _829;
                                float _834 = (_830 * _830) - ((4.0 * _828) * _770);
                                float2 _846;
                                if (_834 >= 0.0)
                                {
                                    _846 = (float2(_829 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_834))) / float2(2.0 * _828);
                                }
                                else
                                {
                                    _846 = float2(-1.0);
                                }
                                if ((_846.x > 0.0) || (_846.y > 0.0))
                                {
                                    _885 = float3(0.0);
                                    break;
                                }
                                float _854 = length(_757);
                                float _857 = dot(View.View_AtmosphereLightDirection[1].xyz, _757 / float3(_854));
                                float _858 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                                float _861 = sqrt(fast::max(0.0, _858 - _769));
                                float _862 = _854 * _854;
                                float _865 = sqrt(fast::max(0.0, _862 - _769));
                                float _875 = View.View_SkyAtmosphereTopRadiusKm - _854;
                                _885 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_854) * _857) + sqrt((_862 * ((_857 * _857) - 1.0)) + _858)) - _875) / ((_865 + _861) - _875), _865 / _861), level(0.0)).xyz;
                                break;
                            }
                        }
                        float3 _886 = fast::clamp(fast::clamp(float3((_730 <= 0.0) ? 0.0 : pow(_730, Material.Material_ScalarExpressions[2].w), (_734 <= 0.0) ? 0.0 : pow(_734, Material.Material_ScalarExpressions[2].w), (_738 <= 0.0) ? 0.0 : pow(_738, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _752;
                        float3 _1135;
                        float3 _1136;
                        float3 _1137;
                        float3 _1138;
                        if (any(_886 > float3(0.0)))
                        {
                            float _903 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _904 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _906;
                            float3 _909;
                            _906 = float3(0.0);
                            _909 = float3(0.0);
                            float _912;
                            float3 _907;
                            float3 _910;
                            for (float _911 = 0.0, _913 = _903; _913 <= 1.0; _906 = _907, _909 = _910, _911 = _912, _913 += _903)
                            {
                                _912 = _913 * _913;
                                float _918 = _912 - _911;
                                float3 _923 = _595 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_911 + (_918 * 0.5))));
                                float _928 = fast::clamp((length(_923 - _536) - _537) * _540, 0.0, 1.0);
                                float4 _934 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_923 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _935 = _934.y;
                                float _949 = ((_928 < 0.0500000007450580596923828125) || (_928 > 0.949999988079071044921875)) ? 0.0 : (_934.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_935 <= 0.0) ? 0.0 : pow(_935, 0.25), 1.0 - _928), level(-1.0)).x);
                                if (_949 <= 0.0)
                                {
                                    _907 = _906;
                                    _910 = _909;
                                    continue;
                                }
                                float3 _954 = _923 * Material.Material_ScalarExpressions[0].x;
                                float4 _958 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_646 + _954) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _959 = _958.x;
                                float _963 = _958.y;
                                float _967 = _958.z;
                                float3 _973 = float3(_949) * fast::clamp(float3((_959 <= 0.0) ? 0.0 : pow(_959, Material.Material_ScalarExpressions[0].z), (_963 <= 0.0) ? 0.0 : pow(_963, Material.Material_ScalarExpressions[0].z), (_967 <= 0.0) ? 0.0 : pow(_967, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _977 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_954 + _675) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _978 = _977.x;
                                float _982 = ((_978 <= 0.0) ? 0.0 : pow(_978, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _992 = fast::clamp(_928 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _1006 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_973, float3((_697 + (fast::clamp((_973 - float3(_982)) / float3(Material.Material_ScalarExpressions[1].z - _982), float3(0.0), float3(1.0)) * _704)).x), float3((_992 <= 0.0) ? 0.0 : pow(_992, Material.Material_ScalarExpressions[2].y))), _161).xyz, float3(0.0), float3(65000.0));
                                _907 = _906 + ((_1006 * _479) * _918);
                                _910 = _909 + (_1006 * _918);
                            }
                            float3 _1021;
                            float3 _1024;
                            _1021 = float3(0.0);
                            _1024 = float3(0.0);
                            float _1027;
                            float3 _1022;
                            float3 _1025;
                            for (float _1026 = 0.0, _1028 = _903; _1028 <= 1.0; _1021 = _1022, _1024 = _1025, _1026 = _1027, _1028 += _903)
                            {
                                _1027 = _1028 * _1028;
                                float _1033 = _1027 - _1026;
                                float3 _1038 = _595 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1026 + (_1033 * 0.5))));
                                float _1043 = fast::clamp((length(_1038 - _536) - _537) * _540, 0.0, 1.0);
                                float4 _1049 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1038 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _1050 = _1049.y;
                                float _1064 = ((_1043 < 0.0500000007450580596923828125) || (_1043 > 0.949999988079071044921875)) ? 0.0 : (_1049.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1050 <= 0.0) ? 0.0 : pow(_1050, 0.25), 1.0 - _1043), level(-1.0)).x);
                                if (_1064 <= 0.0)
                                {
                                    _1022 = _1021;
                                    _1025 = _1024;
                                    continue;
                                }
                                float3 _1069 = _1038 * Material.Material_ScalarExpressions[0].x;
                                float4 _1073 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_646 + _1069) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _1074 = _1073.x;
                                float _1078 = _1073.y;
                                float _1082 = _1073.z;
                                float3 _1088 = float3(_1064) * fast::clamp(float3((_1074 <= 0.0) ? 0.0 : pow(_1074, Material.Material_ScalarExpressions[0].z), (_1078 <= 0.0) ? 0.0 : pow(_1078, Material.Material_ScalarExpressions[0].z), (_1082 <= 0.0) ? 0.0 : pow(_1082, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _1092 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1069 + _675) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _1093 = _1092.x;
                                float _1097 = ((_1093 <= 0.0) ? 0.0 : pow(_1093, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _1107 = fast::clamp(_1043 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _1121 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1088, float3((_697 + (fast::clamp((_1088 - float3(_1097)) / float3(Material.Material_ScalarExpressions[1].z - _1097), float3(0.0), float3(1.0)) * _704)).x), float3((_1107 <= 0.0) ? 0.0 : pow(_1107, Material.Material_ScalarExpressions[2].y))), _161).xyz, float3(0.0), float3(65000.0));
                                _1022 = _1021 + ((_1121 * _479) * _1033);
                                _1025 = _1024 + (_1121 * _1033);
                            }
                            _1135 = _885 * exp((-_1024) * _904);
                            _1136 = _825 * exp((-_909) * _904);
                            _1137 = _885 * exp((-_1021) * _904);
                            _1138 = _825 * exp((-_906) * _904);
                        }
                        else
                        {
                            _1135 = _885;
                            _1136 = _825;
                            _1137 = _885;
                            _1138 = _825;
                        }
                        float _1151;
                        float _1152;
                        if (any(_752 > float3(0.0)))
                        {
                            float _1147 = fast::min(_578.x, fast::min(_578.y, _578.z));
                            _1151 = _585 + (_587 * _1147);
                            _1152 = _583 + _1147;
                        }
                        else
                        {
                            _1151 = _585;
                            _1152 = _583;
                        }
                        float3 _1160 = ((((_1138 * _414) * mix(0.079577468335628509521484375, _517, _482)) + ((_1137 * _421) * mix(0.079577468335628509521484375, _533, _482))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_886 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _1161 = fast::max(float3(9.9999999747524270787835121154785e-07), _752 * _479);
                        float3 _1177 = ((((_1136 * _414) * _517) + ((_1135 * _421) * _533)) + (_473 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _600, 0.0, 1.0)).xyz) * _886;
                        float3 _1178 = fast::max(float3(9.9999999747524270787835121154785e-07), _752);
                        float3 _1181 = exp((-_1178) * _445);
                        float3 _1186 = (_581 + (_578 * ((_1160 - (_1160 * exp((-_1161) * _445))) / _1161))) + (_578 * ((_1177 - (_1177 * _1181)) / _1178));
                        float3 _1187 = _578 * _1181;
                        if (all(_1187 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _1198 = _1187;
                            _1199 = _1186;
                            _1200 = _1151;
                            _1201 = _1152;
                            break;
                        }
                        _579 = _1187;
                        _582 = _1186;
                        _584 = _1152;
                        _586 = _1151;
                        _588 = _587 + _444;
                        _1197 = _589;
                        uint _590 = _1197 + 1u;
                        _578 = _579;
                        _581 = _582;
                        _583 = _584;
                        _585 = _586;
                        _587 = _588;
                        _589 = _590;
                        continue;
                    }
                    else
                    {
                        _1198 = _578;
                        _1199 = _581;
                        _1200 = _585;
                        _1201 = _583;
                        break;
                    }
                }
                bool _1202 = View.View_RealTimeReflectionCapture != 0.0;
                float _1207 = (_1201 == 0.0) ? _428 : (_1200 / fast::max(1.0000000133514319600180897396058e-10, _1201));
                float3 _1209 = View.View_WorldCameraOrigin + (_257 * _1207);
                float4 _1214 = View.View_WorldToClip * float4(_1209, 1.0);
                float _1215 = dot(_1198, float3(0.3333333432674407958984375));
                bool _1219 = _1201 > 0.0;
                float3 _1292;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1219)
                {
                    float3 _1231 = (_1209 * 9.9999997473787516355514526367188e-06) - _256;
                    float _1237 = sqrt((fast::max(0.0, length(_1231) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                    float _1238 = _1237 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                    float _1245;
                    if (_1238 < 0.707106769084930419921875)
                    {
                        _1245 = fast::clamp((_1238 * _1238) * 2.0, 0.0, 1.0);
                    }
                    else
                    {
                        _1245 = 1.0;
                    }
                    float2 _1273;
                    if (_1202)
                    {
                        float3 _1248 = normalize(_1231);
                        float _1249 = _1248.z;
                        float _1252 = sqrt(1.0 - (_1249 * _1249));
                        float2 _1255 = _165;
                        _1255.y = (_1249 * 0.5) + 0.5;
                        float _1260 = acos(_1248.x / _1252);
                        float2 _1265 = _1255;
                        _1265.x = (((_1248.y / _1252) < 0.0) ? (6.283185482025146484375 - _1260) : _1260) * 0.15915493667125701904296875;
                        _1273 = (_1265 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                    }
                    else
                    {
                        _1273 = ((_1214.xy / _1214.ww) * float2(0.5, -0.5)) + float2(0.5);
                    }
                    float4 _1278 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1273, _1237), level(0.0));
                    _1292 = (((_1278.xyz * _1245).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1215)) + (_1199 * (1.0 - (_1245 * (1.0 - _1278.w))));
                }
                else
                {
                    _1292 = _1199;
                }
                float3 _1539;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1219)
                {
                    float3 _1299 = _1209 - View.View_WorldCameraOrigin;
                    float _1316 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                    float _1319 = _1299.z + (View.View_WorldCameraOrigin.z - _1316);
                    float3 _1320 = _1299;
                    _1320.z = _1319;
                    float _1321 = dot(_1320, _1320);
                    float _1322 = rsqrt(_1321);
                    float _1323 = _1321 * _1322;
                    float _1331 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1299) / dot(_1299, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                    float _1365;
                    float _1366;
                    float _1367;
                    float _1368;
                    if (_1331 > 0.0)
                    {
                        float _1335 = _1331 * _1322;
                        float _1336 = _1335 * _1319;
                        float _1337 = _1316 + _1336;
                        _1365 = (1.0 - _1335) * _1323;
                        _1366 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1337 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                        _1367 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1337 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                        _1368 = _1319 - _1336;
                    }
                    else
                    {
                        _1365 = _1323;
                        _1366 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                        _1367 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                        _1368 = _1319;
                    }
                    float _1372 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1368);
                    float _1386 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1368);
                    float _1397 = (_1367 * ((abs(_1372) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1372)) / _1372) : (0.693147182464599609375 - (0.2402265071868896484375 * _1372)))) + (_1366 * ((abs(_1386) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1386)) / _1386) : (0.693147182464599609375 - (0.2402265071868896484375 * _1386))));
                    float3 _1439;
                    if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                    {
                        float2 _1424 = float2(dot(_1320.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1320.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                        float3 _1425 = float3(_1424.x, _1424.y, _1320.z);
                        _1439 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1425, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1425, level(0.0)).xyz, float3(fast::clamp((_1323 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                    }
                    else
                    {
                        _1439 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                    }
                    float3 _1467;
                    if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                    {
                        _1467 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1320 * _1322, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1397 * fast::max(_1365 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                    }
                    else
                    {
                        _1467 = float3(0.0);
                    }
                    bool _1476 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1323 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                    float _1479 = _1476 ? 1.0 : fast::max(fast::clamp(exp2(-(_1397 * _1365)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                    float4 _1486 = float4((_1439 * (1.0 - _1479)) + select(_1467, float3(0.0), bool3(_1476)), _1479);
                    bool _1489 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                    float4 _1532;
                    if (_1489)
                    {
                        float _1492 = _1214.w;
                        float4 _1521;
                        if (_1489)
                        {
                            _1521 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1214.xy / float2(_1492)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1492 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                        }
                        else
                        {
                            _1521 = float4(0.0, 0.0, 0.0, 1.0);
                        }
                        _1532 = float4(_1521.xyz + (_1486.xyz * _1521.w), _1521.w * _1479);
                    }
                    else
                    {
                        _1532 = _1486;
                    }
                    _1539 = (_1532.xyz * (1.0 - _1215)) + (_1292 * _1532.w);
                }
                else
                {
                    _1539 = _1292;
                }
                float _1543 = (_1215 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1215;
                float2 _1549 = _393;
                _1549.x = 65504.0;
                float2 _1557;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1556 = _1549;
                    _1556.x = ((_1543 > 0.9900000095367431640625) ? _428 : _1207) * 9.9999997473787516355514526367188e-06;
                    _1557 = _1556;
                }
                else
                {
                    _1557 = _1549;
                }
                _1558 = _1557;
                _1559 = float4(_1539 * (_1202 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1543);
                break;
            }
        }
        if (_Globals.TargetCubeFace >= 0)
        {
            uint3 _1588 = uint3(gl_GlobalInvocationID.xy, uint(_Globals.TargetCubeFace));
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1597 = OutCloudColorCube.read(uint2(_1588.xy), uint(_1588.z));
                OutCloudColorCube.write(spvIdentity(float4((_1597.xyz * _1559.w) + _1559.xyz, _1597.w * _1559.w)), uint2(_1588.xy), uint(_1588.z));
            }
            else
            {
                OutCloudColorCube.write(spvIdentity(_1559), uint2(_1588.xy), uint(_1588.z));
            }
        }
        else
        {
            if (_Globals.bBlendCloudColor != 0)
            {
                float4 _1574 = OutCloudColor.read(uint2(gl_GlobalInvocationID.xy));
                OutCloudColor.write(spvIdentity(float4((_1574.xyz * _1559.w) + _1559.xyz, _1574.w * _1559.w)), uint2(gl_GlobalInvocationID.xy));
            }
            else
            {
                OutCloudColor.write(spvIdentity(_1559), uint2(gl_GlobalInvocationID.xy));
            }
        }
        OutCloudDepth.write(spvIdentity(_1558.xyyy), uint2(gl_GlobalInvocationID.xy));
    }
}

