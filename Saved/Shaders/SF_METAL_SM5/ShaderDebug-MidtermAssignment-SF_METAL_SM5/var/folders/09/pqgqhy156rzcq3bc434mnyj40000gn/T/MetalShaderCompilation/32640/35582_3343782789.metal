

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
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[120];
    float View_ReflectionCubemapMaxMip;
    char _m21_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m23_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m25_pad[16];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float4 _216 = {};
constant float3 _217 = {};
constant float4 _219 = {};
constant float2 _220 = {};
constant float3 _221 = {};

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

fragment MainPS_out Main_00008afe_c74e1385(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(10)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(11)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(12)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(13)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(16)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(17)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(18)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(19)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(20)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _281 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _285 = _281.xyz / float3(_281.w);
    float3 _286 = _285 - View.View_PreViewTranslation;
    float3 _288 = normalize(-_285);
    float3 _296 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _313 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _319 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _320 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _330 = fast::clamp((_286 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _341 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_330.x), int(_330.y), int(_330.z), 0).xyz), 0));
    float3 _356 = (((_341.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_330 / float3(_341.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _365 = (_313 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _372 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _375 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _380;
    if (_375)
    {
        _380 = _365 + (_372 * 0.449999988079071044921875);
    }
    else
    {
        _380 = _365;
    }
    float3 _382 = select(_372, float3(0.0), bool3(_375));
    float4 _386 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _356, level(0.0));
    float _402 = _386.x;
    float4 _404 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _402) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _405 = _386.y;
    float4 _407 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _405) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _408 = _386.z;
    float4 _410 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _408) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _427 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _402) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _429 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _405) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _431 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _356, level(0.0)) * 2.0) - float4(1.0)) * _408) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _462 = _296.y;
    float4 _464 = _219;
    _464.y = (-0.48860299587249755859375) * _462;
    float _465 = _296.z;
    float4 _467 = _464;
    _467.z = 0.48860299587249755859375 * _465;
    float _468 = _296.x;
    float4 _470 = _467;
    _470.w = (-0.48860299587249755859375) * _468;
    float3 _471 = _296 * _296;
    float4 _474 = _216;
    _474.x = (1.09254801273345947265625 * _468) * _462;
    float4 _477 = _474;
    _477.y = ((-1.09254801273345947265625) * _462) * _465;
    float4 _482 = _477;
    _482.z = 0.3153919875621795654296875 * ((3.0 * _471.z) - 1.0);
    float4 _485 = _482;
    _485.w = ((-1.09254801273345947265625) * _468) * _465;
    float4 _489 = _470;
    _489.x = 0.886227548122406005859375;
    float3 _491 = _489.yzw * 2.094395160675048828125;
    float4 _492 = float4(_489.x, _491.x, _491.y, _491.z);
    float4 _493 = _485 * 0.785398185253143310546875;
    float _494 = (_471.x - _471.y) * 0.4290426075458526611328125;
    float3 _500 = float3(0.0);
    _500.x = (dot(float4(_402, _404.xyz), _492) + dot(float4(_404.w, _427.xyz), _493)) + (_427.w * _494);
    float3 _506 = _500;
    _506.y = (dot(float4(_405, _407.xyz), _492) + dot(float4(_407.w, _429.xyz), _493)) + (_429.w * _494);
    float3 _512 = _506;
    _512.z = (dot(float4(_408, _410.xyz), _492) + dot(float4(_410.w, _431.xyz), _493)) + (_431.w * _494);
    float _541;
    float _542;
    float3 _543;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _528 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _356, level(0.0)).xyz * 2.0) - float3(1.0);
        float _529 = length(_528);
        float3 _532 = _528 / float3(fast::max(_529, 9.9999997473787516355514526367188e-05));
        float _533 = 1.0 - _529;
        float _535 = 1.0 - (_533 * _533);
        _541 = mix(fast::clamp(dot(_532, _296), 0.0, 1.0), 1.0, _535);
        _542 = _529;
        _543 = mix(_532, _296, float3(_535));
    }
    else
    {
        _541 = 1.0;
        _542 = 1.0;
        _543 = _296;
    }
    float4 _547 = float4(_543, 1.0);
    float3 _551 = _217;
    _551.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _547);
    float3 _555 = _551;
    _555.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _547);
    float3 _559 = _555;
    _559.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _547);
    float4 _562 = _547.xyzz * _547.yzzx;
    float3 _566 = _217;
    _566.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _562);
    float3 _570 = _566;
    _570.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _562);
    float3 _574 = _570;
    _574.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _562);
    float3 _589 = ((fast::max(float3(0.0), _512) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_559 + _574) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_543.x * _543.x) - (_543.y * _543.y)))) * View.View_SkyLightColor.xyz) * (_542 * _541));
    uint2 _634 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _648 = (_296 * (2.0 * dot(_288, _296))) - _288;
    uint _654 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _634.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _634.x)) * 2u;
    float _669 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_319, 0.001000000047497451305389404296875)));
    float2 _673;
    float4 _676;
    _673 = float2(0.0, 1.0);
    _676 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _674;
    float4 _677;
    for (uint _678 = 0u; _678 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_654)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _673 = _674, _676 = _677, _678++)
    {
        if (_676.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _689 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_654 + 1u))).x + _678)));
        uint _690 = _689.x;
        float3 _696 = _286 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_690].xyz;
        float _697 = dot(_696, _696);
        float _698 = sqrt(_697);
        if (_698 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_690].w)
        {
            float _789;
            float3 _790;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_690].z > 0.0)
            {
                float3 _746 = (ReflectionCapture.ReflectionCapture_BoxTransform[_690] * float4(_286, 1.0)).xyz;
                float3 _752 = (ReflectionCapture.ReflectionCapture_BoxTransform[_690] * float4(_648, 0.0)).xyz;
                float3 _753 = float3(1.0) / _752;
                float3 _755 = _746 * _753;
                float3 _758 = fast::max((float3(-1.0) / _752) - _755, _753 - _755);
                float3 _772 = ReflectionCapture.ReflectionCapture_BoxScales[_690].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_690].w);
                float3 _773 = -_772;
                float3 _774 = _746 * ReflectionCapture.ReflectionCapture_BoxScales[_690].xyz;
                _789 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_690].w, dot(select(float3(0.0), abs(_774 - _773), _774 < _773), float3(1.0)) + dot(select(float3(0.0), abs(_774 - _772), _774 > _772), float3(1.0)));
                _790 = (_286 + (_648 * fast::min(_758.x, fast::min(_758.y, _758.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_690].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_690].xyz);
            }
            else
            {
                float _714 = dot(_648, _696);
                float _717 = (_714 * _714) - (_697 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_690].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_690].w));
                float _734;
                float3 _735;
                if (_717 >= 0.0)
                {
                    float _728 = fast::clamp((2.5 * fast::clamp(_698 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_690].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _734 = 1.0 - ((_728 * _728) * (3.0 - (2.0 * _728)));
                    _735 = (_696 + (_648 * (sqrt(_717) - _714))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_690].xyz;
                }
                else
                {
                    _734 = 0.0;
                    _735 = _648;
                }
                _789 = _734;
                _790 = _735;
            }
            float4 _797 = float4(_790, ReflectionCapture.ReflectionCapture_CaptureProperties[_690].y);
            float4 _799 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _797.xyz, uint(round(_797.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _669));
            float3 _802 = _799.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_690].x;
            float4 _804 = float4(_802.x, _802.y, _802.z, _799.w) * _789;
            float3 _809 = _676.xyz + ((_804.xyz * _676.w) * 1.0);
            float4 _814 = float4(_809.x, _809.y, _809.z, _676.w);
            _814.w = _676.w * (1.0 - _804.w);
            float2 _821 = _220;
            _821.x = _673.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_690].w * _789) * _673.y);
            float2 _824 = _821;
            _824.y = _673.y * (1.0 - _789);
            _674 = _824;
            _677 = _814;
        }
        else
        {
            _674 = _673;
            _677 = _676;
        }
    }
    float3 _826 = _676.xyz * View.View_IndirectLightingColorScale;
    float4 _827 = float4(_826.x, _826.y, _826.z, _676.w);
    float _830 = _673.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _831 = _220;
    _831.x = _830;
    float4 _873;
    float2 _874;
    float3 _875;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _851 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _648, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _669)).xyz * View.View_SkyLightColor.xyz;
        float4 _870;
        float2 _871;
        float3 _872;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _864 = _826.xyz + ((_851 * _676.w) * 1.0);
            float2 _869 = _220;
            _869.x = _830 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _673.y);
            _870 = float4(_864.x, _864.y, _864.z, _676.w);
            _871 = _869;
            _872 = float3(0.0);
        }
        else
        {
            _870 = _827;
            _871 = _831;
            _872 = _851 * 1.0;
        }
        _873 = _870;
        _874 = _871;
        _875 = _872;
    }
    else
    {
        _873 = _827;
        _874 = _831;
        _875 = float3(0.0);
    }
    float3 _897 = ((_873.xyz * mix(1.0, fast::min(dot(_589, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_874.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_319 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_875 * _873.w)).xyz;
    float4 _899 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _319) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _900 = _899.x;
    float2 _910 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_900 * _900, exp2((-9.27999973297119140625) * fast::clamp(dot(_296, _288), 0.0, 1.0))) * _900) + _899.y)) + _899.zw;
    float3 _1046;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _946 = _286 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _982 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_286, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_946, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_946, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _296) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_319 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _1040;
        if (_982 > 0.0)
        {
            float4 _1011 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_286 + (reflect(reflect(normalize(_286 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _296).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _1018;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _1018 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _1018 = 0u;
            }
            float4 _1035 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_1011.xy / float2(_1011.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1018].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1018].zw), level(0.0));
            float4 _1039 = float4(_1035.x, _1035.y, _1035.z, float4(0.0).w);
            _1039.w = _982 * _1035.w;
            _1040 = _1039;
        }
        else
        {
            _1040 = float4(0.0);
        }
        _1046 = _1040.xyz + (_897 * (1.0 - _1040.w));
    }
    else
    {
        _1046 = _897;
    }
    bool _1064 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1112;
    if (_1064)
    {
        float4 _1071 = View.View_WorldToClip * float4(_286, 1.0);
        float _1072 = _1071.w;
        float4 _1100;
        if (_1064)
        {
            _1100 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1071.xy / float2(_1072)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1072 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1100 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1112 = float4(_1100.xyz + (in.in_var_TEXCOORD7.xyz * _1100.w), _1100.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1112 = in.in_var_TEXCOORD7;
    }
    float3 _1120 = (_286 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1128 = (_286 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1133 = fast::clamp((float3(0.5) - abs(_1120 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1138 = (_1133.x * _1133.y) * _1133.z;
    float4 _1146 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1128, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1120, level(0.0)), float4(_1138));
    float3 _1157 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1128, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1120, level(0.0)).xyz, float3(_1138)) * 1.0;
    float4 _1159 = _219;
    _1159.x = _1146.x;
    float4 _1161 = _219;
    _1161.x = _1146.y;
    float4 _1163 = _219;
    _1163.x = _1146.z;
    float3 _1164 = _1146.xyz;
    float3 _1168 = _1164 / float3(dot(_1164, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1170 = _1157 * _1168.x;
    float3 _1173 = _1157 * _1168.y;
    float3 _1176 = _1157 * _1168.z;
    float3 _1179 = _221;
    _1179.x = dot(float4(_1159.x, _1170.x, _1170.y, _1170.z), _492);
    float3 _1181 = _1179;
    _1181.y = dot(float4(_1161.x, _1173.x, _1173.y, _1173.z), _492);
    float3 _1183 = _1181;
    _1183.z = dot(float4(_1163.x, _1176.x, _1176.y, _1176.z), _492);
    float _1185 = _1146.w;
    float3 _1190 = float4(fast::max(float3(0.0), _1183), _1185).xyz;
    float3 _1256;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1204 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_286, 1.0);
        float2 _1208 = _1204.xy / float2(_1204.w);
        float _1209 = _1204.z;
        float4 _1212 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1208, level(0.0));
        float3 _1216 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1209;
        bool2 _1241 = _1208 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1243 = _1208 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1256 = _380 * fast::max(_1190 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _1185) * (float3(1.0) - select(fast::clamp(exp((float3((((_1212.x * _1209) * 0.5) + dot((sin(_1216) * _1212.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1216)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1208, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1241.x || _1243.x, _1241.y || _1243.y)))))), float3(0.0));
    }
    else
    {
        _1256 = _380 * _1190;
    }
    float3 _1264 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1295;
    float3 _1296;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1270 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1283 = any(abs(_286 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1270 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1270 + 19u)].xyz + float3(1.0)));
        float3 _1293;
        if (_1283)
        {
            _1293 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_286, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1293 = _1264;
        }
        _1295 = _1283 ? 1.0 : _320;
        _1296 = _1293;
    }
    else
    {
        _1295 = _320;
        _1296 = _1264;
    }
    float4 _1306 = float4((((mix((((_1046 * ((_382 * _910.x) + float3(fast::clamp(50.0 * _382.y, 0.0, 1.0) * _910.y))) * 1.0) * fast::max(float3(1.0), ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1256, _380 + (_382 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_589 * _380) * fast::max(float3(1.0), ((((((_313 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_313 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_313 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1296) * _1112.w) + _1112.xyz, _1295);
    float3 _1310 = _1306.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1310.x, _1310.y, _1310.z, _1306.w);
    return out;
}

