

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

fragment MainPS_out Main_00006ac0_42c9107e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
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
    float4 _361 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _356);
    float4 _363 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_356 + float2(0.0, 0.5)));
    uint _369 = in.in_var_LIGHTMAP_ID * 15u;
    uint _370 = _369 + 4u;
    uint _375 = _369 + 6u;
    float3 _380 = _361.xyz;
    float _398 = _282.y;
    float3 _408 = ((((_380 * _380) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _370)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _375)].xyz) * ((exp2(((_361.w + ((_363.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _370)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _375)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_363 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _369 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _369 + 7u)], float4(_398, _282.zx, 1.0))))) * View.View_IndirectLightingColorScale;
    uint2 _453 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _467 = (_282 * (2.0 * dot(_257, _282))) - _257;
    uint _472 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _453.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _453.x)) * 2u;
    float2 _491;
    float4 _494;
    _491 = float2(0.0, 1.0);
    _494 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _492;
    float4 _495;
    for (uint _496 = 0u; _496 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_472)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _491 = _492, _494 = _495, _496++)
    {
        if (_494.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _507 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_472 + 1u))).x + _496)));
        uint _508 = _507.x;
        float3 _514 = _255 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_508].xyz;
        float _515 = dot(_514, _514);
        float _516 = sqrt(_515);
        if (_516 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_508].w)
        {
            float _607;
            float3 _608;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_508].z > 0.0)
            {
                float3 _564 = (ReflectionCapture.ReflectionCapture_BoxTransform[_508] * float4(_255, 1.0)).xyz;
                float3 _570 = (ReflectionCapture.ReflectionCapture_BoxTransform[_508] * float4(_467, 0.0)).xyz;
                float3 _571 = float3(1.0) / _570;
                float3 _573 = _564 * _571;
                float3 _576 = fast::max((float3(-1.0) / _570) - _573, _571 - _573);
                float3 _590 = ReflectionCapture.ReflectionCapture_BoxScales[_508].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_508].w);
                float3 _591 = -_590;
                float3 _592 = _564 * ReflectionCapture.ReflectionCapture_BoxScales[_508].xyz;
                _607 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_508].w, dot(select(float3(0.0), abs(_592 - _591), _592 < _591), float3(1.0)) + dot(select(float3(0.0), abs(_592 - _590), _592 > _590), float3(1.0)));
                _608 = (_255 + (_467 * fast::min(_576.x, fast::min(_576.y, _576.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_508].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_508].xyz);
            }
            else
            {
                float _532 = dot(_467, _514);
                float _535 = (_532 * _532) - (_515 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_508].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_508].w));
                float _552;
                float3 _553;
                if (_535 >= 0.0)
                {
                    float _546 = fast::clamp((2.5 * fast::clamp(_516 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_508].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _552 = 1.0 - ((_546 * _546) * (3.0 - (2.0 * _546)));
                    _553 = (_514 + (_467 * (sqrt(_535) - _532))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_508].xyz;
                }
                else
                {
                    _552 = 0.0;
                    _553 = _467;
                }
                _607 = _552;
                _608 = _553;
            }
            float4 _615 = float4(_608, ReflectionCapture.ReflectionCapture_CaptureProperties[_508].y);
            float4 _617 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _615.xyz, uint(round(_615.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_324, 0.001000000047497451305389404296875))))));
            float3 _620 = _617.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_508].x;
            float4 _622 = float4(_620.x, _620.y, _620.z, _617.w) * _607;
            float3 _627 = _494.xyz + ((_622.xyz * _494.w) * 1.0);
            float4 _632 = float4(_627.x, _627.y, _627.z, _494.w);
            _632.w = _494.w * (1.0 - _622.w);
            float2 _639 = _191;
            _639.x = _491.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_508].w * _607) * _491.y);
            float2 _642 = _639;
            _642.y = _491.y * (1.0 - _607);
            _492 = _642;
            _495 = _632;
        }
        else
        {
            _492 = _491;
            _495 = _494;
        }
    }
    float3 _664 = ((_494.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(dot(_408, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_491.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)), 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_324 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _666 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _324) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _667 = _666.x;
    float2 _677 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_667 * _667, exp2((-9.27999973297119140625) * fast::clamp(_299, 0.0, 1.0))) * _667) + _666.y)) + _666.zw;
    float3 _813;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _713 = _255 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _749 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_255, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_713, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_713, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _282) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_324 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _807;
        if (_749 > 0.0)
        {
            float4 _778 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_255 + (reflect(reflect(normalize(_255 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _282).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _785;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _785 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _785 = 0u;
            }
            float4 _802 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_778.xy / float2(_778.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_785].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_785].zw), level(0.0));
            float4 _806 = float4(_802.x, _802.y, _802.z, float4(0.0).w);
            _806.w = _749 * _802.w;
            _807 = _806;
        }
        else
        {
            _807 = float4(0.0);
        }
        _813 = _807.xyz + (_664 * (1.0 - _807.w));
    }
    else
    {
        _813 = _664;
    }
    bool _831 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _880;
    if (_831)
    {
        float4 _838 = View.View_WorldToClip * float4(_255, 1.0);
        float _839 = _838.w;
        float4 _868;
        if (_831)
        {
            _868 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_838.xy / float2(_839)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_839 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _868 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _880 = float4(_868.xyz + (in.in_var_TEXCOORD7.xyz * _868.w), _868.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _880 = in.in_var_TEXCOORD7;
    }
    float3 _888 = (_255 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _896 = (_255 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _901 = fast::clamp((float3(0.5) - abs(_888 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _906 = (_901.x * _901.y) * _901.z;
    float4 _915 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _896, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _888, level(0.0)), float4(_906));
    float3 _926 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _896, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _888, level(0.0)).xyz, float3(_906)) * 1.0;
    float4 _928 = _192;
    _928.x = _915.x;
    float4 _930 = _192;
    _930.x = _915.y;
    float4 _932 = _192;
    _932.x = _915.z;
    float3 _933 = _915.xyz;
    float3 _937 = _933 / float3(dot(_933, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _939 = _926 * _937.x;
    float3 _942 = _926 * _937.y;
    float3 _945 = _926 * _937.z;
    float4 _948 = _192;
    _948.y = (-0.48860299587249755859375) * _398;
    float4 _950 = _948;
    _950.z = 0.48860299587249755859375 * _282.z;
    float4 _952 = _950;
    _952.w = (-0.48860299587249755859375) * _282.x;
    float4 _953 = _952;
    _953.x = 0.886227548122406005859375;
    float3 _955 = _953.yzw * 2.094395160675048828125;
    float4 _956 = float4(_953.x, _955.x, _955.y, _955.z);
    float3 _958 = _193;
    _958.x = dot(float4(_928.x, _939.x, _939.y, _939.z), _956);
    float3 _960 = _958;
    _960.y = dot(float4(_930.x, _942.x, _942.y, _942.z), _956);
    float3 _962 = _960;
    _962.z = dot(float4(_932.x, _945.x, _945.y, _945.z), _956);
    float3 _977 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1008;
    float3 _1009;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _983 = in.in_var_PRIMITIVE_ID * 36u;
        bool _996 = any(abs(_255 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _983 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _983 + 19u)].xyz + float3(1.0)));
        float3 _1006;
        if (_996)
        {
            _1006 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_255, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1006 = _977;
        }
        _1008 = _996 ? 1.0 : _325;
        _1009 = _1006;
    }
    else
    {
        _1008 = _325;
        _1009 = _977;
    }
    float4 _1019 = float4((((mix((((_813 * ((_354 * _677.x) + float3(fast::clamp(50.0 * _354.y, 0.0, 1.0) * _677.y))) * 1.0) * fast::max(float3(1.0), ((((((_354 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_354 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_354 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_352 * float4(fast::max(float3(0.0), _962), _189).xyz), _352 + (_354 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_408 * _352) * fast::max(float3(1.0), ((((((_318 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_318 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_318 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1009) * _880.w) + _880.xyz, _1008);
    float3 _1023 = _1019.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1023.x, _1023.y, _1023.z, _1019.w);
    return out;
}

