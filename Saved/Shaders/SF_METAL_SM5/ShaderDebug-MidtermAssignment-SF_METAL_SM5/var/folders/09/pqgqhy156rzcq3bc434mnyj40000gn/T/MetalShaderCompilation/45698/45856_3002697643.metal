

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

constant float _167 = {};
constant float3 _169 = {};
constant uint3 _170 = {};
constant float4 _171 = {};
constant float2 _172 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000b320_b2f987ab(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(2)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(3)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(4)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(5)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], texture2d<float> Material_Texture2D_1 [[texture(8)]], texture3d<float> Material_VolumeTexture_0 [[texture(9)]], texture3d<float> Material_VolumeTexture_1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(5)]], sampler Material_Texture2D_0Sampler [[sampler(6)]], sampler Material_Texture2D_1Sampler [[sampler(7)]], sampler Material_VolumeTexture_0Sampler [[sampler(8)]], sampler Material_VolumeTexture_1Sampler [[sampler(9)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1398;
    float4 _1399;
    switch (0u)
    {
        default:
        {
            float _261;
            float _267;
            float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
            float3 _246 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
            float3 _247 = -normalize(-(_239.xyz / float3(_239.w)));
            float2 _281;
            bool _282;
            switch (0u)
            {
                default:
                {
                    float3 _259 = _246 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _261 = dot(_247, _247);
                    float _262 = dot(_247, _259);
                    float _263 = 2.0 * _262;
                    _267 = 4.0 * _261;
                    float _269 = (_263 * _263) - (_267 * (dot(_259, _259) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_269 >= 0.0)
                    {
                        _281 = (float2(_262 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_269))) / float2(2.0 * _261);
                        _282 = true;
                        break;
                    }
                    _281 = float2(0.0);
                    _282 = false;
                    break;
                }
            }
            float _287;
            float _339;
            float _340;
            if (_282)
            {
                _287 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                float2 _312;
                bool _313;
                switch (0u)
                {
                    default:
                    {
                        float3 _292 = _246 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _287).xyz;
                        float _294 = dot(_247, _292);
                        float _295 = 2.0 * _294;
                        float _300 = (_295 * _295) - (_267 * (dot(_292, _292) - (_287 * _287)));
                        if (_300 >= 0.0)
                        {
                            _312 = (float2(_294 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_300))) / float2(2.0 * _261);
                            _313 = true;
                            break;
                        }
                        _312 = float2(0.0);
                        _313 = false;
                        break;
                    }
                }
                if (_313)
                {
                    float _323 = fast::min(_281.x, _281.y);
                    bool _327 = all(_312 > float2(0.0));
                    float _332 = _327 ? fast::min(_312.x, _312.y) : fast::max(_312.x, _312.y);
                    float _336;
                    if (_327)
                    {
                        _336 = fast::max(0.0, _323);
                    }
                    else
                    {
                        _336 = all(_281 > float2(0.0)) ? _323 : fast::max(_281.x, _281.y);
                    }
                    _339 = fast::max(_332, _336);
                    _340 = fast::min(_332, _336);
                }
                else
                {
                    _339 = _281.y;
                    _340 = _281.x;
                }
            }
            else
            {
                _1398 = float2(65504.0);
                _1399 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _342 = fast::max(0.0, _340) * 100000.0;
            float _344 = fast::max(0.0, _339) * 100000.0;
            if ((_344 <= _342) || (_342 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1398 = float2(65504.0);
                _1399 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _364 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _372 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_364.xy), _364.z).x), 1.0);
            float _381 = length(((_372.xyz / float3(_372.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _383 = float2(65504.0);
            _383.y = _381 * 9.9999997473787516355514526367188e-06;
            bool _386 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_386 && (_381 < _342))
            {
                _1398 = _383;
                _1399 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _394;
            if (_386)
            {
                _394 = fast::min(_344, _381);
            }
            else
            {
                _394 = _344;
            }
            float3 _404 = View.View_AtmosphereLightColorGlobalPostTransmittance[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
            float _411 = _342 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _394 - _342);
            float _418 = _411 - _342;
            uint _425 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_418 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _427 = _418 / float(_425);
            float _428 = _427 * 0.00999999977648258209228515625;
            float3 _456;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _455;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _455 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _440 = _169;
                    _440.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _444 = _440;
                    _444.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _448 = _444;
                    _448.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _455 = fast::max(float3(0.0), _448);
                }
                _456 = _455;
            }
            else
            {
                _456 = float3(0.0);
            }
            float _462 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _473 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _474 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _476 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _247);
            float _477 = _473 * _473;
            float _482 = (1.0 + _477) + ((2.0 * _473) * _476);
            float _486 = (1.0 - _477) / ((12.56637096405029296875 * _482) * sqrt(_482));
            float _487 = _474 * _474;
            float _492 = (1.0 + _487) + ((2.0 * _474) * _476);
            float _499 = _486 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _487) / ((12.56637096405029296875 * _492) * sqrt(_492))) - _486));
            float3 _501 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _502 = _287 * 100000.0;
            float _505 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _502);
            float _541;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _521 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _522 = _521.y;
                uint _523 = _521.z;
                uint _526 = _521.x + (_522 * _523);
                uint _528 = _522 + (_523 * _526);
                uint3 _533 = _170;
                _533.x = _526 + (_528 * (_523 + (_526 * _528)));
                _541 = _342 + ((float((_533 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _427);
            }
            else
            {
                _541 = _342 + (0.5 * _427);
            }
            float3 _543;
            float3 _546;
            _543 = float3(1.0);
            _546 = float3(0.0);
            float3 _544;
            float3 _547;
            float _549;
            float _551;
            float _553;
            uint _1037;
            float3 _1038;
            float3 _1039;
            float _1040;
            float _1041;
            float _548 = 0.0;
            float _550 = 0.0;
            float _552 = _541;
            uint _554 = 0u;
            for (;;)
            {
                if (_554 < _425)
                {
                    float3 _559 = _247 * _552;
                    float3 _560 = View.View_WorldCameraOrigin + _559;
                    float _565 = fast::clamp((length(_560 - _501) - _502) * _505, 0.0, 1.0);
                    float4 _575 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_560 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _576 = _575.y;
                    float _592 = ((_565 < 0.0500000007450580596923828125) || (_565 > 0.949999988079071044921875)) ? 0.0 : (_575.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_576 <= 0.0) ? 0.0 : pow(_576, 0.25), 1.0 - _565), level(-1.0)).x);
                    if (_592 <= 0.0)
                    {
                        _544 = _543;
                        _547 = _546;
                        _549 = _548;
                        _551 = _550;
                        _553 = _552 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _427);
                        _1037 = _554 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _555 = _1037 + 1u;
                        _543 = _544;
                        _546 = _547;
                        _548 = _549;
                        _550 = _551;
                        _552 = _553;
                        _554 = _555;
                        continue;
                    }
                    float3 _610 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _611 = _610 * 0.1500000059604644775390625;
                    float3 _614 = _560 * Material.Material_ScalarExpressions[0].x;
                    float4 _622 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_611 + _614) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _625 = _622.x;
                    float _629 = _622.y;
                    float _633 = _622.z;
                    float3 _639 = float3(_592) * fast::clamp(float3((_625 <= 0.0) ? 0.0 : pow(_625, Material.Material_ScalarExpressions[0].z), (_629 <= 0.0) ? 0.0 : pow(_629, Material.Material_ScalarExpressions[0].z), (_633 <= 0.0) ? 0.0 : pow(_633, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _640 = _610 * (-0.100000001490116119384765625);
                    float4 _648 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_614 + _640) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _649 = _648.x;
                    float _657 = ((_649 <= 0.0) ? 0.0 : pow(_649, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _662 = float3(Material.Material_ScalarExpressions[1].w);
                    float _669 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _675 = fast::clamp(_565 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _684 = mix(_639, float3((_662 + (fast::clamp((_639 - float3(_657)) / float3(Material.Material_ScalarExpressions[1].z - _657), float3(0.0), float3(1.0)) * _669)).x), float3((_675 <= 0.0) ? 0.0 : pow(_675, Material.Material_ScalarExpressions[2].y)));
                    float3 _692 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _684) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _695 = _692.x;
                    float _699 = _692.y;
                    float _703 = _692.z;
                    float3 _717 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _684, _167).xyz, float3(0.0), float3(65000.0));
                    float3 _720 = fast::clamp(fast::clamp(float3((_695 <= 0.0) ? 0.0 : pow(_695, Material.Material_ScalarExpressions[2].w), (_699 <= 0.0) ? 0.0 : pow(_699, Material.Material_ScalarExpressions[2].w), (_703 <= 0.0) ? 0.0 : pow(_703, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _717;
                    float3 _983;
                    float3 _984;
                    if (any(_720 > float3(0.0)))
                    {
                        float _808;
                        if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                        {
                            float4 _743 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_560, 1.0);
                            float2 _747 = _743.xy / float2(_743.w);
                            bool2 _748 = _747 >= float2(0.0);
                            bool2 _749 = _747 <= float2(1.0);
                            float _807;
                            if (all(bool2(_748.x && _749.x, _748.y && _749.y)))
                            {
                                float2 _761 = (_747 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                float2 _762 = fract(_761);
                                float2 _763 = floor(_761);
                                float4 _771 = _171;
                                _771.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_763 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _777 = _771;
                                _777.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_763 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _783 = _777;
                                _783.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_763 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _788 = _783;
                                _788.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_763 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _798 = fast::clamp(fast::clamp((_788 * 40.0) - float4((_743.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _788 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                float2 _802 = mix(_798.wx, _798.zy, _762.xx);
                                _807 = mix(_802.x, _802.y, _762.y);
                            }
                            else
                            {
                                _807 = 1.0;
                            }
                            _808 = _807;
                        }
                        else
                        {
                            _808 = 1.0;
                        }
                        float4 _815 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_560, 1.0);
                        float2 _819 = _815.xy / float2(_815.w);
                        bool2 _823 = _819 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                        bool2 _825 = _819 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                        float _845;
                        if (all(bool2(_823.x && _825.x, _823.y && _825.y)))
                        {
                            float4 _833 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _819, level(0.0));
                            float _834 = _833.x;
                            _845 = fast::clamp(float(_815.z < (_834 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_834 == 1.0), 0.0, 1.0);
                        }
                        else
                        {
                            _845 = 1.0;
                        }
                        float _856 = fast::clamp((dot(_560 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                        float3 _860 = float3(1.0) * fast::min(_808, mix(_845, 1.0, _856 * _856));
                        float _866 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _867 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _869;
                        float3 _872;
                        _869 = float3(0.0);
                        _872 = float3(0.0);
                        float _875;
                        float3 _870;
                        float3 _873;
                        for (float _874 = 0.0, _876 = _866; _876 <= 1.0; _869 = _870, _872 = _873, _874 = _875, _876 += _866)
                        {
                            _875 = _876 * _876;
                            float _881 = _875 - _874;
                            float3 _886 = _560 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_874 + (_881 * 0.5))));
                            float _891 = fast::clamp((length(_886 - _501) - _502) * _505, 0.0, 1.0);
                            float4 _897 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_886 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _898 = _897.y;
                            float _912 = ((_891 < 0.0500000007450580596923828125) || (_891 > 0.949999988079071044921875)) ? 0.0 : (_897.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_898 <= 0.0) ? 0.0 : pow(_898, 0.25), 1.0 - _891), level(-1.0)).x);
                            if (_912 <= 0.0)
                            {
                                _870 = _869;
                                _873 = _872;
                                continue;
                            }
                            float3 _917 = _886 * Material.Material_ScalarExpressions[0].x;
                            float4 _921 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_611 + _917) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _922 = _921.x;
                            float _926 = _921.y;
                            float _930 = _921.z;
                            float3 _936 = float3(_912) * fast::clamp(float3((_922 <= 0.0) ? 0.0 : pow(_922, Material.Material_ScalarExpressions[0].z), (_926 <= 0.0) ? 0.0 : pow(_926, Material.Material_ScalarExpressions[0].z), (_930 <= 0.0) ? 0.0 : pow(_930, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _940 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_917 + _640) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _941 = _940.x;
                            float _945 = ((_941 <= 0.0) ? 0.0 : pow(_941, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _955 = fast::clamp(_891 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _969 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_936, float3((_662 + (fast::clamp((_936 - float3(_945)) / float3(Material.Material_ScalarExpressions[1].z - _945), float3(0.0), float3(1.0)) * _669)).x), float3((_955 <= 0.0) ? 0.0 : pow(_955, Material.Material_ScalarExpressions[2].y))), _167).xyz, float3(0.0), float3(65000.0));
                            _870 = _869 + ((_969 * _462) * _881);
                            _873 = _872 + (_969 * _881);
                        }
                        _983 = _860 * exp((-_872) * _867);
                        _984 = _860 * exp((-_869) * _867);
                    }
                    else
                    {
                        _983 = float3(1.0);
                        _984 = float3(1.0);
                    }
                    float _997;
                    float _998;
                    if (any(_717 > float3(0.0)))
                    {
                        float _993 = fast::min(_543.x, fast::min(_543.y, _543.z));
                        _997 = _550 + (_552 * _993);
                        _998 = _548 + _993;
                    }
                    else
                    {
                        _997 = _550;
                        _998 = _548;
                    }
                    float3 _1003 = (((_984 * _404) * mix(0.079577468335628509521484375, _499, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_720 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _1004 = fast::max(float3(9.9999999747524270787835121154785e-07), _717 * _462);
                    float3 _1017 = (((_983 * _404) * _499) + (_456 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _565, 0.0, 1.0)).xyz) * _720;
                    float3 _1018 = fast::max(float3(9.9999999747524270787835121154785e-07), _717);
                    float3 _1021 = exp((-_1018) * _428);
                    float3 _1026 = (_546 + (_543 * ((_1003 - (_1003 * exp((-_1004) * _428))) / _1004))) + (_543 * ((_1017 - (_1017 * _1021)) / _1018));
                    float3 _1027 = _543 * _1021;
                    if (all(_1027 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _1038 = _1027;
                        _1039 = _1026;
                        _1040 = _997;
                        _1041 = _998;
                        break;
                    }
                    _544 = _1027;
                    _547 = _1026;
                    _549 = _998;
                    _551 = _997;
                    _553 = _552 + _427;
                    _1037 = _554;
                    uint _555 = _1037 + 1u;
                    _543 = _544;
                    _546 = _547;
                    _548 = _549;
                    _550 = _551;
                    _552 = _553;
                    _554 = _555;
                    continue;
                }
                else
                {
                    _1038 = _543;
                    _1039 = _546;
                    _1040 = _550;
                    _1041 = _548;
                    break;
                }
            }
            bool _1042 = View.View_RealTimeReflectionCapture != 0.0;
            float _1047 = (_1041 == 0.0) ? _411 : (_1040 / fast::max(1.0000000133514319600180897396058e-10, _1041));
            float3 _1049 = View.View_WorldCameraOrigin + (_247 * _1047);
            float4 _1054 = View.View_WorldToClip * float4(_1049, 1.0);
            float _1055 = dot(_1038, float3(0.3333333432674407958984375));
            bool _1059 = _1041 > 0.0;
            float3 _1132;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1059)
            {
                float3 _1071 = (_1049 * 9.9999997473787516355514526367188e-06) - _246;
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
                    float2 _1095 = _172;
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
            float2 _1389 = _383;
            _1389.x = 65504.0;
            float2 _1397;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1396 = _1389;
                _1396.x = ((_1383 > 0.9900000095367431640625) ? _411 : _1047) * 9.9999997473787516355514526367188e-06;
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

