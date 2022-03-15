

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

constant float _168 = {};
constant float3 _170 = {};
constant uint3 _171 = {};
constant float4 _172 = {};
constant float2 _173 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float2 out_var_SV_Target1 [[color(1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000c5bf_f9b5a0e3(constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(0)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(1)]], texture2d<float> RenderVolumetricCloudParameters_ShadowDepthTexture [[texture(2)]], texture2d<float> RenderVolumetricCloudParameters_StaticShadowDepthTexture [[texture(3)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(4)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(5)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(6)]], texture2d<float> Material_Texture2D_0 [[texture(7)]], texture2d<float> Material_Texture2D_1 [[texture(8)]], texture3d<float> Material_VolumeTexture_0 [[texture(9)]], texture3d<float> Material_VolumeTexture_1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_ShadowDepthTextureSampler [[sampler(3)]], sampler RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler [[sampler(4)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(5)]], sampler Material_Texture2D_0Sampler [[sampler(6)]], sampler Material_Texture2D_1Sampler [[sampler(7)]], sampler Material_VolumeTexture_0Sampler [[sampler(8)]], sampler Material_VolumeTexture_1Sampler [[sampler(9)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _1549;
    float4 _1550;
    switch (0u)
    {
        default:
        {
            float _266;
            float _272;
            float4 _244 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
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
                _1549 = float2(65504.0);
                _1550 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            float _347 = fast::max(0.0, _345) * 100000.0;
            float _349 = fast::max(0.0, _344) * 100000.0;
            if ((_349 <= _347) || (_347 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
            {
                _1549 = float2(65504.0);
                _1550 = float4(0.0, 0.0, 0.0, 1.0);
                break;
            }
            int3 _369 = int3(uint3((uint2(gl_FragCoord.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
            float4 _377 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xy, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_369.xy), _369.z).x), 1.0);
            float _386 = length(((_377.xyz / float3(_377.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
            float2 _388 = float2(65504.0);
            _388.y = _386 * 9.9999997473787516355514526367188e-06;
            bool _391 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
            if (_391 && (_386 < _347))
            {
                _1549 = _388;
                _1550 = float4(0.0, 0.0, 0.0, 1.0);
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
            bool3 _404 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
            float3 _409 = View.View_AtmosphereLightColorGlobalPostTransmittance[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _404);
            float3 _416 = View.View_AtmosphereLightColorGlobalPostTransmittance[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _404);
            float _423 = _347 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _399 - _347);
            float _430 = _423 - _347;
            uint _437 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_430 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
            float _439 = _430 / float(_437);
            float _440 = _439 * 0.00999999977648258209228515625;
            float3 _468;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
            {
                float3 _467;
                if (View.View_SkyAtmospherePresentInScene > 0.0)
                {
                    _467 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                }
                else
                {
                    float3 _452 = _170;
                    _452.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)].w;
                    float3 _456 = _452;
                    _456.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)].w;
                    float3 _460 = _456;
                    _460.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)].w;
                    _467 = fast::max(float3(0.0), _460);
                }
                _468 = _467;
            }
            else
            {
                _468 = float3(0.0);
            }
            float _474 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
            float _477 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
            float _486 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
            float _487 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
            float _488 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
            float _489 = -dot(View.View_AtmosphereLightDirection[0].xyz, _252);
            float _490 = _486 * _486;
            float _491 = 1.0 - _490;
            float _492 = 1.0 + _490;
            float _493 = 2.0 * _486;
            float _495 = _492 + (_493 * _489);
            float _499 = _491 / ((12.56637096405029296875 * _495) * sqrt(_495));
            float _500 = _487 * _487;
            float _501 = 1.0 - _500;
            float _502 = 1.0 + _500;
            float _503 = 2.0 * _487;
            float _505 = _502 + (_503 * _489);
            float _512 = _499 + (_488 * ((_501 / ((12.56637096405029296875 * _505) * sqrt(_505))) - _499));
            float _513 = -dot(View.View_AtmosphereLightDirection[1].xyz, _252);
            float _515 = _492 + (_493 * _513);
            float _519 = _491 / ((12.56637096405029296875 * _515) * sqrt(_515));
            float _521 = _502 + (_503 * _513);
            float _528 = _519 + (_488 * ((_501 / ((12.56637096405029296875 * _521) * sqrt(_521))) - _519));
            float3 _531 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
            float _532 = _292 * 100000.0;
            float _535 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _532);
            float _571;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
            {
                uint3 _551 = (uint3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                uint _552 = _551.y;
                uint _553 = _551.z;
                uint _556 = _551.x + (_552 * _553);
                uint _558 = _552 + (_553 * _556);
                uint3 _563 = _171;
                _563.x = _556 + (_558 * (_553 + (_556 * _558)));
                _571 = _347 + ((float((_563 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _439);
            }
            else
            {
                _571 = _347 + (0.5 * _439);
            }
            float3 _573;
            float3 _576;
            _573 = float3(1.0);
            _576 = float3(0.0);
            float3 _574;
            float3 _577;
            float _579;
            float _581;
            float _583;
            uint _1188;
            float3 _1189;
            float3 _1190;
            float _1191;
            float _1192;
            float _578 = 0.0;
            float _580 = 0.0;
            float _582 = _571;
            uint _584 = 0u;
            for (;;)
            {
                if (_584 < _437)
                {
                    float3 _589 = _252 * _582;
                    float3 _590 = View.View_WorldCameraOrigin + _589;
                    float _595 = fast::clamp((length(_590 - _531) - _532) * _535, 0.0, 1.0);
                    float4 _605 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_590 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                    float _606 = _605.y;
                    float _622 = ((_595 < 0.0500000007450580596923828125) || (_595 > 0.949999988079071044921875)) ? 0.0 : (_605.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_606 <= 0.0) ? 0.0 : pow(_606, 0.25), 1.0 - _595), level(-1.0)).x);
                    if (_622 <= 0.0)
                    {
                        _574 = _573;
                        _577 = _576;
                        _579 = _578;
                        _581 = _580;
                        _583 = _582 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _439);
                        _1188 = _584 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                        uint _585 = _1188 + 1u;
                        _573 = _574;
                        _576 = _577;
                        _578 = _579;
                        _580 = _581;
                        _582 = _583;
                        _584 = _585;
                        continue;
                    }
                    float3 _640 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                    float3 _641 = _640 * 0.1500000059604644775390625;
                    float3 _644 = _590 * Material.Material_ScalarExpressions[0].x;
                    float4 _652 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_641 + _644) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                    float _655 = _652.x;
                    float _659 = _652.y;
                    float _663 = _652.z;
                    float3 _669 = float3(_622) * fast::clamp(float3((_655 <= 0.0) ? 0.0 : pow(_655, Material.Material_ScalarExpressions[0].z), (_659 <= 0.0) ? 0.0 : pow(_659, Material.Material_ScalarExpressions[0].z), (_663 <= 0.0) ? 0.0 : pow(_663, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                    float3 _670 = _640 * (-0.100000001490116119384765625);
                    float4 _678 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_644 + _670) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                    float _679 = _678.x;
                    float _687 = ((_679 <= 0.0) ? 0.0 : pow(_679, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                    float3 _692 = float3(Material.Material_ScalarExpressions[1].w);
                    float _699 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                    float _705 = fast::clamp(_595 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                    float3 _714 = mix(_669, float3((_692 + (fast::clamp((_669 - float3(_687)) / float3(Material.Material_ScalarExpressions[1].z - _687), float3(0.0), float3(1.0)) * _699)).x), float3((_705 <= 0.0) ? 0.0 : pow(_705, Material.Material_ScalarExpressions[2].y)));
                    float3 _722 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _714) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                    float _725 = _722.x;
                    float _729 = _722.y;
                    float _733 = _722.z;
                    float3 _747 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _714, _168).xyz, float3(0.0), float3(65000.0));
                    float3 _750 = fast::clamp(fast::clamp(float3((_725 <= 0.0) ? 0.0 : pow(_725, Material.Material_ScalarExpressions[2].w), (_729 <= 0.0) ? 0.0 : pow(_729, Material.Material_ScalarExpressions[2].w), (_733 <= 0.0) ? 0.0 : pow(_733, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _747;
                    float3 _1126;
                    float3 _1127;
                    float3 _1128;
                    float3 _1129;
                    if (any(_750 > float3(0.0)))
                    {
                        float _838;
                        if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_bStaticallyShadowed != 0u)
                        {
                            float4 _773 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToStaticShadowMatrix * float4(_590, 1.0);
                            float2 _777 = _773.xy / float2(_773.w);
                            bool2 _778 = _777 >= float2(0.0);
                            bool2 _779 = _777 <= float2(1.0);
                            float _837;
                            if (all(bool2(_778.x && _779.x, _778.y && _779.y)))
                            {
                                float2 _791 = (_777 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.xy) - float2(0.5);
                                float2 _792 = fract(_791);
                                float2 _793 = floor(_791);
                                float4 _801 = _172;
                                _801.x = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_793 + float2(0.5, 1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _807 = _801;
                                _807.y = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_793 + float2(1.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _813 = _807;
                                _813.z = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_793 + float2(1.5, 0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _818 = _813;
                                _818.w = RenderVolumetricCloudParameters_StaticShadowDepthTexture.sample(RenderVolumetricCloudParameters_StaticShadowDepthTextureSampler, ((_793 + float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StaticShadowBufferSize.zw), level(0.0)).x;
                                float4 _828 = fast::clamp(fast::clamp((_818 * 40.0) - float4((_773.z * 40.0) - 1.0), float4(0.0), float4(1.0)) + select(float4(0.0), float4(1.0), _818 > float4(0.9900000095367431640625)), float4(0.0), float4(1.0));
                                float2 _832 = mix(_828.wx, _828.zy, _792.xx);
                                _837 = mix(_832.x, _832.y, _792.y);
                            }
                            else
                            {
                                _837 = 1.0;
                            }
                            _838 = _837;
                        }
                        else
                        {
                            _838 = 1.0;
                        }
                        float4 _845 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_WorldToShadowMatrix * float4(_590, 1.0);
                        float2 _849 = _845.xy / float2(_845.w);
                        bool2 _853 = _849 >= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.xy;
                        bool2 _855 = _849 <= RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowmapMinMax.zw;
                        float _875;
                        if (all(bool2(_853.x && _855.x, _853.y && _855.y)))
                        {
                            float4 _863 = RenderVolumetricCloudParameters_ShadowDepthTexture.sample(RenderVolumetricCloudParameters_ShadowDepthTextureSampler, _849, level(0.0));
                            float _864 = _863.x;
                            _875 = fast::clamp(float(_845.z < (_864 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DepthBiasParameters.x)) + float(_864 == 1.0), 0.0, 1.0);
                        }
                        else
                        {
                            _875 = 1.0;
                        }
                        float _886 = fast::clamp((dot(_590 - View.View_WorldCameraOrigin, View.View_ViewForward) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.z) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowInjectParams.w, 0.0, 1.0);
                        float3 _890 = float3(1.0) * fast::min(_838, mix(_875, 1.0, _886 * _886));
                        float _896 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                        float _897 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                        float3 _899;
                        float3 _902;
                        _899 = float3(0.0);
                        _902 = float3(0.0);
                        float _905;
                        float3 _900;
                        float3 _903;
                        for (float _904 = 0.0, _906 = _896; _906 <= 1.0; _899 = _900, _902 = _903, _904 = _905, _906 += _896)
                        {
                            _905 = _906 * _906;
                            float _911 = _905 - _904;
                            float3 _916 = _590 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_904 + (_911 * 0.5))));
                            float _921 = fast::clamp((length(_916 - _531) - _532) * _535, 0.0, 1.0);
                            float4 _927 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_916 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _928 = _927.y;
                            float _942 = ((_921 < 0.0500000007450580596923828125) || (_921 > 0.949999988079071044921875)) ? 0.0 : (_927.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_928 <= 0.0) ? 0.0 : pow(_928, 0.25), 1.0 - _921), level(-1.0)).x);
                            if (_942 <= 0.0)
                            {
                                _900 = _899;
                                _903 = _902;
                                continue;
                            }
                            float3 _947 = _916 * Material.Material_ScalarExpressions[0].x;
                            float4 _951 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_641 + _947) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _952 = _951.x;
                            float _956 = _951.y;
                            float _960 = _951.z;
                            float3 _966 = float3(_942) * fast::clamp(float3((_952 <= 0.0) ? 0.0 : pow(_952, Material.Material_ScalarExpressions[0].z), (_956 <= 0.0) ? 0.0 : pow(_956, Material.Material_ScalarExpressions[0].z), (_960 <= 0.0) ? 0.0 : pow(_960, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _970 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_947 + _670) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _971 = _970.x;
                            float _975 = ((_971 <= 0.0) ? 0.0 : pow(_971, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _985 = fast::clamp(_921 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _999 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_966, float3((_692 + (fast::clamp((_966 - float3(_975)) / float3(Material.Material_ScalarExpressions[1].z - _975), float3(0.0), float3(1.0)) * _699)).x), float3((_985 <= 0.0) ? 0.0 : pow(_985, Material.Material_ScalarExpressions[2].y))), _168).xyz, float3(0.0), float3(65000.0));
                            _900 = _899 + ((_999 * _474) * _911);
                            _903 = _902 + (_999 * _911);
                        }
                        float3 _1014;
                        float3 _1017;
                        _1014 = float3(0.0);
                        _1017 = float3(0.0);
                        float _1020;
                        float3 _1015;
                        float3 _1018;
                        for (float _1019 = 0.0, _1021 = _896; _1021 <= 1.0; _1014 = _1015, _1017 = _1018, _1019 = _1020, _1021 += _896)
                        {
                            _1020 = _1021 * _1021;
                            float _1026 = _1020 - _1019;
                            float3 _1031 = _590 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_1019 + (_1026 * 0.5))));
                            float _1036 = fast::clamp((length(_1031 - _531) - _532) * _535, 0.0, 1.0);
                            float4 _1042 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_1031 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                            float _1043 = _1042.y;
                            float _1057 = ((_1036 < 0.0500000007450580596923828125) || (_1036 > 0.949999988079071044921875)) ? 0.0 : (_1042.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_1043 <= 0.0) ? 0.0 : pow(_1043, 0.25), 1.0 - _1036), level(-1.0)).x);
                            if (_1057 <= 0.0)
                            {
                                _1015 = _1014;
                                _1018 = _1017;
                                continue;
                            }
                            float3 _1062 = _1031 * Material.Material_ScalarExpressions[0].x;
                            float4 _1066 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_641 + _1062) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                            float _1067 = _1066.x;
                            float _1071 = _1066.y;
                            float _1075 = _1066.z;
                            float3 _1081 = float3(_1057) * fast::clamp(float3((_1067 <= 0.0) ? 0.0 : pow(_1067, Material.Material_ScalarExpressions[0].z), (_1071 <= 0.0) ? 0.0 : pow(_1071, Material.Material_ScalarExpressions[0].z), (_1075 <= 0.0) ? 0.0 : pow(_1075, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                            float4 _1085 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_1062 + _670) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                            float _1086 = _1085.x;
                            float _1090 = ((_1086 <= 0.0) ? 0.0 : pow(_1086, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                            float _1100 = fast::clamp(_1036 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                            float3 _1114 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_1081, float3((_692 + (fast::clamp((_1081 - float3(_1090)) / float3(Material.Material_ScalarExpressions[1].z - _1090), float3(0.0), float3(1.0)) * _699)).x), float3((_1100 <= 0.0) ? 0.0 : pow(_1100, Material.Material_ScalarExpressions[2].y))), _168).xyz, float3(0.0), float3(65000.0));
                            _1015 = _1014 + ((_1114 * _474) * _1026);
                            _1018 = _1017 + (_1114 * _1026);
                        }
                        _1126 = exp((-_1017) * _897);
                        _1127 = _890 * exp((-_902) * _897);
                        _1128 = exp((-_1014) * _897);
                        _1129 = _890 * exp((-_899) * _897);
                    }
                    else
                    {
                        _1126 = float3(1.0);
                        _1127 = float3(1.0);
                        _1128 = float3(1.0);
                        _1129 = float3(1.0);
                    }
                    float _1142;
                    float _1143;
                    if (any(_747 > float3(0.0)))
                    {
                        float _1138 = fast::min(_573.x, fast::min(_573.y, _573.z));
                        _1142 = _580 + (_582 * _1138);
                        _1143 = _578 + _1138;
                    }
                    else
                    {
                        _1142 = _580;
                        _1143 = _578;
                    }
                    float3 _1151 = ((((_1129 * _409) * mix(0.079577468335628509521484375, _512, _477)) + ((_1128 * _416) * mix(0.079577468335628509521484375, _528, _477))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_750 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                    float3 _1152 = fast::max(float3(9.9999999747524270787835121154785e-07), _747 * _474);
                    float3 _1168 = ((((_1127 * _409) * _512) + ((_1126 * _416) * _528)) + (_468 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _595, 0.0, 1.0)).xyz) * _750;
                    float3 _1169 = fast::max(float3(9.9999999747524270787835121154785e-07), _747);
                    float3 _1172 = exp((-_1169) * _440);
                    float3 _1177 = (_576 + (_573 * ((_1151 - (_1151 * exp((-_1152) * _440))) / _1152))) + (_573 * ((_1168 - (_1168 * _1172)) / _1169));
                    float3 _1178 = _573 * _1172;
                    if (all(_1178 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                    {
                        _1189 = _1178;
                        _1190 = _1177;
                        _1191 = _1142;
                        _1192 = _1143;
                        break;
                    }
                    _574 = _1178;
                    _577 = _1177;
                    _579 = _1143;
                    _581 = _1142;
                    _583 = _582 + _439;
                    _1188 = _584;
                    uint _585 = _1188 + 1u;
                    _573 = _574;
                    _576 = _577;
                    _578 = _579;
                    _580 = _581;
                    _582 = _583;
                    _584 = _585;
                    continue;
                }
                else
                {
                    _1189 = _573;
                    _1190 = _576;
                    _1191 = _580;
                    _1192 = _578;
                    break;
                }
            }
            bool _1193 = View.View_RealTimeReflectionCapture != 0.0;
            float _1198 = (_1192 == 0.0) ? _423 : (_1191 / fast::max(1.0000000133514319600180897396058e-10, _1192));
            float3 _1200 = View.View_WorldCameraOrigin + (_252 * _1198);
            float4 _1205 = View.View_WorldToClip * float4(_1200, 1.0);
            float _1206 = dot(_1189, float3(0.3333333432674407958984375));
            bool _1210 = _1192 > 0.0;
            float3 _1283;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1210)
            {
                float3 _1222 = (_1200 * 9.9999997473787516355514526367188e-06) - _251;
                float _1228 = sqrt((fast::max(0.0, length(_1222) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
                float _1229 = _1228 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
                float _1236;
                if (_1229 < 0.707106769084930419921875)
                {
                    _1236 = fast::clamp((_1229 * _1229) * 2.0, 0.0, 1.0);
                }
                else
                {
                    _1236 = 1.0;
                }
                float2 _1264;
                if (_1193)
                {
                    float3 _1239 = normalize(_1222);
                    float _1240 = _1239.z;
                    float _1243 = sqrt(1.0 - (_1240 * _1240));
                    float2 _1246 = _173;
                    _1246.y = (_1240 * 0.5) + 0.5;
                    float _1251 = acos(_1239.x / _1243);
                    float2 _1256 = _1246;
                    _1256.x = (((_1239.y / _1243) < 0.0) ? (6.283185482025146484375 - _1251) : _1251) * 0.15915493667125701904296875;
                    _1264 = (_1256 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
                }
                else
                {
                    _1264 = ((_1205.xy / _1205.ww) * float2(0.5, -0.5)) + float2(0.5);
                }
                float4 _1269 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1264, _1228), level(0.0));
                _1283 = (((_1269.xyz * _1236).xyz * View.View_OneOverPreExposure).xyz * (1.0 - _1206)) + (_1190 * (1.0 - (_1236 * (1.0 - _1269.w))));
            }
            else
            {
                _1283 = _1190;
            }
            float3 _1530;
            if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableHeightFog != 0) && _1210)
            {
                float3 _1290 = _1200 - View.View_WorldCameraOrigin;
                float _1307 = fast::min(View.View_WorldCameraOrigin.z, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.z);
                float _1310 = _1290.z + (View.View_WorldCameraOrigin.z - _1307);
                float3 _1311 = _1290;
                _1311.z = _1310;
                float _1312 = dot(_1311, _1311);
                float _1313 = rsqrt(_1312);
                float _1314 = _1312 * _1313;
                float _1322 = fast::max(fast::max(View.View_VolumetricFogMaxDistance * (length(_1290) / dot(_1290, View.View_ViewForward)), 0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.w);
                float _1356;
                float _1357;
                float _1358;
                float _1359;
                if (_1322 > 0.0)
                {
                    float _1326 = _1322 * _1313;
                    float _1327 = _1326 * _1310;
                    float _1328 = _1307 + _1327;
                    _1356 = (1.0 - _1326) * _1314;
                    _1357 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.z * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * (_1328 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.w)));
                    _1358 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.x * exp2(-fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * (_1328 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.y)));
                    _1359 = _1310 - _1327;
                }
                else
                {
                    _1356 = _1314;
                    _1357 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.x;
                    _1358 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.x;
                    _1359 = _1310;
                }
                float _1363 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters.y * _1359);
                float _1377 = fast::max(-127.0, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters2.y * _1359);
                float _1388 = (_1358 * ((abs(_1363) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1363)) / _1363) : (0.693147182464599609375 - (0.2402265071868896484375 * _1363)))) + (_1357 * ((abs(_1377) > 0.00999999977648258209228515625) ? ((1.0 - exp2(-_1377)) / _1377) : (0.693147182464599609375 - (0.2402265071868896484375 * _1377))));
                float3 _1430;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z > 0.0)
                {
                    float2 _1415 = float2(dot(_1311.xy, float2(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.y, -RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation.x)), dot(_1311.xy, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SinCosInscatteringColorCubemapRotation));
                    float3 _1416 = float3(_1415.x, _1415.y, _1311.z);
                    _1430 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz * mix(RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1416, level(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[2])).xyz, RenderVolumetricCloudParameters_FogInscatteringColorCubemap.sample(RenderVolumetricCloudParameters_FogInscatteringColorSampler, _1416, level(0.0)).xyz, float3(fast::clamp((_1314 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[0]) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_FogInscatteringTextureParameters[1], 0.0, 1.0)));
                }
                else
                {
                    _1430 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.xyz;
                }
                float3 _1458;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w >= 0.0) && (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.z == 0.0))
                {
                    _1458 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.xyz * pow(fast::clamp(dot(_1311 * _1313, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.xyz), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_DirectionalInscatteringColor.w)) * (1.0 - fast::clamp(exp2(-(_1388 * fast::max(_1356 - RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InscatteringLightDirection.w, 0.0))), 0.0, 1.0));
                }
                else
                {
                    _1458 = float3(0.0);
                }
                bool _1467 = (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w > 0.0) && (_1314 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogParameters3.w);
                float _1470 = _1467 ? 1.0 : fast::max(fast::clamp(exp2(-(_1388 * _1356)), 0.0, 1.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ExponentialFogColorParameter.w);
                float4 _1477 = float4((_1430 * (1.0 - _1470)) + select(_1458, float3(0.0), bool3(_1467)), _1470);
                bool _1480 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ApplyVolumetricFog > 0.0;
                float4 _1523;
                if (_1480)
                {
                    float _1483 = _1205.w;
                    float4 _1512;
                    if (_1480)
                    {
                        _1512 = RenderVolumetricCloudParameters_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1205.xy / float2(_1483)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1483 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
                    }
                    else
                    {
                        _1512 = float4(0.0, 0.0, 0.0, 1.0);
                    }
                    _1523 = float4(_1512.xyz + (_1477.xyz * _1512.w), _1512.w * _1470);
                }
                else
                {
                    _1523 = _1477;
                }
                _1530 = (_1523.xyz * (1.0 - _1206)) + (_1283 * _1523.w);
            }
            else
            {
                _1530 = _1283;
            }
            float _1534 = (_1206 < RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold) ? 0.0 : _1206;
            float2 _1540 = _388;
            _1540.x = 65504.0;
            float2 _1548;
            if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
            {
                float2 _1547 = _1540;
                _1547.x = ((_1534 > 0.9900000095367431640625) ? _423 : _1198) * 9.9999997473787516355514526367188e-06;
                _1548 = _1547;
            }
            else
            {
                _1548 = _1540;
            }
            _1549 = _1548;
            _1550 = float4(_1530 * (_1193 ? View.View_RealTimeReflectionCapturePreExposure : View.View_PreExposure), _1534);
            break;
        }
    }
    out.out_var_SV_Target0 = _1550;
    out.out_var_SV_Target1 = _1549;
    return out;
}

