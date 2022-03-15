

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

constant float _197 = {};
constant float3 _198 = {};
constant float2 _200 = {};
constant float4 _201 = {};
constant float3 _202 = {};

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

fragment MainPS_out Main_00007836_716310d9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(10)]], texture2d<float> Material_Texture2D_0 [[texture(11)]], texture2d<float> Material_Texture2D_1 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[4];
    float4 _261 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _265 = _261.xyz / float3(_261.w);
    float3 _266 = _265 - View.View_PreViewTranslation;
    float3 _268 = normalize(-_265);
    float4 _274 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _277 = (_274.xy * float2(2.0)) - float2(1.0);
    float3 _293 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_277, sqrt(fast::clamp(1.0 - dot(_277, _277), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _304 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _310 = dot(_293, _268);
    float _314 = fast::max(abs(1.0 - fast::max(0.0, _310)), 9.9999997473787516355514526367188e-05);
    float3 _329 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _304.x, float3(0.0), float3(1.0));
    float _335 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _336 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_314 <= 0.0) ? 0.0 : pow(_314, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _348 = ((_329 - (_329 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _355 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _329, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _358 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _363;
    if (_358)
    {
        _363 = _348 + (_355 * 0.449999988079071044921875);
    }
    else
    {
        _363 = _348;
    }
    float3 _365 = select(_355, float3(0.0), bool3(_358));
    float2 _367 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    uint _376 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _386 = (LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _367).xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _376 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _376 + 6u)].xyz;
    float _387 = dot(_386, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _400 = _293.y;
    float _402 = _293.x;
    float _406 = (exp2((_387 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_367 + float2(0.0, 0.5))) * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _376 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _376 + 7u)], float4(_400, _293.z, _402, 1.0)));
    float4 _417 = float4(_402, _400, _293.z, 1.0);
    float3 _421 = _198;
    _421.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 0u)], _417);
    float3 _425 = _421;
    _425.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 1u)], _417);
    float3 _429 = _425;
    _429.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 2u)], _417);
    float4 _432 = _417.xyzz * _417.yzzx;
    float3 _436 = _198;
    _436.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 3u)], _432);
    float3 _440 = _436;
    _440.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 4u)], _432);
    float3 _444 = _440;
    _444.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 5u)], _432);
    float3 _458 = (float4(_386 * (_406 / _387), _406).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_429 + _444) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, 6u)].xyz * ((_402 * _402) - (_400 * _400)))) * View.View_SkyLightColor.xyz) * 1.0);
    uint2 _503 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _517 = (_293 * (2.0 * dot(_268, _293))) - _268;
    uint _522 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _503.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _503.x)) * 2u;
    float _537 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_335, 0.001000000047497451305389404296875)));
    float2 _541;
    float4 _544;
    _541 = float2(0.0, 1.0);
    _544 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _542;
    float4 _545;
    for (uint _546 = 0u; _546 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_522)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _541 = _542, _544 = _545, _546++)
    {
        if (_544.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _557 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_522 + 1u))).x + _546)));
        uint _558 = _557.x;
        float3 _564 = _266 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_558].xyz;
        float _565 = dot(_564, _564);
        float _566 = sqrt(_565);
        if (_566 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_558].w)
        {
            float _657;
            float3 _658;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_558].z > 0.0)
            {
                float3 _614 = (ReflectionCapture.ReflectionCapture_BoxTransform[_558] * float4(_266, 1.0)).xyz;
                float3 _620 = (ReflectionCapture.ReflectionCapture_BoxTransform[_558] * float4(_517, 0.0)).xyz;
                float3 _621 = float3(1.0) / _620;
                float3 _623 = _614 * _621;
                float3 _626 = fast::max((float3(-1.0) / _620) - _623, _621 - _623);
                float3 _640 = ReflectionCapture.ReflectionCapture_BoxScales[_558].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_558].w);
                float3 _641 = -_640;
                float3 _642 = _614 * ReflectionCapture.ReflectionCapture_BoxScales[_558].xyz;
                _657 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_558].w, dot(select(float3(0.0), abs(_642 - _641), _642 < _641), float3(1.0)) + dot(select(float3(0.0), abs(_642 - _640), _642 > _640), float3(1.0)));
                _658 = (_266 + (_517 * fast::min(_626.x, fast::min(_626.y, _626.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_558].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_558].xyz);
            }
            else
            {
                float _582 = dot(_517, _564);
                float _585 = (_582 * _582) - (_565 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_558].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_558].w));
                float _602;
                float3 _603;
                if (_585 >= 0.0)
                {
                    float _596 = fast::clamp((2.5 * fast::clamp(_566 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_558].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _602 = 1.0 - ((_596 * _596) * (3.0 - (2.0 * _596)));
                    _603 = (_564 + (_517 * (sqrt(_585) - _582))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_558].xyz;
                }
                else
                {
                    _602 = 0.0;
                    _603 = _517;
                }
                _657 = _602;
                _658 = _603;
            }
            float4 _665 = float4(_658, ReflectionCapture.ReflectionCapture_CaptureProperties[_558].y);
            float4 _667 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _665.xyz, uint(round(_665.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _537));
            float3 _670 = _667.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_558].x;
            float4 _672 = float4(_670.x, _670.y, _670.z, _667.w) * _657;
            float3 _677 = _544.xyz + ((_672.xyz * _544.w) * 1.0);
            float4 _682 = float4(_677.x, _677.y, _677.z, _544.w);
            _682.w = _544.w * (1.0 - _672.w);
            float2 _689 = _200;
            _689.x = _541.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_558].w * _657) * _541.y);
            float2 _692 = _689;
            _692.y = _541.y * (1.0 - _657);
            _542 = _692;
            _545 = _682;
        }
        else
        {
            _542 = _541;
            _545 = _544;
        }
    }
    float3 _694 = _544.xyz * View.View_IndirectLightingColorScale;
    float4 _695 = float4(_694.x, _694.y, _694.z, _544.w);
    float _698 = _541.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _699 = _200;
    _699.x = _698;
    float4 _741;
    float2 _742;
    float3 _743;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _719 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _517, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _537)).xyz * View.View_SkyLightColor.xyz;
        float4 _738;
        float2 _739;
        float3 _740;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _732 = _694.xyz + ((_719 * _544.w) * 1.0);
            float2 _737 = _200;
            _737.x = _698 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _541.y);
            _738 = float4(_732.x, _732.y, _732.z, _544.w);
            _739 = _737;
            _740 = float3(0.0);
        }
        else
        {
            _738 = _695;
            _739 = _699;
            _740 = _719 * 1.0;
        }
        _741 = _738;
        _742 = _739;
        _743 = _740;
    }
    else
    {
        _741 = _695;
        _742 = _699;
        _743 = float3(0.0);
    }
    float3 _765 = ((_741.xyz * mix(1.0, fast::min(dot(_458, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_742.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_335 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_743 * _741.w)).xyz;
    float4 _767 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _335) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _768 = _767.x;
    float2 _778 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_768 * _768, exp2((-9.27999973297119140625) * fast::clamp(_310, 0.0, 1.0))) * _768) + _767.y)) + _767.zw;
    float3 _914;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _814 = _266 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _850 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_266, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_814, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_814, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _293) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_335 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _908;
        if (_850 > 0.0)
        {
            float4 _879 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_266 + (reflect(reflect(normalize(_266 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _293).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _886;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _886 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _886 = 0u;
            }
            float4 _903 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_879.xy / float2(_879.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_886].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_886].zw), level(0.0));
            float4 _907 = float4(_903.x, _903.y, _903.z, float4(0.0).w);
            _907.w = _850 * _903.w;
            _908 = _907;
        }
        else
        {
            _908 = float4(0.0);
        }
        _914 = _908.xyz + (_765 * (1.0 - _908.w));
    }
    else
    {
        _914 = _765;
    }
    bool _932 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _981;
    if (_932)
    {
        float4 _939 = View.View_WorldToClip * float4(_266, 1.0);
        float _940 = _939.w;
        float4 _969;
        if (_932)
        {
            _969 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_939.xy / float2(_940)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_940 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _969 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _981 = float4(_969.xyz + (in.in_var_TEXCOORD7.xyz * _969.w), _969.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _981 = in.in_var_TEXCOORD7;
    }
    float3 _989 = (_266 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _997 = (_266 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1002 = fast::clamp((float3(0.5) - abs(_989 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1007 = (_1002.x * _1002.y) * _1002.z;
    float4 _1016 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _997, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _989, level(0.0)), float4(_1007));
    float3 _1027 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _997, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _989, level(0.0)).xyz, float3(_1007)) * 1.0;
    float4 _1029 = _201;
    _1029.x = _1016.x;
    float4 _1031 = _201;
    _1031.x = _1016.y;
    float4 _1033 = _201;
    _1033.x = _1016.z;
    float3 _1034 = _1016.xyz;
    float3 _1038 = _1034 / float3(dot(_1034, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1040 = _1027 * _1038.x;
    float3 _1043 = _1027 * _1038.y;
    float3 _1046 = _1027 * _1038.z;
    float4 _1049 = _201;
    _1049.y = (-0.48860299587249755859375) * _400;
    float4 _1051 = _1049;
    _1051.z = 0.48860299587249755859375 * _293.z;
    float4 _1053 = _1051;
    _1053.w = (-0.48860299587249755859375) * _402;
    float4 _1054 = _1053;
    _1054.x = 0.886227548122406005859375;
    float3 _1056 = _1054.yzw * 2.094395160675048828125;
    float4 _1057 = float4(_1054.x, _1056.x, _1056.y, _1056.z);
    float3 _1059 = _202;
    _1059.x = dot(float4(_1029.x, _1040.x, _1040.y, _1040.z), _1057);
    float3 _1061 = _1059;
    _1061.y = dot(float4(_1031.x, _1043.x, _1043.y, _1043.z), _1057);
    float3 _1063 = _1061;
    _1063.z = dot(float4(_1033.x, _1046.x, _1046.y, _1046.z), _1057);
    float3 _1078 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1109;
    float3 _1110;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1084 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1097 = any(abs(_266 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1084 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1084 + 19u)].xyz + float3(1.0)));
        float3 _1107;
        if (_1097)
        {
            _1107 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_266, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1107 = _1078;
        }
        _1109 = _1097 ? 1.0 : _336;
        _1110 = _1107;
    }
    else
    {
        _1109 = _336;
        _1110 = _1078;
    }
    float4 _1120 = float4((((mix((((_914 * ((_365 * _778.x) + float3(fast::clamp(50.0 * _365.y, 0.0, 1.0) * _778.y))) * 1.0) * fast::max(float3(1.0), ((((((_365 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_365 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_365 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_363 * float4(fast::max(float3(0.0), _1063), _197).xyz), _363 + (_365 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_458 * _363) * fast::max(float3(1.0), ((((((_329 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_329 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_329 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1110) * _981.w) + _981.xyz, _1109);
    float3 _1124 = _1120.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1124.x, _1124.y, _1124.z, _1120.w);
    return out;
}

