

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
    char _m1_pad[64];
    float4x4 View_TranslatedWorldToView;
    char _m2_pad[448];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[304];
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    char _m6_pad[16];
    float4 View_LightProbeSizeRatioAndInvSizeRatio;
    char _m7_pad[52];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[80];
    float View_UnlitViewmodeMask;
    char _m14_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m16_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[120];
    float View_ReflectionCubemapMaxMip;
    char _m21_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m23_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m25_pad[80];
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_TranslucentBasePass
{
    char _m0_pad[4];
    uint TranslucentBasePass_Shared_Forward_NumReflectionCaptures;
    char _m1_pad[4];
    uint TranslucentBasePass_Shared_Forward_NumGridCells;
    int3 TranslucentBasePass_Shared_Forward_CulledGridSize;
    uint TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift;
    float3 TranslucentBasePass_Shared_Forward_LightGridZParams;
    char _m5_pad[1216];
    float4 TranslucentBasePass_Shared_Reflection_SkyLightParameters;
    float TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness;
    char _m7_pad[64];
    float4 TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane;
    float4 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin;
    float4 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis;
    float4 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis;
    float3x4 TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix;
    float3 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters;
    float2 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2;
    spvUnsafeArray<float4x4, 2> TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV;
    spvUnsafeArray<float4, 2> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias;
    float2 TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound;
    uint TranslucentBasePass_Shared_PlanarReflection_bIsStereo;
    char _m18_pad[144];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

struct type_ReflectionCapture
{
    spvUnsafeArray<float4, 341> ReflectionCapture_PositionAndRadius;
    spvUnsafeArray<float4, 341> ReflectionCapture_CaptureProperties;
    spvUnsafeArray<float4, 341> ReflectionCapture_CaptureOffsetAndAverageBrightness;
    spvUnsafeArray<float4x4, 341> ReflectionCapture_BoxTransform;
    spvUnsafeArray<float4, 341> ReflectionCapture_BoxScales;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _198 = {};
constant float3 _199 = {};
constant float4 _201 = {};
constant float2 _202 = {};
constant float3 _203 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00008354_5daa9280(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(10)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(6)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(7)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(8)]], constant type_Material& Material [[buffer(9)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(10)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _259 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _263 = _259.xyz / float3(_259.w);
    float3 _264 = _263 - View.View_PreViewTranslation;
    float3 _266 = normalize(-_263);
    float3 _274 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _291 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _297 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _298 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _307 = (_291 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _314 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _317 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _322;
    if (_317)
    {
        _322 = _307 + (_314 * 0.449999988079071044921875);
    }
    else
    {
        _322 = _307;
    }
    float3 _324 = select(_314, float3(0.0), bool3(_317));
    bool _327 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _400;
    if (_327)
    {
        float _348 = _274.y;
        float4 _350 = _201;
        _350.y = (-0.48860299587249755859375) * _348;
        float _351 = _274.z;
        float4 _353 = _350;
        _353.z = 0.48860299587249755859375 * _351;
        float _354 = _274.x;
        float4 _356 = _353;
        _356.w = (-0.48860299587249755859375) * _354;
        float3 _357 = _274 * _274;
        float4 _360 = _198;
        _360.x = (1.09254801273345947265625 * _354) * _348;
        float4 _363 = _360;
        _363.y = ((-1.09254801273345947265625) * _348) * _351;
        float4 _368 = _363;
        _368.z = 0.3153919875621795654296875 * ((3.0 * _357.z) - 1.0);
        float4 _371 = _368;
        _371.w = ((-1.09254801273345947265625) * _354) * _351;
        float4 _375 = _356;
        _375.x = 0.886227548122406005859375;
        float3 _377 = _375.yzw * 2.094395160675048828125;
        float4 _378 = float4(_375.x, _377.x, _377.y, _377.z);
        float4 _379 = _371 * 0.785398185253143310546875;
        float _380 = (_357.x - _357.y) * 0.4290426075458526611328125;
        float3 _386 = float3(0.0);
        _386.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _378) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _379)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _380);
        float3 _392 = _386;
        _392.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _378) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _379)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _380);
        float3 _398 = _392;
        _398.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _378) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _379)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _380);
        _400 = fast::max(float3(0.0), _398);
    }
    else
    {
        _400 = float3(0.0);
    }
    float _426;
    float _427;
    float3 _428;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _416;
        float _417;
        if (_327)
        {
            _416 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _417 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _416 = _274;
            _417 = 1.0;
        }
        float _418 = 1.0 - _417;
        float _420 = 1.0 - (_418 * _418);
        _426 = mix(fast::clamp(dot(_416, _274), 0.0, 1.0), 1.0, _420);
        _427 = _417;
        _428 = mix(_416, _274, float3(_420));
    }
    else
    {
        _426 = 1.0;
        _427 = 1.0;
        _428 = _274;
    }
    float4 _432 = float4(_428, 1.0);
    float3 _436 = _199;
    _436.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _432);
    float3 _440 = _436;
    _440.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _432);
    float3 _444 = _440;
    _444.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _432);
    float4 _447 = _432.xyzz * _432.yzzx;
    float3 _451 = _199;
    _451.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _447);
    float3 _455 = _451;
    _455.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _447);
    float3 _459 = _455;
    _459.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _447);
    float3 _474 = (_400 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_444 + _459) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_428.x * _428.x) - (_428.y * _428.y)))) * View.View_SkyLightColor.xyz) * (_427 * _426));
    uint2 _519 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _533 = (_274 * (2.0 * dot(_266, _274))) - _266;
    uint _539 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _519.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _519.x)) * 2u;
    float _554 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_297, 0.001000000047497451305389404296875)));
    float2 _558;
    float4 _561;
    _558 = float2(0.0, 1.0);
    _561 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _559;
    float4 _562;
    for (uint _563 = 0u; _563 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_539)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _558 = _559, _561 = _562, _563++)
    {
        if (_561.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _574 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_539 + 1u))).x + _563)));
        uint _575 = _574.x;
        float3 _581 = _264 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_575].xyz;
        float _582 = dot(_581, _581);
        float _583 = sqrt(_582);
        if (_583 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_575].w)
        {
            float _674;
            float3 _675;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_575].z > 0.0)
            {
                float3 _631 = (ReflectionCapture.ReflectionCapture_BoxTransform[_575] * float4(_264, 1.0)).xyz;
                float3 _637 = (ReflectionCapture.ReflectionCapture_BoxTransform[_575] * float4(_533, 0.0)).xyz;
                float3 _638 = float3(1.0) / _637;
                float3 _640 = _631 * _638;
                float3 _643 = fast::max((float3(-1.0) / _637) - _640, _638 - _640);
                float3 _657 = ReflectionCapture.ReflectionCapture_BoxScales[_575].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_575].w);
                float3 _658 = -_657;
                float3 _659 = _631 * ReflectionCapture.ReflectionCapture_BoxScales[_575].xyz;
                _674 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_575].w, dot(select(float3(0.0), abs(_659 - _658), _659 < _658), float3(1.0)) + dot(select(float3(0.0), abs(_659 - _657), _659 > _657), float3(1.0)));
                _675 = (_264 + (_533 * fast::min(_643.x, fast::min(_643.y, _643.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_575].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_575].xyz);
            }
            else
            {
                float _599 = dot(_533, _581);
                float _602 = (_599 * _599) - (_582 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_575].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_575].w));
                float _619;
                float3 _620;
                if (_602 >= 0.0)
                {
                    float _613 = fast::clamp((2.5 * fast::clamp(_583 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_575].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _619 = 1.0 - ((_613 * _613) * (3.0 - (2.0 * _613)));
                    _620 = (_581 + (_533 * (sqrt(_602) - _599))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_575].xyz;
                }
                else
                {
                    _619 = 0.0;
                    _620 = _533;
                }
                _674 = _619;
                _675 = _620;
            }
            float4 _682 = float4(_675, ReflectionCapture.ReflectionCapture_CaptureProperties[_575].y);
            float4 _684 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _682.xyz, uint(round(_682.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _554));
            float3 _687 = _684.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_575].x;
            float4 _689 = float4(_687.x, _687.y, _687.z, _684.w) * _674;
            float3 _694 = _561.xyz + ((_689.xyz * _561.w) * 1.0);
            float4 _699 = float4(_694.x, _694.y, _694.z, _561.w);
            _699.w = _561.w * (1.0 - _689.w);
            float2 _706 = _202;
            _706.x = _558.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_575].w * _674) * _558.y);
            float2 _709 = _706;
            _709.y = _558.y * (1.0 - _674);
            _559 = _709;
            _562 = _699;
        }
        else
        {
            _559 = _558;
            _562 = _561;
        }
    }
    float3 _711 = _561.xyz * View.View_IndirectLightingColorScale;
    float4 _712 = float4(_711.x, _711.y, _711.z, _561.w);
    float _715 = _558.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _716 = _202;
    _716.x = _715;
    float4 _758;
    float2 _759;
    float3 _760;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _736 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _533, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _554)).xyz * View.View_SkyLightColor.xyz;
        float4 _755;
        float2 _756;
        float3 _757;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _749 = _711.xyz + ((_736 * _561.w) * 1.0);
            float2 _754 = _202;
            _754.x = _715 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _558.y);
            _755 = float4(_749.x, _749.y, _749.z, _561.w);
            _756 = _754;
            _757 = float3(0.0);
        }
        else
        {
            _755 = _712;
            _756 = _716;
            _757 = _736 * 1.0;
        }
        _758 = _755;
        _759 = _756;
        _760 = _757;
    }
    else
    {
        _758 = _712;
        _759 = _716;
        _760 = float3(0.0);
    }
    float3 _782 = ((_758.xyz * mix(1.0, fast::min(dot(_474, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_759.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_297 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_760 * _758.w)).xyz;
    float4 _784 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _297) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _785 = _784.x;
    float2 _795 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_785 * _785, exp2((-9.27999973297119140625) * fast::clamp(dot(_274, _266), 0.0, 1.0))) * _785) + _784.y)) + _784.zw;
    float3 _931;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _831 = _264 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _867 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_264, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_831, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_831, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _274) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_297 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _925;
        if (_867 > 0.0)
        {
            float4 _896 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_264 + (reflect(reflect(normalize(_264 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _274).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _903;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _903 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _903 = 0u;
            }
            float4 _920 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_896.xy / float2(_896.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_903].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_903].zw), level(0.0));
            float4 _924 = float4(_920.x, _920.y, _920.z, float4(0.0).w);
            _924.w = _867 * _920.w;
            _925 = _924;
        }
        else
        {
            _925 = float4(0.0);
        }
        _931 = _925.xyz + (_782 * (1.0 - _925.w));
    }
    else
    {
        _931 = _782;
    }
    bool _949 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _998;
    if (_949)
    {
        float4 _956 = View.View_WorldToClip * float4(_264, 1.0);
        float _957 = _956.w;
        float4 _986;
        if (_949)
        {
            _986 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_956.xy / float2(_957)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_957 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _986 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _998 = float4(_986.xyz + (in.in_var_TEXCOORD7.xyz * _986.w), _986.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _998 = in.in_var_TEXCOORD7;
    }
    float3 _1006 = (_264 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1014 = (_264 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1019 = fast::clamp((float3(0.5) - abs(_1006 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1024 = (_1019.x * _1019.y) * _1019.z;
    float4 _1033 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1014, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1006, level(0.0)), float4(_1024));
    float3 _1044 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1014, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1006, level(0.0)).xyz, float3(_1024)) * 1.0;
    float4 _1046 = _201;
    _1046.x = _1033.x;
    float4 _1048 = _201;
    _1048.x = _1033.y;
    float4 _1050 = _201;
    _1050.x = _1033.z;
    float3 _1051 = _1033.xyz;
    float3 _1055 = _1051 / float3(dot(_1051, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1057 = _1044 * _1055.x;
    float3 _1060 = _1044 * _1055.y;
    float3 _1063 = _1044 * _1055.z;
    float4 _1067 = _201;
    _1067.y = (-0.48860299587249755859375) * _274.y;
    float4 _1070 = _1067;
    _1070.z = 0.48860299587249755859375 * _274.z;
    float4 _1073 = _1070;
    _1073.w = (-0.48860299587249755859375) * _274.x;
    float4 _1074 = _1073;
    _1074.x = 0.886227548122406005859375;
    float3 _1076 = _1074.yzw * 2.094395160675048828125;
    float4 _1077 = float4(_1074.x, _1076.x, _1076.y, _1076.z);
    float3 _1079 = _203;
    _1079.x = dot(float4(_1046.x, _1057.x, _1057.y, _1057.z), _1077);
    float3 _1081 = _1079;
    _1081.y = dot(float4(_1048.x, _1060.x, _1060.y, _1060.z), _1077);
    float3 _1083 = _1081;
    _1083.z = dot(float4(_1050.x, _1063.x, _1063.y, _1063.z), _1077);
    float _1085 = _1033.w;
    float3 _1090 = float4(fast::max(float3(0.0), _1083), _1085).xyz;
    float3 _1156;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1104 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_264, 1.0);
        float2 _1108 = _1104.xy / float2(_1104.w);
        float _1109 = _1104.z;
        float4 _1112 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1108, level(0.0));
        float3 _1116 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1109;
        bool2 _1141 = _1108 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1143 = _1108 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1156 = _322 * fast::max(_1090 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _1085) * (float3(1.0) - select(fast::clamp(exp((float3((((_1112.x * _1109) * 0.5) + dot((sin(_1116) * _1112.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1116)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1108, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1141.x || _1143.x, _1141.y || _1143.y)))))), float3(0.0));
    }
    else
    {
        _1156 = _322 * _1090;
    }
    float3 _1164 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1195;
    float3 _1196;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1170 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1183 = any(abs(_264 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1170 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1170 + 19u)].xyz + float3(1.0)));
        float3 _1193;
        if (_1183)
        {
            _1193 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_264, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1193 = _1164;
        }
        _1195 = _1183 ? 1.0 : _298;
        _1196 = _1193;
    }
    else
    {
        _1195 = _298;
        _1196 = _1164;
    }
    float4 _1206 = float4((((mix((((_931 * ((_324 * _795.x) + float3(fast::clamp(50.0 * _324.y, 0.0, 1.0) * _795.y))) * 1.0) * fast::max(float3(1.0), ((((((_324 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_324 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_324 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1156, _322 + (_324 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_474 * _322) * fast::max(float3(1.0), ((((((_291 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_291 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_291 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1196) * _998.w) + _998.xyz, _1195);
    float3 _1210 = _1206.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1210.x, _1210.y, _1210.z, _1206.w);
    return out;
}

