

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
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m17_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m18_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m19_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m21_pad[120];
    float View_ReflectionCubemapMaxMip;
    char _m22_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m24_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m26_pad[80];
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

constant float4 _212 = {};
constant float3 _213 = {};
constant float4 _215 = {};
constant float2 _216 = {};
constant float3 _217 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000088b9_9452403d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(10)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(6)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(7)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(8)]], constant type_Material& Material [[buffer(9)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(10)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _277 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _281 = _277.xyz / float3(_277.w);
    float3 _282 = _281 - View.View_PreViewTranslation;
    float3 _284 = normalize(-_281);
    float4 _290 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _293 = (_290.xy * float2(2.0)) - float2(1.0);
    float3 _309 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_293, sqrt(fast::clamp(1.0 - dot(_293, _293), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _320 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _326 = dot(_309, _284);
    float _330 = fast::max(abs(1.0 - fast::max(0.0, _326)), 9.9999997473787516355514526367188e-05);
    float3 _345 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _320.x, float3(0.0), float3(1.0));
    float _351 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _352 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_330 <= 0.0) ? 0.0 : pow(_330, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _364 = ((_345 - (_345 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _371 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _345, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _374 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _379;
    if (_374)
    {
        _379 = _364 + (_371 * 0.449999988079071044921875);
    }
    else
    {
        _379 = _364;
    }
    float3 _381 = select(_371, float3(0.0), bool3(_374));
    bool _384 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _457;
    if (_384)
    {
        float _405 = _309.y;
        float4 _407 = _215;
        _407.y = (-0.48860299587249755859375) * _405;
        float _408 = _309.z;
        float4 _410 = _407;
        _410.z = 0.48860299587249755859375 * _408;
        float _411 = _309.x;
        float4 _413 = _410;
        _413.w = (-0.48860299587249755859375) * _411;
        float3 _414 = _309 * _309;
        float4 _417 = _212;
        _417.x = (1.09254801273345947265625 * _411) * _405;
        float4 _420 = _417;
        _420.y = ((-1.09254801273345947265625) * _405) * _408;
        float4 _425 = _420;
        _425.z = 0.3153919875621795654296875 * ((3.0 * _414.z) - 1.0);
        float4 _428 = _425;
        _428.w = ((-1.09254801273345947265625) * _411) * _408;
        float4 _432 = _413;
        _432.x = 0.886227548122406005859375;
        float3 _434 = _432.yzw * 2.094395160675048828125;
        float4 _435 = float4(_432.x, _434.x, _434.y, _434.z);
        float4 _436 = _428 * 0.785398185253143310546875;
        float _437 = (_414.x - _414.y) * 0.4290426075458526611328125;
        float3 _443 = float3(0.0);
        _443.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _435) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _436)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _437);
        float3 _449 = _443;
        _449.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _435) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _436)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _437);
        float3 _455 = _449;
        _455.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _435) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _436)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _437);
        _457 = fast::max(float3(0.0), _455);
    }
    else
    {
        _457 = float3(0.0);
    }
    float _483;
    float _484;
    float3 _485;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _473;
        float _474;
        if (_384)
        {
            _473 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _474 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _473 = _309;
            _474 = 1.0;
        }
        float _475 = 1.0 - _474;
        float _477 = 1.0 - (_475 * _475);
        _483 = mix(fast::clamp(dot(_473, _309), 0.0, 1.0), 1.0, _477);
        _484 = _474;
        _485 = mix(_473, _309, float3(_477));
    }
    else
    {
        _483 = 1.0;
        _484 = 1.0;
        _485 = _309;
    }
    float4 _489 = float4(_485, 1.0);
    float3 _493 = _213;
    _493.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _489);
    float3 _497 = _493;
    _497.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _489);
    float3 _501 = _497;
    _501.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _489);
    float4 _504 = _489.xyzz * _489.yzzx;
    float3 _508 = _213;
    _508.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _504);
    float3 _512 = _508;
    _512.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _504);
    float3 _516 = _512;
    _516.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _504);
    float3 _531 = (_457 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_501 + _516) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_485.x * _485.x) - (_485.y * _485.y)))) * View.View_SkyLightColor.xyz) * (_484 * _483));
    uint2 _576 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _590 = (_309 * (2.0 * dot(_284, _309))) - _284;
    uint _595 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _576.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _576.x)) * 2u;
    float _610 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_351, 0.001000000047497451305389404296875)));
    float2 _614;
    float4 _617;
    _614 = float2(0.0, 1.0);
    _617 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _615;
    float4 _618;
    for (uint _619 = 0u; _619 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_595)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _614 = _615, _617 = _618, _619++)
    {
        if (_617.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _630 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_595 + 1u))).x + _619)));
        uint _631 = _630.x;
        float3 _637 = _282 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_631].xyz;
        float _638 = dot(_637, _637);
        float _639 = sqrt(_638);
        if (_639 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_631].w)
        {
            float _730;
            float3 _731;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_631].z > 0.0)
            {
                float3 _687 = (ReflectionCapture.ReflectionCapture_BoxTransform[_631] * float4(_282, 1.0)).xyz;
                float3 _693 = (ReflectionCapture.ReflectionCapture_BoxTransform[_631] * float4(_590, 0.0)).xyz;
                float3 _694 = float3(1.0) / _693;
                float3 _696 = _687 * _694;
                float3 _699 = fast::max((float3(-1.0) / _693) - _696, _694 - _696);
                float3 _713 = ReflectionCapture.ReflectionCapture_BoxScales[_631].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_631].w);
                float3 _714 = -_713;
                float3 _715 = _687 * ReflectionCapture.ReflectionCapture_BoxScales[_631].xyz;
                _730 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_631].w, dot(select(float3(0.0), abs(_715 - _714), _715 < _714), float3(1.0)) + dot(select(float3(0.0), abs(_715 - _713), _715 > _713), float3(1.0)));
                _731 = (_282 + (_590 * fast::min(_699.x, fast::min(_699.y, _699.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_631].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_631].xyz);
            }
            else
            {
                float _655 = dot(_590, _637);
                float _658 = (_655 * _655) - (_638 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_631].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_631].w));
                float _675;
                float3 _676;
                if (_658 >= 0.0)
                {
                    float _669 = fast::clamp((2.5 * fast::clamp(_639 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_631].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _675 = 1.0 - ((_669 * _669) * (3.0 - (2.0 * _669)));
                    _676 = (_637 + (_590 * (sqrt(_658) - _655))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_631].xyz;
                }
                else
                {
                    _675 = 0.0;
                    _676 = _590;
                }
                _730 = _675;
                _731 = _676;
            }
            float4 _738 = float4(_731, ReflectionCapture.ReflectionCapture_CaptureProperties[_631].y);
            float4 _740 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _738.xyz, uint(round(_738.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _610));
            float3 _743 = _740.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_631].x;
            float4 _745 = float4(_743.x, _743.y, _743.z, _740.w) * _730;
            float3 _750 = _617.xyz + ((_745.xyz * _617.w) * 1.0);
            float4 _755 = float4(_750.x, _750.y, _750.z, _617.w);
            _755.w = _617.w * (1.0 - _745.w);
            float2 _762 = _216;
            _762.x = _614.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_631].w * _730) * _614.y);
            float2 _765 = _762;
            _765.y = _614.y * (1.0 - _730);
            _615 = _765;
            _618 = _755;
        }
        else
        {
            _615 = _614;
            _618 = _617;
        }
    }
    float3 _767 = _617.xyz * View.View_IndirectLightingColorScale;
    float4 _768 = float4(_767.x, _767.y, _767.z, _617.w);
    float _771 = _614.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _772 = _216;
    _772.x = _771;
    float4 _814;
    float2 _815;
    float3 _816;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _792 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _590, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _610)).xyz * View.View_SkyLightColor.xyz;
        float4 _811;
        float2 _812;
        float3 _813;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _805 = _767.xyz + ((_792 * _617.w) * 1.0);
            float2 _810 = _216;
            _810.x = _771 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _614.y);
            _811 = float4(_805.x, _805.y, _805.z, _617.w);
            _812 = _810;
            _813 = float3(0.0);
        }
        else
        {
            _811 = _768;
            _812 = _772;
            _813 = _792 * 1.0;
        }
        _814 = _811;
        _815 = _812;
        _816 = _813;
    }
    else
    {
        _814 = _768;
        _815 = _772;
        _816 = float3(0.0);
    }
    float3 _838 = ((_814.xyz * mix(1.0, fast::min(dot(_531, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_815.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_351 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_816 * _814.w)).xyz;
    float4 _840 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _351) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _841 = _840.x;
    float2 _851 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_841 * _841, exp2((-9.27999973297119140625) * fast::clamp(_326, 0.0, 1.0))) * _841) + _840.y)) + _840.zw;
    float3 _987;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _887 = _282 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _923 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_282, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_887, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_887, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _309) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_351 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _981;
        if (_923 > 0.0)
        {
            float4 _952 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_282 + (reflect(reflect(normalize(_282 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _309).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _959;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _959 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _959 = 0u;
            }
            float4 _976 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_952.xy / float2(_952.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_959].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_959].zw), level(0.0));
            float4 _980 = float4(_976.x, _976.y, _976.z, float4(0.0).w);
            _980.w = _923 * _976.w;
            _981 = _980;
        }
        else
        {
            _981 = float4(0.0);
        }
        _987 = _981.xyz + (_838 * (1.0 - _981.w));
    }
    else
    {
        _987 = _838;
    }
    bool _1005 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1054;
    if (_1005)
    {
        float4 _1012 = View.View_WorldToClip * float4(_282, 1.0);
        float _1013 = _1012.w;
        float4 _1042;
        if (_1005)
        {
            _1042 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1012.xy / float2(_1013)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1013 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1042 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1054 = float4(_1042.xyz + (in.in_var_TEXCOORD7.xyz * _1042.w), _1042.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1054 = in.in_var_TEXCOORD7;
    }
    float3 _1062 = (_282 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1070 = (_282 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1075 = fast::clamp((float3(0.5) - abs(_1062 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1080 = (_1075.x * _1075.y) * _1075.z;
    float4 _1089 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1070, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1062, level(0.0)), float4(_1080));
    float3 _1100 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1070, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1062, level(0.0)).xyz, float3(_1080)) * 1.0;
    float4 _1102 = _215;
    _1102.x = _1089.x;
    float4 _1104 = _215;
    _1104.x = _1089.y;
    float4 _1106 = _215;
    _1106.x = _1089.z;
    float3 _1107 = _1089.xyz;
    float3 _1111 = _1107 / float3(dot(_1107, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1113 = _1100 * _1111.x;
    float3 _1116 = _1100 * _1111.y;
    float3 _1119 = _1100 * _1111.z;
    float4 _1123 = _215;
    _1123.y = (-0.48860299587249755859375) * _309.y;
    float4 _1126 = _1123;
    _1126.z = 0.48860299587249755859375 * _309.z;
    float4 _1129 = _1126;
    _1129.w = (-0.48860299587249755859375) * _309.x;
    float4 _1130 = _1129;
    _1130.x = 0.886227548122406005859375;
    float3 _1132 = _1130.yzw * 2.094395160675048828125;
    float4 _1133 = float4(_1130.x, _1132.x, _1132.y, _1132.z);
    float3 _1135 = _217;
    _1135.x = dot(float4(_1102.x, _1113.x, _1113.y, _1113.z), _1133);
    float3 _1137 = _1135;
    _1137.y = dot(float4(_1104.x, _1116.x, _1116.y, _1116.z), _1133);
    float3 _1139 = _1137;
    _1139.z = dot(float4(_1106.x, _1119.x, _1119.y, _1119.z), _1133);
    float _1141 = _1089.w;
    float3 _1146 = float4(fast::max(float3(0.0), _1139), _1141).xyz;
    float3 _1212;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1160 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_282, 1.0);
        float2 _1164 = _1160.xy / float2(_1160.w);
        float _1165 = _1160.z;
        float4 _1168 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1164, level(0.0));
        float3 _1172 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1165;
        bool2 _1197 = _1164 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1199 = _1164 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1212 = _379 * fast::max(_1146 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _1141) * (float3(1.0) - select(fast::clamp(exp((float3((((_1168.x * _1165) * 0.5) + dot((sin(_1172) * _1168.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1172)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1164, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1197.x || _1199.x, _1197.y || _1199.y)))))), float3(0.0));
    }
    else
    {
        _1212 = _379 * _1146;
    }
    float3 _1220 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1251;
    float3 _1252;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1226 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1239 = any(abs(_282 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1226 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1226 + 19u)].xyz + float3(1.0)));
        float3 _1249;
        if (_1239)
        {
            _1249 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_282, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1249 = _1220;
        }
        _1251 = _1239 ? 1.0 : _352;
        _1252 = _1249;
    }
    else
    {
        _1251 = _352;
        _1252 = _1220;
    }
    float4 _1262 = float4((((mix((((_987 * ((_381 * _851.x) + float3(fast::clamp(50.0 * _381.y, 0.0, 1.0) * _851.y))) * 1.0) * fast::max(float3(1.0), ((((((_381 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_381 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_381 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1212, _379 + (_381 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_531 * _379) * fast::max(float3(1.0), ((((((_345 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_345 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_345 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1252) * _1054.w) + _1054.xyz, _1251);
    float3 _1266 = _1262.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1266.x, _1266.y, _1266.z, _1262.w);
    return out;
}

