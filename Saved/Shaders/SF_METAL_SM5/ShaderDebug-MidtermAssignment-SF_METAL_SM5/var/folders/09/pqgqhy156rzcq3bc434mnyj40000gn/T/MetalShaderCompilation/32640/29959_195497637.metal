

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

constant float3 _203 = {};
constant float4 _204 = {};

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

fragment MainPS_out Main_00007507_0ba70ea5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(10)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _262 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _266 = _262.xyz / float3(_262.w);
    float3 _267 = _266 - View.View_PreViewTranslation;
    float3 _269 = normalize(-_266);
    float4 _275 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _278 = (_275.xy * float2(2.0)) - float2(1.0);
    float3 _294 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_278, sqrt(fast::clamp(1.0 - dot(_278, _278), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _305 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _311 = dot(_294, _269);
    float _315 = fast::max(abs(1.0 - fast::max(0.0, _311)), 9.9999997473787516355514526367188e-05);
    float3 _330 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _305.x, float3(0.0), float3(1.0));
    float _336 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _337 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_315 <= 0.0) ? 0.0 : pow(_315, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _349 = ((_330 - (_330 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _356 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _330, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _359 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _364;
    if (_359)
    {
        _364 = _349 + (_356 * 0.449999988079071044921875);
    }
    else
    {
        _364 = _349;
    }
    float3 _366 = select(_356, float3(0.0), bool3(_359));
    float _367 = _294.x;
    float _368 = _294.y;
    float4 _370 = float4(_367, _368, _294.z, 1.0);
    float3 _374 = _203;
    _374.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _370);
    float3 _378 = _374;
    _378.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _370);
    float3 _382 = _378;
    _382.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _370);
    float4 _385 = _370.xyzz * _370.yzzx;
    float3 _389 = _203;
    _389.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _385);
    float3 _393 = _389;
    _393.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _385);
    float3 _397 = _393;
    _397.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _385);
    uint2 _454 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _468 = (_294 * (2.0 * dot(_269, _294))) - _269;
    uint _473 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _454.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _454.x)) * 2u;
    float _488 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_336, 0.001000000047497451305389404296875)));
    float4 _492;
    _492 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _493;
    for (uint _495 = 0u; _495 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_473)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _492 = _493, _495++)
    {
        if (_492.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _506 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_473 + 1u))).x + _495)));
        uint _507 = _506.x;
        float3 _513 = _267 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_507].xyz;
        float _514 = dot(_513, _513);
        float _515 = sqrt(_514);
        if (_515 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_507].w)
        {
            float _606;
            float3 _607;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_507].z > 0.0)
            {
                float3 _563 = (ReflectionCapture.ReflectionCapture_BoxTransform[_507] * float4(_267, 1.0)).xyz;
                float3 _569 = (ReflectionCapture.ReflectionCapture_BoxTransform[_507] * float4(_468, 0.0)).xyz;
                float3 _570 = float3(1.0) / _569;
                float3 _572 = _563 * _570;
                float3 _575 = fast::max((float3(-1.0) / _569) - _572, _570 - _572);
                float3 _589 = ReflectionCapture.ReflectionCapture_BoxScales[_507].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_507].w);
                float3 _590 = -_589;
                float3 _591 = _563 * ReflectionCapture.ReflectionCapture_BoxScales[_507].xyz;
                _606 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_507].w, dot(select(float3(0.0), abs(_591 - _590), _591 < _590), float3(1.0)) + dot(select(float3(0.0), abs(_591 - _589), _591 > _589), float3(1.0)));
                _607 = (_267 + (_468 * fast::min(_575.x, fast::min(_575.y, _575.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_507].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_507].xyz);
            }
            else
            {
                float _531 = dot(_468, _513);
                float _534 = (_531 * _531) - (_514 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_507].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_507].w));
                float _551;
                float3 _552;
                if (_534 >= 0.0)
                {
                    float _545 = fast::clamp((2.5 * fast::clamp(_515 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_507].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _551 = 1.0 - ((_545 * _545) * (3.0 - (2.0 * _545)));
                    _552 = (_513 + (_468 * (sqrt(_534) - _531))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_507].xyz;
                }
                else
                {
                    _551 = 0.0;
                    _552 = _468;
                }
                _606 = _551;
                _607 = _552;
            }
            float4 _614 = float4(_607, ReflectionCapture.ReflectionCapture_CaptureProperties[_507].y);
            float4 _616 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _614.xyz, uint(round(_614.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _488));
            float3 _619 = _616.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_507].x;
            float4 _621 = float4(_619.x, _619.y, _619.z, _616.w) * _606;
            float3 _626 = _492.xyz + ((_621.xyz * _492.w) * 1.0);
            float4 _631 = float4(_626.x, _626.y, _626.z, _492.w);
            _631.w = _492.w * (1.0 - _621.w);
            _493 = _631;
        }
        else
        {
            _493 = _492;
        }
    }
    float3 _635 = _492.xyz * View.View_IndirectLightingColorScale;
    float4 _636 = float4(_635.x, _635.y, _635.z, _492.w);
    float4 _669;
    float3 _670;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _652 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _468, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _488)).xyz * View.View_SkyLightColor.xyz;
        float4 _667;
        float3 _668;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _665 = _635.xyz + ((_652 * _492.w) * 1.0);
            _667 = float4(_665.x, _665.y, _665.z, _492.w);
            _668 = float3(0.0);
        }
        else
        {
            _667 = _636;
            _668 = _652 * 1.0;
        }
        _669 = _667;
        _670 = _668;
    }
    else
    {
        _669 = _636;
        _670 = float3(0.0);
    }
    float3 _689 = ((_669.xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_336 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_670 * _669.w)).xyz;
    float4 _691 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _336) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _692 = _691.x;
    float2 _702 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_692 * _692, exp2((-9.27999973297119140625) * fast::clamp(_311, 0.0, 1.0))) * _692) + _691.y)) + _691.zw;
    float3 _838;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _738 = _267 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _774 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_267, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_738, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_738, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _294) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_336 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _832;
        if (_774 > 0.0)
        {
            float4 _803 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_267 + (reflect(reflect(normalize(_267 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _294).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _810;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _810 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _810 = 0u;
            }
            float4 _827 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_803.xy / float2(_803.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_810].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_810].zw), level(0.0));
            float4 _831 = float4(_827.x, _827.y, _827.z, float4(0.0).w);
            _831.w = _774 * _827.w;
            _832 = _831;
        }
        else
        {
            _832 = float4(0.0);
        }
        _838 = _832.xyz + (_689 * (1.0 - _832.w));
    }
    else
    {
        _838 = _689;
    }
    bool _856 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _905;
    if (_856)
    {
        float4 _863 = View.View_WorldToClip * float4(_267, 1.0);
        float _864 = _863.w;
        float4 _893;
        if (_856)
        {
            _893 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_863.xy / float2(_864)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_864 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _893 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _905 = float4(_893.xyz + (in.in_var_TEXCOORD7.xyz * _893.w), _893.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _905 = in.in_var_TEXCOORD7;
    }
    float3 _913 = (_267 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _921 = (_267 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _926 = fast::clamp((float3(0.5) - abs(_913 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _931 = (_926.x * _926.y) * _926.z;
    float4 _940 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _921, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _913, level(0.0)), float4(_931));
    float3 _951 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _921, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _913, level(0.0)).xyz, float3(_931)) * 1.0;
    float4 _953 = _204;
    _953.x = _940.x;
    float4 _955 = _204;
    _955.x = _940.y;
    float4 _957 = _204;
    _957.x = _940.z;
    float3 _958 = _940.xyz;
    float3 _962 = _958 / float3(dot(_958, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _964 = _951 * _962.x;
    float3 _967 = _951 * _962.y;
    float3 _970 = _951 * _962.z;
    float4 _973 = _204;
    _973.y = (-0.48860299587249755859375) * _368;
    float4 _975 = _973;
    _975.z = 0.48860299587249755859375 * _294.z;
    float4 _977 = _975;
    _977.w = (-0.48860299587249755859375) * _367;
    float4 _978 = _977;
    _978.x = 0.886227548122406005859375;
    float3 _980 = _978.yzw * 2.094395160675048828125;
    float4 _981 = float4(_978.x, _980.x, _980.y, _980.z);
    float3 _983 = _203;
    _983.x = dot(float4(_953.x, _964.x, _964.y, _964.z), _981);
    float3 _985 = _983;
    _985.y = dot(float4(_955.x, _967.x, _967.y, _967.z), _981);
    float3 _987 = _985;
    _987.z = dot(float4(_957.x, _970.x, _970.y, _970.z), _981);
    float _989 = _940.w;
    float3 _994 = float4(fast::max(float3(0.0), _987), _989).xyz;
    float3 _1060;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1008 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_267, 1.0);
        float2 _1012 = _1008.xy / float2(_1008.w);
        float _1013 = _1008.z;
        float4 _1016 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1012, level(0.0));
        float3 _1020 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1013;
        bool2 _1045 = _1012 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1047 = _1012 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1060 = _364 * fast::max(_994 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _989) * (float3(1.0) - select(fast::clamp(exp((float3((((_1016.x * _1013) * 0.5) + dot((sin(_1020) * _1016.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1020)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1012, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1045.x || _1047.x, _1045.y || _1047.y)))))), float3(0.0));
    }
    else
    {
        _1060 = _364 * _994;
    }
    float3 _1068 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1099;
    float3 _1100;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1074 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1087 = any(abs(_267 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1074 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1074 + 19u)].xyz + float3(1.0)));
        float3 _1097;
        if (_1087)
        {
            _1097 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_267, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1097 = _1068;
        }
        _1099 = _1087 ? 1.0 : _337;
        _1100 = _1097;
    }
    else
    {
        _1099 = _337;
        _1100 = _1068;
    }
    float4 _1110 = float4((((mix((((_838 * ((_366 * _702.x) + float3(fast::clamp(50.0 * _366.y, 0.0, 1.0) * _702.y))) * 1.0) * fast::max(float3(1.0), ((((((_366 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_366 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_366 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1060, _364 + (_366 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_382 + _397) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_367 * _367) - (_368 * _368)))) * View.View_SkyLightColor.xyz) * 1.0) * _364) * fast::max(float3(1.0), ((((((_330 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_330 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_330 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1100) * _905.w) + _905.xyz, _1099);
    float3 _1114 = _1110.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1114.x, _1114.y, _1114.z, _1110.w);
    return out;
}

