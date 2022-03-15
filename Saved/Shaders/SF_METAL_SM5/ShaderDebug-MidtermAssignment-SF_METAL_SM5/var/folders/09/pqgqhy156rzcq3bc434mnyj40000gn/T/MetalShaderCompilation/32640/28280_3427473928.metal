

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
    char _m19_pad[184];
    float View_ReflectionCubemapMaxMip;
    char _m20_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m22_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m24_pad[80];
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

constant float _187 = {};
constant float4 _188 = {};
constant float4 _190 = {};
constant float2 _191 = {};
constant float3 _192 = {};

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

fragment MainPS_out Main_00006e78_cc4b1a08(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _249 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _253 = _249.xyz / float3(_249.w);
    float3 _254 = _253 - View.View_PreViewTranslation;
    float3 _256 = normalize(-_253);
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _265 = (_262.xy * float2(2.0)) - float2(1.0);
    float3 _281 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_265, sqrt(fast::clamp(1.0 - dot(_265, _265), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _298 = dot(_281, _256);
    float _302 = fast::max(abs(1.0 - fast::max(0.0, _298)), 9.9999997473787516355514526367188e-05);
    float3 _317 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _292.x, float3(0.0), float3(1.0));
    float _323 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _324 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_302 <= 0.0) ? 0.0 : pow(_302, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _336 = ((_317 - (_317 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _343 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _317, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _346 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _351;
    if (_346)
    {
        _351 = _336 + (_343 * 0.449999988079071044921875);
    }
    else
    {
        _351 = _336;
    }
    float3 _353 = select(_343, float3(0.0), bool3(_346));
    float3 _429;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _377 = _281.y;
        float4 _379 = _190;
        _379.y = (-0.48860299587249755859375) * _377;
        float _380 = _281.z;
        float4 _382 = _379;
        _382.z = 0.48860299587249755859375 * _380;
        float _383 = _281.x;
        float4 _385 = _382;
        _385.w = (-0.48860299587249755859375) * _383;
        float3 _386 = _281 * _281;
        float4 _389 = _188;
        _389.x = (1.09254801273345947265625 * _383) * _377;
        float4 _392 = _389;
        _392.y = ((-1.09254801273345947265625) * _377) * _380;
        float4 _397 = _392;
        _397.z = 0.3153919875621795654296875 * ((3.0 * _386.z) - 1.0);
        float4 _400 = _397;
        _400.w = ((-1.09254801273345947265625) * _383) * _380;
        float4 _404 = _385;
        _404.x = 0.886227548122406005859375;
        float3 _406 = _404.yzw * 2.094395160675048828125;
        float4 _407 = float4(_404.x, _406.x, _406.y, _406.z);
        float4 _408 = _400 * 0.785398185253143310546875;
        float _409 = (_386.x - _386.y) * 0.4290426075458526611328125;
        float3 _415 = float3(0.0);
        _415.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _407) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _408)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _409);
        float3 _421 = _415;
        _421.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _407) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _408)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _409);
        float3 _427 = _421;
        _427.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _407) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _408)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _409);
        _429 = fast::max(float3(0.0), _427);
    }
    else
    {
        _429 = float3(0.0);
    }
    float3 _432 = _429 * View.View_IndirectLightingColorScale;
    uint2 _477 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _491 = (_281 * (2.0 * dot(_256, _281))) - _256;
    uint _496 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _477.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _477.x)) * 2u;
    float2 _515;
    float4 _518;
    _515 = float2(0.0, 1.0);
    _518 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _516;
    float4 _519;
    for (uint _520 = 0u; _520 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_496)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _515 = _516, _518 = _519, _520++)
    {
        if (_518.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _531 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_496 + 1u))).x + _520)));
        uint _532 = _531.x;
        float3 _538 = _254 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_532].xyz;
        float _539 = dot(_538, _538);
        float _540 = sqrt(_539);
        if (_540 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_532].w)
        {
            float _631;
            float3 _632;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_532].z > 0.0)
            {
                float3 _588 = (ReflectionCapture.ReflectionCapture_BoxTransform[_532] * float4(_254, 1.0)).xyz;
                float3 _594 = (ReflectionCapture.ReflectionCapture_BoxTransform[_532] * float4(_491, 0.0)).xyz;
                float3 _595 = float3(1.0) / _594;
                float3 _597 = _588 * _595;
                float3 _600 = fast::max((float3(-1.0) / _594) - _597, _595 - _597);
                float3 _614 = ReflectionCapture.ReflectionCapture_BoxScales[_532].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_532].w);
                float3 _615 = -_614;
                float3 _616 = _588 * ReflectionCapture.ReflectionCapture_BoxScales[_532].xyz;
                _631 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_532].w, dot(select(float3(0.0), abs(_616 - _615), _616 < _615), float3(1.0)) + dot(select(float3(0.0), abs(_616 - _614), _616 > _614), float3(1.0)));
                _632 = (_254 + (_491 * fast::min(_600.x, fast::min(_600.y, _600.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_532].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_532].xyz);
            }
            else
            {
                float _556 = dot(_491, _538);
                float _559 = (_556 * _556) - (_539 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_532].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_532].w));
                float _576;
                float3 _577;
                if (_559 >= 0.0)
                {
                    float _570 = fast::clamp((2.5 * fast::clamp(_540 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_532].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _576 = 1.0 - ((_570 * _570) * (3.0 - (2.0 * _570)));
                    _577 = (_538 + (_491 * (sqrt(_559) - _556))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_532].xyz;
                }
                else
                {
                    _576 = 0.0;
                    _577 = _491;
                }
                _631 = _576;
                _632 = _577;
            }
            float4 _639 = float4(_632, ReflectionCapture.ReflectionCapture_CaptureProperties[_532].y);
            float4 _641 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _639.xyz, uint(round(_639.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_323, 0.001000000047497451305389404296875))))));
            float3 _644 = _641.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_532].x;
            float4 _646 = float4(_644.x, _644.y, _644.z, _641.w) * _631;
            float3 _651 = _518.xyz + ((_646.xyz * _518.w) * 1.0);
            float4 _656 = float4(_651.x, _651.y, _651.z, _518.w);
            _656.w = _518.w * (1.0 - _646.w);
            float2 _663 = _191;
            _663.x = _515.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_532].w * _631) * _515.y);
            float2 _666 = _663;
            _666.y = _515.y * (1.0 - _631);
            _516 = _666;
            _519 = _656;
        }
        else
        {
            _516 = _515;
            _519 = _518;
        }
    }
    float3 _688 = ((_518.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_432, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_515.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_323 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _690 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _323) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _691 = _690.x;
    float2 _701 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_691 * _691, exp2((-9.27999973297119140625) * fast::clamp(_298, 0.0, 1.0))) * _691) + _690.y)) + _690.zw;
    float3 _837;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _737 = _254 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _773 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_254, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_737, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_737, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _281) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_323 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _831;
        if (_773 > 0.0)
        {
            float4 _802 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_254 + (reflect(reflect(normalize(_254 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _281).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _809;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _809 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _809 = 0u;
            }
            float4 _826 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_802.xy / float2(_802.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_809].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_809].zw), level(0.0));
            float4 _830 = float4(_826.x, _826.y, _826.z, float4(0.0).w);
            _830.w = _773 * _826.w;
            _831 = _830;
        }
        else
        {
            _831 = float4(0.0);
        }
        _837 = _831.xyz + (_688 * (1.0 - _831.w));
    }
    else
    {
        _837 = _688;
    }
    bool _855 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _904;
    if (_855)
    {
        float4 _862 = View.View_WorldToClip * float4(_254, 1.0);
        float _863 = _862.w;
        float4 _892;
        if (_855)
        {
            _892 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_862.xy / float2(_863)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_863 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _892 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _904 = float4(_892.xyz + (in.in_var_TEXCOORD7.xyz * _892.w), _892.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _904 = in.in_var_TEXCOORD7;
    }
    float3 _912 = (_254 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _920 = (_254 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _925 = fast::clamp((float3(0.5) - abs(_912 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _930 = (_925.x * _925.y) * _925.z;
    float4 _939 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _920, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _912, level(0.0)), float4(_930));
    float3 _950 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _920, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _912, level(0.0)).xyz, float3(_930)) * 1.0;
    float4 _952 = _190;
    _952.x = _939.x;
    float4 _954 = _190;
    _954.x = _939.y;
    float4 _956 = _190;
    _956.x = _939.z;
    float3 _957 = _939.xyz;
    float3 _961 = _957 / float3(dot(_957, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _963 = _950 * _961.x;
    float3 _966 = _950 * _961.y;
    float3 _969 = _950 * _961.z;
    float4 _973 = _190;
    _973.y = (-0.48860299587249755859375) * _281.y;
    float4 _976 = _973;
    _976.z = 0.48860299587249755859375 * _281.z;
    float4 _979 = _976;
    _979.w = (-0.48860299587249755859375) * _281.x;
    float4 _980 = _979;
    _980.x = 0.886227548122406005859375;
    float3 _982 = _980.yzw * 2.094395160675048828125;
    float4 _983 = float4(_980.x, _982.x, _982.y, _982.z);
    float3 _985 = _192;
    _985.x = dot(float4(_952.x, _963.x, _963.y, _963.z), _983);
    float3 _987 = _985;
    _987.y = dot(float4(_954.x, _966.x, _966.y, _966.z), _983);
    float3 _989 = _987;
    _989.z = dot(float4(_956.x, _969.x, _969.y, _969.z), _983);
    float3 _1004 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1035;
    float3 _1036;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1010 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1023 = any(abs(_254 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1010 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1010 + 19u)].xyz + float3(1.0)));
        float3 _1033;
        if (_1023)
        {
            _1033 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_254, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1033 = _1004;
        }
        _1035 = _1023 ? 1.0 : _324;
        _1036 = _1033;
    }
    else
    {
        _1035 = _324;
        _1036 = _1004;
    }
    float4 _1046 = float4((((mix((((_837 * ((_353 * _701.x) + float3(fast::clamp(50.0 * _353.y, 0.0, 1.0) * _701.y))) * 1.0) * fast::max(float3(1.0), ((((((_353 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_353 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_353 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_351 * float4(fast::max(float3(0.0), _989), _187).xyz), _351 + (_353 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_432 * _351) * fast::max(float3(1.0), ((((((_317 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_317 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_317 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1036) * _904.w) + _904.xyz, _1035);
    float3 _1050 = _1046.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1050.x, _1050.y, _1050.z, _1046.w);
    return out;
}

