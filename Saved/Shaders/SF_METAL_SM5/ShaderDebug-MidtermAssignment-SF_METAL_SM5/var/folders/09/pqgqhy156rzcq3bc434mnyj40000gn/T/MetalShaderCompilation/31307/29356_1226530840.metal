

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
    char _m18_pad[48];
    float4 View_SkyLightColor;
    char _m19_pad[120];
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

constant float _183 = {};
constant float3 _184 = {};
constant float2 _186 = {};
constant float4 _187 = {};
constant float3 _188 = {};

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

fragment MainPS_out Main_000072ac_491b6018(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[4];
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = _243.xyz / float3(_243.w);
    float3 _248 = _247 - View.View_PreViewTranslation;
    float3 _250 = normalize(-_247);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _275 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _281 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _282 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _291 = (_275 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _298 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _301 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _306;
    if (_301)
    {
        _306 = _291 + (_298 * 0.449999988079071044921875);
    }
    else
    {
        _306 = _291;
    }
    float3 _308 = select(_298, float3(0.0), bool3(_301));
    float2 _310 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    uint _319 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _329 = (LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _310).xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _319 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _319 + 6u)].xyz;
    float _330 = dot(_329, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _343 = _258.y;
    float _345 = _258.x;
    float _349 = (exp2((_330 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_310 + float2(0.0, 0.5))) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _319 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _319 + 7u)], float4(_343, _258.z, _345, 1.0)));
    float4 _360 = float4(_345, _343, _258.z, 1.0);
    float3 _364 = _184;
    _364.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 0u)], _360);
    float3 _368 = _364;
    _368.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 1u)], _360);
    float3 _372 = _368;
    _372.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 2u)], _360);
    float4 _375 = _360.xyzz * _360.yzzx;
    float3 _379 = _184;
    _379.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 3u)], _375);
    float3 _383 = _379;
    _383.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 4u)], _375);
    float3 _387 = _383;
    _387.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 5u)], _375);
    float3 _401 = (float4(_329 * (_349 / _330), _349).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_372 + _387) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 6u)].xyz * ((_345 * _345) - (_343 * _343)))) * View.View_SkyLightColor.xyz) * 1.0);
    uint2 _446 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _460 = (_258 * (2.0 * dot(_250, _258))) - _250;
    uint _466 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _446.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _446.x)) * 2u;
    float _481 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_281, 0.001000000047497451305389404296875)));
    float2 _485;
    float4 _488;
    _485 = float2(0.0, 1.0);
    _488 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _486;
    float4 _489;
    for (uint _490 = 0u; _490 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_466)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _485 = _486, _488 = _489, _490++)
    {
        if (_488.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _501 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_466 + 1u))).x + _490)));
        uint _502 = _501.x;
        float3 _508 = _248 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_502].xyz;
        float _509 = dot(_508, _508);
        float _510 = sqrt(_509);
        if (_510 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_502].w)
        {
            float _601;
            float3 _602;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_502].z > 0.0)
            {
                float3 _558 = (ReflectionCapture.ReflectionCapture_BoxTransform[_502] * float4(_248, 1.0)).xyz;
                float3 _564 = (ReflectionCapture.ReflectionCapture_BoxTransform[_502] * float4(_460, 0.0)).xyz;
                float3 _565 = float3(1.0) / _564;
                float3 _567 = _558 * _565;
                float3 _570 = fast::max((float3(-1.0) / _564) - _567, _565 - _567);
                float3 _584 = ReflectionCapture.ReflectionCapture_BoxScales[_502].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_502].w);
                float3 _585 = -_584;
                float3 _586 = _558 * ReflectionCapture.ReflectionCapture_BoxScales[_502].xyz;
                _601 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_502].w, dot(select(float3(0.0), abs(_586 - _585), _586 < _585), float3(1.0)) + dot(select(float3(0.0), abs(_586 - _584), _586 > _584), float3(1.0)));
                _602 = (_248 + (_460 * fast::min(_570.x, fast::min(_570.y, _570.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_502].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_502].xyz);
            }
            else
            {
                float _526 = dot(_460, _508);
                float _529 = (_526 * _526) - (_509 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_502].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_502].w));
                float _546;
                float3 _547;
                if (_529 >= 0.0)
                {
                    float _540 = fast::clamp((2.5 * fast::clamp(_510 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_502].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _546 = 1.0 - ((_540 * _540) * (3.0 - (2.0 * _540)));
                    _547 = (_508 + (_460 * (sqrt(_529) - _526))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_502].xyz;
                }
                else
                {
                    _546 = 0.0;
                    _547 = _460;
                }
                _601 = _546;
                _602 = _547;
            }
            float4 _609 = float4(_602, ReflectionCapture.ReflectionCapture_CaptureProperties[_502].y);
            float4 _611 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _609.xyz, uint(round(_609.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _481));
            float3 _614 = _611.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_502].x;
            float4 _616 = float4(_614.x, _614.y, _614.z, _611.w) * _601;
            float3 _621 = _488.xyz + ((_616.xyz * _488.w) * 1.0);
            float4 _626 = float4(_621.x, _621.y, _621.z, _488.w);
            _626.w = _488.w * (1.0 - _616.w);
            float2 _633 = _186;
            _633.x = _485.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_502].w * _601) * _485.y);
            float2 _636 = _633;
            _636.y = _485.y * (1.0 - _601);
            _486 = _636;
            _489 = _626;
        }
        else
        {
            _486 = _485;
            _489 = _488;
        }
    }
    float3 _638 = _488.xyz * View.View_IndirectLightingColorScale;
    float4 _639 = float4(_638.x, _638.y, _638.z, _488.w);
    float _642 = _485.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _643 = _186;
    _643.x = _642;
    float4 _685;
    float2 _686;
    float3 _687;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _663 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _460, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _481)).xyz * View.View_SkyLightColor.xyz;
        float4 _682;
        float2 _683;
        float3 _684;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _676 = _638.xyz + ((_663 * _488.w) * 1.0);
            float2 _681 = _186;
            _681.x = _642 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _485.y);
            _682 = float4(_676.x, _676.y, _676.z, _488.w);
            _683 = _681;
            _684 = float3(0.0);
        }
        else
        {
            _682 = _639;
            _683 = _643;
            _684 = _663 * 1.0;
        }
        _685 = _682;
        _686 = _683;
        _687 = _684;
    }
    else
    {
        _685 = _639;
        _686 = _643;
        _687 = float3(0.0);
    }
    float3 _709 = ((_685.xyz * mix(1.0, fast::min(dot(_401, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_686.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_281 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_687 * _685.w)).xyz;
    float4 _711 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _281) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _712 = _711.x;
    float2 _722 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_712 * _712, exp2((-9.27999973297119140625) * fast::clamp(dot(_258, _250), 0.0, 1.0))) * _712) + _711.y)) + _711.zw;
    float3 _858;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _758 = _248 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _794 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_248, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_758, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_758, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _258) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_281 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _852;
        if (_794 > 0.0)
        {
            float4 _823 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_248 + (reflect(reflect(normalize(_248 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _258).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _830;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _830 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _830 = 0u;
            }
            float4 _847 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_823.xy / float2(_823.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_830].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_830].zw), level(0.0));
            float4 _851 = float4(_847.x, _847.y, _847.z, float4(0.0).w);
            _851.w = _794 * _847.w;
            _852 = _851;
        }
        else
        {
            _852 = float4(0.0);
        }
        _858 = _852.xyz + (_709 * (1.0 - _852.w));
    }
    else
    {
        _858 = _709;
    }
    bool _876 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _925;
    if (_876)
    {
        float4 _883 = View.View_WorldToClip * float4(_248, 1.0);
        float _884 = _883.w;
        float4 _913;
        if (_876)
        {
            _913 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_883.xy / float2(_884)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_884 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _913 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _925 = float4(_913.xyz + (in.in_var_TEXCOORD7.xyz * _913.w), _913.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _925 = in.in_var_TEXCOORD7;
    }
    float3 _933 = (_248 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _941 = (_248 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _946 = fast::clamp((float3(0.5) - abs(_933 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _951 = (_946.x * _946.y) * _946.z;
    float4 _960 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _941, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _933, level(0.0)), float4(_951));
    float3 _971 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _941, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _933, level(0.0)).xyz, float3(_951)) * 1.0;
    float4 _973 = _187;
    _973.x = _960.x;
    float4 _975 = _187;
    _975.x = _960.y;
    float4 _977 = _187;
    _977.x = _960.z;
    float3 _978 = _960.xyz;
    float3 _982 = _978 / float3(dot(_978, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _984 = _971 * _982.x;
    float3 _987 = _971 * _982.y;
    float3 _990 = _971 * _982.z;
    float4 _993 = _187;
    _993.y = (-0.48860299587249755859375) * _343;
    float4 _995 = _993;
    _995.z = 0.48860299587249755859375 * _258.z;
    float4 _997 = _995;
    _997.w = (-0.48860299587249755859375) * _345;
    float4 _998 = _997;
    _998.x = 0.886227548122406005859375;
    float3 _1000 = _998.yzw * 2.094395160675048828125;
    float4 _1001 = float4(_998.x, _1000.x, _1000.y, _1000.z);
    float3 _1003 = _188;
    _1003.x = dot(float4(_973.x, _984.x, _984.y, _984.z), _1001);
    float3 _1005 = _1003;
    _1005.y = dot(float4(_975.x, _987.x, _987.y, _987.z), _1001);
    float3 _1007 = _1005;
    _1007.z = dot(float4(_977.x, _990.x, _990.y, _990.z), _1001);
    float3 _1022 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1053;
    float3 _1054;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1028 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1041 = any(abs(_248 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1028 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1028 + 19u)].xyz + float3(1.0)));
        float3 _1051;
        if (_1041)
        {
            _1051 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1051 = _1022;
        }
        _1053 = _1041 ? 1.0 : _282;
        _1054 = _1051;
    }
    else
    {
        _1053 = _282;
        _1054 = _1022;
    }
    float4 _1064 = float4((((mix((((_858 * ((_308 * _722.x) + float3(fast::clamp(50.0 * _308.y, 0.0, 1.0) * _722.y))) * 1.0) * fast::max(float3(1.0), ((((((_308 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_308 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_308 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_306 * float4(fast::max(float3(0.0), _1007), _183).xyz), _306 + (_308 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_401 * _306) * fast::max(float3(1.0), ((((((_275 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_275 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_275 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1054) * _925.w) + _925.xyz, _1053);
    float3 _1068 = _1064.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1068.x, _1068.y, _1068.z, _1064.w);
    return out;
}

