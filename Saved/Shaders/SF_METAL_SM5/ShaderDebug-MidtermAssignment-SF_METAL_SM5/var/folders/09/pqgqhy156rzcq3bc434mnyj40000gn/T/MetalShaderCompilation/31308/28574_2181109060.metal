

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

constant float3 _189 = {};
constant float4 _190 = {};

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

fragment MainPS_out Main_00006f9e_82011544(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(10)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _244 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _248 = _244.xyz / float3(_244.w);
    float3 _249 = _248 - View.View_PreViewTranslation;
    float3 _251 = normalize(-_248);
    float3 _259 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _276 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _282 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _283 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _292 = (_276 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _299 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _302 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _307;
    if (_302)
    {
        _307 = _292 + (_299 * 0.449999988079071044921875);
    }
    else
    {
        _307 = _292;
    }
    float3 _309 = select(_299, float3(0.0), bool3(_302));
    float _310 = _259.x;
    float _311 = _259.y;
    float4 _313 = float4(_310, _311, _259.z, 1.0);
    float3 _317 = _189;
    _317.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _313);
    float3 _321 = _317;
    _321.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _313);
    float3 _325 = _321;
    _325.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _313);
    float4 _328 = _313.xyzz * _313.yzzx;
    float3 _332 = _189;
    _332.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _328);
    float3 _336 = _332;
    _336.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _328);
    float3 _340 = _336;
    _340.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _328);
    uint2 _397 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _411 = (_259 * (2.0 * dot(_251, _259))) - _251;
    uint _417 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _397.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _397.x)) * 2u;
    float _432 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_282, 0.001000000047497451305389404296875)));
    float4 _436;
    _436 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _437;
    for (uint _439 = 0u; _439 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_417)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _436 = _437, _439++)
    {
        if (_436.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _450 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_417 + 1u))).x + _439)));
        uint _451 = _450.x;
        float3 _457 = _249 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_451].xyz;
        float _458 = dot(_457, _457);
        float _459 = sqrt(_458);
        if (_459 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_451].w)
        {
            float _550;
            float3 _551;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_451].z > 0.0)
            {
                float3 _507 = (ReflectionCapture.ReflectionCapture_BoxTransform[_451] * float4(_249, 1.0)).xyz;
                float3 _513 = (ReflectionCapture.ReflectionCapture_BoxTransform[_451] * float4(_411, 0.0)).xyz;
                float3 _514 = float3(1.0) / _513;
                float3 _516 = _507 * _514;
                float3 _519 = fast::max((float3(-1.0) / _513) - _516, _514 - _516);
                float3 _533 = ReflectionCapture.ReflectionCapture_BoxScales[_451].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_451].w);
                float3 _534 = -_533;
                float3 _535 = _507 * ReflectionCapture.ReflectionCapture_BoxScales[_451].xyz;
                _550 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_451].w, dot(select(float3(0.0), abs(_535 - _534), _535 < _534), float3(1.0)) + dot(select(float3(0.0), abs(_535 - _533), _535 > _533), float3(1.0)));
                _551 = (_249 + (_411 * fast::min(_519.x, fast::min(_519.y, _519.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_451].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_451].xyz);
            }
            else
            {
                float _475 = dot(_411, _457);
                float _478 = (_475 * _475) - (_458 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_451].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_451].w));
                float _495;
                float3 _496;
                if (_478 >= 0.0)
                {
                    float _489 = fast::clamp((2.5 * fast::clamp(_459 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_451].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _495 = 1.0 - ((_489 * _489) * (3.0 - (2.0 * _489)));
                    _496 = (_457 + (_411 * (sqrt(_478) - _475))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_451].xyz;
                }
                else
                {
                    _495 = 0.0;
                    _496 = _411;
                }
                _550 = _495;
                _551 = _496;
            }
            float4 _558 = float4(_551, ReflectionCapture.ReflectionCapture_CaptureProperties[_451].y);
            float4 _560 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _558.xyz, uint(round(_558.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _432));
            float3 _563 = _560.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_451].x;
            float4 _565 = float4(_563.x, _563.y, _563.z, _560.w) * _550;
            float3 _570 = _436.xyz + ((_565.xyz * _436.w) * 1.0);
            float4 _575 = float4(_570.x, _570.y, _570.z, _436.w);
            _575.w = _436.w * (1.0 - _565.w);
            _437 = _575;
        }
        else
        {
            _437 = _436;
        }
    }
    float3 _579 = _436.xyz * View.View_IndirectLightingColorScale;
    float4 _580 = float4(_579.x, _579.y, _579.z, _436.w);
    float4 _613;
    float3 _614;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _596 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _411, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _432)).xyz * View.View_SkyLightColor.xyz;
        float4 _611;
        float3 _612;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _609 = _579.xyz + ((_596 * _436.w) * 1.0);
            _611 = float4(_609.x, _609.y, _609.z, _436.w);
            _612 = float3(0.0);
        }
        else
        {
            _611 = _580;
            _612 = _596 * 1.0;
        }
        _613 = _611;
        _614 = _612;
    }
    else
    {
        _613 = _580;
        _614 = float3(0.0);
    }
    float3 _633 = ((_613.xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_282 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_614 * _613.w)).xyz;
    float4 _635 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _282) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _636 = _635.x;
    float2 _646 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_636 * _636, exp2((-9.27999973297119140625) * fast::clamp(dot(_259, _251), 0.0, 1.0))) * _636) + _635.y)) + _635.zw;
    float3 _782;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _682 = _249 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _718 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_249, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_682, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_682, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _259) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_282 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _776;
        if (_718 > 0.0)
        {
            float4 _747 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_249 + (reflect(reflect(normalize(_249 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _259).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _754;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _754 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _754 = 0u;
            }
            float4 _771 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_747.xy / float2(_747.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_754].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_754].zw), level(0.0));
            float4 _775 = float4(_771.x, _771.y, _771.z, float4(0.0).w);
            _775.w = _718 * _771.w;
            _776 = _775;
        }
        else
        {
            _776 = float4(0.0);
        }
        _782 = _776.xyz + (_633 * (1.0 - _776.w));
    }
    else
    {
        _782 = _633;
    }
    bool _800 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _849;
    if (_800)
    {
        float4 _807 = View.View_WorldToClip * float4(_249, 1.0);
        float _808 = _807.w;
        float4 _837;
        if (_800)
        {
            _837 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_807.xy / float2(_808)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_808 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _837 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _849 = float4(_837.xyz + (in.in_var_TEXCOORD7.xyz * _837.w), _837.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _849 = in.in_var_TEXCOORD7;
    }
    float3 _857 = (_249 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _865 = (_249 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _870 = fast::clamp((float3(0.5) - abs(_857 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _875 = (_870.x * _870.y) * _870.z;
    float4 _884 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _865, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _857, level(0.0)), float4(_875));
    float3 _895 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _865, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _857, level(0.0)).xyz, float3(_875)) * 1.0;
    float4 _897 = _190;
    _897.x = _884.x;
    float4 _899 = _190;
    _899.x = _884.y;
    float4 _901 = _190;
    _901.x = _884.z;
    float3 _902 = _884.xyz;
    float3 _906 = _902 / float3(dot(_902, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _908 = _895 * _906.x;
    float3 _911 = _895 * _906.y;
    float3 _914 = _895 * _906.z;
    float4 _917 = _190;
    _917.y = (-0.48860299587249755859375) * _311;
    float4 _919 = _917;
    _919.z = 0.48860299587249755859375 * _259.z;
    float4 _921 = _919;
    _921.w = (-0.48860299587249755859375) * _310;
    float4 _922 = _921;
    _922.x = 0.886227548122406005859375;
    float3 _924 = _922.yzw * 2.094395160675048828125;
    float4 _925 = float4(_922.x, _924.x, _924.y, _924.z);
    float3 _927 = _189;
    _927.x = dot(float4(_897.x, _908.x, _908.y, _908.z), _925);
    float3 _929 = _927;
    _929.y = dot(float4(_899.x, _911.x, _911.y, _911.z), _925);
    float3 _931 = _929;
    _931.z = dot(float4(_901.x, _914.x, _914.y, _914.z), _925);
    float _933 = _884.w;
    float3 _938 = float4(fast::max(float3(0.0), _931), _933).xyz;
    float3 _1004;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _952 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_249, 1.0);
        float2 _956 = _952.xy / float2(_952.w);
        float _957 = _952.z;
        float4 _960 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _956, level(0.0));
        float3 _964 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _957;
        bool2 _989 = _956 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _991 = _956 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1004 = _307 * fast::max(_938 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _933) * (float3(1.0) - select(fast::clamp(exp((float3((((_960.x * _957) * 0.5) + dot((sin(_964) * _960.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_964)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _956, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_989.x || _991.x, _989.y || _991.y)))))), float3(0.0));
    }
    else
    {
        _1004 = _307 * _938;
    }
    float3 _1012 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1043;
    float3 _1044;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1018 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1031 = any(abs(_249 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1018 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1018 + 19u)].xyz + float3(1.0)));
        float3 _1041;
        if (_1031)
        {
            _1041 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_249, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1041 = _1012;
        }
        _1043 = _1031 ? 1.0 : _283;
        _1044 = _1041;
    }
    else
    {
        _1043 = _283;
        _1044 = _1012;
    }
    float4 _1054 = float4((((mix((((_782 * ((_309 * _646.x) + float3(fast::clamp(50.0 * _309.y, 0.0, 1.0) * _646.y))) * 1.0) * fast::max(float3(1.0), ((((((_309 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_309 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_309 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1004, _307 + (_309 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_325 + _340) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_310 * _310) - (_311 * _311)))) * View.View_SkyLightColor.xyz) * 1.0) * _307) * fast::max(float3(1.0), ((((((_276 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_276 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_276 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1044) * _849.w) + _849.xyz, _1043);
    float3 _1058 = _1054.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1058.x, _1058.y, _1058.z, _1054.w);
    return out;
}

