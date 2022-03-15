

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

constant float _158 = {};
constant float3 _160 = {};
constant uint3 _161 = {};
constant float2 _162 = {};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

// Identity function as workaround for bug in Metal compiler
template<typename T>
T spvIdentity(T x)
{
    return x;
}

kernel void Main_0000be56_c52ee1e3(constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_RenderVolumetricCloudParameters& RenderVolumetricCloudParameters [[buffer(5)]], constant type_Material& Material [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture2d<float, access::read_write> OutCloudColor [[texture(0)]], texture2d<float, access::write> OutCloudDepth [[texture(1)]], texture2d_array<float, access::read_write> OutCloudColorCube [[texture(2)]], texture2d<float> View_DistantSkyLightLutTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], texturecube<float> RenderVolumetricCloudParameters_FogInscatteringColorCubemap [[texture(5)]], texture3d<float> RenderVolumetricCloudParameters_IntegratedLightScattering [[texture(6)]], texture2d<float> RenderVolumetricCloudParameters_SceneDepthTexture [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture3d<float> Material_VolumeTexture_0 [[texture(10)]], texture3d<float> Material_VolumeTexture_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler View_DistantSkyLightLutTextureSampler [[sampler(1)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(2)]], sampler RenderVolumetricCloudParameters_FogInscatteringColorSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], sampler Material_VolumeTexture_0Sampler [[sampler(6)]], sampler Material_VolumeTexture_1Sampler [[sampler(7)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    if (all(gl_GlobalInvocationID.xy < uint2(_Globals.OutputViewRect.zw)))
    {
        float _199 = float(gl_GlobalInvocationID.x) + 0.5;
        float _202 = float(gl_GlobalInvocationID.y) + 0.5;
        float4 _203 = float4(_199, _202, 0.5, 1.0);
        float2 _1414;
        float4 _1415;
        switch (0u)
        {
            default:
            {
                float _262;
                float _268;
                float4 _240 = View.View_SVPositionToTranslatedWorld * _203;
                float3 _247 = View.View_WorldCameraOrigin * 9.9999997473787516355514526367188e-06;
                float3 _248 = -normalize(-(_240.xyz / float3(_240.w)));
                float2 _282;
                bool _283;
                switch (0u)
                {
                    default:
                    {
                        float3 _260 = _247 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm).xyz;
                        _262 = dot(_248, _248);
                        float _263 = dot(_248, _260);
                        float _264 = 2.0 * _263;
                        _268 = 4.0 * _262;
                        float _270 = (_264 * _264) - (_268 * (dot(_260, _260) - (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm)));
                        if (_270 >= 0.0)
                        {
                            _282 = (float2(_263 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_270))) / float2(2.0 * _262);
                            _283 = true;
                            break;
                        }
                        _282 = float2(0.0);
                        _283 = false;
                        break;
                    }
                }
                float _288;
                float _340;
                float _341;
                if (_283)
                {
                    _288 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_BottomRadiusKm;
                    float2 _313;
                    bool _314;
                    switch (0u)
                    {
                        default:
                        {
                            float3 _293 = _247 - float4(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm, _288).xyz;
                            float _295 = dot(_248, _293);
                            float _296 = 2.0 * _295;
                            float _301 = (_296 * _296) - (_268 * (dot(_293, _293) - (_288 * _288)));
                            if (_301 >= 0.0)
                            {
                                _313 = (float2(_295 * (-2.0)) + (float2(-1.0, 1.0) * sqrt(_301))) / float2(2.0 * _262);
                                _314 = true;
                                break;
                            }
                            _313 = float2(0.0);
                            _314 = false;
                            break;
                        }
                    }
                    if (_314)
                    {
                        float _324 = fast::min(_282.x, _282.y);
                        bool _328 = all(_313 > float2(0.0));
                        float _333 = _328 ? fast::min(_313.x, _313.y) : fast::max(_313.x, _313.y);
                        float _337;
                        if (_328)
                        {
                            _337 = fast::max(0.0, _324);
                        }
                        else
                        {
                            _337 = all(_282 > float2(0.0)) ? _324 : fast::max(_282.x, _282.y);
                        }
                        _340 = fast::max(_333, _337);
                        _341 = fast::min(_333, _337);
                    }
                    else
                    {
                        _340 = _282.y;
                        _341 = _282.x;
                    }
                }
                else
                {
                    _1414 = float2(65504.0);
                    _1415 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _343 = fast::max(0.0, _341) * 100000.0;
                float _345 = fast::max(0.0, _340) * 100000.0;
                if ((_345 <= _343) || (_343 > RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingStartMaxDistance))
                {
                    _1414 = float2(65504.0);
                    _1415 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                int3 _365 = int3(uint3((uint2(_203.xy - float2(0.5)) * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.xy) + RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingCoordToZbufferCoordScaleBias.zw, 0u));
                float4 _373 = View.View_SVPositionToTranslatedWorld * float4(_199, _202, fast::max(9.9999999600419720025001879548654e-13, RenderVolumetricCloudParameters_SceneDepthTexture.read(uint2(_365.xy), _365.z).x), 1.0);
                float _382 = length(((_373.xyz / float3(_373.w)) - View.View_PreViewTranslation) - View.View_WorldCameraOrigin);
                float2 _384 = float2(65504.0);
                _384.y = _382 * 9.9999997473787516355514526367188e-06;
                bool _387 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 2;
                if (_387 && (_382 < _343))
                {
                    _1414 = _384;
                    _1415 = float4(0.0, 0.0, 0.0, 1.0);
                    break;
                }
                float _395;
                if (_387)
                {
                    _395 = fast::min(_345, _382);
                }
                else
                {
                    _395 = _345;
                }
                bool3 _400 = bool3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAtmosphericLightsSampling != 0);
                float3 _405 = View.View_AtmosphereLightColorGlobalPostTransmittance[0].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[0].xyz, _400);
                float3 _412 = View.View_AtmosphereLightColorGlobalPostTransmittance[1].xyz * select(float3(0.0), RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_AtmosphericLightCloudScatteredLuminanceScale[1].xyz, _400);
                float _419 = _343 + fast::min(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TracingMaxDistance, _395 - _343);
                float _426 = _419 - _343;
                uint _433 = uint(fast::max(float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMin), float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SampleCountMax) * fast::clamp(_426 * RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_InvDistanceToSampleCountMax, 0.0, 1.0)));
                float _435 = _426 / float(_433);
                float _436 = _435 * 0.00999999977648258209228515625;
                float3 _464;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableDistantSkyLightSampling != 0)
                {
                    float3 _463;
                    if (View.View_SkyAtmospherePresentInScene > 0.0)
                    {
                        _463 = View_DistantSkyLightLutTexture.sample(View_DistantSkyLightLutTextureSampler, float2(0.5), level(0.0)).xyz;
                    }
                    else
                    {
                        float3 _448 = _160;
                        _448.x = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)].w;
                        float3 _452 = _448;
                        _452.y = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)].w;
                        float3 _456 = _452;
                        _456.z = View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)].w;
                        _463 = fast::max(float3(0.0), _456);
                    }
                    _464 = _463;
                }
                else
                {
                    _464 = float3(0.0);
                }
                float _470 = fast::clamp(Material.Material_ScalarExpressions[4].w, 0.0, 1.0);
                float _473 = fast::clamp(Material.Material_ScalarExpressions[5].x, 0.0, 1.0);
                float _482 = fast::clamp(Material.Material_ScalarExpressions[3].w, -0.999000012874603271484375, 0.999000012874603271484375);
                float _483 = fast::clamp(Material.Material_ScalarExpressions[4].x, -0.999000012874603271484375, 0.999000012874603271484375);
                float _484 = fast::clamp(Material.Material_ScalarExpressions[4].y, 0.0, 1.0);
                float _485 = -dot(View.View_AtmosphereLightDirection[0].xyz, _248);
                float _486 = _482 * _482;
                float _487 = 1.0 - _486;
                float _488 = 1.0 + _486;
                float _489 = 2.0 * _482;
                float _491 = _488 + (_489 * _485);
                float _495 = _487 / ((12.56637096405029296875 * _491) * sqrt(_491));
                float _496 = _483 * _483;
                float _497 = 1.0 - _496;
                float _498 = 1.0 + _496;
                float _499 = 2.0 * _483;
                float _501 = _498 + (_499 * _485);
                float _508 = _495 + (_484 * ((_497 / ((12.56637096405029296875 * _501) * sqrt(_501))) - _495));
                float _509 = -dot(View.View_AtmosphereLightDirection[1].xyz, _248);
                float _511 = _488 + (_489 * _509);
                float _515 = _487 / ((12.56637096405029296875 * _511) * sqrt(_511));
                float _517 = _498 + (_499 * _509);
                float _524 = _515 + (_484 * ((_497 / ((12.56637096405029296875 * _517) * sqrt(_517))) - _515));
                float3 _527 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_CloudLayerCenterKm * 100000.0;
                float _528 = _288 * 100000.0;
                float _531 = 1.0 / ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_TopRadiusKm * 100000.0) - _528);
                float _567;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_IsReflectionRendering == 0u)
                {
                    uint3 _547 = (uint3(int3(int(_199), int(_202), int(View.View_StateFrameIndexMod8))) * uint3(1664525u)) + uint3(1013904223u);
                    uint _548 = _547.y;
                    uint _549 = _547.z;
                    uint _552 = _547.x + (_548 * _549);
                    uint _554 = _548 + (_549 * _552);
                    uint3 _559 = _161;
                    _559.x = _552 + (_554 * (_549 + (_552 * _554)));
                    _567 = _343 + ((float((_559 >> (uint3(16u) & uint3(31u))).x) * 1.52587890625e-05) * _435);
                }
                else
                {
                    _567 = _343 + (0.5 * _435);
                }
                float3 _569;
                float3 _572;
                _569 = float3(1.0);
                _572 = float3(0.0);
                float3 _570;
                float3 _573;
                float _575;
                float _577;
                float _579;
                uint _1053;
                float3 _1054;
                float3 _1055;
                float _1056;
                float _1057;
                float _574 = 0.0;
                float _576 = 0.0;
                float _578 = _567;
                uint _580 = 0u;
                for (;;)
                {
                    if (_580 < _433)
                    {
                        float3 _585 = _248 * _578;
                        float3 _586 = View.View_WorldCameraOrigin + _585;
                        float _591 = fast::clamp((length(_586 - _527) - _528) * _531, 0.0, 1.0);
                        float4 _601 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_586 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                        float _602 = _601.y;
                        float _618 = ((_591 < 0.0500000007450580596923828125) || (_591 > 0.949999988079071044921875)) ? 0.0 : (_601.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_602 <= 0.0) ? 0.0 : pow(_602, 0.25), 1.0 - _591), level(-1.0)).x);
                        if (_618 <= 0.0)
                        {
                            _570 = _569;
                            _573 = _572;
                            _575 = _574;
                            _577 = _576;
                            _579 = _578 + (float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity) * _435);
                            _1053 = _580 + uint(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StepSizeOnZeroConservativeDensity - 1);
                            uint _581 = _1053 + 1u;
                            _569 = _570;
                            _572 = _573;
                            _574 = _575;
                            _576 = _577;
                            _578 = _579;
                            _580 = _581;
                            continue;
                        }
                        float3 _636 = Material.Material_VectorExpressions[2].xyz * View.View_GameTime;
                        float3 _637 = _636 * 0.1500000059604644775390625;
                        float3 _640 = _586 * Material.Material_ScalarExpressions[0].x;
                        float4 _648 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_637 + _640) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                        float _651 = _648.x;
                        float _655 = _648.y;
                        float _659 = _648.z;
                        float3 _665 = float3(_618) * fast::clamp(float3((_651 <= 0.0) ? 0.0 : pow(_651, Material.Material_ScalarExpressions[0].z), (_655 <= 0.0) ? 0.0 : pow(_655, Material.Material_ScalarExpressions[0].z), (_659 <= 0.0) ? 0.0 : pow(_659, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                        float3 _666 = _636 * (-0.100000001490116119384765625);
                        float4 _674 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_640 + _666) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                        float _675 = _674.x;
                        float _683 = ((_675 <= 0.0) ? 0.0 : pow(_675, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                        float3 _688 = float3(Material.Material_ScalarExpressions[1].w);
                        float _695 = Material.Material_ScalarExpressions[1].z - Material.Material_ScalarExpressions[1].w;
                        float _701 = fast::clamp(_591 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                        float3 _710 = mix(_665, float3((_688 + (fast::clamp((_665 - float3(_683)) / float3(Material.Material_ScalarExpressions[1].z - _683), float3(0.0), float3(1.0)) * _695)).x), float3((_701 <= 0.0) ? 0.0 : pow(_701, Material.Material_ScalarExpressions[2].y)));
                        float3 _718 = fast::clamp((Material.Material_VectorExpressions[3].xyz * _710) * Material.Material_ScalarExpressions[2].z, float3(0.0), float3(1.0));
                        float _721 = _718.x;
                        float _725 = _718.y;
                        float _729 = _718.z;
                        float3 _743 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * _710, _158).xyz, float3(0.0), float3(65000.0));
                        float3 _746 = fast::clamp(fast::clamp(float3((_721 <= 0.0) ? 0.0 : pow(_721, Material.Material_ScalarExpressions[2].w), (_725 <= 0.0) ? 0.0 : pow(_725, Material.Material_ScalarExpressions[2].w), (_729 <= 0.0) ? 0.0 : pow(_729, Material.Material_ScalarExpressions[2].w)), float3(0.0), float3(1.0)), float3(0.0), float3(1.0)) * _743;
                        float3 _991;
                        float3 _992;
                        float3 _993;
                        float3 _994;
                        if (any(_746 > float3(0.0)))
                        {
                            float _763 = 1.0 / float(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowSampleCountMax);
                            float _764 = RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * 0.00999999977648258209228515625;
                            float3 _766;
                            float3 _769;
                            _766 = float3(0.0);
                            _769 = float3(0.0);
                            float _772;
                            float3 _767;
                            float3 _770;
                            for (float _771 = 0.0, _773 = _763; _773 <= 1.0; _766 = _767, _769 = _770, _771 = _772, _773 += _763)
                            {
                                _772 = _773 * _773;
                                float _778 = _772 - _771;
                                float3 _783 = _586 + (View.View_AtmosphereLightDirection[0].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_771 + (_778 * 0.5))));
                                float _788 = fast::clamp((length(_783 - _527) - _528) * _531, 0.0, 1.0);
                                float4 _794 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_783 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _795 = _794.y;
                                float _809 = ((_788 < 0.0500000007450580596923828125) || (_788 > 0.949999988079071044921875)) ? 0.0 : (_794.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_795 <= 0.0) ? 0.0 : pow(_795, 0.25), 1.0 - _788), level(-1.0)).x);
                                if (_809 <= 0.0)
                                {
                                    _767 = _766;
                                    _770 = _769;
                                    continue;
                                }
                                float3 _814 = _783 * Material.Material_ScalarExpressions[0].x;
                                float4 _818 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_637 + _814) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _819 = _818.x;
                                float _823 = _818.y;
                                float _827 = _818.z;
                                float3 _833 = float3(_809) * fast::clamp(float3((_819 <= 0.0) ? 0.0 : pow(_819, Material.Material_ScalarExpressions[0].z), (_823 <= 0.0) ? 0.0 : pow(_823, Material.Material_ScalarExpressions[0].z), (_827 <= 0.0) ? 0.0 : pow(_827, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _837 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_814 + _666) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _838 = _837.x;
                                float _842 = ((_838 <= 0.0) ? 0.0 : pow(_838, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _852 = fast::clamp(_788 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _866 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_833, float3((_688 + (fast::clamp((_833 - float3(_842)) / float3(Material.Material_ScalarExpressions[1].z - _842), float3(0.0), float3(1.0)) * _695)).x), float3((_852 <= 0.0) ? 0.0 : pow(_852, Material.Material_ScalarExpressions[2].y))), _158).xyz, float3(0.0), float3(65000.0));
                                _767 = _766 + ((_866 * _470) * _778);
                                _770 = _769 + (_866 * _778);
                            }
                            float3 _879;
                            float3 _882;
                            _879 = float3(0.0);
                            _882 = float3(0.0);
                            float _885;
                            float3 _880;
                            float3 _883;
                            for (float _884 = 0.0, _886 = _763; _886 <= 1.0; _879 = _880, _882 = _883, _884 = _885, _886 += _763)
                            {
                                _885 = _886 * _886;
                                float _891 = _885 - _884;
                                float3 _896 = _586 + (View.View_AtmosphereLightDirection[1].xyz * (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_ShadowTracingMaxDistance * (_884 + (_891 * 0.5))));
                                float _901 = fast::clamp((length(_896 - _527) - _528) * _531, 0.0, 1.0);
                                float4 _907 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (((_896 + float3(500000.0, 500000.0, 0.0)).xy * Material.Material_ScalarExpressions[5].y) * Material.Material_ScalarExpressions[5].y), level(-1.0));
                                float _908 = _907.y;
                                float _922 = ((_901 < 0.0500000007450580596923828125) || (_901 > 0.949999988079071044921875)) ? 0.0 : (_907.x * Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2((_908 <= 0.0) ? 0.0 : pow(_908, 0.25), 1.0 - _901), level(-1.0)).x);
                                if (_922 <= 0.0)
                                {
                                    _880 = _879;
                                    _883 = _882;
                                    continue;
                                }
                                float3 _927 = _896 * Material.Material_ScalarExpressions[0].x;
                                float4 _931 = Material_VolumeTexture_0.sample(Material_VolumeTexture_0Sampler, ((_637 + _927) * Material.Material_ScalarExpressions[0].y), level(-1.0));
                                float _932 = _931.x;
                                float _936 = _931.y;
                                float _940 = _931.z;
                                float3 _946 = float3(_922) * fast::clamp(float3((_932 <= 0.0) ? 0.0 : pow(_932, Material.Material_ScalarExpressions[0].z), (_936 <= 0.0) ? 0.0 : pow(_936, Material.Material_ScalarExpressions[0].z), (_940 <= 0.0) ? 0.0 : pow(_940, Material.Material_ScalarExpressions[0].z)), float3(0.0), float3(1.0));
                                float4 _950 = Material_VolumeTexture_1.sample(Material_VolumeTexture_1Sampler, ((_927 + _666) * Material.Material_ScalarExpressions[0].w), level(-1.0));
                                float _951 = _950.x;
                                float _955 = ((_951 <= 0.0) ? 0.0 : pow(_951, Material.Material_ScalarExpressions[1].x)) * Material.Material_ScalarExpressions[1].y;
                                float _965 = fast::clamp(_901 * Material.Material_ScalarExpressions[2].x, 0.0, 1.0);
                                float3 _979 = fast::clamp(float4(Material.Material_VectorExpressions[6].xyz * mix(_946, float3((_688 + (fast::clamp((_946 - float3(_955)) / float3(Material.Material_ScalarExpressions[1].z - _955), float3(0.0), float3(1.0)) * _695)).x), float3((_965 <= 0.0) ? 0.0 : pow(_965, Material.Material_ScalarExpressions[2].y))), _158).xyz, float3(0.0), float3(65000.0));
                                _880 = _879 + ((_979 * _470) * _891);
                                _883 = _882 + (_979 * _891);
                            }
                            _991 = exp((-_882) * _764);
                            _992 = exp((-_769) * _764);
                            _993 = exp((-_879) * _764);
                            _994 = exp((-_766) * _764);
                        }
                        else
                        {
                            _991 = float3(1.0);
                            _992 = float3(1.0);
                            _993 = float3(1.0);
                            _994 = float3(1.0);
                        }
                        float _1007;
                        float _1008;
                        if (any(_743 > float3(0.0)))
                        {
                            float _1003 = fast::min(_569.x, fast::min(_569.y, _569.z));
                            _1007 = _576 + (_578 * _1003);
                            _1008 = _574 + _1003;
                        }
                        else
                        {
                            _1007 = _576;
                            _1008 = _574;
                        }
                        float3 _1016 = ((((_994 * _405) * mix(0.079577468335628509521484375, _508, _473)) + ((_993 * _412) * mix(0.079577468335628509521484375, _524, _473))) + float3(float3(0.0).x, float3(0.0).y, float3(0.0).z)) * (_746 * fast::clamp(Material.Material_ScalarExpressions[4].z, 0.0, 1.0));
                        float3 _1017 = fast::max(float3(9.9999999747524270787835121154785e-07), _743 * _470);
                        float3 _1033 = ((((_992 * _405) * _508) + ((_991 * _412) * _524)) + (_464 * fast::clamp(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_SkyLightCloudBottomVisibility + _591, 0.0, 1.0)).xyz) * _746;
                        float3 _1034 = fast::max(float3(9.9999999747524270787835121154785e-07), _743);
                        float3 _1037 = exp((-_1034) * _436);
                        float3 _1042 = (_572 + (_569 * ((_1016 - (_1016 * exp((-_1017) * _436))) / _1017))) + (_569 * ((_1033 - (_1033 * _1037)) / _1034));
                        float3 _1043 = _569 * _1037;
                        if (all(_1043 < float3(RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_StopTracingTransmittanceThreshold)) && true)
                        {
                            _1054 = _1043;
                            _1055 = _1042;
                            _1056 = _1007;
                            _1057 = _1008;
                            break;
                        }
                        _570 = _1043;
                        _573 = _1042;
                        _575 = _1008;
                        _577 = _1007;
                        _579 = _578 + _435;
                        _1053 = _580;
                        uint _581 = _1053 + 1u;
                        _569 = _570;
                        _572 = _573;
                        _574 = _575;
                        _576 = _577;
                        _578 = _579;
                        _580 = _581;
                        continue;
                    }
                    else
                    {
                        _1054 = _569;
                        _1055 = _572;
                        _1056 = _576;
                        _1057 = _574;
                        break;
                    }
                }
                bool _1058 = View.View_RealTimeReflectionCapture != 0.0;
                float _1063 = (_1057 == 0.0) ? _419 : (_1056 / fast::max(1.0000000133514319600180897396058e-10, _1057));
                float3 _1065 = View.View_WorldCameraOrigin + (_248 * _1063);
                float4 _1070 = View.View_WorldToClip * float4(_1065, 1.0);
                float _1071 = dot(_1054, float3(0.3333333432674407958984375));
                bool _1075 = _1057 > 0.0;
                float3 _1148;
                if ((RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_EnableAerialPerspectiveSampling != 0) && _1075)
                {
                    float3 _1087 = (_1065 * 9.9999997473787516355514526367188e-06) - _247;
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
                        float2 _1111 = _162;
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
                float2 _1405 = _384;
                _1405.x = 65504.0;
                float2 _1413;
                if (RenderVolumetricCloudParameters.RenderVolumetricCloudParameters_OpaqueIntersectionMode >= 1)
                {
                    float2 _1412 = _1405;
                    _1412.x = ((_1399 > 0.9900000095367431640625) ? _419 : _1063) * 9.9999997473787516355514526367188e-06;
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

