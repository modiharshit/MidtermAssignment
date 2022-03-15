

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

constant float4 _180 = {};
constant float3 _181 = {};

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

fragment MainPS_out Main_0000628a_6ea3d85c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = _234.xyz / float3(_234.w);
    float3 _239 = _238 - View.View_PreViewTranslation;
    float3 _241 = normalize(-_238);
    float3 _249 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _272 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _273 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _282 = (fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _289 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _292 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _297;
    if (_292)
    {
        _297 = _282 + (_289 * 0.449999988079071044921875);
    }
    else
    {
        _297 = _282;
    }
    float3 _299 = select(_289, float3(0.0), bool3(_292));
    uint2 _329 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _343 = (_249 * (2.0 * dot(_241, _249))) - _241;
    uint _349 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _329.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _329.x)) * 2u;
    float4 _368;
    _368 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _369;
    for (uint _371 = 0u; _371 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_349)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _368 = _369, _371++)
    {
        if (_368.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _382 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_349 + 1u))).x + _371)));
        uint _383 = _382.x;
        float3 _389 = _239 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_383].xyz;
        float _390 = dot(_389, _389);
        float _391 = sqrt(_390);
        if (_391 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_383].w)
        {
            float _482;
            float3 _483;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_383].z > 0.0)
            {
                float3 _439 = (ReflectionCapture.ReflectionCapture_BoxTransform[_383] * float4(_239, 1.0)).xyz;
                float3 _445 = (ReflectionCapture.ReflectionCapture_BoxTransform[_383] * float4(_343, 0.0)).xyz;
                float3 _446 = float3(1.0) / _445;
                float3 _448 = _439 * _446;
                float3 _451 = fast::max((float3(-1.0) / _445) - _448, _446 - _448);
                float3 _465 = ReflectionCapture.ReflectionCapture_BoxScales[_383].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_383].w);
                float3 _466 = -_465;
                float3 _467 = _439 * ReflectionCapture.ReflectionCapture_BoxScales[_383].xyz;
                _482 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_383].w, dot(select(float3(0.0), abs(_467 - _466), _467 < _466), float3(1.0)) + dot(select(float3(0.0), abs(_467 - _465), _467 > _465), float3(1.0)));
                _483 = (_239 + (_343 * fast::min(_451.x, fast::min(_451.y, _451.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_383].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_383].xyz);
            }
            else
            {
                float _407 = dot(_343, _389);
                float _410 = (_407 * _407) - (_390 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_383].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_383].w));
                float _427;
                float3 _428;
                if (_410 >= 0.0)
                {
                    float _421 = fast::clamp((2.5 * fast::clamp(_391 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_383].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _427 = 1.0 - ((_421 * _421) * (3.0 - (2.0 * _421)));
                    _428 = (_389 + (_343 * (sqrt(_410) - _407))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_383].xyz;
                }
                else
                {
                    _427 = 0.0;
                    _428 = _343;
                }
                _482 = _427;
                _483 = _428;
            }
            float4 _490 = float4(_483, ReflectionCapture.ReflectionCapture_CaptureProperties[_383].y);
            float4 _492 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _490.xyz, uint(round(_490.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_272, 0.001000000047497451305389404296875))))));
            float3 _495 = _492.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_383].x;
            float4 _497 = float4(_495.x, _495.y, _495.z, _492.w) * _482;
            float3 _502 = _368.xyz + ((_497.xyz * _368.w) * 1.0);
            float4 _507 = float4(_502.x, _502.y, _502.z, _368.w);
            _507.w = _368.w * (1.0 - _497.w);
            _369 = _507;
        }
        else
        {
            _369 = _368;
        }
    }
    float3 _526 = ((_368.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_272 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _528 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _272) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _529 = _528.x;
    float2 _539 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_529 * _529, exp2((-9.27999973297119140625) * fast::clamp(dot(_249, _241), 0.0, 1.0))) * _529) + _528.y)) + _528.zw;
    float3 _675;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _575 = _239 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _611 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_239, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_575, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_575, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _249) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_272 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _669;
        if (_611 > 0.0)
        {
            float4 _640 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_239 + (reflect(reflect(normalize(_239 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _249).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _647;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _647 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _647 = 0u;
            }
            float4 _664 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_640.xy / float2(_640.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_647].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_647].zw), level(0.0));
            float4 _668 = float4(_664.x, _664.y, _664.z, float4(0.0).w);
            _668.w = _611 * _664.w;
            _669 = _668;
        }
        else
        {
            _669 = float4(0.0);
        }
        _675 = _669.xyz + (_526 * (1.0 - _669.w));
    }
    else
    {
        _675 = _526;
    }
    bool _693 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _742;
    if (_693)
    {
        float4 _700 = View.View_WorldToClip * float4(_239, 1.0);
        float _701 = _700.w;
        float4 _730;
        if (_693)
        {
            _730 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_700.xy / float2(_701)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_701 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _730 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _742 = float4(_730.xyz + (in.in_var_TEXCOORD7.xyz * _730.w), _730.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _742 = in.in_var_TEXCOORD7;
    }
    float3 _750 = (_239 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _758 = (_239 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _763 = fast::clamp((float3(0.5) - abs(_750 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _768 = (_763.x * _763.y) * _763.z;
    float4 _777 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _758, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _750, level(0.0)), float4(_768));
    float3 _788 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _758, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _750, level(0.0)).xyz, float3(_768)) * 1.0;
    float4 _790 = _180;
    _790.x = _777.x;
    float4 _792 = _180;
    _792.x = _777.y;
    float4 _794 = _180;
    _794.x = _777.z;
    float3 _795 = _777.xyz;
    float3 _799 = _795 / float3(dot(_795, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _801 = _788 * _799.x;
    float3 _804 = _788 * _799.y;
    float3 _807 = _788 * _799.z;
    float4 _811 = _180;
    _811.y = (-0.48860299587249755859375) * _249.y;
    float4 _814 = _811;
    _814.z = 0.48860299587249755859375 * _249.z;
    float4 _817 = _814;
    _817.w = (-0.48860299587249755859375) * _249.x;
    float4 _818 = _817;
    _818.x = 0.886227548122406005859375;
    float3 _820 = _818.yzw * 2.094395160675048828125;
    float4 _821 = float4(_818.x, _820.x, _820.y, _820.z);
    float3 _823 = _181;
    _823.x = dot(float4(_790.x, _801.x, _801.y, _801.z), _821);
    float3 _825 = _823;
    _825.y = dot(float4(_792.x, _804.x, _804.y, _804.z), _821);
    float3 _827 = _825;
    _827.z = dot(float4(_794.x, _807.x, _807.y, _807.z), _821);
    float _829 = _777.w;
    float3 _834 = float4(fast::max(float3(0.0), _827), _829).xyz;
    float3 _900;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _848 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_239, 1.0);
        float2 _852 = _848.xy / float2(_848.w);
        float _853 = _848.z;
        float4 _856 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _852, level(0.0));
        float3 _860 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _853;
        bool2 _885 = _852 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _887 = _852 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _900 = _297 * fast::max(_834 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _829) * (float3(1.0) - select(fast::clamp(exp((float3((((_856.x * _853) * 0.5) + dot((sin(_860) * _856.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_860)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _852, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_885.x || _887.x, _885.y || _887.y)))))), float3(0.0));
    }
    else
    {
        _900 = _297 * _834;
    }
    float3 _908 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _939;
    float3 _940;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _914 = in.in_var_PRIMITIVE_ID * 36u;
        bool _927 = any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _914 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _914 + 19u)].xyz + float3(1.0)));
        float3 _937;
        if (_927)
        {
            _937 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _937 = _908;
        }
        _939 = _927 ? 1.0 : _273;
        _940 = _937;
    }
    else
    {
        _939 = _273;
        _940 = _908;
    }
    float4 _949 = float4(((mix((((_675 * ((_299 * _539.x) + float3(fast::clamp(50.0 * _299.y, 0.0, 1.0) * _539.y))) * 1.0) * fast::max(float3(1.0), ((((((_299 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_299 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_299 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _900, _297 + (_299 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _940) * _742.w) + _742.xyz, _939);
    float3 _953 = _949.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_953.x, _953.y, _953.z, _949.w);
    return out;
}

