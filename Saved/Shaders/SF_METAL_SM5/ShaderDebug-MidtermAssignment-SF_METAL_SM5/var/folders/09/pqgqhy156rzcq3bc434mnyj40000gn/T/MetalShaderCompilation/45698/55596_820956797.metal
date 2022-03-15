

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

constant float _171 = {};
constant float3 _173 = {};
constant uint3 _174 = {};
constant float4 _175 = {};
constant float2 _176 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000d92c_30eece7d(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_TransmittanceLutTexture [[texture(0)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(1)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(2)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(3)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(4)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(5)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(6)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture3d<float> Material_VolumeTexture_0 [[texture(10)]], texture3d<float> Material_VolumeTexture_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_TransmittanceLutTextureSampler [[sampler(1)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(5)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(6)]], sampler Material_Texture2D_0Sampler [[sampler(7)]], sampler Material_Texture2D_1Sampler [[sampler(8)]], sampler Material_VolumeTexture_0Sampler [[sampler(9)]], sampler Material_VolumeTexture_1Sampler [[sampler(10)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1691;
    float4 _1692;
    switch (0u)
    {
        default:
        {
            float _275;
            float _281;
            float4 _253 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
            float3 _260 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
            float3 _261 = -normalize(-(_253.xyz / float3(_253.w)));
            float2 _295;
            bool _296;
            switch (0u)
            {
                default:
                {
                    float3 _273 = _260 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                    _275 = dot(_261, _261);
                    float _276 = dot(_261, _273);
                    float _277 = 2.0 * _276;
                    _281 = 4.0 * _275;
                    float _283 = (_277 * _277) - (_281 * (dot(_273, _273) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                    if (_283 >= 0.0)
                    {
                        _295 = (float2(_276 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_283))) / float2(2.0 * _275);
                        _296 = true;
                        break;
                    }
                    _295 = float2(0.0);
                    _296 = false;
                    break;
                }
            }
            float _301;
            float _353;
            float _354;
            if (_296)
            {
                _301 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                float2 _326;
                bool _327;
                switch (0u)
                {
                    default:
                    {
                        float3 _306 = _260 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _301).xyz;
                        float _308 = dot(_261, _306);
                        float _309 = 2.0 * _308;
                        float _314 = (_309 * _309) - (_281 * (dot(_306, _306) - (_301 * _301)));
                        if (_314 >= 0.0)
                        {
                            _326 = (float2(_308 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_314))) / float2(2.0 * _275);
                            _327 = true;
                            break;
                        }
                        _326 = float2(0.0);
                        _327 = false;
                        break;
                    }
                }
                if (_327)
                {
                    float _337 = fast::min(_295.x, _295.y);
                    bool _341 = all(_326 > float2(0.0));
                    float _346 = _341 ? fast::min(_326.x, _326.y) : fast::max(_326.x, _326.y);
                    float _350;
                    if (_341)
                    {
                        _350 = fast::max(0.0, _337);
                    }
                    else
                    {
                        _350 = all(_295 > float2(0.0)) ? _337 : fast::max(_295.x, _295.y);
                    }
                    _353 = fast::max(_346, _350);
                    _354 = fast::min(_346, _350);
                }
                else
                {
                    _353 = _295.y;
                    _354 = _295.x;
                }
            }
            else
            {
                _1691 = float2(65504.0);
                _1692 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _356 = fast::max(0.0, _354) * 100000.0;
            float _358 = fast::max(0.0, _353) * 100000.0;
            if ((_358 <= _356) || (_356 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1691 = float2(65504.0);
                _1692 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _378 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _386 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_378.xy), _378.z).x), 1.0);
            float _395 = length(((_386.xyz / float3(_386.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _397 = float2(65504.0);
            _397.y = _395 * 9.9999997473787516355514526367188e-06;
            bool _400 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_400 && (_395 < _356))
            {
                _1691 = _397;
                _1692 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _408;
            if (_400)
            {
                _408 = fast::min(_358, _395);
            }
            else
            {
                _408 = _358;
            }
            bool3 _413 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
            float3 _418 = View.View_AtmosphereLightColor[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _413);
            float3 _425 = View.View_AtmosphereLightColor[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _413);
            float _432 = _356 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _408 - _356);
            float _439 = _432 - _356;
            uint _446 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_439 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _448 = _439 / float(_446);
            float _449 = _448 * 0.00999999977648258209228515625;
            float3 _477;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _476;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _476 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _461 = _173;
                    _461.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _465 = _461;
                    _465.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _469 = _465;
                    _469.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _476 = fast::max(float3(0.0), _469);
                }
                _477 = _476;
            }
            else
            {
                _477 = float3(0.0);
            }
            float _483 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _486 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
            float _495 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _496 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _497 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
            float _498 = -dot(View.View_AtmosphereLightDirection[0].xyz, _261);
            float _499 = _495 * _495;
            float _500 = 1.0 - _499;
            float _501 = 1.0 + _499;
            float _502 = 2.0 * _495;
            float _504 = _501 + (_502 * _498);
            float _508 = _500 / ((12.56637096405029296875 * _504) * sqrt(_504));
            float _509 = _496 * _496;
            float _510 = 1.0 - _509;
            float _511 = 1.0 + _509;
            float _512 = 2.0 * _496;
            float _514 = _511 + (_512 * _498);
            float _521 = _508 + (_497 * ((_510 / ((12.56637096405029296875 * _514) * sqrt(_514))) - _508));
            float _522 = -dot(View.View_AtmosphereLightDirection[1].xyz, _261);
            float _524 = _501 + (_502 * _522);
            float _528 = _500 / ((12.56637096405029296875 * _524) * sqrt(_524));
            float _530 = _511 + (_512 * _522);
            float _537 = _528 + (_497 * ((_510 / ((12.56637096405029296875 * _530) * sqrt(_530))) - _528));
            float3 _540 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _541 = _301 * 100000.0;
            float _544 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _541);
            float _580;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _560 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _561 = _560.y;
                uint _562 = _560.z;
                uint _565 = _560.x + (_561 * _562);
                uint _567 = _561 + (_562 * _565);
                uint3 _572 = _174;
                _572.x = _565 + (_567 * (_562 + (_565 * _567)));
                _580 = _356 + ((float((_572 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _448);
            }
            else
            {
                _580 = _356 + (0.5 * _448);
            }
            float3 _582;
            float3 _585;
            _582 = float3(1.0);
            _585 = float3(0.0);
            float3 _583;
            float3 _586;
            float _588;
            float _590;
            float _592;
            uint _1330;
            float3 _1331;
            float3 _1332;
            float _1333;
            float _1334;
            float _587 = 0.0;
            float _589 = 0.0;
            float _591 = _580;
            uint _593 = 0u;
            for (;;)
            {
                if (_593 < _446)
                {
                    float3 _598 = _261 * _591;
                    float3 _599 = View.View_WorldCameraOrigin + _598;
                    float _604 = fast::clamp((length(_599 - _540) - _541) * _544, 0.0, 1.0);
                    float4 _614 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_599 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _615 = _614.y;
                    float _631 = ((_604 < 0.0500000007450580596923828125) || (_604 > 0.949999988079071044921875)) ? 0.0 : (_614.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_615 <= 0.0) ? 0.0 : pow(_615, 0.25), 1.0 - _604), level(-1.0)).x);
                    if (_631 <= 0.0)
                    {
                        _583 = _582;
                        _586 = _585;
                        _588 = _587;
                        _590 = _589;
                        _592 = _591 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _448);
                        _1330 = _593 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _594 = _1330 + 1u;
                        _582 = _583;
                        _585 = _586;
                        _587 = _588;
                        _589 = _590;
                        _591 = _592;
                        _593 = _594;
                        continue;
                    }
                    float3 _768;
                    float _773;
                    float _774;
                    float3 _649 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _650 = _649 * 0.1500000059604644775390625;
                    float3 _653 = _599 * Material.Material_ScalarExpressions[0].x;
                    float4 _661 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_650 + _653) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _664 = _661.x;
                    float _668 = _661.y;
                    float _672 = _661.z;
                    float3 _678 = float3(_631) * fast::clamp(float3((_664 <= 0.0) ? 0.0 : pow(_664, Material.Material_ScalarExpressions[0].z), (_668 <= 0.0) ? 0.0 : pow(_668, Material.Material_ScalarExpressions[0].z), (_672 <= 0.0) ? 0.0 : pow(_672, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _679 = _649 * (-0.100000001490116119384765625);
                    float4 _687 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_653 + _679) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _688 = _687.x;
                    float _696 = ((_688 <= 0.0) ? 0.0 : pow(_688, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _701 = float3(Material.Material_ScalarExpressions[1].w);
                    float _708 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _714 = fast::clamp(_604 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _723 = mix(_678, float3((_701 + (fast::clamp((_678 - float3(_696)) / float3(Material.Material_ScalarExpressions[1].z - _696), float3(0.0), float3(1.0)) * _708)).x), float3((_714 <= 0.0) ? 0.0 : pow(_714, Material.Material_ScalarExpressions[2].y)));
                    float3 _731 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _723) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _734 = _731.x;
                    float _738 = _731.y;
                    float _742 = _731.z;
                    float3 _756 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _723, _171).xyz, float3(0.0), float3(65000.0));
                    float3 _761 = (_599 - View.View_SkyPlanetCenterAndViewHeight.xyz) * 9.9999997473787516355514526367188e-06;
                    float3 _829;
                    switch (0u)
                    {
                        default:
                        {
                            _768 = _761 - float4(0.0, 0.0, 0.0, View.View_SkyAtmosphereBottomRadiusKm).xyz;
                            float _770 = dot(View.View_AtmosphereLightDirection[0].xyz, View.View_AtmosphereLightDirection[0].xyz);
                            float _771 = dot(View.View_AtmosphereLightDirection[0].xyz, _768);
                            float _772 = 2.0 * _771;
                            _773 = View.View_SkyAtmosphereBottomRadiusKm * View.View_SkyAtmosphereBottomRadiusKm;
                            _774 = dot(_768, _768) - _773;
                            float _778 = (_772 * _772) - ((4.0 * _770) * _774);
                            float2 _790;
                            if (_778 >= 0.0)
                            {
                                _790 = (float2(_771 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_778))) / float2(2.0 * _770);
                            }
                            else
                            {
                                _790 = float2(-1.0);
                            }
                            if ((_790.x > 0.0) || (_790.y > 0.0))
                            {
                                _829 = float3(0.0);
                                break;
                            }
                            float _798 = length(_761);
                            float _801 = dot(View.View_AtmosphereLightDirection[0].xyz, _761 / float3(_798));
                            float _802 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                            float _805 = sqrt(fast::max(0.0, _802 - _773));
                            float _806 = _798 * _798;
                            float _809 = sqrt(fast::max(0.0, _806 - _773));
                            float _819 = View.View_SkyAtmosphereTopRadiusKm - _798;
                            _829 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_798) * _801) + sqrt((_806 * ((_801 * _801) - 1.0)) + _802)) - _819) / ((_809 + _805) - _819), _809 / _805), level(0.0)).xyz;
                            break;
                        }
                    }
                    float3 _889;
                    switch (0u)
                    {
                        default:
                        {
                            float _832 = dot(View.View_AtmosphereLightDirection[1].xyz, View.View_AtmosphereLightDirection[1].xyz);
                            float _833 = dot(View.View_AtmosphereLightDirection[1].xyz, _768);
                            float _834 = 2.0 * _833;
                            float _838 = (_834 * _834) - ((4.0 * _832) * _774);
                            float2 _850;
                            if (_838 >= 0.0)
                            {
                                _850 = (float2(_833 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_838))) / float2(2.0 * _832);
                            }
                            else
                            {
                                _850 = float2(-1.0);
                            }
                            if ((_850.x > 0.0) || (_850.y > 0.0))
                            {
                                _889 = float3(0.0);
                                break;
                            }
                            float _858 = length(_761);
                            float _861 = dot(View.View_AtmosphereLightDirection[1].xyz, _761 / float3(_858));
                            float _862 = View.View_SkyAtmosphereTopRadiusKm * View.View_SkyAtmosphereTopRadiusKm;
                            float _865 = sqrt(fast::max(0.0, _862 - _773));
                            float _866 = _858 * _858;
                            float _869 = sqrt(fast::max(0.0, _866 - _773));
                            float _879 = View.View_SkyAtmosphereTopRadiusKm - _858;
                            _889 = View_TransmittanceLutTexture.sample(View_TransmittanceLutTextureSampler, float2((fast::max(0.0, ((-_858) * _861) + sqrt((_866 * ((_861 * _861) - 1.0)) + _862)) - _879) / ((_869 + _865) - _879), _869 / _865), level(0.0)).xyz;
                            break;
                        }
                    }
                    float3 _890 = fast::clamp(fast::clamp(float3((_734 <= 0.0) ? 0.0 : pow(_734, Material.Material_ScalarExpressions[2].w), (_738 <= 0.0) ? 0.0 : pow(_738, Material.Material_ScalarExpressions[2].w), (_742 <= 0.0) ? 0.0 : pow(_742, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _756;
                    float3 _1268;
                    float3 _1269;
                    float3 _1270;
                    float3 _1271;
                    if (any(_890 > float3(0.0)))
                    {
                        float _978;
                        if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                        {
                            float4 _913 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_599, 1.0);
                            float2 _917 = _913.xy / float2(_913.w);
                            bool2 _918 = _917 >= float2(0.0);
                            bool2 _919 = _917 <= float2(1.0);
                            float _977;
                            if (all(bool2(_918.x && _919.x, _918.y && _919.y)))
                            {
                                float2 _931 = (_917 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                float2 _932 = fract(_931);
                                float2 _933 = floor(_931);
                                float4 _941 = _175;
                                _941.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_933 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _947 = _941;
                                _947.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_933 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _953 = _947;
                                _953.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_933 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _958 = _953;
                                _958.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_933 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _968 = fast::clamp(fast::clamp((_958 * 40.0) - float4((_913.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _958 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                float2 _972 = mix(_968.wx, _968.zy, _932.xx);
                                _977 = mix(_972.x, _972.y, _932.y);
                            }
                            else
                            {
                                _977 = 1.0;
                            }
                            _978 = _977;
                        }
                        else
                        {
                            _978 = 1.0;
                        }
                        float4 _985 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_599, 1.0);
                        float2 _989 = _985.xy / float2(_985.w);
                        bool2 _993 = _989 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                        bool2 _995 = _989 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                        float _1015;
                        if (all(bool2(_993.x && _995.x, _993.y && _995.y)))
                        {
                            float4 _1003 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _989, level(0.0));
                            float _1004 = _1003.x;
                            _1015 = fast::clamp(float(_985.z < (_1004 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_1004 == 1.0), 0.0, 1.0);
                        }
                        else
                        {
                            _1015 = 1.0;
                        }
                        float _1026 = fast::clamp((dot(_599 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                        float3 _1030 = _829 * fast::min(_978, mix(_1015, 1.0, _1026 * _1026));
                        float _1036 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _1037 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _1039;
                        float3 _1042;
                        _1039 = float3(0.0);
                        _1042 = float3(0.0);
                        float _1045;
                        float3 _1040;
                        float3 _1043;
                        for (float _1044 = 0.0, _1046 = _1036; _1046 <= 1.0; _1039 = _1040, _1042 = _1043, _1044 = _1045, _1046 += _1036)
                        {
                            _1045 = _1046 * _1046;
                            float _1051 = _1045 - _1044;
                            float3 _1056 = _599 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1044 + (_1051 * 0.5))));
                            float _1061 = fast::clamp((length(_1056 - _540) - _541) * _544, 0.0, 1.0);
                            float4 _1067 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1056 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _1068 = _1067.y;
                            float _1082 = ((_1061 < 0.0500000007450580596923828125) || (_1061 > 0.949999988079071044921875)) ? 0.0 : (_1067.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1068 <= 0.0) ? 0.0 : pow(_1068, 0.25), 1.0 - _1061), level(-1.0)).x);
                            if (_1082 <= 0.0)
                            {
                                _1040 = _1039;
                                _1043 = _1042;
                                continue;
                            }
                            float3 _1087 = _1056 * Material.Material_ScalarExpressions[0].x;
                            float4 _1091 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_650 + _1087) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _1092 = _1091.x;
                            float _1096 = _1091.y;
                            float _1100 = _1091.z;
                            float3 _1106 = float3(_1082) * fast::clamp(float3((_1092 <= 0.0) ? 0.0 : pow(_1092, Material.Material_ScalarExpressions[0].z), (_1096 <= 0.0) ? 0.0 : pow(_1096, Material.Material_ScalarExpressions[0].z), (_1100 <= 0.0) ? 0.0 : pow(_1100, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _1110 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1087 + _679) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _1111 = _1110.x;
                            float _1115 = ((_1111 <= 0.0) ? 0.0 : pow(_1111, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _1125 = fast::clamp(_1061 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _1139 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1106, float3((_701 + (fast::clamp((_1106 - float3(_1115)) / float3(Material.Material_ScalarExpressions[1].z - _1115), float3(0.0), float3(1.0)) * _708)).x), float3((_1125 <= 0.0) ? 0.0 : pow(_1125, Material.Material_ScalarExpressions[2].y))), _171).xyz, float3(0.0), float3(65000.0));
                            _1040 = _1039 + ((_1139 * _483) * _1051);
                            _1043 = _1042 + (_1139 * _1051);
                        }
                        float3 _1154;
                        float3 _1157;
                        _1154 = float3(0.0);
                        _1157 = float3(0.0);
                        float _1160;
                        float3 _1155;
                        float3 _1158;
                        for (float _1159 = 0.0, _1161 = _1036; _1161 <= 1.0; _1154 = _1155, _1157 = _1158, _1159 = _1160, _1161 += _1036)
                        {
                            _1160 = _1161 * _1161;
                            float _1166 = _1160 - _1159;
                            float3 _1171 = _599 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1159 + (_1166 * 0.5))));
                            float _1176 = fast::clamp((length(_1171 - _540) - _541) * _544, 0.0, 1.0);
                            float4 _1182 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1171 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _1183 = _1182.y;
                            float _1197 = ((_1176 < 0.0500000007450580596923828125) || (_1176 > 0.949999988079071044921875)) ? 0.0 : (_1182.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1183 <= 0.0) ? 0.0 : pow(_1183, 0.25), 1.0 - _1176), level(-1.0)).x);
                            if (_1197 <= 0.0)
                            {
                                _1155 = _1154;
                                _1158 = _1157;
                                continue;
                            }
                            float3 _1202 = _1171 * Material.Material_ScalarExpressions[0].x;
                            float4 _1206 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_650 + _1202) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _1207 = _1206.x;
                            float _1211 = _1206.y;
                            float _1215 = _1206.z;
                            float3 _1221 = float3(_1197) * fast::clamp(float3((_1207 <= 0.0) ? 0.0 : pow(_1207, Material.Material_ScalarExpressions[0].z), (_1211 <= 0.0) ? 0.0 : pow(_1211, Material.Material_ScalarExpressions[0].z), (_1215 <= 0.0) ? 0.0 : pow(_1215, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _1225 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1202 + _679) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _1226 = _1225.x;
                            float _1230 = ((_1226 <= 0.0) ? 0.0 : pow(_1226, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _1240 = fast::clamp(_1176 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _1254 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1221, float3((_701 + (fast::clamp((_1221 - float3(_1230)) / float3(Material.Material_ScalarExpressions[1].z - _1230), float3(0.0), float3(1.0)) * _708)).x), float3((_1240 <= 0.0) ? 0.0 : pow(_1240, Material.Material_ScalarExpressions[2].y))), _171).xyz, float3(0.0), float3(65000.0));
                            _1155 = _1154 + ((_1254 * _483) * _1166);
                            _1158 = _1157 + (_1254 * _1166);
                        }
                        _1268 = _889 * exp((-_1157) * _1037);
                        _1269 = _1030 * exp((-_1042) * _1037);
                        _1270 = _889 * exp((-_1154) * _1037);
                        _1271 = _1030 * exp((-_1039) * _1037);
                    }
                    else
                    {
                        _1268 = _889;
                        _1269 = _829;
                        _1270 = _889;
                        _1271 = _829;
                    }
                    float _1284;
                    float _1285;
                    if (any(_756 > float3(0.0)))
                    {
                        float _1280 = fast::min(_582.x, fast::min(_582.y, _582.z));
                        _1284 = _589 + (_591 * _1280);
                        _1285 = _587 + _1280;
                    }
                    else
                    {
                        _1284 = _589;
                        _1285 = _587;
                    }
                    float3 _1293 = ((((_1271 * _418) * mix(0.079577468335628509521484375, _521, _486)) + ((_1270 * _425) * mix(0.079577468335628509521484375, _537, _486))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_890 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _1294 = fast::max(float3(9.9999999747524270787835121154785e-07), _756 * _483);
                    float3 _1310 = ((((_1269 * _418) * _521) + ((_1268 * _425) * _537)) + (_477 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _604, 0.0, 1.0)).xyz) * _890;
                    float3 _1311 = fast::max(float3(9.9999999747524270787835121154785e-07), _756);
                    float3 _1314 = exp((-_1311) * _449);
                    float3 _1319 = (_585 + (_582 * ((_1293 - (_1293 * exp((-_1294) * _449))) / _1294))) + (_582 * ((_1310 - (_1310 * _1314)) / _1311));
                    float3 _1320 = _582 * _1314;
                    if (all(_1320 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _1331 = _1320;
                        _1332 = _1319;
                        _1333 = _1284;
                        _1334 = _1285;
                        break;
                    }
                    _583 = _1320;
                    _586 = _1319;
                    _588 = _1285;
                    _590 = _1284;
                    _592 = _591 + _448;
                    _1330 = _593;
                    uint _594 = _1330 + 1u;
                    _582 = _583;
                    _585 = _586;
                    _587 = _588;
                    _589 = _590;
                    _591 = _592;
                    _593 = _594;
                    continue;
                }
                else
                {
                    _1331 = _582;
                    _1332 = _585;
                    _1333 = _589;
                    _1334 = _587;
                    break;
                }
            }
            bool _1335 = View.View_RealTimeReflectionCapture != 0.0;
            float _1340 = (_1334 == 0.0) ? _432 : (_1333 / fast::max(1.0000000133514319600180897396058e-10, _1334));
            float3 _1342 = View.View_WorldCameraOrigin + (_261 * _1340);
            float4 _1347 = View.View_WorldToClip * float4(_1342, 1.0);
            float _1348 = dot(_1331, float3(0.3333333432674407958984375));
            bool _1352 = _1334 > 0.0;
            float3 _1425;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1352)
            {
                float3 _1364 = (_1342 * 9.9999997473787516355514526367188e-06) - _260;
                float _1370 = sqrt((fast::max(0.0, length(_1364) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                float _1371 = _1370 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                float _1378;
                if (_1371 < 0.707106769084930419921875)
                {
                    _1378 = fast::clamp((_1371 * _1371) * 2.0, 0.0, 1.0);
                }
                else
                {
                    _1378 = 1.0;
                }
                float2 _1406;
                if (_1335)
                {
                    float3 _1381 = normalize(_1364);
                    float _1382 = _1381.z;
                    float _1385 = sqrt(1.0 - (_1382 * _1382));
                    float2 _1388 = _176;
                    _1388.y = (_1382 * 0.5) + 0.5;
                    float _1393 = acos(_1381.x / _1385);
                    float2 _1398 = _1388;
                    _1398.x = (((_1381.y / _1385) < 0.0) ? (6.283185482025146484375 - _1393) : _1393) * 0.15915493667125701904296875;
                    _1406 = (_1398 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                }
                else
                {
                    _1406 = ((_1347.xy / _1347.ww) * float2(0.5, -0.5)) + float2(0.5);
                }
                float4 _1411 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1406, _1370), level(0.0));
                _1425 = (((_1411.xyz * _1378).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1348)) + (_1332 * (1.0 - (_1378 * (1.0 - _1411.w))));
            }
            else
            {
                _1425 = _1332;
            }
            float3 _1672;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1352)
            {
                float3 _1432 = _1342 - View.View_WorldCameraOrigin;
                float _1449 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                float _1452 = _1432.z + (View.View_WorldCameraOrigin.z - _1449);
                float3 _1453 = _1432;
                _1453.z = _1452;
                float _1454 = dot(_1453, _1453);
                float _1455 = rsqrt(_1454);
                float _1456 = _1454 * _1455;
                float _1464 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1432) / dot(_1432, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                float _1498;
                float _1499;
                float _1500;
                float _1501;
                if (_1464 > 0.0)
                {
                    float _1468 = _1464 * _1455;
                    float _1469 = _1468 * _1452;
                    float _1470 = _1449 + _1469;
                    _1498 = (1.0 - _1468) * _1456;
                    _1499 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1470 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                    _1500 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1470 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                    _1501 = _1452 - _1469;
                }
                else
                {
                    _1498 = _1456;
                    _1499 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                    _1500 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                    _1501 = _1452;
                }
                float _1505 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1501);
                float _1519 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1501);
                float _1530 = (_1500 * ((abs(_1505) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1505)) / _1505) : (0.693147182464599609375 - (0.2402265071868896484375 * _1505)))) + (_1499 * ((abs(_1519) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1519)) / _1519) : (0.693147182464599609375 - (0.2402265071868896484375 * _1519))));
                float3 _1572;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                {
                    float2 _1557 = float2(dot(_1453.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1453.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                    float3 _1558 = float3(_1557.x, _1557.y, _1453.z);
                    _1572 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1558, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1558, level(0.0)).xyz, float3(fast::clamp((_1456 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                }
                else
                {
                    _1572 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                }
                float3 _1600;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                {
                    _1600 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1453 * _1455, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1530 * fast::max(_1498 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                }
                else
                {
                    _1600 = float3(0.0);
                }
                bool _1609 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1456 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                float _1612 = _1609 ? 1.0 : fast::max(fast::clamp(exp2(-(_1530 * _1498)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                float4 _1619 = float4((_1572 * (1.0 - _1612)) + select(_1600, float3(0.0), bool3(_1609)), _1612);
                bool _1622 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                float4 _1665;
                if (_1622)
                {
                    float _1625 = _1347.w;
                    float4 _1654;
                    if (_1622)
                    {
                        _1654 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1347.xy / float2(_1625)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1625 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                    }
                    else
                    {
                        _1654 = float4(0.0, 0.0, 0.0, 1.0);
                    }
                    _1665 = float4(_1654.xyz + (_1619.xyz * _1654.w), _1654.w * _1612);
                }
                else
                {
                    _1665 = _1619;
                }
                _1672 = (_1665.xyz * (1.0 - _1348)) + (_1425 * _1665.w);
            }
            else
            {
                _1672 = _1425;
            }
            float _1676 = (_1348 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1348;
            float2 _1682 = _397;
            _1682.x = 65504.0;
            float2 _1690;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1689 = _1682;
                _1689.x = ((_1676 > 0.9900000095367431640625) ? _432 : _1340) * 9.9999997473787516355514526367188e-06;
                _1690 = _1689;
            }
            else
            {
                _1690 = _1682;
            }
            _1691 = _1690;
            _1692 = float4(_1672 * (_1335 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1676);
            break;
        }
    }
    out.out_var_SV_Target0 = _1692;
    out.out_var_SV_Target1 = _1691;
    return out;
}

