

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

constant float4 _194 = {};
constant float3 _195 = {};

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

fragment MainPS_out Main_000067fa_62ac32cd(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(2)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(8)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(9)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(10)]], texture2d<float> Material_Texture2D_0 [[texture(11)]], texture2d<float> Material_Texture2D_1 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    float4 _252 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _256 = _252.xyz / float3(_252.w);
    float3 _257 = _256 - View.View_PreViewTranslation;
    float3 _259 = normalize(-_256);
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float3 _284 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _295 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _301 = dot(_284, _259);
    float _305 = fast::max(abs(1.0 - fast::max(0.0, _301)), 9.9999997473787516355514526367188e-05);
    float3 _320 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _295.x, float3(0.0), float3(1.0));
    float _326 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _327 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_305 <= 0.0) ? 0.0 : pow(_305, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _339 = ((_320 - (_320 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _346 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _320, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _349 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _354;
    if (_349)
    {
        _354 = _339 + (_346 * 0.449999988079071044921875);
    }
    else
    {
        _354 = _339;
    }
    float3 _356 = select(_346, float3(0.0), bool3(_349));
    uint2 _386 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _400 = (_284 * (2.0 * dot(_259, _284))) - _259;
    uint _405 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _386.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _386.x)) * 2u;
    float4 _424;
    _424 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _425;
    for (uint _427 = 0u; _427 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_405)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _424 = _425, _427++)
    {
        if (_424.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _438 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_405 + 1u))).x + _427)));
        uint _439 = _438.x;
        float3 _445 = _257 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_439].xyz;
        float _446 = dot(_445, _445);
        float _447 = sqrt(_446);
        if (_447 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_439].w)
        {
            float _538;
            float3 _539;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_439].z > 0.0)
            {
                float3 _495 = (ReflectionCapture.ReflectionCapture_BoxTransform[_439] * float4(_257, 1.0)).xyz;
                float3 _501 = (ReflectionCapture.ReflectionCapture_BoxTransform[_439] * float4(_400, 0.0)).xyz;
                float3 _502 = float3(1.0) / _501;
                float3 _504 = _495 * _502;
                float3 _507 = fast::max((float3(-1.0) / _501) - _504, _502 - _504);
                float3 _521 = ReflectionCapture.ReflectionCapture_BoxScales[_439].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_439].w);
                float3 _522 = -_521;
                float3 _523 = _495 * ReflectionCapture.ReflectionCapture_BoxScales[_439].xyz;
                _538 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_439].w, dot(select(float3(0.0), abs(_523 - _522), _523 < _522), float3(1.0)) + dot(select(float3(0.0), abs(_523 - _521), _523 > _521), float3(1.0)));
                _539 = (_257 + (_400 * fast::min(_507.x, fast::min(_507.y, _507.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_439].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_439].xyz);
            }
            else
            {
                float _463 = dot(_400, _445);
                float _466 = (_463 * _463) - (_446 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_439].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_439].w));
                float _483;
                float3 _484;
                if (_466 >= 0.0)
                {
                    float _477 = fast::clamp((2.5 * fast::clamp(_447 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_439].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _483 = 1.0 - ((_477 * _477) * (3.0 - (2.0 * _477)));
                    _484 = (_445 + (_400 * (sqrt(_466) - _463))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_439].xyz;
                }
                else
                {
                    _483 = 0.0;
                    _484 = _400;
                }
                _538 = _483;
                _539 = _484;
            }
            float4 _546 = float4(_539, ReflectionCapture.ReflectionCapture_CaptureProperties[_439].y);
            float4 _548 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _546.xyz, uint(round(_546.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - (1.0 - (1.2000000476837158203125 * log2(fast::max(_326, 0.001000000047497451305389404296875))))));
            float3 _551 = _548.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_439].x;
            float4 _553 = float4(_551.x, _551.y, _551.z, _548.w) * _538;
            float3 _558 = _424.xyz + ((_553.xyz * _424.w) * 1.0);
            float4 _563 = float4(_558.x, _558.y, _558.z, _424.w);
            _563.w = _424.w * (1.0 - _553.w);
            _425 = _563;
        }
        else
        {
            _425 = _424;
        }
    }
    float3 _582 = ((_424.xyz * View.View_IndirectLightingColorScale).xyz * mix(1.0, fast::min(0.0, View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_326 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz;
    float4 _584 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _326) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _585 = _584.x;
    float2 _595 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_585 * _585, exp2((-9.27999973297119140625) * fast::clamp(_301, 0.0, 1.0))) * _585) + _584.y)) + _584.zw;
    float3 _731;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _631 = _257 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _667 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_257, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_631, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_631, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _284) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_326 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _725;
        if (_667 > 0.0)
        {
            float4 _696 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_257 + (reflect(reflect(normalize(_257 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _284).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _703;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _703 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _703 = 0u;
            }
            float4 _720 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_696.xy / float2(_696.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_703].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_703].zw), level(0.0));
            float4 _724 = float4(_720.x, _720.y, _720.z, float4(0.0).w);
            _724.w = _667 * _720.w;
            _725 = _724;
        }
        else
        {
            _725 = float4(0.0);
        }
        _731 = _725.xyz + (_582 * (1.0 - _725.w));
    }
    else
    {
        _731 = _582;
    }
    bool _749 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _798;
    if (_749)
    {
        float4 _756 = View.View_WorldToClip * float4(_257, 1.0);
        float _757 = _756.w;
        float4 _786;
        if (_749)
        {
            _786 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_756.xy / float2(_757)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_757 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _786 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _798 = float4(_786.xyz + (in.in_var_TEXCOORD7.xyz * _786.w), _786.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _798 = in.in_var_TEXCOORD7;
    }
    float3 _806 = (_257 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _814 = (_257 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _819 = fast::clamp((float3(0.5) - abs(_806 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _824 = (_819.x * _819.y) * _819.z;
    float4 _833 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _814, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _806, level(0.0)), float4(_824));
    float3 _844 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _814, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _806, level(0.0)).xyz, float3(_824)) * 1.0;
    float4 _846 = _194;
    _846.x = _833.x;
    float4 _848 = _194;
    _848.x = _833.y;
    float4 _850 = _194;
    _850.x = _833.z;
    float3 _851 = _833.xyz;
    float3 _855 = _851 / float3(dot(_851, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _857 = _844 * _855.x;
    float3 _860 = _844 * _855.y;
    float3 _863 = _844 * _855.z;
    float4 _867 = _194;
    _867.y = (-0.48860299587249755859375) * _284.y;
    float4 _870 = _867;
    _870.z = 0.48860299587249755859375 * _284.z;
    float4 _873 = _870;
    _873.w = (-0.48860299587249755859375) * _284.x;
    float4 _874 = _873;
    _874.x = 0.886227548122406005859375;
    float3 _876 = _874.yzw * 2.094395160675048828125;
    float4 _877 = float4(_874.x, _876.x, _876.y, _876.z);
    float3 _879 = _195;
    _879.x = dot(float4(_846.x, _857.x, _857.y, _857.z), _877);
    float3 _881 = _879;
    _881.y = dot(float4(_848.x, _860.x, _860.y, _860.z), _877);
    float3 _883 = _881;
    _883.z = dot(float4(_850.x, _863.x, _863.y, _863.z), _877);
    float _885 = _833.w;
    float3 _890 = float4(fast::max(float3(0.0), _883), _885).xyz;
    float3 _956;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _904 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_257, 1.0);
        float2 _908 = _904.xy / float2(_904.w);
        float _909 = _904.z;
        float4 _912 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _908, level(0.0));
        float3 _916 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _909;
        bool2 _941 = _908 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _943 = _908 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _956 = _354 * fast::max(_890 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _885) * (float3(1.0) - select(fast::clamp(exp((float3((((_912.x * _909) * 0.5) + dot((sin(_916) * _912.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_916)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _908, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_941.x || _943.x, _941.y || _943.y)))))), float3(0.0));
    }
    else
    {
        _956 = _354 * _890;
    }
    float3 _964 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _995;
    float3 _996;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _970 = in.in_var_PRIMITIVE_ID * 36u;
        bool _983 = any(abs(_257 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _970 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _970 + 19u)].xyz + float3(1.0)));
        float3 _993;
        if (_983)
        {
            _993 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_257, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _993 = _964;
        }
        _995 = _983 ? 1.0 : _327;
        _996 = _993;
    }
    else
    {
        _995 = _327;
        _996 = _964;
    }
    float4 _1005 = float4(((mix((((_731 * ((_356 * _595.x) + float3(fast::clamp(50.0 * _356.y, 0.0, 1.0) * _595.y))) * 1.0) * fast::max(float3(1.0), ((((((_356 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_356 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_356 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _956, _354 + (_356 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _996) * _798.w) + _798.xyz, _995);
    float3 _1009 = _1005.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1009.x, _1009.y, _1009.z, _1005.w);
    return out;
}

