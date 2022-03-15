

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

constant float _189 = {};
constant float2 _191 = {};
constant float4 _192 = {};
constant float3 _193 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000069e3_1885958d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    float4 _250 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _254 = _250.xyz / float3(_250.w);
    float3 _255 = _254 - View.View_PreViewTranslation;
    float3 _257 = normalize(-_254);
    float4 _263 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _266 = (_263.xy * float2(2.0)) - float2(1.0);
    float3 _282 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_266, sqrt(fast::clamp(1.0 - dot(_266, _266), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _293 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _299 = dot(_282, _257);
    float _303 = fast::max(abs(1.0 - fast::max(0.0, _299)), 9.9999997473787516355514526367188e-05);
    float3 _318 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _293.x, float3(0.0), float3(1.0));
    float _324 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _325 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_303 <= 0.0) ? 0.0 : pow(_303, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _337 = ((_318 - (_318 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _344 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _318, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _347 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _352;
    if (_347)
    {
        _352 = _337 + (_344 * 0.449999988079071044921875);
    }
    else
    {
        _352 = _337;
    }
    float3 _354 = select(_344, float3(0.0), bool3(_347));
    float2 _356 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    uint _365 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _375 = (LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _356).xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _365 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _365 + 6u)].xyz;
    float _376 = dot(_375, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _389 = _282.y;
    float _395 = (exp2((_376 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_356 + float2(0.0, 0.5))) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _365 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _365 + 7u)], float4(_389, _282.zx, 1.0)));
    float3 _405 = float4(_375 * (_395 / _376), _395).xyz * View.View_IndirectLightingColorScale;
    uint2 _450 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _464 = (_282 * (2.0 * dot(_257, _282))) - _257;
    uint _469 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _450.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _450.x)) * 2u;
    float2 _488;
    float4 _491;
    _488 = float2(0.0, 1.0);
    _491 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _489;
    float4 _492;
    for (uint _493 = 0u; _493 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_469)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _488 = _489, _491 = _492, _493++)
    {
        if (_491.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _504 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_469 + 1u))).x + _493)));
        uint _505 = _504.x;
        float3 _511 = _255 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_505].xyz;
        float _512 = dot(_511, _511);
        float _513 = sqrt(_512);
        if (_513 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_505].w)
        {
            float _604;
            float3 _605;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_505].z > 0.0)
            {
                float3 _561 = (ReflectionCapture.ReflectionCapture_BoxTransform[_505] * float4(_255, 1.0)).xyz;
                float3 _567 = (ReflectionCapture.ReflectionCapture_BoxTransform[_505] * float4(_464, 0.0)).xyz;
                float3 _568 = float3(1.0) / _567;
                float3 _570 = _561 * _568;
                float3 _573 = fast::max((float3(-1.0) / _567) - _570, _568 - _570);
                float3 _587 = ReflectionCapture.ReflectionCapture_BoxScales[_505].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_505].w);
                float3 _588 = -_587;
                float3 _589 = _561 * ReflectionCapture.ReflectionCapture_BoxScales[_505].xyz;
                _604 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_505].w, dot(select(float3(0.0), abs(_589 - _588), _589 < _588), float3(1.0)) + dot(select(float3(0.0), abs(_589 - _587), _589 > _587), float3(1.0)));
                _605 = (_255 + (_464 * fast::min(_573.x, fast::min(_573.y, _573.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_505].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_505].xyz);
            }
            else
            {
                float _529 = dot(_464, _511);
                float _532 = (_529 * _529) - (_512 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_505].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_505].w));
                float _549;
                float3 _550;
                if (_532 >= 0.0)
                {
                    float _543 = fast::clamp((2.5 * fast::clamp(_513 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_505].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _549 = 1.0 - ((_543 * _543) * (3.0 - (2.0 * _543)));
                    _550 = (_511 + (_464 * (sqrt(_532) - _529))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_505].xyz;
                }
                else
                {
                    _549 = 0.0;
                    _550 = _464;
                }
                _604 = _549;
                _605 = _550;
            }
            float4 _612 = float4(_605, ReflectionCapture.ReflectionCapture_CaptureProperties[_505].y);
            float4 _614 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _612.xyz, uint(round(_612.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_324, 0.001000000047497451305389404296875))))));
            float3 _617 = _614.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_505].x;
            float4 _619 = float4(_617.x, _617.y, _617.z, _614.w) * _604;
            float3 _624 = _491.xyz + ((_619.xyz * _491.w) * 1.0);
            float4 _629 = float4(_624.x, _624.y, _624.z, _491.w);
            _629.w = _491.w * (1.0 - _619.w);
            float2 _636 = _191;
            _636.x = _488.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_505].w * _604) * _488.y);
            float2 _639 = _636;
            _639.y = _488.y * (1.0 - _604);
            _489 = _639;
            _492 = _629;
        }
        else
        {
            _489 = _488;
            _492 = _491;
        }
    }
    float3 _661 = ((_491.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_405, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_488.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_324 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _663 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _324) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _664 = _663.x;
    float2 _674 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_664 * _664, exp2((-9.27999973297119140625) * fast::clamp(_299, 0.0, 1.0))) * _664) + _663.y)) + _663.zw;
    float3 _810;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _710 = _255 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _746 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_255, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_710, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_710, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _282) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_324 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _804;
        if (_746 > 0.0)
        {
            float4 _775 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_255 + (reflect(reflect(normalize(_255 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _282).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _782;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _782 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _782 = 0u;
            }
            float4 _799 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_775.xy / float2(_775.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_782].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_782].zw), level(0.0));
            float4 _803 = float4(_799.x, _799.y, _799.z, float4(0.0).w);
            _803.w = _746 * _799.w;
            _804 = _803;
        }
        else
        {
            _804 = float4(0.0);
        }
        _810 = _804.xyz + (_661 * (1.0 - _804.w));
    }
    else
    {
        _810 = _661;
    }
    bool _828 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _877;
    if (_828)
    {
        float4 _835 = View.View_WorldToClip * float4(_255, 1.0);
        float _836 = _835.w;
        float4 _865;
        if (_828)
        {
            _865 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_835.xy / float2(_836)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_836 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _865 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _877 = float4(_865.xyz + (in.in_var_TEXCOORD7.xyz * _865.w), _865.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _877 = in.in_var_TEXCOORD7;
    }
    float3 _885 = (_255 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _893 = (_255 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _898 = fast::clamp((float3(0.5) - abs(_885 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _903 = (_898.x * _898.y) * _898.z;
    float4 _912 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _893, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _885, level(0.0)), float4(_903));
    float3 _923 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _893, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _885, level(0.0)).xyz, float3(_903)) * 1.0;
    float4 _925 = _192;
    _925.x = _912.x;
    float4 _927 = _192;
    _927.x = _912.y;
    float4 _929 = _192;
    _929.x = _912.z;
    float3 _930 = _912.xyz;
    float3 _934 = _930 / float3(dot(_930, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _936 = _923 * _934.x;
    float3 _939 = _923 * _934.y;
    float3 _942 = _923 * _934.z;
    float4 _945 = _192;
    _945.y = (-0.48860299587249755859375) * _389;
    float4 _947 = _945;
    _947.z = 0.48860299587249755859375 * _282.z;
    float4 _949 = _947;
    _949.w = (-0.48860299587249755859375) * _282.x;
    float4 _950 = _949;
    _950.x = 0.886227548122406005859375;
    float3 _952 = _950.yzw * 2.094395160675048828125;
    float4 _953 = float4(_950.x, _952.x, _952.y, _952.z);
    float3 _955 = _193;
    _955.x = dot(float4(_925.x, _936.x, _936.y, _936.z), _953);
    float3 _957 = _955;
    _957.y = dot(float4(_927.x, _939.x, _939.y, _939.z), _953);
    float3 _959 = _957;
    _959.z = dot(float4(_929.x, _942.x, _942.y, _942.z), _953);
    float3 _974 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1005;
    float3 _1006;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _980 = in.in_var_PRIMITIVE_ID * 36u;
        bool _993 = any(abs(_255 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _980 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _980 + 19u)].xyz + float3(1.0)));
        float3 _1003;
        if (_993)
        {
            _1003 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_255, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1003 = _974;
        }
        _1005 = _993 ? 1.0 : _325;
        _1006 = _1003;
    }
    else
    {
        _1005 = _325;
        _1006 = _974;
    }
    float4 _1016 = float4((((mix((((_810 * ((_354 * _674.x) + float3(fast::clamp(50.0 * _354.y, 0.0, 1.0) * _674.y))) * 1.0) * fast::max(float3(1.0), ((((((_354 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_354 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_354 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_352 * float4(fast::max(float3(0.0), _959), _189).xyz), _352 + (_354 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_405 * _352) * fast::max(float3(1.0), ((((((_318 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_318 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_318 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1006) * _877.w) + _877.xyz, _1005);
    float3 _1020 = _1016.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1020.x, _1020.y, _1020.z, _1016.w);
    return out;
}

