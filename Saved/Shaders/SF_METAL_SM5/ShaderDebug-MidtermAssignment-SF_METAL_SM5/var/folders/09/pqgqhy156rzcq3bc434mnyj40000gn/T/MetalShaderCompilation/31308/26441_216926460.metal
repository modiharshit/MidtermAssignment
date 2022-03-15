

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

constant float _171 = {};
constant float3 _173 = {};
constant float4 _174 = {};

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

fragment MainPS_out Main_00006749_0cee08fc(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = _228.xyz / float3(_228.w);
    float3 _233 = _232 - View.View_PreViewTranslation;
    float3 _235 = normalize(-_232);
    float3 _243 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _260 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _266 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _267 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _276 = (_260 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _283 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _286 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _291;
    if (_286)
    {
        _291 = _276 + (_283 * 0.449999988079071044921875);
    }
    else
    {
        _291 = _276;
    }
    float3 _293 = select(_283, float3(0.0), bool3(_286));
    float _294 = _243.x;
    float _295 = _243.y;
    float4 _297 = float4(_294, _295, _243.z, 1.0);
    float3 _301 = _173;
    _301.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _297);
    float3 _305 = _301;
    _305.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _297);
    float3 _309 = _305;
    _309.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _297);
    float4 _312 = _297.xyzz * _297.yzzx;
    float3 _316 = _173;
    _316.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _312);
    float3 _320 = _316;
    _320.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _312);
    float3 _324 = _320;
    _324.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _312);
    uint2 _381 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _395 = (_243 * (2.0 * dot(_235, _243))) - _235;
    uint _401 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _381.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _381.x)) * 2u;
    float _416 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_266, 0.001000000047497451305389404296875)));
    float4 _420;
    _420 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _421;
    for (uint _423 = 0u; _423 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_401)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _420 = _421, _423++)
    {
        if (_420.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _434 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_401 + 1u))).x + _423)));
        uint _435 = _434.x;
        float3 _441 = _233 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_435].xyz;
        float _442 = dot(_441, _441);
        float _443 = sqrt(_442);
        if (_443 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_435].w)
        {
            float _534;
            float3 _535;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_435].z > 0.0)
            {
                float3 _491 = (ReflectionCapture.ReflectionCapture_BoxTransform[_435] * float4(_233, 1.0)).xyz;
                float3 _497 = (ReflectionCapture.ReflectionCapture_BoxTransform[_435] * float4(_395, 0.0)).xyz;
                float3 _498 = float3(1.0) / _497;
                float3 _500 = _491 * _498;
                float3 _503 = fast::max((float3(-1.0) / _497) - _500, _498 - _500);
                float3 _517 = ReflectionCapture.ReflectionCapture_BoxScales[_435].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_435].w);
                float3 _518 = -_517;
                float3 _519 = _491 * ReflectionCapture.ReflectionCapture_BoxScales[_435].xyz;
                _534 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_435].w, dot(select(float3(0.0), abs(_519 - _518), _519 < _518), float3(1.0)) + dot(select(float3(0.0), abs(_519 - _517), _519 > _517), float3(1.0)));
                _535 = (_233 + (_395 * fast::min(_503.x, fast::min(_503.y, _503.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_435].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_435].xyz);
            }
            else
            {
                float _459 = dot(_395, _441);
                float _462 = (_459 * _459) - (_442 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_435].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_435].w));
                float _479;
                float3 _480;
                if (_462 >= 0.0)
                {
                    float _473 = fast::clamp((2.5 * fast::clamp(_443 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_435].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _479 = 1.0 - ((_473 * _473) * (3.0 - (2.0 * _473)));
                    _480 = (_441 + (_395 * (sqrt(_462) - _459))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_435].xyz;
                }
                else
                {
                    _479 = 0.0;
                    _480 = _395;
                }
                _534 = _479;
                _535 = _480;
            }
            float4 _542 = float4(_535, ReflectionCapture.ReflectionCapture_CaptureProperties[_435].y);
            float4 _544 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _542.xyz, uint(round(_542.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _416));
            float3 _547 = _544.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_435].x;
            float4 _549 = float4(_547.x, _547.y, _547.z, _544.w) * _534;
            float3 _554 = _420.xyz + ((_549.xyz * _420.w) * 1.0);
            float4 _559 = float4(_554.x, _554.y, _554.z, _420.w);
            _559.w = _420.w * (1.0 - _549.w);
            _421 = _559;
        }
        else
        {
            _421 = _420;
        }
    }
    float3 _563 = _420.xyz * View.View_IndirectLightingColorScale;
    float4 _564 = float4(_563.x, _563.y, _563.z, _420.w);
    float4 _597;
    float3 _598;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _580 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _395, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _416)).xyz * View.View_SkyLightColor.xyz;
        float4 _595;
        float3 _596;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _593 = _563.xyz + ((_580 * _420.w) * 1.0);
            _595 = float4(_593.x, _593.y, _593.z, _420.w);
            _596 = float3(0.0);
        }
        else
        {
            _595 = _564;
            _596 = _580 * 1.0;
        }
        _597 = _595;
        _598 = _596;
    }
    else
    {
        _597 = _564;
        _598 = float3(0.0);
    }
    float3 _617 = ((_597.xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_266 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_598 * _597.w)).xyz;
    float4 _619 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _266) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _620 = _619.x;
    float2 _630 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_620 * _620, exp2((-9.27999973297119140625) * fast::clamp(dot(_243, _235), 0.0, 1.0))) * _620) + _619.y)) + _619.zw;
    float3 _766;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _666 = _233 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _702 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_233, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_666, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_666, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _243) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_266 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _760;
        if (_702 > 0.0)
        {
            float4 _731 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_233 + (reflect(reflect(normalize(_233 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _243).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _738;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _738 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _738 = 0u;
            }
            float4 _755 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_731.xy / float2(_731.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_738].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_738].zw), level(0.0));
            float4 _759 = float4(_755.x, _755.y, _755.z, float4(0.0).w);
            _759.w = _702 * _755.w;
            _760 = _759;
        }
        else
        {
            _760 = float4(0.0);
        }
        _766 = _760.xyz + (_617 * (1.0 - _760.w));
    }
    else
    {
        _766 = _617;
    }
    bool _784 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _833;
    if (_784)
    {
        float4 _791 = View.View_WorldToClip * float4(_233, 1.0);
        float _792 = _791.w;
        float4 _821;
        if (_784)
        {
            _821 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_791.xy / float2(_792)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_792 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _821 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _833 = float4(_821.xyz + (in.in_var_TEXCOORD7.xyz * _821.w), _821.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _833 = in.in_var_TEXCOORD7;
    }
    float3 _841 = (_233 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _849 = (_233 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _854 = fast::clamp((float3(0.5) - abs(_841 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _859 = (_854.x * _854.y) * _854.z;
    float4 _868 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _849, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _841, level(0.0)), float4(_859));
    float3 _879 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _849, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _841, level(0.0)).xyz, float3(_859)) * 1.0;
    float4 _881 = _174;
    _881.x = _868.x;
    float4 _883 = _174;
    _883.x = _868.y;
    float4 _885 = _174;
    _885.x = _868.z;
    float3 _886 = _868.xyz;
    float3 _890 = _886 / float3(dot(_886, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _892 = _879 * _890.x;
    float3 _895 = _879 * _890.y;
    float3 _898 = _879 * _890.z;
    float4 _901 = _174;
    _901.y = (-0.48860299587249755859375) * _295;
    float4 _903 = _901;
    _903.z = 0.48860299587249755859375 * _243.z;
    float4 _905 = _903;
    _905.w = (-0.48860299587249755859375) * _294;
    float4 _906 = _905;
    _906.x = 0.886227548122406005859375;
    float3 _908 = _906.yzw * 2.094395160675048828125;
    float4 _909 = float4(_906.x, _908.x, _908.y, _908.z);
    float3 _911 = _173;
    _911.x = dot(float4(_881.x, _892.x, _892.y, _892.z), _909);
    float3 _913 = _911;
    _913.y = dot(float4(_883.x, _895.x, _895.y, _895.z), _909);
    float3 _915 = _913;
    _915.z = dot(float4(_885.x, _898.x, _898.y, _898.z), _909);
    float3 _930 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _961;
    float3 _962;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _936 = in.in_var_PRIMITIVE_ID * 36u;
        bool _949 = any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _936 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _936 + 19u)].xyz + float3(1.0)));
        float3 _959;
        if (_949)
        {
            _959 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _959 = _930;
        }
        _961 = _949 ? 1.0 : _267;
        _962 = _959;
    }
    else
    {
        _961 = _267;
        _962 = _930;
    }
    float4 _972 = float4((((mix((((_766 * ((_293 * _630.x) + float3(fast::clamp(50.0 * _293.y, 0.0, 1.0) * _630.y))) * 1.0) * fast::max(float3(1.0), ((((((_293 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_293 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_293 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_291 * float4(fast::max(float3(0.0), _915), _171).xyz), _291 + (_293 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_309 + _324) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_294 * _294) - (_295 * _295)))) * View.View_SkyLightColor.xyz) * 1.0) * _291) * fast::max(float3(1.0), ((((((_260 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_260 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_260 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _962) * _833.w) + _833.xyz, _961);
    float3 _976 = _972.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_976.x, _976.y, _976.z, _972.w);
    return out;
}

