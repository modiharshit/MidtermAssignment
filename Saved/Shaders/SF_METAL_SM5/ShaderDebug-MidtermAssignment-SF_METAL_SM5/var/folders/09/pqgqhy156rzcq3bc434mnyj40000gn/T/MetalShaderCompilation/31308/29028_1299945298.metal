

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

constant float4 _190 = {};
constant float4 _192 = {};
constant float2 _193 = {};
constant float3 _194 = {};

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

fragment MainPS_out Main_00007164_4d7b9752(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(5)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _247 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _251 = _247.xyz / float3(_247.w);
    float3 _252 = _251 - View.View_PreViewTranslation;
    float3 _254 = normalize(-_251);
    float3 _262 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _279 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _285 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _286 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _295 = (_279 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _302 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _305 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _310;
    if (_305)
    {
        _310 = _295 + (_302 * 0.449999988079071044921875);
    }
    else
    {
        _310 = _295;
    }
    float3 _312 = select(_302, float3(0.0), bool3(_305));
    float3 _388;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float _336 = _262.y;
        float4 _338 = _192;
        _338.y = (-0.48860299587249755859375) * _336;
        float _339 = _262.z;
        float4 _341 = _338;
        _341.z = 0.48860299587249755859375 * _339;
        float _342 = _262.x;
        float4 _344 = _341;
        _344.w = (-0.48860299587249755859375) * _342;
        float3 _345 = _262 * _262;
        float4 _348 = _190;
        _348.x = (1.09254801273345947265625 * _342) * _336;
        float4 _351 = _348;
        _351.y = ((-1.09254801273345947265625) * _336) * _339;
        float4 _356 = _351;
        _356.z = 0.3153919875621795654296875 * ((3.0 * _345.z) - 1.0);
        float4 _359 = _356;
        _359.w = ((-1.09254801273345947265625) * _342) * _339;
        float4 _363 = _344;
        _363.x = 0.886227548122406005859375;
        float3 _365 = _363.yzw * 2.094395160675048828125;
        float4 _366 = float4(_363.x, _365.x, _365.y, _365.z);
        float4 _367 = _359 * 0.785398185253143310546875;
        float _368 = (_345.x - _345.y) * 0.4290426075458526611328125;
        float3 _374 = float3(0.0);
        _374.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _366) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _367)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _368);
        float3 _380 = _374;
        _380.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _366) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _367)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _368);
        float3 _386 = _380;
        _386.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _366) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _367)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _368);
        _388 = fast::max(float3(0.0), _386);
    }
    else
    {
        _388 = float3(0.0);
    }
    float3 _391 = _388 * View.View_IndirectLightingColorScale;
    uint2 _436 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _450 = (_262 * (2.0 * dot(_254, _262))) - _254;
    uint _456 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _436.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _436.x)) * 2u;
    float2 _475;
    float4 _478;
    _475 = float2(0.0, 1.0);
    _478 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _476;
    float4 _479;
    for (uint _480 = 0u; _480 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_456)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _475 = _476, _478 = _479, _480++)
    {
        if (_478.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _491 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_456 + 1u))).x + _480)));
        uint _492 = _491.x;
        float3 _498 = _252 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_492].xyz;
        float _499 = dot(_498, _498);
        float _500 = sqrt(_499);
        if (_500 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_492].w)
        {
            float _591;
            float3 _592;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_492].z > 0.0)
            {
                float3 _548 = (ReflectionCapture.ReflectionCapture_BoxTransform[_492] * float4(_252, 1.0)).xyz;
                float3 _554 = (ReflectionCapture.ReflectionCapture_BoxTransform[_492] * float4(_450, 0.0)).xyz;
                float3 _555 = float3(1.0) / _554;
                float3 _557 = _548 * _555;
                float3 _560 = fast::max((float3(-1.0) / _554) - _557, _555 - _557);
                float3 _574 = ReflectionCapture.ReflectionCapture_BoxScales[_492].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_492].w);
                float3 _575 = -_574;
                float3 _576 = _548 * ReflectionCapture.ReflectionCapture_BoxScales[_492].xyz;
                _591 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_492].w, dot(select(float3(0.0), abs(_576 - _575), _576 < _575), float3(1.0)) + dot(select(float3(0.0), abs(_576 - _574), _576 > _574), float3(1.0)));
                _592 = (_252 + (_450 * fast::min(_560.x, fast::min(_560.y, _560.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_492].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_492].xyz);
            }
            else
            {
                float _516 = dot(_450, _498);
                float _519 = (_516 * _516) - (_499 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_492].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_492].w));
                float _536;
                float3 _537;
                if (_519 >= 0.0)
                {
                    float _530 = fast::clamp((2.5 * fast::clamp(_500 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_492].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _536 = 1.0 - ((_530 * _530) * (3.0 - (2.0 * _530)));
                    _537 = (_498 + (_450 * (sqrt(_519) - _516))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_492].xyz;
                }
                else
                {
                    _536 = 0.0;
                    _537 = _450;
                }
                _591 = _536;
                _592 = _537;
            }
            float4 _599 = float4(_592, ReflectionCapture.ReflectionCapture_CaptureProperties[_492].y);
            float4 _601 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _599.xyz, uint(round(_599.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_285, 0.001000000047497451305389404296875))))));
            float3 _604 = _601.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_492].x;
            float4 _606 = float4(_604.x, _604.y, _604.z, _601.w) * _591;
            float3 _611 = _478.xyz + ((_606.xyz * _478.w) * 1.0);
            float4 _616 = float4(_611.x, _611.y, _611.z, _478.w);
            _616.w = _478.w * (1.0 - _606.w);
            float2 _623 = _193;
            _623.x = _475.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_492].w * _591) * _475.y);
            float2 _626 = _623;
            _626.y = _475.y * (1.0 - _591);
            _476 = _626;
            _479 = _616;
        }
        else
        {
            _476 = _475;
            _479 = _478;
        }
    }
    float3 _648 = ((_478.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_391, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_475.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_285 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _650 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _285) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _651 = _650.x;
    float2 _661 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_651 * _651, exp2((-9.27999973297119140625) * fast::clamp(dot(_262, _254), 0.0, 1.0))) * _651) + _650.y)) + _650.zw;
    float3 _797;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _697 = _252 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _733 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_252, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_697, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_697, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _262) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_285 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _791;
        if (_733 > 0.0)
        {
            float4 _762 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_252 + (reflect(reflect(normalize(_252 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _262).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _769;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _769 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _769 = 0u;
            }
            float4 _786 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_762.xy / float2(_762.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_769].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_769].zw), level(0.0));
            float4 _790 = float4(_786.x, _786.y, _786.z, float4(0.0).w);
            _790.w = _733 * _786.w;
            _791 = _790;
        }
        else
        {
            _791 = float4(0.0);
        }
        _797 = _791.xyz + (_648 * (1.0 - _791.w));
    }
    else
    {
        _797 = _648;
    }
    bool _815 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _864;
    if (_815)
    {
        float4 _822 = View.View_WorldToClip * float4(_252, 1.0);
        float _823 = _822.w;
        float4 _852;
        if (_815)
        {
            _852 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_822.xy / float2(_823)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_823 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _852 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _864 = float4(_852.xyz + (in.in_var_TEXCOORD7.xyz * _852.w), _852.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _864 = in.in_var_TEXCOORD7;
    }
    float3 _872 = (_252 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _880 = (_252 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _885 = fast::clamp((float3(0.5) - abs(_872 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _890 = (_885.x * _885.y) * _885.z;
    float4 _899 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _880, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _872, level(0.0)), float4(_890));
    float3 _910 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _880, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _872, level(0.0)).xyz, float3(_890)) * 1.0;
    float4 _912 = _192;
    _912.x = _899.x;
    float4 _914 = _192;
    _914.x = _899.y;
    float4 _916 = _192;
    _916.x = _899.z;
    float3 _917 = _899.xyz;
    float3 _921 = _917 / float3(dot(_917, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _923 = _910 * _921.x;
    float3 _926 = _910 * _921.y;
    float3 _929 = _910 * _921.z;
    float4 _933 = _192;
    _933.y = (-0.48860299587249755859375) * _262.y;
    float4 _936 = _933;
    _936.z = 0.48860299587249755859375 * _262.z;
    float4 _939 = _936;
    _939.w = (-0.48860299587249755859375) * _262.x;
    float4 _940 = _939;
    _940.x = 0.886227548122406005859375;
    float3 _942 = _940.yzw * 2.094395160675048828125;
    float4 _943 = float4(_940.x, _942.x, _942.y, _942.z);
    float3 _945 = _194;
    _945.x = dot(float4(_912.x, _923.x, _923.y, _923.z), _943);
    float3 _947 = _945;
    _947.y = dot(float4(_914.x, _926.x, _926.y, _926.z), _943);
    float3 _949 = _947;
    _949.z = dot(float4(_916.x, _929.x, _929.y, _929.z), _943);
    float _951 = _899.w;
    float3 _956 = float4(fast::max(float3(0.0), _949), _951).xyz;
    float3 _1022;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _970 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_252, 1.0);
        float2 _974 = _970.xy / float2(_970.w);
        float _975 = _970.z;
        float4 _978 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _974, level(0.0));
        float3 _982 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _975;
        bool2 _1007 = _974 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1009 = _974 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1022 = _310 * fast::max(_956 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _951) * (float3(1.0) - select(fast::clamp(exp((float3((((_978.x * _975) * 0.5) + dot((sin(_982) * _978.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_982)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _974, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1007.x || _1009.x, _1007.y || _1009.y)))))), float3(0.0));
    }
    else
    {
        _1022 = _310 * _956;
    }
    float3 _1030 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1061;
    float3 _1062;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1036 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1049 = any(abs(_252 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1036 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1036 + 19u)].xyz + float3(1.0)));
        float3 _1059;
        if (_1049)
        {
            _1059 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_252, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1059 = _1030;
        }
        _1061 = _1049 ? 1.0 : _286;
        _1062 = _1059;
    }
    else
    {
        _1061 = _286;
        _1062 = _1030;
    }
    float4 _1072 = float4((((mix((((_797 * ((_312 * _661.x) + float3(fast::clamp(50.0 * _312.y, 0.0, 1.0) * _661.y))) * 1.0) * fast::max(float3(1.0), ((((((_312 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_312 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_312 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1022, _310 + (_312 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_391 * _310) * fast::max(float3(1.0), ((((((_279 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_279 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_279 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1062) * _864.w) + _864.xyz, _1061);
    float3 _1076 = _1072.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1076.x, _1076.y, _1076.z, _1072.w);
    return out;
}

