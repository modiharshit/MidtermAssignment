

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

constant float _156 = {};
constant float3 _158 = {};
constant uint3 _159 = {};
constant float2 _160 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000a6cc_032439be(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(3)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(4)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture3d<float> Material_VolumeTexture_0 [[texture(8)]], texture3d<float> Material_VolumeTexture_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(4)]], sampler Material_Texture2D_0Sampler [[sampler(5)]], sampler Material_Texture2D_1Sampler [[sampler(6)]], sampler Material_VolumeTexture_0Sampler [[sampler(7)]], sampler Material_VolumeTexture_1Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1329;
    float4 _1330;
    switch (0u)
    {
        default:
        {
            float _250;
            float _256;
            float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
            float3 _235 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
            float3 _236 = -normalize(-(_228.xyz / float3(_228.w)));
            float2 _270;
            bool _271;
            switch (0u)
            {
                default:
                {
                    float3 _248 = _235 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _250 = dot(_236, _236);
                    float _251 = dot(_236, _248);
                    float _252 = 2.0 * _251;
                    _256 = 4.0 * _250;
                    float _258 = (_252 * _252) - (_256 * (dot(_248, _248) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_258 >= 0.0)
                    {
                        _270 = (float2(_251 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_258))) / float2(2.0 * _250);
                        _271 = true;
                        break;
                    }
                    _270 = float2(0.0);
                    _271 = false;
                    break;
                }
            }
            float _276;
            float _328;
            float _329;
            if (_271)
            {
                _276 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                float2 _301;
                bool _302;
                switch (0u)
                {
                    default:
                    {
                        float3 _281 = _235 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _276).xyz;
                        float _283 = dot(_236, _281);
                        float _284 = 2.0 * _283;
                        float _289 = (_284 * _284) - (_256 * (dot(_281, _281) - (_276 * _276)));
                        if (_289 >= 0.0)
                        {
                            _301 = (float2(_283 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_289))) / float2(2.0 * _250);
                            _302 = true;
                            break;
                        }
                        _301 = float2(0.0);
                        _302 = false;
                        break;
                    }
                }
                if (_302)
                {
                    float _312 = fast::min(_270.x, _270.y);
                    bool _316 = all(_301 > float2(0.0));
                    float _321 = _316 ? fast::min(_301.x, _301.y) : fast::max(_301.x, _301.y);
                    float _325;
                    if (_316)
                    {
                        _325 = fast::max(0.0, _312);
                    }
                    else
                    {
                        _325 = all(_270 > float2(0.0)) ? _312 : fast::max(_270.x, _270.y);
                    }
                    _328 = fast::max(_321, _325);
                    _329 = fast::min(_321, _325);
                }
                else
                {
                    _328 = _270.y;
                    _329 = _270.x;
                }
            }
            else
            {
                _1329 = float2(65504.0);
                _1330 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _331 = fast::max(0.0, _329) * 100000.0;
            float _333 = fast::max(0.0, _328) * 100000.0;
            if ((_333 <= _331) || (_331 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1329 = float2(65504.0);
                _1330 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _353 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _361 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_353.xy), _353.z).x), 1.0);
            float _370 = length(((_361.xyz / float3(_361.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _372 = float2(65504.0);
            _372.y = _370 * 9.9999997473787516355514526367188e-06;
            bool _375 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_375 && (_370 < _331))
            {
                _1329 = _372;
                _1330 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _383;
            if (_375)
            {
                _383 = fast::min(_333, _370);
            }
            else
            {
                _383 = _333;
            }
            float3 _393 = View.View_AtmosphereLightColor[0u].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0));
            float _400 = _331 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _383 - _331);
            float _407 = _400 - _331;
            uint _414 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_407 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _416 = _407 / float(_414);
            float _417 = _416 * 0.00999999977648258209228515625;
            float3 _445;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _444;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _444 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _429 = _158;
                    _429.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _433 = _429;
                    _433.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _437 = _433;
                    _437.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _444 = fast::max(float3(0.0), _437);
                }
                _445 = _444;
            }
            else
            {
                _445 = float3(0.0);
            }
            float _451 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _462 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _463 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _465 = -dot(View.View_AtmosphereLightDirection[0u].xyz, _236);
            float _466 = _462 * _462;
            float _471 = (1.0 + _466) + ((2.0 * _462) * _465);
            float _475 = (1.0 - _466) / ((12.56637096405029296875 * _471) * sqrt(_471));
            float _476 = _463 * _463;
            float _481 = (1.0 + _476) + ((2.0 * _463) * _465);
            float _488 = _475 + (fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0) * (((1.0 - _476) / ((12.56637096405029296875 * _481) * sqrt(_481))) - _475));
            float3 _490 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _491 = _276 * 100000.0;
            float _494 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _491);
            float _530;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _510 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _511 = _510.y;
                uint _512 = _510.z;
                uint _515 = _510.x + (_511 * _512);
                uint _517 = _511 + (_512 * _515);
                uint3 _522 = _159;
                _522.x = _515 + (_517 * (_512 + (_515 * _517)));
                _530 = _331 + ((float((_522 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _416);
            }
            else
            {
                _530 = _331 + (0.5 * _416);
            }
            float3 _532;
            float3 _535;
            _532 = float3(1.0);
            _535 = float3(0.0);
            float3 _533;
            float3 _536;
            float _538;
            float _540;
            float _542;
            uint _968;
            float3 _969;
            float3 _970;
            float _971;
            float _972;
            float _537 = 0.0;
            float _539 = 0.0;
            float _541 = _530;
            uint _543 = 0u;
            for (;;)
            {
                if (_543 < _414)
                {
                    float3 _548 = _236 * _541;
                    float3 _549 = View.View_WorldCameraOrigin + _548;
                    float _554 = fast::clamp((length(_549 - _490) - _491) * _494, 0.0, 1.0);
                    float4 _564 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_549 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _565 = _564.y;
                    float _581 = ((_554 < 0.0500000007450580596923828125) || (_554 > 0.949999988079071044921875)) ? 0.0 : (_564.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_565 <= 0.0) ? 0.0 : pow(_565, 0.25), 1.0 - _554), level(-1.0)).x);
                    if (_581 <= 0.0)
                    {
                        _533 = _532;
                        _536 = _535;
                        _538 = _537;
                        _540 = _539;
                        _542 = _541 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _416);
                        _968 = _543 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _544 = _968 + 1u;
                        _532 = _533;
                        _535 = _536;
                        _537 = _538;
                        _539 = _540;
                        _541 = _542;
                        _543 = _544;
                        continue;
                    }
                    float3 _599 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _600 = _599 * 0.1500000059604644775390625;
                    float3 _603 = _549 * Material.Material_ScalarExpressions[0].x;
                    float4 _611 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_600 + _603) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _614 = _611.x;
                    float _618 = _611.y;
                    float _622 = _611.z;
                    float3 _628 = float3(_581) * fast::clamp(float3((_614 <= 0.0) ? 0.0 : pow(_614, Material.Material_ScalarExpressions[0].z), (_618 <= 0.0) ? 0.0 : pow(_618, Material.Material_ScalarExpressions[0].z), (_622 <= 0.0) ? 0.0 : pow(_622, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _629 = _599 * (-0.100000001490116119384765625);
                    float4 _637 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_603 + _629) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _638 = _637.x;
                    float _646 = ((_638 <= 0.0) ? 0.0 : pow(_638, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _651 = float3(Material.Material_ScalarExpressions[1].w);
                    float _658 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _664 = fast::clamp(_554 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _673 = mix(_628, float3((_651 + (fast::clamp((_628 - float3(_646)) / float3(Material.Material_ScalarExpressions[1].z - _646), float3(0.0), float3(1.0)) * _658)).x), float3((_664 <= 0.0) ? 0.0 : pow(_664, Material.Material_ScalarExpressions[2].y)));
                    float3 _681 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _673) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _684 = _681.x;
                    float _688 = _681.y;
                    float _692 = _681.z;
                    float3 _706 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _673, _156).xyz, float3(0.0), float3(65000.0));
                    float3 _711 = (_549 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                    float3 _779;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _718 = _711 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                            float _720 = dot(View.View_AtmosphereLightDirection[0u].xyz, View.View_AtmosphereLightDirection[0u].xyz);
                            float _721 = dot(View.View_AtmosphereLightDirection[0u].xyz, _718);
                            float _722 = 2.0 * _721;
                            float _723 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                            float _728 = (_722 * _722) - ((4.0 * _720) * (dot(_718, _718) - _723));
                            float2 _740;
                            if (_728 >= 0.0)
                            {
                                _740 = (float2(_721 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_728))) / float2(2.0 * _720);
                            }
                            else
                            {
                                _740 = float2(-1.0);
                            }
                            if ((_740.x > 0.0) || (_740.y > 0.0))
                            {
                                _779 = float3(0.0);
                                break;
                            }
                            float _748 = length(_711);
                            float _751 = dot(View.View_AtmosphereLightDirection[0u].xyz, _711 / float3(_748));
                            float _752 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                            float _755 = sqrt(fast::max(0.0, _752 - _723));
                            float _756 = _748 * _748;
                            float _759 = sqrt(fast::max(0.0, _756 - _723));
                            float _769 = View.View_SkyAtmosphereTopRadiusKm - _748;
                            _779 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_748) * _751) + sqrt((_756 * ((_751 * _751) - 1.0)) + _752)) - _769) / ((_759 + _755) - _769), _759 / _755), level(0.0)).xyz;
                            break;
                        }
                    }
                    float3 _780 = fast::clamp(fast::clamp(float3((_684 <= 0.0) ? 0.0 : pow(_684, Material.Material_ScalarExpressions[2].w), (_688 <= 0.0) ? 0.0 : pow(_688, Material.Material_ScalarExpressions[2].w), (_692 <= 0.0) ? 0.0 : pow(_692, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _706;
                    float3 _914;
                    float3 _915;
                    if (any(_780 > float3(0.0)))
                    {
                        float _797 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _798 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _800;
                        float3 _803;
                        _800 = float3(0.0);
                        _803 = float3(0.0);
                        float _806;
                        float3 _801;
                        float3 _804;
                        for (float _805 = 0.0, _807 = _797; _807 <= 1.0; _800 = _801, _803 = _804, _805 = _806, _807 += _797)
                        {
                            _806 = _807 * _807;
                            float _812 = _806 - _805;
                            float3 _817 = _549 + (View.View_AtmosphereLightDirection[0u].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_805 + (_812 * 0.5))));
                            float _822 = fast::clamp((length(_817 - _490) - _491) * _494, 0.0, 1.0);
                            float4 _828 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_817 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _829 = _828.y;
                            float _843 = ((_822 < 0.0500000007450580596923828125) || (_822 > 0.949999988079071044921875)) ? 0.0 : (_828.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_829 <= 0.0) ? 0.0 : pow(_829, 0.25), 1.0 - _822), level(-1.0)).x);
                            if (_843 <= 0.0)
                            {
                                _801 = _800;
                                _804 = _803;
                                continue;
                            }
                            float3 _848 = _817 * Material.Material_ScalarExpressions[0].x;
                            float4 _852 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_600 + _848) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _853 = _852.x;
                            float _857 = _852.y;
                            float _861 = _852.z;
                            float3 _867 = float3(_843) * fast::clamp(float3((_853 <= 0.0) ? 0.0 : pow(_853, Material.Material_ScalarExpressions[0].z), (_857 <= 0.0) ? 0.0 : pow(_857, Material.Material_ScalarExpressions[0].z), (_861 <= 0.0) ? 0.0 : pow(_861, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _871 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_848 + _629) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _872 = _871.x;
                            float _876 = ((_872 <= 0.0) ? 0.0 : pow(_872, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _886 = fast::clamp(_822 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _900 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_867, float3((_651 + (fast::clamp((_867 - float3(_876)) / float3(Material.Material_ScalarExpressions[1].z - _876), float3(0.0), float3(1.0)) * _658)).x), float3((_886 <= 0.0) ? 0.0 : pow(_886, Material.Material_ScalarExpressions[2].y))), _156).xyz, float3(0.0), float3(65000.0));
                            _801 = _800 + ((_900 * _451) * _812);
                            _804 = _803 + (_900 * _812);
                        }
                        _914 = _779 * exp((-_803) * _798);
                        _915 = _779 * exp((-_800) * _798);
                    }
                    else
                    {
                        _914 = _779;
                        _915 = _779;
                    }
                    float _928;
                    float _929;
                    if (any(_706 > float3(0.0)))
                    {
                        float _924 = fast::min(_532.x, fast::min(_532.y, _532.z));
                        _928 = _539 + (_541 * _924);
                        _929 = _537 + _924;
                    }
                    else
                    {
                        _928 = _539;
                        _929 = _537;
                    }
                    float3 _934 = (((_915 * _393) * mix(0.079577468335628509521484375, _488, fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_780 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _935 = fast::max(float3(9.9999999747524270787835121154785e-07), _706 * _451);
                    float3 _948 = (((_914 * _393) * _488) + (_445 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _554, 0.0, 1.0)).xyz) * _780;
                    float3 _949 = fast::max(float3(9.9999999747524270787835121154785e-07), _706);
                    float3 _952 = exp((-_949) * _417);
                    float3 _957 = (_535 + (_532 * ((_934 - (_934 * exp((-_935) * _417))) / _935))) + (_532 * ((_948 - (_948 * _952)) / _949));
                    float3 _958 = _532 * _952;
                    if (all(_958 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _969 = _958;
                        _970 = _957;
                        _971 = _928;
                        _972 = _929;
                        break;
                    }
                    _533 = _958;
                    _536 = _957;
                    _538 = _929;
                    _540 = _928;
                    _542 = _541 + _416;
                    _968 = _543;
                    uint _544 = _968 + 1u;
                    _532 = _533;
                    _535 = _536;
                    _537 = _538;
                    _539 = _540;
                    _541 = _542;
                    _543 = _544;
                    continue;
                }
                else
                {
                    _969 = _532;
                    _970 = _535;
                    _971 = _539;
                    _972 = _537;
                    break;
                }
            }
            bool _973 = View.View_RealTimeReflectionCapture != 0.0;
            float _978 = (_972 == 0.0) ? _400 : (_971 / fast::max(1.0000000133514319600180897396058e-10, _972));
            float3 _980 = View.View_WorldCameraOrigin + (_236 * _978);
            float4 _985 = View.View_WorldToClip * float4(_980, 1.0);
            float _986 = dot(_969, float3(0.3333333432674407958984375));
            bool _990 = _972 > 0.0;
            float3 _1063;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _990)
            {
                float3 _1002 = (_980 * 9.9999997473787516355514526367188e-06) - _235;
                float _1008 = sqrt((fast::max(0.0, length(_1002) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                float _1009 = _1008 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                float _1016;
                if (_1009 < 0.707106769084930419921875)
                {
                    _1016 = fast::clamp((_1009 * _1009) * 2.0, 0.0, 1.0);
                }
                else
                {
                    _1016 = 1.0;
                }
                float2 _1044;
                if (_973)
                {
                    float3 _1019 = normalize(_1002);
                    float _1020 = _1019.z;
                    float _1023 = sqrt(1.0 - (_1020 * _1020));
                    float2 _1026 = _160;
                    _1026.y = (_1020 * 0.5) + 0.5;
                    float _1031 = acos(_1019.x / _1023);
                    float2 _1036 = _1026;
                    _1036.x = (((_1019.y / _1023) < 0.0) ? (6.283185482025146484375 - _1031) : _1031) * 0.15915493667125701904296875;
                    _1044 = (_1036 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                }
                else
                {
                    _1044 = ((_985.xy / _985.ww) * float2(0.5, -0.5)) + float2(0.5);
                }
                float4 _1049 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1044, _1008), level(0.0));
                _1063 = (((_1049.xyz * _1016).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _986)) + (_970 * (1.0 - (_1016 * (1.0 - _1049.w))));
            }
            else
            {
                _1063 = _970;
            }
            float3 _1310;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _990)
            {
                float3 _1070 = _980 - View.View_WorldCameraOrigin;
                float _1087 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                float _1090 = _1070.z + (View.View_WorldCameraOrigin.z - _1087);
                float3 _1091 = _1070;
                _1091.z = _1090;
                float _1092 = dot(_1091, _1091);
                float _1093 = rsqrt(_1092);
                float _1094 = _1092 * _1093;
                float _1102 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1070) / dot(_1070, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                float _1136;
                float _1137;
                float _1138;
                float _1139;
                if (_1102 > 0.0)
                {
                    float _1106 = _1102 * _1093;
                    float _1107 = _1106 * _1090;
                    float _1108 = _1087 + _1107;
                    _1136 = (1.0 - _1106) * _1094;
                    _1137 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1108 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                    _1138 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1108 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                    _1139 = _1090 - _1107;
                }
                else
                {
                    _1136 = _1094;
                    _1137 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                    _1138 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                    _1139 = _1090;
                }
                float _1143 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1139);
                float _1157 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1139);
                float _1168 = (_1138 * ((abs(_1143) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1143)) / _1143) : (0.693147182464599609375 - (0.2402265071868896484375 * _1143)))) + (_1137 * ((abs(_1157) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1157)) / _1157) : (0.693147182464599609375 - (0.2402265071868896484375 * _1157))));
                float3 _1210;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                {
                    float2 _1195 = float2(dot(_1091.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1091.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                    float3 _1196 = float3(_1195.x, _1195.y, _1091.z);
                    _1210 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1196, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1196, level(0.0)).xyz, float3(fast::clamp((_1094 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                }
                else
                {
                    _1210 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                }
                float3 _1238;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                {
                    _1238 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1091 * _1093, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1168 * fast::max(_1136 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                }
                else
                {
                    _1238 = float3(0.0);
                }
                bool _1247 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1094 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                float _1250 = _1247 ? 1.0 : fast::max(fast::clamp(exp2(-(_1168 * _1136)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                float4 _1257 = float4((_1210 * (1.0 - _1250)) + select(_1238, float3(0.0), bool3(_1247)), _1250);
                bool _1260 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                float4 _1303;
                if (_1260)
                {
                    float _1263 = _985.w;
                    float4 _1292;
                    if (_1260)
                    {
                        _1292 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_985.xy / float2(_1263)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1263 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                    }
                    else
                    {
                        _1292 = float4(0.0, 0.0, 0.0, 1.0);
                    }
                    _1303 = float4(_1292.xyz + (_1257.xyz * _1292.w), _1292.w * _1250);
                }
                else
                {
                    _1303 = _1257;
                }
                _1310 = (_1303.xyz * (1.0 - _986)) + (_1063 * _1303.w);
            }
            else
            {
                _1310 = _1063;
            }
            float _1314 = (_986 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _986;
            float2 _1320 = _372;
            _1320.x = 65504.0;
            float2 _1328;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1327 = _1320;
                _1327.x = ((_1314 > 0.9900000095367431640625) ? _400 : _978) * 9.9999997473787516355514526367188e-06;
                _1328 = _1327;
            }
            else
            {
                _1328 = _1320;
            }
            _1329 = _1328;
            _1330 = float4(_1310 * (_973 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1314);
            break;
        }
    }
    out.out_var_SV_Target0 = _1330;
    out.out_var_SV_Target1 = _1329;
    return out;
}

