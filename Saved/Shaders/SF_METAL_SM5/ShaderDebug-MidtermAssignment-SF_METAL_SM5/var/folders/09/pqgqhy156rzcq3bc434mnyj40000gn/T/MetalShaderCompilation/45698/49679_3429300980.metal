

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

constant float _157 = {};
constant float3 _159 = {};
constant uint3 _160 = {};
constant float2 _161 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000c20f_cc66faf4(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(3)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(4)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture3d<float> Material_VolumeTexture_0 [[texture(8)]], texture3d<float> Material_VolumeTexture_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(4)]], sampler Material_Texture2D_0Sampler [[sampler(5)]], sampler Material_Texture2D_1Sampler [[sampler(6)]], sampler Material_VolumeTexture_0Sampler [[sampler(7)]], sampler Material_VolumeTexture_1Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1542;
    float4 _1543;
    switch (0u)
    {
        default:
        {
            float _255;
            float _261;
            float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
            float3 _240 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
            float3 _241 = -normalize(-(_233.xyz / float3(_233.w)));
            float2 _275;
            bool _276;
            switch (0u)
            {
                default:
                {
                    float3 _253 = _240 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _255 = dot(_241, _241);
                    float _256 = dot(_241, _253);
                    float _257 = 2.0 * _256;
                    _261 = 4.0 * _255;
                    float _263 = (_257 * _257) - (_261 * (dot(_253, _253) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_263 >= 0.0)
                    {
                        _275 = (float2(_256 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_263))) / float2(2.0 * _255);
                        _276 = true;
                        break;
                    }
                    _275 = float2(0.0);
                    _276 = false;
                    break;
                }
            }
            float _281;
            float _333;
            float _334;
            if (_276)
            {
                _281 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                float2 _306;
                bool _307;
                switch (0u)
                {
                    default:
                    {
                        float3 _286 = _240 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _281).xyz;
                        float _288 = dot(_241, _286);
                        float _289 = 2.0 * _288;
                        float _294 = (_289 * _289) - (_261 * (dot(_286, _286) - (_281 * _281)));
                        if (_294 >= 0.0)
                        {
                            _306 = (float2(_288 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_294))) / float2(2.0 * _255);
                            _307 = true;
                            break;
                        }
                        _306 = float2(0.0);
                        _307 = false;
                        break;
                    }
                }
                if (_307)
                {
                    float _317 = fast::min(_275.x, _275.y);
                    bool _321 = all(_306 > float2(0.0));
                    float _326 = _321 ? fast::min(_306.x, _306.y) : fast::max(_306.x, _306.y);
                    float _330;
                    if (_321)
                    {
                        _330 = fast::max(0.0, _317);
                    }
                    else
                    {
                        _330 = all(_275 > float2(0.0)) ? _317 : fast::max(_275.x, _275.y);
                    }
                    _333 = fast::max(_326, _330);
                    _334 = fast::min(_326, _330);
                }
                else
                {
                    _333 = _275.y;
                    _334 = _275.x;
                }
            }
            else
            {
                _1542 = float2(65504.0);
                _1543 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _336 = fast::max(0.0, _334) * 100000.0;
            float _338 = fast::max(0.0, _333) * 100000.0;
            if ((_338 <= _336) || (_336 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1542 = float2(65504.0);
                _1543 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _358 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _366 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_358.xy), _358.z).x), 1.0);
            float _375 = length(((_366.xyz / float3(_366.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _377 = float2(65504.0);
            _377.y = _375 * 9.9999997473787516355514526367188e-06;
            bool _380 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_380 && (_375 < _336))
            {
                _1542 = _377;
                _1543 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _388;
            if (_380)
            {
                _388 = fast::min(_338, _375);
            }
            else
            {
                _388 = _338;
            }
            bool3 _393 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
            float3 _398 = View.View_AtmosphereLightColor[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _393);
            float3 _405 = View.View_AtmosphereLightColor[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _393);
            float _412 = _336 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _388 - _336);
            float _419 = _412 - _336;
            uint _426 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_419 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _428 = _419 / float(_426);
            float _429 = _428 * 0.00999999977648258209228515625;
            float3 _457;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _456;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _456 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _441 = _159;
                    _441.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _445 = _441;
                    _445.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _449 = _445;
                    _449.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _456 = fast::max(float3(0.0), _449);
                }
                _457 = _456;
            }
            else
            {
                _457 = float3(0.0);
            }
            float _463 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _466 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
            float _475 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _476 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _477 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
            float _478 = -dot(View.View_AtmosphereLightDirection[0].xyz, _241);
            float _479 = _475 * _475;
            float _480 = 1.0 - _479;
            float _481 = 1.0 + _479;
            float _482 = 2.0 * _475;
            float _484 = _481 + (_482 * _478);
            float _488 = _480 / ((12.56637096405029296875 * _484) * sqrt(_484));
            float _489 = _476 * _476;
            float _490 = 1.0 - _489;
            float _491 = 1.0 + _489;
            float _492 = 2.0 * _476;
            float _494 = _491 + (_492 * _478);
            float _501 = _488 + (_477 * ((_490 / ((12.56637096405029296875 * _494) * sqrt(_494))) - _488));
            float _502 = -dot(View.View_AtmosphereLightDirection[1].xyz, _241);
            float _504 = _481 + (_482 * _502);
            float _508 = _480 / ((12.56637096405029296875 * _504) * sqrt(_504));
            float _510 = _491 + (_492 * _502);
            float _517 = _508 + (_477 * ((_490 / ((12.56637096405029296875 * _510) * sqrt(_510))) - _508));
            float3 _520 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _521 = _281 * 100000.0;
            float _524 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _521);
            float _560;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _540 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _541 = _540.y;
                uint _542 = _540.z;
                uint _545 = _540.x + (_541 * _542);
                uint _547 = _541 + (_542 * _545);
                uint3 _552 = _160;
                _552.x = _545 + (_547 * (_542 + (_545 * _547)));
                _560 = _336 + ((float((_552 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _428);
            }
            else
            {
                _560 = _336 + (0.5 * _428);
            }
            float3 _562;
            float3 _565;
            _562 = float3(1.0);
            _565 = float3(0.0);
            float3 _563;
            float3 _566;
            float _568;
            float _570;
            float _572;
            uint _1181;
            float3 _1182;
            float3 _1183;
            float _1184;
            float _1185;
            float _567 = 0.0;
            float _569 = 0.0;
            float _571 = _560;
            uint _573 = 0u;
            for (;;)
            {
                if (_573 < _426)
                {
                    float3 _578 = _241 * _571;
                    float3 _579 = View.View_WorldCameraOrigin + _578;
                    float _584 = fast::clamp((length(_579 - _520) - _521) * _524, 0.0, 1.0);
                    float4 _594 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_579 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _595 = _594.y;
                    float _611 = ((_584 < 0.0500000007450580596923828125) || (_584 > 0.949999988079071044921875)) ? 0.0 : (_594.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_595 <= 0.0) ? 0.0 : pow(_595, 0.25), 1.0 - _584), level(-1.0)).x);
                    if (_611 <= 0.0)
                    {
                        _563 = _562;
                        _566 = _565;
                        _568 = _567;
                        _570 = _569;
                        _572 = _571 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _428);
                        _1181 = _573 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _574 = _1181 + 1u;
                        _562 = _563;
                        _565 = _566;
                        _567 = _568;
                        _569 = _570;
                        _571 = _572;
                        _573 = _574;
                        continue;
                    }
                    float3 _748;
                    float _753;
                    float _754;
                    float3 _629 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _630 = _629 * 0.1500000059604644775390625;
                    float3 _633 = _579 * Material.Material_ScalarExpressions[0].x;
                    float4 _641 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_630 + _633) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _644 = _641.x;
                    float _648 = _641.y;
                    float _652 = _641.z;
                    float3 _658 = float3(_611) * fast::clamp(float3((_644 <= 0.0) ? 0.0 : pow(_644, Material.Material_ScalarExpressions[0].z), (_648 <= 0.0) ? 0.0 : pow(_648, Material.Material_ScalarExpressions[0].z), (_652 <= 0.0) ? 0.0 : pow(_652, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _659 = _629 * (-0.100000001490116119384765625);
                    float4 _667 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_633 + _659) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _668 = _667.x;
                    float _676 = ((_668 <= 0.0) ? 0.0 : pow(_668, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _681 = float3(Material.Material_ScalarExpressions[1].w);
                    float _688 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _694 = fast::clamp(_584 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _703 = mix(_658, float3((_681 + (fast::clamp((_658 - float3(_676)) / float3(Material.Material_ScalarExpressions[1].z - _676), float3(0.0), float3(1.0)) * _688)).x), float3((_694 <= 0.0) ? 0.0 : pow(_694, Material.Material_ScalarExpressions[2].y)));
                    float3 _711 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _703) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _714 = _711.x;
                    float _718 = _711.y;
                    float _722 = _711.z;
                    float3 _736 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _703, _157).xyz, float3(0.0), float3(65000.0));
                    float3 _741 = (_579 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                    float3 _809;
                    switch (0u)
                    {
                        default:
                        {
                            _748 = _741 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                            float _750 = dot(View.View_AtmosphereLightDirection[0].xyz, View.View_AtmosphereLightDirection[0].xyz);
                            float _751 = dot(View.View_AtmosphereLightDirection[0].xyz, _748);
                            float _752 = 2.0 * _751;
                            _753 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                            _754 = dot(_748, _748) - _753;
                            float _758 = (_752 * _752) - ((4.0 * _750) * _754);
                            float2 _770;
                            if (_758 >= 0.0)
                            {
                                _770 = (float2(_751 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_758))) / float2(2.0 * _750);
                            }
                            else
                            {
                                _770 = float2(-1.0);
                            }
                            if ((_770.x > 0.0) || (_770.y > 0.0))
                            {
                                _809 = float3(0.0);
                                break;
                            }
                            float _778 = length(_741);
                            float _781 = dot(View.View_AtmosphereLightDirection[0].xyz, _741 / float3(_778));
                            float _782 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                            float _785 = sqrt(fast::max(0.0, _782 - _753));
                            float _786 = _778 * _778;
                            float _789 = sqrt(fast::max(0.0, _786 - _753));
                            float _799 = View.View_SkyAtmosphereTopRadiusKm - _778;
                            _809 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_778) * _781) + sqrt((_786 * ((_781 * _781) - 1.0)) + _782)) - _799) / ((_789 + _785) - _799), _789 / _785), level(0.0)).xyz;
                            break;
                        }
                    }
                    float3 _869;
                    switch (0u)
                    {
                        default:
                        {
                            float _812 = dot(View.View_AtmosphereLightDirection[1].xyz, View.View_AtmosphereLightDirection[1].xyz);
                            float _813 = dot(View.View_AtmosphereLightDirection[1].xyz, _748);
                            float _814 = 2.0 * _813;
                            float _818 = (_814 * _814) - ((4.0 * _812) * _754);
                            float2 _830;
                            if (_818 >= 0.0)
                            {
                                _830 = (float2(_813 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_818))) / float2(2.0 * _812);
                            }
                            else
                            {
                                _830 = float2(-1.0);
                            }
                            if ((_830.x > 0.0) || (_830.y > 0.0))
                            {
                                _869 = float3(0.0);
                                break;
                            }
                            float _838 = length(_741);
                            float _841 = dot(View.View_AtmosphereLightDirection[1].xyz, _741 / float3(_838));
                            float _842 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                            float _845 = sqrt(fast::max(0.0, _842 - _753));
                            float _846 = _838 * _838;
                            float _849 = sqrt(fast::max(0.0, _846 - _753));
                            float _859 = View.View_SkyAtmosphereTopRadiusKm - _838;
                            _869 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_838) * _841) + sqrt((_846 * ((_841 * _841) - 1.0)) + _842)) - _859) / ((_849 + _845) - _859), _849 / _845), level(0.0)).xyz;
                            break;
                        }
                    }
                    float3 _870 = fast::clamp(fast::clamp(float3((_714 <= 0.0) ? 0.0 : pow(_714, Material.Material_ScalarExpressions[2].w), (_718 <= 0.0) ? 0.0 : pow(_718, Material.Material_ScalarExpressions[2].w), (_722 <= 0.0) ? 0.0 : pow(_722, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _736;
                    float3 _1119;
                    float3 _1120;
                    float3 _1121;
                    float3 _1122;
                    if (any(_870 > float3(0.0)))
                    {
                        float _887 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _888 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _890;
                        float3 _893;
                        _890 = float3(0.0);
                        _893 = float3(0.0);
                        float _896;
                        float3 _891;
                        float3 _894;
                        for (float _895 = 0.0, _897 = _887; _897 <= 1.0; _890 = _891, _893 = _894, _895 = _896, _897 += _887)
                        {
                            _896 = _897 * _897;
                            float _902 = _896 - _895;
                            float3 _907 = _579 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_895 + (_902 * 0.5))));
                            float _912 = fast::clamp((length(_907 - _520) - _521) * _524, 0.0, 1.0);
                            float4 _918 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_907 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _919 = _918.y;
                            float _933 = ((_912 < 0.0500000007450580596923828125) || (_912 > 0.949999988079071044921875)) ? 0.0 : (_918.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_919 <= 0.0) ? 0.0 : pow(_919, 0.25), 1.0 - _912), level(-1.0)).x);
                            if (_933 <= 0.0)
                            {
                                _891 = _890;
                                _894 = _893;
                                continue;
                            }
                            float3 _938 = _907 * Material.Material_ScalarExpressions[0].x;
                            float4 _942 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_630 + _938) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _943 = _942.x;
                            float _947 = _942.y;
                            float _951 = _942.z;
                            float3 _957 = float3(_933) * fast::clamp(float3((_943 <= 0.0) ? 0.0 : pow(_943, Material.Material_ScalarExpressions[0].z), (_947 <= 0.0) ? 0.0 : pow(_947, Material.Material_ScalarExpressions[0].z), (_951 <= 0.0) ? 0.0 : pow(_951, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _961 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_938 + _659) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _962 = _961.x;
                            float _966 = ((_962 <= 0.0) ? 0.0 : pow(_962, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _976 = fast::clamp(_912 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _990 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_957, float3((_681 + (fast::clamp((_957 - float3(_966)) / float3(Material.Material_ScalarExpressions[1].z - _966), float3(0.0), float3(1.0)) * _688)).x), float3((_976 <= 0.0) ? 0.0 : pow(_976, Material.Material_ScalarExpressions[2].y))), _157).xyz, float3(0.0), float3(65000.0));
                            _891 = _890 + ((_990 * _463) * _902);
                            _894 = _893 + (_990 * _902);
                        }
                        float3 _1005;
                        float3 _1008;
                        _1005 = float3(0.0);
                        _1008 = float3(0.0);
                        float _1011;
                        float3 _1006;
                        float3 _1009;
                        for (float _1010 = 0.0, _1012 = _887; _1012 <= 1.0; _1005 = _1006, _1008 = _1009, _1010 = _1011, _1012 += _887)
                        {
                            _1011 = _1012 * _1012;
                            float _1017 = _1011 - _1010;
                            float3 _1022 = _579 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1010 + (_1017 * 0.5))));
                            float _1027 = fast::clamp((length(_1022 - _520) - _521) * _524, 0.0, 1.0);
                            float4 _1033 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1022 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _1034 = _1033.y;
                            float _1048 = ((_1027 < 0.0500000007450580596923828125) || (_1027 > 0.949999988079071044921875)) ? 0.0 : (_1033.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1034 <= 0.0) ? 0.0 : pow(_1034, 0.25), 1.0 - _1027), level(-1.0)).x);
                            if (_1048 <= 0.0)
                            {
                                _1006 = _1005;
                                _1009 = _1008;
                                continue;
                            }
                            float3 _1053 = _1022 * Material.Material_ScalarExpressions[0].x;
                            float4 _1057 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_630 + _1053) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _1058 = _1057.x;
                            float _1062 = _1057.y;
                            float _1066 = _1057.z;
                            float3 _1072 = float3(_1048) * fast::clamp(float3((_1058 <= 0.0) ? 0.0 : pow(_1058, Material.Material_ScalarExpressions[0].z), (_1062 <= 0.0) ? 0.0 : pow(_1062, Material.Material_ScalarExpressions[0].z), (_1066 <= 0.0) ? 0.0 : pow(_1066, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _1076 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1053 + _659) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _1077 = _1076.x;
                            float _1081 = ((_1077 <= 0.0) ? 0.0 : pow(_1077, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _1091 = fast::clamp(_1027 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _1105 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1072, float3((_681 + (fast::clamp((_1072 - float3(_1081)) / float3(Material.Material_ScalarExpressions[1].z - _1081), float3(0.0), float3(1.0)) * _688)).x), float3((_1091 <= 0.0) ? 0.0 : pow(_1091, Material.Material_ScalarExpressions[2].y))), _157).xyz, float3(0.0), float3(65000.0));
                            _1006 = _1005 + ((_1105 * _463) * _1017);
                            _1009 = _1008 + (_1105 * _1017);
                        }
                        _1119 = _869 * exp((-_1008) * _888);
                        _1120 = _809 * exp((-_893) * _888);
                        _1121 = _869 * exp((-_1005) * _888);
                        _1122 = _809 * exp((-_890) * _888);
                    }
                    else
                    {
                        _1119 = _869;
                        _1120 = _809;
                        _1121 = _869;
                        _1122 = _809;
                    }
                    float _1135;
                    float _1136;
                    if (any(_736 > float3(0.0)))
                    {
                        float _1131 = fast::min(_562.x, fast::min(_562.y, _562.z));
                        _1135 = _569 + (_571 * _1131);
                        _1136 = _567 + _1131;
                    }
                    else
                    {
                        _1135 = _569;
                        _1136 = _567;
                    }
                    float3 _1144 = ((((_1122 * _398) * mix(0.079577468335628509521484375, _501, _466)) + ((_1121 * _405) * mix(0.079577468335628509521484375, _517, _466))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_870 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _1145 = fast::max(float3(9.9999999747524270787835121154785e-07), _736 * _463);
                    float3 _1161 = ((((_1120 * _398) * _501) + ((_1119 * _405) * _517)) + (_457 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _584, 0.0, 1.0)).xyz) * _870;
                    float3 _1162 = fast::max(float3(9.9999999747524270787835121154785e-07), _736);
                    float3 _1165 = exp((-_1162) * _429);
                    float3 _1170 = (_565 + (_562 * ((_1144 - (_1144 * exp((-_1145) * _429))) / _1145))) + (_562 * ((_1161 - (_1161 * _1165)) / _1162));
                    float3 _1171 = _562 * _1165;
                    if (all(_1171 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _1182 = _1171;
                        _1183 = _1170;
                        _1184 = _1135;
                        _1185 = _1136;
                        break;
                    }
                    _563 = _1171;
                    _566 = _1170;
                    _568 = _1136;
                    _570 = _1135;
                    _572 = _571 + _428;
                    _1181 = _573;
                    uint _574 = _1181 + 1u;
                    _562 = _563;
                    _565 = _566;
                    _567 = _568;
                    _569 = _570;
                    _571 = _572;
                    _573 = _574;
                    continue;
                }
                else
                {
                    _1182 = _562;
                    _1183 = _565;
                    _1184 = _569;
                    _1185 = _567;
                    break;
                }
            }
            bool _1186 = View.View_RealTimeReflectionCapture != 0.0;
            float _1191 = (_1185 == 0.0) ? _412 : (_1184 / fast::max(1.0000000133514319600180897396058e-10, _1185));
            float3 _1193 = View.View_WorldCameraOrigin + (_241 * _1191);
            float4 _1198 = View.View_WorldToClip * float4(_1193, 1.0);
            float _1199 = dot(_1182, float3(0.3333333432674407958984375));
            bool _1203 = _1185 > 0.0;
            float3 _1276;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1203)
            {
                float3 _1215 = (_1193 * 9.9999997473787516355514526367188e-06) - _240;
                float _1221 = sqrt((fast::max(0.0, length(_1215) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                float _1222 = _1221 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                float _1229;
                if (_1222 < 0.707106769084930419921875)
                {
                    _1229 = fast::clamp((_1222 * _1222) * 2.0, 0.0, 1.0);
                }
                else
                {
                    _1229 = 1.0;
                }
                float2 _1257;
                if (_1186)
                {
                    float3 _1232 = normalize(_1215);
                    float _1233 = _1232.z;
                    float _1236 = sqrt(1.0 - (_1233 * _1233));
                    float2 _1239 = _161;
                    _1239.y = (_1233 * 0.5) + 0.5;
                    float _1244 = acos(_1232.x / _1236);
                    float2 _1249 = _1239;
                    _1249.x = (((_1232.y / _1236) < 0.0) ? (6.283185482025146484375 - _1244) : _1244) * 0.15915493667125701904296875;
                    _1257 = (_1249 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                }
                else
                {
                    _1257 = ((_1198.xy / _1198.ww) * float2(0.5, -0.5)) + float2(0.5);
                }
                float4 _1262 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1257, _1221), level(0.0));
                _1276 = (((_1262.xyz * _1229).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1199)) + (_1183 * (1.0 - (_1229 * (1.0 - _1262.w))));
            }
            else
            {
                _1276 = _1183;
            }
            float3 _1523;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1203)
            {
                float3 _1283 = _1193 - View.View_WorldCameraOrigin;
                float _1300 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                float _1303 = _1283.z + (View.View_WorldCameraOrigin.z - _1300);
                float3 _1304 = _1283;
                _1304.z = _1303;
                float _1305 = dot(_1304, _1304);
                float _1306 = rsqrt(_1305);
                float _1307 = _1305 * _1306;
                float _1315 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1283) / dot(_1283, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                float _1349;
                float _1350;
                float _1351;
                float _1352;
                if (_1315 > 0.0)
                {
                    float _1319 = _1315 * _1306;
                    float _1320 = _1319 * _1303;
                    float _1321 = _1300 + _1320;
                    _1349 = (1.0 - _1319) * _1307;
                    _1350 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1321 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                    _1351 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1321 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                    _1352 = _1303 - _1320;
                }
                else
                {
                    _1349 = _1307;
                    _1350 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                    _1351 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                    _1352 = _1303;
                }
                float _1356 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1352);
                float _1370 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1352);
                float _1381 = (_1351 * ((abs(_1356) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1356)) / _1356) : (0.693147182464599609375 - (0.2402265071868896484375 * _1356)))) + (_1350 * ((abs(_1370) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1370)) / _1370) : (0.693147182464599609375 - (0.2402265071868896484375 * _1370))));
                float3 _1423;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                {
                    float2 _1408 = float2(dot(_1304.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1304.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                    float3 _1409 = float3(_1408.x, _1408.y, _1304.z);
                    _1423 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1409, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1409, level(0.0)).xyz, float3(fast::clamp((_1307 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                }
                else
                {
                    _1423 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                }
                float3 _1451;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                {
                    _1451 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1304 * _1306, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1381 * fast::max(_1349 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                }
                else
                {
                    _1451 = float3(0.0);
                }
                bool _1460 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1307 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                float _1463 = _1460 ? 1.0 : fast::max(fast::clamp(exp2(-(_1381 * _1349)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                float4 _1470 = float4((_1423 * (1.0 - _1463)) + select(_1451, float3(0.0), bool3(_1460)), _1463);
                bool _1473 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                float4 _1516;
                if (_1473)
                {
                    float _1476 = _1198.w;
                    float4 _1505;
                    if (_1473)
                    {
                        _1505 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1198.xy / float2(_1476)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1476 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                    }
                    else
                    {
                        _1505 = float4(0.0, 0.0, 0.0, 1.0);
                    }
                    _1516 = float4(_1505.xyz + (_1470.xyz * _1505.w), _1505.w * _1463);
                }
                else
                {
                    _1516 = _1470;
                }
                _1523 = (_1516.xyz * (1.0 - _1199)) + (_1276 * _1516.w);
            }
            else
            {
                _1523 = _1276;
            }
            float _1527 = (_1199 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1199;
            float2 _1533 = _377;
            _1533.x = 65504.0;
            float2 _1541;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1540 = _1533;
                _1540.x = ((_1527 > 0.9900000095367431640625) ? _412 : _1191) * 9.9999997473787516355514526367188e-06;
                _1541 = _1540;
            }
            else
            {
                _1541 = _1533;
            }
            _1542 = _1541;
            _1543 = float4(_1523 * (_1186 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1527);
            break;
        }
    }
    out.out_var_SV_Target0 = _1543;
    out.out_var_SV_Target1 = _1542;
    return out;
}

