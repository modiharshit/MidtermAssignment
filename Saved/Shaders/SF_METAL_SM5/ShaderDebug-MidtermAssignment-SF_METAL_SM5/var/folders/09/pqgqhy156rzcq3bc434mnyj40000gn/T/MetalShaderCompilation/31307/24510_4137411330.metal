

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

constant float _176 = {};
constant float4 _178 = {};
constant float3 _179 = {};

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

fragment MainPS_out Main_00005fbe_f69be302(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = _236.xyz / float3(_236.w);
    float3 _241 = _240 - View.View_PreViewTranslation;
    float3 _243 = normalize(-_240);
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float3 _268 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _285 = dot(_268, _243);
    float _289 = fast::max(abs(1.0 - fast::max(0.0, _285)), 9.9999997473787516355514526367188e-05);
    float3 _304 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _279.x, float3(0.0), float3(1.0));
    float _310 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _311 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_289 <= 0.0) ? 0.0 : pow(_289, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _323 = ((_304 - (_304 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _330 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _304, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _333 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _338;
    if (_333)
    {
        _338 = _323 + (_330 * 0.449999988079071044921875);
    }
    else
    {
        _338 = _323;
    }
    float3 _340 = select(_330, float3(0.0), bool3(_333));
    uint2 _370 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _384 = (_268 * (2.0 * dot(_243, _268))) - _243;
    uint _389 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _370.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _370.x)) * 2u;
    float4 _408;
    _408 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _409;
    for (uint _411 = 0u; _411 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_389)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _408 = _409, _411++)
    {
        if (_408.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _422 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_389 + 1u))).x + _411)));
        uint _423 = _422.x;
        float3 _429 = _241 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_423].xyz;
        float _430 = dot(_429, _429);
        float _431 = sqrt(_430);
        if (_431 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_423].w)
        {
            float _522;
            float3 _523;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_423].z > 0.0)
            {
                float3 _479 = (ReflectionCapture.ReflectionCapture_BoxTransform[_423] * float4(_241, 1.0)).xyz;
                float3 _485 = (ReflectionCapture.ReflectionCapture_BoxTransform[_423] * float4(_384, 0.0)).xyz;
                float3 _486 = float3(1.0) / _485;
                float3 _488 = _479 * _486;
                float3 _491 = fast::max((float3(-1.0) / _485) - _488, _486 - _488);
                float3 _505 = ReflectionCapture.ReflectionCapture_BoxScales[_423].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_423].w);
                float3 _506 = -_505;
                float3 _507 = _479 * ReflectionCapture.ReflectionCapture_BoxScales[_423].xyz;
                _522 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_423].w, dot(select(float3(0.0), abs(_507 - _506), _507 < _506), float3(1.0)) + dot(select(float3(0.0), abs(_507 - _505), _507 > _505), float3(1.0)));
                _523 = (_241 + (_384 * fast::min(_491.x, fast::min(_491.y, _491.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_423].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_423].xyz);
            }
            else
            {
                float _447 = dot(_384, _429);
                float _450 = (_447 * _447) - (_430 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_423].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_423].w));
                float _467;
                float3 _468;
                if (_450 >= 0.0)
                {
                    float _461 = fast::clamp((2.5 * fast::clamp(_431 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_423].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _467 = 1.0 - ((_461 * _461) * (3.0 - (2.0 * _461)));
                    _468 = (_429 + (_384 * (sqrt(_450) - _447))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_423].xyz;
                }
                else
                {
                    _467 = 0.0;
                    _468 = _384;
                }
                _522 = _467;
                _523 = _468;
            }
            float4 _530 = float4(_523, ReflectionCapture.ReflectionCapture_CaptureProperties[_423].y);
            float4 _532 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _530.xyz, uint(round(_530.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_310, 0.001000000047497451305389404296875))))));
            float3 _535 = _532.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_423].x;
            float4 _537 = float4(_535.x, _535.y, _535.z, _532.w) * _522;
            float3 _542 = _408.xyz + ((_537.xyz * _408.w) * 1.0);
            float4 _547 = float4(_542.x, _542.y, _542.z, _408.w);
            _547.w = _408.w * (1.0 - _537.w);
            _409 = _547;
        }
        else
        {
            _409 = _408;
        }
    }
    float3 _566 = ((_408.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_310 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _568 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _310) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _569 = _568.x;
    float2 _579 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_569 * _569, exp2((-9.27999973297119140625) * fast::clamp(_285, 0.0, 1.0))) * _569) + _568.y)) + _568.zw;
    float3 _715;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _615 = _241 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _651 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_241, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_615, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_615, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _268) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_310 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _709;
        if (_651 > 0.0)
        {
            float4 _680 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_241 + (reflect(reflect(normalize(_241 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _268).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _687;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _687 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _687 = 0u;
            }
            float4 _704 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_680.xy / float2(_680.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_687].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_687].zw), level(0.0));
            float4 _708 = float4(_704.x, _704.y, _704.z, float4(0.0).w);
            _708.w = _651 * _704.w;
            _709 = _708;
        }
        else
        {
            _709 = float4(0.0);
        }
        _715 = _709.xyz + (_566 * (1.0 - _709.w));
    }
    else
    {
        _715 = _566;
    }
    bool _733 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _782;
    if (_733)
    {
        float4 _740 = View.View_WorldToClip * float4(_241, 1.0);
        float _741 = _740.w;
        float4 _770;
        if (_733)
        {
            _770 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_740.xy / float2(_741)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_741 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _770 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _782 = float4(_770.xyz + (in.in_var_TEXCOORD7.xyz * _770.w), _770.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _782 = in.in_var_TEXCOORD7;
    }
    float3 _790 = (_241 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _798 = (_241 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _803 = fast::clamp((float3(0.5) - abs(_790 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _808 = (_803.x * _803.y) * _803.z;
    float4 _817 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _798, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _790, level(0.0)), float4(_808));
    float3 _828 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _798, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _790, level(0.0)).xyz, float3(_808)) * 1.0;
    float4 _830 = _178;
    _830.x = _817.x;
    float4 _832 = _178;
    _832.x = _817.y;
    float4 _834 = _178;
    _834.x = _817.z;
    float3 _835 = _817.xyz;
    float3 _839 = _835 / float3(dot(_835, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _841 = _828 * _839.x;
    float3 _844 = _828 * _839.y;
    float3 _847 = _828 * _839.z;
    float4 _851 = _178;
    _851.y = (-0.48860299587249755859375) * _268.y;
    float4 _854 = _851;
    _854.z = 0.48860299587249755859375 * _268.z;
    float4 _857 = _854;
    _857.w = (-0.48860299587249755859375) * _268.x;
    float4 _858 = _857;
    _858.x = 0.886227548122406005859375;
    float3 _860 = _858.yzw * 2.094395160675048828125;
    float4 _861 = float4(_858.x, _860.x, _860.y, _860.z);
    float3 _863 = _179;
    _863.x = dot(float4(_830.x, _841.x, _841.y, _841.z), _861);
    float3 _865 = _863;
    _865.y = dot(float4(_832.x, _844.x, _844.y, _844.z), _861);
    float3 _867 = _865;
    _867.z = dot(float4(_834.x, _847.x, _847.y, _847.z), _861);
    float3 _882 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _913;
    float3 _914;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _888 = in.in_var_PRIMITIVE_ID * 36u;
        bool _901 = any(abs(_241 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _888 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _888 + 19u)].xyz + float3(1.0)));
        float3 _911;
        if (_901)
        {
            _911 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _911 = _882;
        }
        _913 = _901 ? 1.0 : _311;
        _914 = _911;
    }
    else
    {
        _913 = _311;
        _914 = _882;
    }
    float4 _923 = float4(((mix((((_715 * ((_340 * _579.x) + float3(fast::clamp(50.0 * _340.y, 0.0, 1.0) * _579.y))) * 1.0) * fast::max(float3(1.0), ((((((_340 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_340 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_340 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_338 * float4(fast::max(float3(0.0), _867), _176).xyz), _338 + (_340 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _914) * _782.w) + _782.xyz, _913);
    float3 _927 = _923.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_927.x, _927.y, _927.z, _923.w);
    return out;
}

