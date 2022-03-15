

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

constant float _162 = {};
constant float4 _164 = {};
constant float3 _165 = {};

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

fragment MainPS_out Main_00005a57_89b2b6b9(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = _218.xyz / float3(_218.w);
    float3 _223 = _222 - View.View_PreViewTranslation;
    float3 _225 = normalize(-_222);
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _256 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _257 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _266 = (fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _273 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _276 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _281;
    if (_276)
    {
        _281 = _266 + (_273 * 0.449999988079071044921875);
    }
    else
    {
        _281 = _266;
    }
    float3 _283 = select(_273, float3(0.0), bool3(_276));
    uint2 _313 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _327 = (_233 * (2.0 * dot(_225, _233))) - _225;
    uint _333 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _313.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _313.x)) * 2u;
    float4 _352;
    _352 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _353;
    for (uint _355 = 0u; _355 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_333)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _352 = _353, _355++)
    {
        if (_352.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _366 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_333 + 1u))).x + _355)));
        uint _367 = _366.x;
        float3 _373 = _223 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_367].xyz;
        float _374 = dot(_373, _373);
        float _375 = sqrt(_374);
        if (_375 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_367].w)
        {
            float _466;
            float3 _467;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_367].z > 0.0)
            {
                float3 _423 = (ReflectionCapture.ReflectionCapture_BoxTransform[_367] * float4(_223, 1.0)).xyz;
                float3 _429 = (ReflectionCapture.ReflectionCapture_BoxTransform[_367] * float4(_327, 0.0)).xyz;
                float3 _430 = float3(1.0) / _429;
                float3 _432 = _423 * _430;
                float3 _435 = fast::max((float3(-1.0) / _429) - _432, _430 - _432);
                float3 _449 = ReflectionCapture.ReflectionCapture_BoxScales[_367].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_367].w);
                float3 _450 = -_449;
                float3 _451 = _423 * ReflectionCapture.ReflectionCapture_BoxScales[_367].xyz;
                _466 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_367].w, dot(select(float3(0.0), abs(_451 - _450), _451 < _450), float3(1.0)) + dot(select(float3(0.0), abs(_451 - _449), _451 > _449), float3(1.0)));
                _467 = (_223 + (_327 * fast::min(_435.x, fast::min(_435.y, _435.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_367].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_367].xyz);
            }
            else
            {
                float _391 = dot(_327, _373);
                float _394 = (_391 * _391) - (_374 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_367].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_367].w));
                float _411;
                float3 _412;
                if (_394 >= 0.0)
                {
                    float _405 = fast::clamp((2.5 * fast::clamp(_375 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_367].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _411 = 1.0 - ((_405 * _405) * (3.0 - (2.0 * _405)));
                    _412 = (_373 + (_327 * (sqrt(_394) - _391))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_367].xyz;
                }
                else
                {
                    _411 = 0.0;
                    _412 = _327;
                }
                _466 = _411;
                _467 = _412;
            }
            float4 _474 = float4(_467, ReflectionCapture.ReflectionCapture_CaptureProperties[_367].y);
            float4 _476 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _474.xyz, uint(round(_474.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_256, 0.001000000047497451305389404296875))))));
            float3 _479 = _476.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_367].x;
            float4 _481 = float4(_479.x, _479.y, _479.z, _476.w) * _466;
            float3 _486 = _352.xyz + ((_481.xyz * _352.w) * 1.0);
            float4 _491 = float4(_486.x, _486.y, _486.z, _352.w);
            _491.w = _352.w * (1.0 - _481.w);
            _353 = _491;
        }
        else
        {
            _353 = _352;
        }
    }
    float3 _510 = ((_352.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_256 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _512 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _256) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _513 = _512.x;
    float2 _523 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_513 * _513, exp2((-9.27999973297119140625) * fast::clamp(dot(_233, _225), 0.0, 1.0))) * _513) + _512.y)) + _512.zw;
    float3 _659;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _559 = _223 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _595 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_223, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_559, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_559, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _233) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_256 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _653;
        if (_595 > 0.0)
        {
            float4 _624 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_223 + (reflect(reflect(normalize(_223 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _233).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _631;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _631 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _631 = 0u;
            }
            float4 _648 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_624.xy / float2(_624.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_631].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_631].zw), level(0.0));
            float4 _652 = float4(_648.x, _648.y, _648.z, float4(0.0).w);
            _652.w = _595 * _648.w;
            _653 = _652;
        }
        else
        {
            _653 = float4(0.0);
        }
        _659 = _653.xyz + (_510 * (1.0 - _653.w));
    }
    else
    {
        _659 = _510;
    }
    bool _677 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _726;
    if (_677)
    {
        float4 _684 = View.View_WorldToClip * float4(_223, 1.0);
        float _685 = _684.w;
        float4 _714;
        if (_677)
        {
            _714 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_684.xy / float2(_685)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_685 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _714 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _726 = float4(_714.xyz + (in.in_var_TEXCOORD7.xyz * _714.w), _714.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _726 = in.in_var_TEXCOORD7;
    }
    float3 _734 = (_223 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _742 = (_223 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _747 = fast::clamp((float3(0.5) - abs(_734 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _752 = (_747.x * _747.y) * _747.z;
    float4 _761 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _742, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _734, level(0.0)), float4(_752));
    float3 _772 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _742, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _734, level(0.0)).xyz, float3(_752)) * 1.0;
    float4 _774 = _164;
    _774.x = _761.x;
    float4 _776 = _164;
    _776.x = _761.y;
    float4 _778 = _164;
    _778.x = _761.z;
    float3 _779 = _761.xyz;
    float3 _783 = _779 / float3(dot(_779, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _785 = _772 * _783.x;
    float3 _788 = _772 * _783.y;
    float3 _791 = _772 * _783.z;
    float4 _795 = _164;
    _795.y = (-0.48860299587249755859375) * _233.y;
    float4 _798 = _795;
    _798.z = 0.48860299587249755859375 * _233.z;
    float4 _801 = _798;
    _801.w = (-0.48860299587249755859375) * _233.x;
    float4 _802 = _801;
    _802.x = 0.886227548122406005859375;
    float3 _804 = _802.yzw * 2.094395160675048828125;
    float4 _805 = float4(_802.x, _804.x, _804.y, _804.z);
    float3 _807 = _165;
    _807.x = dot(float4(_774.x, _785.x, _785.y, _785.z), _805);
    float3 _809 = _807;
    _809.y = dot(float4(_776.x, _788.x, _788.y, _788.z), _805);
    float3 _811 = _809;
    _811.z = dot(float4(_778.x, _791.x, _791.y, _791.z), _805);
    float3 _826 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _857;
    float3 _858;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _832 = in.in_var_PRIMITIVE_ID * 36u;
        bool _845 = any(abs(_223 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _832 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _832 + 19u)].xyz + float3(1.0)));
        float3 _855;
        if (_845)
        {
            _855 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _855 = _826;
        }
        _857 = _845 ? 1.0 : _257;
        _858 = _855;
    }
    else
    {
        _857 = _257;
        _858 = _826;
    }
    float4 _867 = float4(((mix((((_659 * ((_283 * _523.x) + float3(fast::clamp(50.0 * _283.y, 0.0, 1.0) * _523.y))) * 1.0) * fast::max(float3(1.0), ((((((_283 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_283 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_283 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_281 * float4(fast::max(float3(0.0), _811), _162).xyz), _281 + (_283 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _858) * _726.w) + _726.xyz, _857);
    float3 _871 = _867.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_871.x, _871.y, _871.z, _867.w);
    return out;
}

