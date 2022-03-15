

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
    char _m18_pad[184];
    float View_ReflectionCubemapMaxMip;
    char _m19_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m21_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m23_pad[80];
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
    char _m5_pad[1312];
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
    char _m16_pad[144];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_IndirectLightingCache
{
    char _m0_pad[96];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
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

constant float _173 = {};
constant float4 _174 = {};
constant float4 _176 = {};
constant float2 _177 = {};
constant float3 _178 = {};

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

fragment MainPS_out Main_0000690d_4fa02554(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = _231.xyz / float3(_231.w);
    float3 _236 = _235 - View.View_PreViewTranslation;
    float3 _238 = normalize(-_235);
    float3 _246 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _263 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _269 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _270 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _279 = (_263 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _286 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _289 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _294;
    if (_289)
    {
        _294 = _279 + (_286 * 0.449999988079071044921875);
    }
    else
    {
        _294 = _279;
    }
    float3 _296 = select(_286, float3(0.0), bool3(_289));
    float3 _372;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _320 = _246.y;
        float4 _322 = _176;
        _322.y = (-0.48860299587249755859375) * _320;
        float _323 = _246.z;
        float4 _325 = _322;
        _325.z = 0.48860299587249755859375 * _323;
        float _326 = _246.x;
        float4 _328 = _325;
        _328.w = (-0.48860299587249755859375) * _326;
        float3 _329 = _246 * _246;
        float4 _332 = _174;
        _332.x = (1.09254801273345947265625 * _326) * _320;
        float4 _335 = _332;
        _335.y = ((-1.09254801273345947265625) * _320) * _323;
        float4 _340 = _335;
        _340.z = 0.3153919875621795654296875 * ((3.0 * _329.z) - 1.0);
        float4 _343 = _340;
        _343.w = ((-1.09254801273345947265625) * _326) * _323;
        float4 _347 = _328;
        _347.x = 0.886227548122406005859375;
        float3 _349 = _347.yzw * 2.094395160675048828125;
        float4 _350 = float4(_347.x, _349.x, _349.y, _349.z);
        float4 _351 = _343 * 0.785398185253143310546875;
        float _352 = (_329.x - _329.y) * 0.4290426075458526611328125;
        float3 _358 = float3(0.0);
        _358.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _350) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _351)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _352);
        float3 _364 = _358;
        _364.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _350) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _351)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _352);
        float3 _370 = _364;
        _370.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _350) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _351)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _352);
        _372 = fast::max(float3(0.0), _370);
    }
    else
    {
        _372 = float3(0.0);
    }
    float3 _375 = _372 * View.View_IndirectLightingColorScale;
    uint2 _420 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _434 = (_246 * (2.0 * dot(_238, _246))) - _238;
    uint _440 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _420.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _420.x)) * 2u;
    float2 _459;
    float4 _462;
    _459 = float2(0.0, 1.0);
    _462 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _460;
    float4 _463;
    for (uint _464 = 0u; _464 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_440)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _459 = _460, _462 = _463, _464++)
    {
        if (_462.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _475 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_440 + 1u))).x + _464)));
        uint _476 = _475.x;
        float3 _482 = _236 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_476].xyz;
        float _483 = dot(_482, _482);
        float _484 = sqrt(_483);
        if (_484 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_476].w)
        {
            float _575;
            float3 _576;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_476].z > 0.0)
            {
                float3 _532 = (ReflectionCapture.ReflectionCapture_BoxTransform[_476] * float4(_236, 1.0)).xyz;
                float3 _538 = (ReflectionCapture.ReflectionCapture_BoxTransform[_476] * float4(_434, 0.0)).xyz;
                float3 _539 = float3(1.0) / _538;
                float3 _541 = _532 * _539;
                float3 _544 = fast::max((float3(-1.0) / _538) - _541, _539 - _541);
                float3 _558 = ReflectionCapture.ReflectionCapture_BoxScales[_476].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_476].w);
                float3 _559 = -_558;
                float3 _560 = _532 * ReflectionCapture.ReflectionCapture_BoxScales[_476].xyz;
                _575 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_476].w, dot(select(float3(0.0), abs(_560 - _559), _560 < _559), float3(1.0)) + dot(select(float3(0.0), abs(_560 - _558), _560 > _558), float3(1.0)));
                _576 = (_236 + (_434 * fast::min(_544.x, fast::min(_544.y, _544.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_476].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_476].xyz);
            }
            else
            {
                float _500 = dot(_434, _482);
                float _503 = (_500 * _500) - (_483 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_476].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_476].w));
                float _520;
                float3 _521;
                if (_503 >= 0.0)
                {
                    float _514 = fast::clamp((2.5 * fast::clamp(_484 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_476].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _520 = 1.0 - ((_514 * _514) * (3.0 - (2.0 * _514)));
                    _521 = (_482 + (_434 * (sqrt(_503) - _500))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_476].xyz;
                }
                else
                {
                    _520 = 0.0;
                    _521 = _434;
                }
                _575 = _520;
                _576 = _521;
            }
            float4 _583 = float4(_576, ReflectionCapture.ReflectionCapture_CaptureProperties[_476].y);
            float4 _585 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _583.xyz, uint(round(_583.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_269, 0.001000000047497451305389404296875))))));
            float3 _588 = _585.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_476].x;
            float4 _590 = float4(_588.x, _588.y, _588.z, _585.w) * _575;
            float3 _595 = _462.xyz + ((_590.xyz * _462.w) * 1.0);
            float4 _600 = float4(_595.x, _595.y, _595.z, _462.w);
            _600.w = _462.w * (1.0 - _590.w);
            float2 _607 = _177;
            _607.x = _459.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_476].w * _575) * _459.y);
            float2 _610 = _607;
            _610.y = _459.y * (1.0 - _575);
            _460 = _610;
            _463 = _600;
        }
        else
        {
            _460 = _459;
            _463 = _462;
        }
    }
    float3 _632 = ((_462.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_375, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_459.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_269 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _634 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _269) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _635 = _634.x;
    float2 _645 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_635 * _635, exp2((-9.27999973297119140625) * fast::clamp(dot(_246, _238), 0.0, 1.0))) * _635) + _634.y)) + _634.zw;
    float3 _781;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _681 = _236 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _717 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_236, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_681, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_681, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _246) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_269 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _775;
        if (_717 > 0.0)
        {
            float4 _746 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_236 + (reflect(reflect(normalize(_236 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _246).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _753;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _753 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _753 = 0u;
            }
            float4 _770 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_746.xy / float2(_746.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_753].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_753].zw), level(0.0));
            float4 _774 = float4(_770.x, _770.y, _770.z, float4(0.0).w);
            _774.w = _717 * _770.w;
            _775 = _774;
        }
        else
        {
            _775 = float4(0.0);
        }
        _781 = _775.xyz + (_632 * (1.0 - _775.w));
    }
    else
    {
        _781 = _632;
    }
    bool _799 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _848;
    if (_799)
    {
        float4 _806 = View.View_WorldToClip * float4(_236, 1.0);
        float _807 = _806.w;
        float4 _836;
        if (_799)
        {
            _836 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_806.xy / float2(_807)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_807 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _836 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _848 = float4(_836.xyz + (in.in_var_TEXCOORD7.xyz * _836.w), _836.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _848 = in.in_var_TEXCOORD7;
    }
    float3 _856 = (_236 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _864 = (_236 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _869 = fast::clamp((float3(0.5) - abs(_856 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _874 = (_869.x * _869.y) * _869.z;
    float4 _883 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _864, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _856, level(0.0)), float4(_874));
    float3 _894 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _864, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _856, level(0.0)).xyz, float3(_874)) * 1.0;
    float4 _896 = _176;
    _896.x = _883.x;
    float4 _898 = _176;
    _898.x = _883.y;
    float4 _900 = _176;
    _900.x = _883.z;
    float3 _901 = _883.xyz;
    float3 _905 = _901 / float3(dot(_901, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _907 = _894 * _905.x;
    float3 _910 = _894 * _905.y;
    float3 _913 = _894 * _905.z;
    float4 _917 = _176;
    _917.y = (-0.48860299587249755859375) * _246.y;
    float4 _920 = _917;
    _920.z = 0.48860299587249755859375 * _246.z;
    float4 _923 = _920;
    _923.w = (-0.48860299587249755859375) * _246.x;
    float4 _924 = _923;
    _924.x = 0.886227548122406005859375;
    float3 _926 = _924.yzw * 2.094395160675048828125;
    float4 _927 = float4(_924.x, _926.x, _926.y, _926.z);
    float3 _929 = _178;
    _929.x = dot(float4(_896.x, _907.x, _907.y, _907.z), _927);
    float3 _931 = _929;
    _931.y = dot(float4(_898.x, _910.x, _910.y, _910.z), _927);
    float3 _933 = _931;
    _933.z = dot(float4(_900.x, _913.x, _913.y, _913.z), _927);
    float3 _948 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _979;
    float3 _980;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _954 = in.in_var_PRIMITIVE_ID * 36u;
        bool _967 = any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _954 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _954 + 19u)].xyz + float3(1.0)));
        float3 _977;
        if (_967)
        {
            _977 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _977 = _948;
        }
        _979 = _967 ? 1.0 : _270;
        _980 = _977;
    }
    else
    {
        _979 = _270;
        _980 = _948;
    }
    float4 _990 = float4((((mix((((_781 * ((_296 * _645.x) + float3(fast::clamp(50.0 * _296.y, 0.0, 1.0) * _645.y))) * 1.0) * fast::max(float3(1.0), ((((((_296 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_296 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_296 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_294 * float4(fast::max(float3(0.0), _933), _173).xyz), _294 + (_296 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_375 * _294) * fast::max(float3(1.0), ((((((_263 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_263 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_263 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _980) * _848.w) + _848.xyz, _979);
    float3 _994 = _990.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_994.x, _994.y, _994.z, _990.w);
    return out;
}

