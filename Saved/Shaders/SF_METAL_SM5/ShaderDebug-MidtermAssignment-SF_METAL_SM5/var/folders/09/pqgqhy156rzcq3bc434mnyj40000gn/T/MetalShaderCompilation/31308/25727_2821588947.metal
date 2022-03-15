

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

constant float _175 = {};
constant float2 _177 = {};
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
    float4 in_var_TEXCOORD4 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    uint in_var_LIGHTMAP_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000647f_a82e07d3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = _232.xyz / float3(_232.w);
    float3 _237 = _236 - View.View_PreViewTranslation;
    float3 _239 = normalize(-_236);
    float3 _247 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _264 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _270 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _271 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _280 = (_264 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _287 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _290 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _295;
    if (_290)
    {
        _295 = _280 + (_287 * 0.449999988079071044921875);
    }
    else
    {
        _295 = _280;
    }
    float3 _297 = select(_287, float3(0.0), bool3(_290));
    float2 _299 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    uint _308 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _318 = (LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _299).xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _308 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _308 + 6u)].xyz;
    float _319 = dot(_318, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _332 = _247.y;
    float _338 = (exp2((_319 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_299 + float2(0.0, 0.5))) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _308 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _308 + 7u)], float4(_332, _247.zx, 1.0)));
    float3 _348 = float4(_318 * (_338 / _319), _338).xyz * View.View_IndirectLightingColorScale;
    uint2 _393 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _407 = (_247 * (2.0 * dot(_239, _247))) - _239;
    uint _413 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _393.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _393.x)) * 2u;
    float2 _432;
    float4 _435;
    _432 = float2(0.0, 1.0);
    _435 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _433;
    float4 _436;
    for (uint _437 = 0u; _437 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_413)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _432 = _433, _435 = _436, _437++)
    {
        if (_435.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _448 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_413 + 1u))).x + _437)));
        uint _449 = _448.x;
        float3 _455 = _237 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_449].xyz;
        float _456 = dot(_455, _455);
        float _457 = sqrt(_456);
        if (_457 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_449].w)
        {
            float _548;
            float3 _549;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_449].z > 0.0)
            {
                float3 _505 = (ReflectionCapture.ReflectionCapture_BoxTransform[_449] * float4(_237, 1.0)).xyz;
                float3 _511 = (ReflectionCapture.ReflectionCapture_BoxTransform[_449] * float4(_407, 0.0)).xyz;
                float3 _512 = float3(1.0) / _511;
                float3 _514 = _505 * _512;
                float3 _517 = fast::max((float3(-1.0) / _511) - _514, _512 - _514);
                float3 _531 = ReflectionCapture.ReflectionCapture_BoxScales[_449].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_449].w);
                float3 _532 = -_531;
                float3 _533 = _505 * ReflectionCapture.ReflectionCapture_BoxScales[_449].xyz;
                _548 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_449].w, dot(select(float3(0.0), abs(_533 - _532), _533 < _532), float3(1.0)) + dot(select(float3(0.0), abs(_533 - _531), _533 > _531), float3(1.0)));
                _549 = (_237 + (_407 * fast::min(_517.x, fast::min(_517.y, _517.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_449].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_449].xyz);
            }
            else
            {
                float _473 = dot(_407, _455);
                float _476 = (_473 * _473) - (_456 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_449].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_449].w));
                float _493;
                float3 _494;
                if (_476 >= 0.0)
                {
                    float _487 = fast::clamp((2.5 * fast::clamp(_457 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_449].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _493 = 1.0 - ((_487 * _487) * (3.0 - (2.0 * _487)));
                    _494 = (_455 + (_407 * (sqrt(_476) - _473))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_449].xyz;
                }
                else
                {
                    _493 = 0.0;
                    _494 = _407;
                }
                _548 = _493;
                _549 = _494;
            }
            float4 _556 = float4(_549, ReflectionCapture.ReflectionCapture_CaptureProperties[_449].y);
            float4 _558 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _556.xyz, uint(round(_556.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_270, 0.001000000047497451305389404296875))))));
            float3 _561 = _558.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_449].x;
            float4 _563 = float4(_561.x, _561.y, _561.z, _558.w) * _548;
            float3 _568 = _435.xyz + ((_563.xyz * _435.w) * 1.0);
            float4 _573 = float4(_568.x, _568.y, _568.z, _435.w);
            _573.w = _435.w * (1.0 - _563.w);
            float2 _580 = _177;
            _580.x = _432.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_449].w * _548) * _432.y);
            float2 _583 = _580;
            _583.y = _432.y * (1.0 - _548);
            _433 = _583;
            _436 = _573;
        }
        else
        {
            _433 = _432;
            _436 = _435;
        }
    }
    float3 _605 = ((_435.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_348, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_432.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_270 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _607 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _270) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _608 = _607.x;
    float2 _618 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_608 * _608, exp2((-9.27999973297119140625) * fast::clamp(dot(_247, _239), 0.0, 1.0))) * _608) + _607.y)) + _607.zw;
    float3 _754;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _654 = _237 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _690 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_237, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_654, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_654, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _247) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_270 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _748;
        if (_690 > 0.0)
        {
            float4 _719 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_237 + (reflect(reflect(normalize(_237 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _247).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _726;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _726 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _726 = 0u;
            }
            float4 _743 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_719.xy / float2(_719.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_726].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_726].zw), level(0.0));
            float4 _747 = float4(_743.x, _743.y, _743.z, float4(0.0).w);
            _747.w = _690 * _743.w;
            _748 = _747;
        }
        else
        {
            _748 = float4(0.0);
        }
        _754 = _748.xyz + (_605 * (1.0 - _748.w));
    }
    else
    {
        _754 = _605;
    }
    bool _772 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _821;
    if (_772)
    {
        float4 _779 = View.View_WorldToClip * float4(_237, 1.0);
        float _780 = _779.w;
        float4 _809;
        if (_772)
        {
            _809 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_779.xy / float2(_780)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_780 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _809 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _821 = float4(_809.xyz + (in.in_var_TEXCOORD7.xyz * _809.w), _809.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _821 = in.in_var_TEXCOORD7;
    }
    float3 _829 = (_237 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _837 = (_237 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _842 = fast::clamp((float3(0.5) - abs(_829 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _847 = (_842.x * _842.y) * _842.z;
    float4 _856 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _837, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _829, level(0.0)), float4(_847));
    float3 _867 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _837, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _829, level(0.0)).xyz, float3(_847)) * 1.0;
    float4 _869 = _178;
    _869.x = _856.x;
    float4 _871 = _178;
    _871.x = _856.y;
    float4 _873 = _178;
    _873.x = _856.z;
    float3 _874 = _856.xyz;
    float3 _878 = _874 / float3(dot(_874, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _880 = _867 * _878.x;
    float3 _883 = _867 * _878.y;
    float3 _886 = _867 * _878.z;
    float4 _889 = _178;
    _889.y = (-0.48860299587249755859375) * _332;
    float4 _891 = _889;
    _891.z = 0.48860299587249755859375 * _247.z;
    float4 _893 = _891;
    _893.w = (-0.48860299587249755859375) * _247.x;
    float4 _894 = _893;
    _894.x = 0.886227548122406005859375;
    float3 _896 = _894.yzw * 2.094395160675048828125;
    float4 _897 = float4(_894.x, _896.x, _896.y, _896.z);
    float3 _899 = _179;
    _899.x = dot(float4(_869.x, _880.x, _880.y, _880.z), _897);
    float3 _901 = _899;
    _901.y = dot(float4(_871.x, _883.x, _883.y, _883.z), _897);
    float3 _903 = _901;
    _903.z = dot(float4(_873.x, _886.x, _886.y, _886.z), _897);
    float3 _918 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _949;
    float3 _950;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _924 = in.in_var_PRIMITIVE_ID * 36u;
        bool _937 = any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _924 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _924 + 19u)].xyz + float3(1.0)));
        float3 _947;
        if (_937)
        {
            _947 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _947 = _918;
        }
        _949 = _937 ? 1.0 : _271;
        _950 = _947;
    }
    else
    {
        _949 = _271;
        _950 = _918;
    }
    float4 _960 = float4((((mix((((_754 * ((_297 * _618.x) + float3(fast::clamp(50.0 * _297.y, 0.0, 1.0) * _618.y))) * 1.0) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_295 * float4(fast::max(float3(0.0), _903), _175).xyz), _295 + (_297 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_348 * _295) * fast::max(float3(1.0), ((((((_264 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_264 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_264 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _950) * _821.w) + _821.xyz, _949);
    float3 _964 = _960.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_964.x, _964.y, _964.z, _960.w);
    return out;
}

