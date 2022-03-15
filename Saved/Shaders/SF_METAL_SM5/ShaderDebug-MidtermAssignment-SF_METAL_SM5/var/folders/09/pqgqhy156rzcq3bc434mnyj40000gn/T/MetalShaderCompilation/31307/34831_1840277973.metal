

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
    char _m19_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m21_pad[120];
    float View_ReflectionCubemapMaxMip;
    char _m22_pad[20];
    packed_float3 View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight;
    int View_StereoPassIndex;
    char _m24_pad[160];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m26_pad[16];
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

constant float _213 = {};
constant float4 _214 = {};
constant float3 _215 = {};
constant float4 _217 = {};
constant float2 _218 = {};
constant float3 _219 = {};

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

fragment MainPS_out Main_0000880f_6db069d5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(10)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(11)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(12)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(13)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(16)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(17)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(18)]], texture2d<float> Material_Texture2D_0 [[texture(19)]], texture2d<float> Material_Texture2D_1 [[texture(20)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _283 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _287 = _283.xyz / float3(_283.w);
    float3 _288 = _287 - View.View_PreViewTranslation;
    float3 _290 = normalize(-_287);
    float4 _296 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _299 = (_296.xy * float2(2.0)) - float2(1.0);
    float3 _315 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_299, sqrt(fast::clamp(1.0 - dot(_299, _299), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _326 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _332 = dot(_315, _290);
    float _336 = fast::max(abs(1.0 - fast::max(0.0, _332)), 9.9999997473787516355514526367188e-05);
    float3 _351 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _326.x, float3(0.0), float3(1.0));
    float _357 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _358 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_336 <= 0.0) ? 0.0 : pow(_336, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _368 = fast::clamp((_288 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _379 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_368.x), int(_368.y), int(_368.z), 0).xyz), 0));
    float3 _394 = (((_379.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_368 / float3(_379.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _406 = ((_351 - (_351 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _413 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _351, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _416 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _421;
    if (_416)
    {
        _421 = _406 + (_413 * 0.449999988079071044921875);
    }
    else
    {
        _421 = _406;
    }
    float3 _423 = select(_413, float3(0.0), bool3(_416));
    float4 _427 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _394, level(0.0));
    float _443 = _427.x;
    float4 _445 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _443) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _446 = _427.y;
    float4 _448 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _446) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _449 = _427.z;
    float4 _451 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _449) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _468 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _443) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _470 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _446) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _472 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _394, level(0.0)) * 2.0) - float4(1.0)) * _449) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _503 = _315.y;
    float4 _505 = _217;
    _505.y = (-0.48860299587249755859375) * _503;
    float _506 = _315.z;
    float4 _508 = _505;
    _508.z = 0.48860299587249755859375 * _506;
    float _509 = _315.x;
    float4 _511 = _508;
    _511.w = (-0.48860299587249755859375) * _509;
    float3 _512 = _315 * _315;
    float4 _515 = _214;
    _515.x = (1.09254801273345947265625 * _509) * _503;
    float4 _518 = _515;
    _518.y = ((-1.09254801273345947265625) * _503) * _506;
    float4 _523 = _518;
    _523.z = 0.3153919875621795654296875 * ((3.0 * _512.z) - 1.0);
    float4 _526 = _523;
    _526.w = ((-1.09254801273345947265625) * _509) * _506;
    float4 _530 = _511;
    _530.x = 0.886227548122406005859375;
    float3 _532 = _530.yzw * 2.094395160675048828125;
    float4 _533 = float4(_530.x, _532.x, _532.y, _532.z);
    float4 _534 = _526 * 0.785398185253143310546875;
    float _535 = (_512.x - _512.y) * 0.4290426075458526611328125;
    float3 _541 = float3(0.0);
    _541.x = (dot(float4(_443, _445.xyz), _533) + dot(float4(_445.w, _468.xyz), _534)) + (_468.w * _535);
    float3 _547 = _541;
    _547.y = (dot(float4(_446, _448.xyz), _533) + dot(float4(_448.w, _470.xyz), _534)) + (_470.w * _535);
    float3 _553 = _547;
    _553.z = (dot(float4(_449, _451.xyz), _533) + dot(float4(_451.w, _472.xyz), _534)) + (_472.w * _535);
    float _582;
    float _583;
    float3 _584;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _569 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _394, level(0.0)).xyz * 2.0) - float3(1.0);
        float _570 = length(_569);
        float3 _573 = _569 / float3(fast::max(_570, 9.9999997473787516355514526367188e-05));
        float _574 = 1.0 - _570;
        float _576 = 1.0 - (_574 * _574);
        _582 = mix(fast::clamp(dot(_573, _315), 0.0, 1.0), 1.0, _576);
        _583 = _570;
        _584 = mix(_573, _315, float3(_576));
    }
    else
    {
        _582 = 1.0;
        _583 = 1.0;
        _584 = _315;
    }
    float4 _588 = float4(_584, 1.0);
    float3 _592 = _215;
    _592.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _588);
    float3 _596 = _592;
    _596.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _588);
    float3 _600 = _596;
    _600.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _588);
    float4 _603 = _588.xyzz * _588.yzzx;
    float3 _607 = _215;
    _607.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _603);
    float3 _611 = _607;
    _611.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _603);
    float3 _615 = _611;
    _615.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _603);
    float3 _630 = ((fast::max(float3(0.0), _553) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_600 + _615) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_584.x * _584.x) - (_584.y * _584.y)))) * View.View_SkyLightColor.xyz) * (_583 * _582));
    uint2 _675 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _689 = (_315 * (2.0 * dot(_290, _315))) - _290;
    uint _694 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _675.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _675.x)) * 2u;
    float _709 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_357, 0.001000000047497451305389404296875)));
    float2 _713;
    float4 _716;
    _713 = float2(0.0, 1.0);
    _716 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _714;
    float4 _717;
    for (uint _718 = 0u; _718 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_694)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _713 = _714, _716 = _717, _718++)
    {
        if (_716.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _729 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_694 + 1u))).x + _718)));
        uint _730 = _729.x;
        float3 _736 = _288 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_730].xyz;
        float _737 = dot(_736, _736);
        float _738 = sqrt(_737);
        if (_738 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_730].w)
        {
            float _829;
            float3 _830;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_730].z > 0.0)
            {
                float3 _786 = (ReflectionCapture.ReflectionCapture_BoxTransform[_730] * float4(_288, 1.0)).xyz;
                float3 _792 = (ReflectionCapture.ReflectionCapture_BoxTransform[_730] * float4(_689, 0.0)).xyz;
                float3 _793 = float3(1.0) / _792;
                float3 _795 = _786 * _793;
                float3 _798 = fast::max((float3(-1.0) / _792) - _795, _793 - _795);
                float3 _812 = ReflectionCapture.ReflectionCapture_BoxScales[_730].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_730].w);
                float3 _813 = -_812;
                float3 _814 = _786 * ReflectionCapture.ReflectionCapture_BoxScales[_730].xyz;
                _829 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_730].w, dot(select(float3(0.0), abs(_814 - _813), _814 < _813), float3(1.0)) + dot(select(float3(0.0), abs(_814 - _812), _814 > _812), float3(1.0)));
                _830 = (_288 + (_689 * fast::min(_798.x, fast::min(_798.y, _798.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_730].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_730].xyz);
            }
            else
            {
                float _754 = dot(_689, _736);
                float _757 = (_754 * _754) - (_737 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_730].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_730].w));
                float _774;
                float3 _775;
                if (_757 >= 0.0)
                {
                    float _768 = fast::clamp((2.5 * fast::clamp(_738 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_730].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _774 = 1.0 - ((_768 * _768) * (3.0 - (2.0 * _768)));
                    _775 = (_736 + (_689 * (sqrt(_757) - _754))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_730].xyz;
                }
                else
                {
                    _774 = 0.0;
                    _775 = _689;
                }
                _829 = _774;
                _830 = _775;
            }
            float4 _837 = float4(_830, ReflectionCapture.ReflectionCapture_CaptureProperties[_730].y);
            float4 _839 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _837.xyz, uint(round(_837.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _709));
            float3 _842 = _839.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_730].x;
            float4 _844 = float4(_842.x, _842.y, _842.z, _839.w) * _829;
            float3 _849 = _716.xyz + ((_844.xyz * _716.w) * 1.0);
            float4 _854 = float4(_849.x, _849.y, _849.z, _716.w);
            _854.w = _716.w * (1.0 - _844.w);
            float2 _861 = _218;
            _861.x = _713.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_730].w * _829) * _713.y);
            float2 _864 = _861;
            _864.y = _713.y * (1.0 - _829);
            _714 = _864;
            _717 = _854;
        }
        else
        {
            _714 = _713;
            _717 = _716;
        }
    }
    float3 _866 = _716.xyz * View.View_IndirectLightingColorScale;
    float4 _867 = float4(_866.x, _866.y, _866.z, _716.w);
    float _870 = _713.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _871 = _218;
    _871.x = _870;
    float4 _913;
    float2 _914;
    float3 _915;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _891 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _689, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _709)).xyz * View.View_SkyLightColor.xyz;
        float4 _910;
        float2 _911;
        float3 _912;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _904 = _866.xyz + ((_891 * _716.w) * 1.0);
            float2 _909 = _218;
            _909.x = _870 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _713.y);
            _910 = float4(_904.x, _904.y, _904.z, _716.w);
            _911 = _909;
            _912 = float3(0.0);
        }
        else
        {
            _910 = _867;
            _911 = _871;
            _912 = _891 * 1.0;
        }
        _913 = _910;
        _914 = _911;
        _915 = _912;
    }
    else
    {
        _913 = _867;
        _914 = _871;
        _915 = float3(0.0);
    }
    float3 _937 = ((_913.xyz * mix(1.0, fast::min(dot(_630, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_914.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_357 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_915 * _913.w)).xyz;
    float4 _939 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _357) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _940 = _939.x;
    float2 _950 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_940 * _940, exp2((-9.27999973297119140625) * fast::clamp(_332, 0.0, 1.0))) * _940) + _939.y)) + _939.zw;
    float3 _1086;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _986 = _288 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _1022 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_288, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_986, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_986, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _315) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_357 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _1080;
        if (_1022 > 0.0)
        {
            float4 _1051 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_288 + (reflect(reflect(normalize(_288 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _315).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _1058;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _1058 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _1058 = 0u;
            }
            float4 _1075 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_1051.xy / float2(_1051.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1058].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1058].zw), level(0.0));
            float4 _1079 = float4(_1075.x, _1075.y, _1075.z, float4(0.0).w);
            _1079.w = _1022 * _1075.w;
            _1080 = _1079;
        }
        else
        {
            _1080 = float4(0.0);
        }
        _1086 = _1080.xyz + (_937 * (1.0 - _1080.w));
    }
    else
    {
        _1086 = _937;
    }
    bool _1104 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1152;
    if (_1104)
    {
        float4 _1111 = View.View_WorldToClip * float4(_288, 1.0);
        float _1112 = _1111.w;
        float4 _1140;
        if (_1104)
        {
            _1140 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1111.xy / float2(_1112)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1112 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1140 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1152 = float4(_1140.xyz + (in.in_var_TEXCOORD7.xyz * _1140.w), _1140.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1152 = in.in_var_TEXCOORD7;
    }
    float3 _1160 = (_288 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1168 = (_288 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1173 = fast::clamp((float3(0.5) - abs(_1160 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1178 = (_1173.x * _1173.y) * _1173.z;
    float4 _1186 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1168, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1160, level(0.0)), float4(_1178));
    float3 _1197 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1168, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1160, level(0.0)).xyz, float3(_1178)) * 1.0;
    float4 _1199 = _217;
    _1199.x = _1186.x;
    float4 _1201 = _217;
    _1201.x = _1186.y;
    float4 _1203 = _217;
    _1203.x = _1186.z;
    float3 _1204 = _1186.xyz;
    float3 _1208 = _1204 / float3(dot(_1204, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1210 = _1197 * _1208.x;
    float3 _1213 = _1197 * _1208.y;
    float3 _1216 = _1197 * _1208.z;
    float3 _1219 = _219;
    _1219.x = dot(float4(_1199.x, _1210.x, _1210.y, _1210.z), _533);
    float3 _1221 = _1219;
    _1221.y = dot(float4(_1201.x, _1213.x, _1213.y, _1213.z), _533);
    float3 _1223 = _1221;
    _1223.z = dot(float4(_1203.x, _1216.x, _1216.y, _1216.z), _533);
    float3 _1238 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1269;
    float3 _1270;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1244 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1257 = any(abs(_288 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1244 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1244 + 19u)].xyz + float3(1.0)));
        float3 _1267;
        if (_1257)
        {
            _1267 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_288, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1267 = _1238;
        }
        _1269 = _1257 ? 1.0 : _358;
        _1270 = _1267;
    }
    else
    {
        _1269 = _358;
        _1270 = _1238;
    }
    float4 _1280 = float4((((mix((((_1086 * ((_423 * _950.x) + float3(fast::clamp(50.0 * _423.y, 0.0, 1.0) * _950.y))) * 1.0) * fast::max(float3(1.0), ((((((_423 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_423 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_423 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_421 * float4(fast::max(float3(0.0), _1223), _213).xyz), _421 + (_423 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_630 * _421) * fast::max(float3(1.0), ((((((_351 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_351 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_351 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1270) * _1152.w) + _1152.xyz, _1269);
    float3 _1284 = _1280.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1284.x, _1284.y, _1284.z, _1280.w);
    return out;
}

