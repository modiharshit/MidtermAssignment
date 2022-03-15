

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
    char _m19_pad[48];
    float4 View_SkyLightColor;
    char _m20_pad[120];
    float View_ReflectionCubemapMaxMip;
    char _m21_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m23_pad[160];
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
    char _m5_pad[1216];
    float4 TranslucentBasePass_Shared_Reflection_SkyLightParameters;
    char _m6_pad[80];
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
    char _m17_pad[144];
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

constant float _185 = {};
constant float3 _187 = {};
constant float4 _188 = {};

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

fragment MainPS_out Main_00006cb0_3780e46f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _246 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _250 = _246.xyz / float3(_246.w);
    float3 _251 = _250 - View.View_PreViewTranslation;
    float3 _253 = normalize(-_250);
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _262 = (_259.xy * float2(2.0)) - float2(1.0);
    float3 _278 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_262, sqrt(fast::clamp(1.0 - dot(_262, _262), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _289 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _295 = dot(_278, _253);
    float _299 = fast::max(abs(1.0 - fast::max(0.0, _295)), 9.9999997473787516355514526367188e-05);
    float3 _314 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _289.x, float3(0.0), float3(1.0));
    float _320 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _321 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_299 <= 0.0) ? 0.0 : pow(_299, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _333 = ((_314 - (_314 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _340 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _314, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _343 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _348;
    if (_343)
    {
        _348 = _333 + (_340 * 0.449999988079071044921875);
    }
    else
    {
        _348 = _333;
    }
    float3 _350 = select(_340, float3(0.0), bool3(_343));
    float _351 = _278.x;
    float _352 = _278.y;
    float4 _354 = float4(_351, _352, _278.z, 1.0);
    float3 _358 = _187;
    _358.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _354);
    float3 _362 = _358;
    _362.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _354);
    float3 _366 = _362;
    _366.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _354);
    float4 _369 = _354.xyzz * _354.yzzx;
    float3 _373 = _187;
    _373.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _369);
    float3 _377 = _373;
    _377.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _369);
    float3 _381 = _377;
    _381.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _369);
    uint2 _438 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _452 = (_278 * (2.0 * dot(_253, _278))) - _253;
    uint _457 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _438.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _438.x)) * 2u;
    float _472 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_320, 0.001000000047497451305389404296875)));
    float4 _476;
    _476 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _477;
    for (uint _479 = 0u; _479 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_457)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _476 = _477, _479++)
    {
        if (_476.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _490 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_457 + 1u))).x + _479)));
        uint _491 = _490.x;
        float3 _497 = _251 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_491].xyz;
        float _498 = dot(_497, _497);
        float _499 = sqrt(_498);
        if (_499 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_491].w)
        {
            float _590;
            float3 _591;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_491].z > 0.0)
            {
                float3 _547 = (ReflectionCapture.ReflectionCapture_BoxTransform[_491] * float4(_251, 1.0)).xyz;
                float3 _553 = (ReflectionCapture.ReflectionCapture_BoxTransform[_491] * float4(_452, 0.0)).xyz;
                float3 _554 = float3(1.0) / _553;
                float3 _556 = _547 * _554;
                float3 _559 = fast::max((float3(-1.0) / _553) - _556, _554 - _556);
                float3 _573 = ReflectionCapture.ReflectionCapture_BoxScales[_491].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_491].w);
                float3 _574 = -_573;
                float3 _575 = _547 * ReflectionCapture.ReflectionCapture_BoxScales[_491].xyz;
                _590 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_491].w, dot(select(float3(0.0), abs(_575 - _574), _575 < _574), float3(1.0)) + dot(select(float3(0.0), abs(_575 - _573), _575 > _573), float3(1.0)));
                _591 = (_251 + (_452 * fast::min(_559.x, fast::min(_559.y, _559.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_491].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_491].xyz);
            }
            else
            {
                float _515 = dot(_452, _497);
                float _518 = (_515 * _515) - (_498 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_491].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_491].w));
                float _535;
                float3 _536;
                if (_518 >= 0.0)
                {
                    float _529 = fast::clamp((2.5 * fast::clamp(_499 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_491].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _535 = 1.0 - ((_529 * _529) * (3.0 - (2.0 * _529)));
                    _536 = (_497 + (_452 * (sqrt(_518) - _515))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_491].xyz;
                }
                else
                {
                    _535 = 0.0;
                    _536 = _452;
                }
                _590 = _535;
                _591 = _536;
            }
            float4 _598 = float4(_591, ReflectionCapture.ReflectionCapture_CaptureProperties[_491].y);
            float4 _600 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _598.xyz, uint(round(_598.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _472));
            float3 _603 = _600.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_491].x;
            float4 _605 = float4(_603.x, _603.y, _603.z, _600.w) * _590;
            float3 _610 = _476.xyz + ((_605.xyz * _476.w) * 1.0);
            float4 _615 = float4(_610.x, _610.y, _610.z, _476.w);
            _615.w = _476.w * (1.0 - _605.w);
            _477 = _615;
        }
        else
        {
            _477 = _476;
        }
    }
    float3 _619 = _476.xyz * View.View_IndirectLightingColorScale;
    float4 _620 = float4(_619.x, _619.y, _619.z, _476.w);
    float4 _653;
    float3 _654;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _636 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _452, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _472)).xyz * View.View_SkyLightColor.xyz;
        float4 _651;
        float3 _652;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _649 = _619.xyz + ((_636 * _476.w) * 1.0);
            _651 = float4(_649.x, _649.y, _649.z, _476.w);
            _652 = float3(0.0);
        }
        else
        {
            _651 = _620;
            _652 = _636 * 1.0;
        }
        _653 = _651;
        _654 = _652;
    }
    else
    {
        _653 = _620;
        _654 = float3(0.0);
    }
    float3 _673 = ((_653.xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_320 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_654 * _653.w)).xyz;
    float4 _675 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _320) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _676 = _675.x;
    float2 _686 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_676 * _676, exp2((-9.27999973297119140625) * fast::clamp(_295, 0.0, 1.0))) * _676) + _675.y)) + _675.zw;
    float3 _822;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _722 = _251 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _758 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_251, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_722, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_722, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _278) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_320 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _816;
        if (_758 > 0.0)
        {
            float4 _787 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_251 + (reflect(reflect(normalize(_251 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _278).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _794;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _794 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _794 = 0u;
            }
            float4 _811 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_787.xy / float2(_787.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_794].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_794].zw), level(0.0));
            float4 _815 = float4(_811.x, _811.y, _811.z, float4(0.0).w);
            _815.w = _758 * _811.w;
            _816 = _815;
        }
        else
        {
            _816 = float4(0.0);
        }
        _822 = _816.xyz + (_673 * (1.0 - _816.w));
    }
    else
    {
        _822 = _673;
    }
    bool _840 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _889;
    if (_840)
    {
        float4 _847 = View.View_WorldToClip * float4(_251, 1.0);
        float _848 = _847.w;
        float4 _877;
        if (_840)
        {
            _877 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_847.xy / float2(_848)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_848 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _877 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _889 = float4(_877.xyz + (in.in_var_TEXCOORD7.xyz * _877.w), _877.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _889 = in.in_var_TEXCOORD7;
    }
    float3 _897 = (_251 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _905 = (_251 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _910 = fast::clamp((float3(0.5) - abs(_897 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _915 = (_910.x * _910.y) * _910.z;
    float4 _924 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _905, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _897, level(0.0)), float4(_915));
    float3 _935 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _905, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _897, level(0.0)).xyz, float3(_915)) * 1.0;
    float4 _937 = _188;
    _937.x = _924.x;
    float4 _939 = _188;
    _939.x = _924.y;
    float4 _941 = _188;
    _941.x = _924.z;
    float3 _942 = _924.xyz;
    float3 _946 = _942 / float3(dot(_942, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _948 = _935 * _946.x;
    float3 _951 = _935 * _946.y;
    float3 _954 = _935 * _946.z;
    float4 _957 = _188;
    _957.y = (-0.48860299587249755859375) * _352;
    float4 _959 = _957;
    _959.z = 0.48860299587249755859375 * _278.z;
    float4 _961 = _959;
    _961.w = (-0.48860299587249755859375) * _351;
    float4 _962 = _961;
    _962.x = 0.886227548122406005859375;
    float3 _964 = _962.yzw * 2.094395160675048828125;
    float4 _965 = float4(_962.x, _964.x, _964.y, _964.z);
    float3 _967 = _187;
    _967.x = dot(float4(_937.x, _948.x, _948.y, _948.z), _965);
    float3 _969 = _967;
    _969.y = dot(float4(_939.x, _951.x, _951.y, _951.z), _965);
    float3 _971 = _969;
    _971.z = dot(float4(_941.x, _954.x, _954.y, _954.z), _965);
    float3 _986 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1017;
    float3 _1018;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _992 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1005 = any(abs(_251 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _992 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _992 + 19u)].xyz + float3(1.0)));
        float3 _1015;
        if (_1005)
        {
            _1015 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_251, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1015 = _986;
        }
        _1017 = _1005 ? 1.0 : _321;
        _1018 = _1015;
    }
    else
    {
        _1017 = _321;
        _1018 = _986;
    }
    float4 _1028 = float4((((mix((((_822 * ((_350 * _686.x) + float3(fast::clamp(50.0 * _350.y, 0.0, 1.0) * _686.y))) * 1.0) * fast::max(float3(1.0), ((((((_350 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_350 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_350 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_348 * float4(fast::max(float3(0.0), _971), _185).xyz), _348 + (_350 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_366 + _381) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_351 * _351) - (_352 * _352)))) * View.View_SkyLightColor.xyz) * 1.0) * _348) * fast::max(float3(1.0), ((((((_314 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_314 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_314 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1018) * _889.w) + _889.xyz, _1017);
    float3 _1032 = _1028.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1032.x, _1032.y, _1032.z, _1028.w);
    return out;
}

