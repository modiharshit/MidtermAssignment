

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

constant float4 _230 = {};
constant float3 _231 = {};
constant float4 _233 = {};
constant float2 _234 = {};
constant float3 _235 = {};

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

fragment MainPS_out Main_00009055_868b5a85(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(10)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(11)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(12)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(13)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(16)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(17)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(18)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(19)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(20)]], texture2d<float> Material_Texture2D_0 [[texture(21)]], texture2d<float> Material_Texture2D_1 [[texture(22)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _299 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _303 = _299.xyz / float3(_299.w);
    float3 _304 = _303 - View.View_PreViewTranslation;
    float3 _306 = normalize(-_303);
    float4 _312 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _315 = (_312.xy * float2(2.0)) - float2(1.0);
    float3 _331 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_315, sqrt(fast::clamp(1.0 - dot(_315, _315), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _342 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _348 = dot(_331, _306);
    float _352 = fast::max(abs(1.0 - fast::max(0.0, _348)), 9.9999997473787516355514526367188e-05);
    float3 _367 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _342.x, float3(0.0), float3(1.0));
    float _373 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _374 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_352 <= 0.0) ? 0.0 : pow(_352, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _384 = fast::clamp((_304 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _395 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_384.x), int(_384.y), int(_384.z), 0).xyz), 0));
    float3 _410 = (((_395.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_384 / float3(_395.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _422 = ((_367 - (_367 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _429 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _367, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _432 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _437;
    if (_432)
    {
        _437 = _422 + (_429 * 0.449999988079071044921875);
    }
    else
    {
        _437 = _422;
    }
    float3 _439 = select(_429, float3(0.0), bool3(_432));
    float4 _443 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _410, level(0.0));
    float _459 = _443.x;
    float4 _461 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _410, level(0.0)) * 2.0) - float4(1.0)) * _459) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _462 = _443.y;
    float4 _464 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _410, level(0.0)) * 2.0) - float4(1.0)) * _462) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _465 = _443.z;
    float4 _467 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _410, level(0.0)) * 2.0) - float4(1.0)) * _465) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _484 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _410, level(0.0)) * 2.0) - float4(1.0)) * _459) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _486 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _410, level(0.0)) * 2.0) - float4(1.0)) * _462) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _488 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _410, level(0.0)) * 2.0) - float4(1.0)) * _465) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _519 = _331.y;
    float4 _521 = _233;
    _521.y = (-0.48860299587249755859375) * _519;
    float _522 = _331.z;
    float4 _524 = _521;
    _524.z = 0.48860299587249755859375 * _522;
    float _525 = _331.x;
    float4 _527 = _524;
    _527.w = (-0.48860299587249755859375) * _525;
    float3 _528 = _331 * _331;
    float4 _531 = _230;
    _531.x = (1.09254801273345947265625 * _525) * _519;
    float4 _534 = _531;
    _534.y = ((-1.09254801273345947265625) * _519) * _522;
    float4 _539 = _534;
    _539.z = 0.3153919875621795654296875 * ((3.0 * _528.z) - 1.0);
    float4 _542 = _539;
    _542.w = ((-1.09254801273345947265625) * _525) * _522;
    float4 _546 = _527;
    _546.x = 0.886227548122406005859375;
    float3 _548 = _546.yzw * 2.094395160675048828125;
    float4 _549 = float4(_546.x, _548.x, _548.y, _548.z);
    float4 _550 = _542 * 0.785398185253143310546875;
    float _551 = (_528.x - _528.y) * 0.4290426075458526611328125;
    float3 _557 = float3(0.0);
    _557.x = (dot(float4(_459, _461.xyz), _549) + dot(float4(_461.w, _484.xyz), _550)) + (_484.w * _551);
    float3 _563 = _557;
    _563.y = (dot(float4(_462, _464.xyz), _549) + dot(float4(_464.w, _486.xyz), _550)) + (_486.w * _551);
    float3 _569 = _563;
    _569.z = (dot(float4(_465, _467.xyz), _549) + dot(float4(_467.w, _488.xyz), _550)) + (_488.w * _551);
    float _598;
    float _599;
    float3 _600;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _585 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _410, level(0.0)).xyz * 2.0) - float3(1.0);
        float _586 = length(_585);
        float3 _589 = _585 / float3(fast::max(_586, 9.9999997473787516355514526367188e-05));
        float _590 = 1.0 - _586;
        float _592 = 1.0 - (_590 * _590);
        _598 = mix(fast::clamp(dot(_589, _331), 0.0, 1.0), 1.0, _592);
        _599 = _586;
        _600 = mix(_589, _331, float3(_592));
    }
    else
    {
        _598 = 1.0;
        _599 = 1.0;
        _600 = _331;
    }
    float4 _604 = float4(_600, 1.0);
    float3 _608 = _231;
    _608.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _604);
    float3 _612 = _608;
    _612.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _604);
    float3 _616 = _612;
    _616.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _604);
    float4 _619 = _604.xyzz * _604.yzzx;
    float3 _623 = _231;
    _623.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _619);
    float3 _627 = _623;
    _627.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _619);
    float3 _631 = _627;
    _631.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _619);
    float3 _646 = ((fast::max(float3(0.0), _569) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_616 + _631) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_600.x * _600.x) - (_600.y * _600.y)))) * View.View_SkyLightColor.xyz) * (_599 * _598));
    uint2 _691 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _705 = (_331 * (2.0 * dot(_306, _331))) - _306;
    uint _710 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _691.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _691.x)) * 2u;
    float _725 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_373, 0.001000000047497451305389404296875)));
    float2 _729;
    float4 _732;
    _729 = float2(0.0, 1.0);
    _732 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _730;
    float4 _733;
    for (uint _734 = 0u; _734 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_710)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _729 = _730, _732 = _733, _734++)
    {
        if (_732.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _745 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_710 + 1u))).x + _734)));
        uint _746 = _745.x;
        float3 _752 = _304 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_746].xyz;
        float _753 = dot(_752, _752);
        float _754 = sqrt(_753);
        if (_754 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_746].w)
        {
            float _845;
            float3 _846;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_746].z > 0.0)
            {
                float3 _802 = (ReflectionCapture.ReflectionCapture_BoxTransform[_746] * float4(_304, 1.0)).xyz;
                float3 _808 = (ReflectionCapture.ReflectionCapture_BoxTransform[_746] * float4(_705, 0.0)).xyz;
                float3 _809 = float3(1.0) / _808;
                float3 _811 = _802 * _809;
                float3 _814 = fast::max((float3(-1.0) / _808) - _811, _809 - _811);
                float3 _828 = ReflectionCapture.ReflectionCapture_BoxScales[_746].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_746].w);
                float3 _829 = -_828;
                float3 _830 = _802 * ReflectionCapture.ReflectionCapture_BoxScales[_746].xyz;
                _845 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_746].w, dot(select(float3(0.0), abs(_830 - _829), _830 < _829), float3(1.0)) + dot(select(float3(0.0), abs(_830 - _828), _830 > _828), float3(1.0)));
                _846 = (_304 + (_705 * fast::min(_814.x, fast::min(_814.y, _814.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_746].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_746].xyz);
            }
            else
            {
                float _770 = dot(_705, _752);
                float _773 = (_770 * _770) - (_753 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_746].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_746].w));
                float _790;
                float3 _791;
                if (_773 >= 0.0)
                {
                    float _784 = fast::clamp((2.5 * fast::clamp(_754 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_746].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _790 = 1.0 - ((_784 * _784) * (3.0 - (2.0 * _784)));
                    _791 = (_752 + (_705 * (sqrt(_773) - _770))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_746].xyz;
                }
                else
                {
                    _790 = 0.0;
                    _791 = _705;
                }
                _845 = _790;
                _846 = _791;
            }
            float4 _853 = float4(_846, ReflectionCapture.ReflectionCapture_CaptureProperties[_746].y);
            float4 _855 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _853.xyz, uint(round(_853.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _725));
            float3 _858 = _855.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_746].x;
            float4 _860 = float4(_858.x, _858.y, _858.z, _855.w) * _845;
            float3 _865 = _732.xyz + ((_860.xyz * _732.w) * 1.0);
            float4 _870 = float4(_865.x, _865.y, _865.z, _732.w);
            _870.w = _732.w * (1.0 - _860.w);
            float2 _877 = _234;
            _877.x = _729.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_746].w * _845) * _729.y);
            float2 _880 = _877;
            _880.y = _729.y * (1.0 - _845);
            _730 = _880;
            _733 = _870;
        }
        else
        {
            _730 = _729;
            _733 = _732;
        }
    }
    float3 _882 = _732.xyz * View.View_IndirectLightingColorScale;
    float4 _883 = float4(_882.x, _882.y, _882.z, _732.w);
    float _886 = _729.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _887 = _234;
    _887.x = _886;
    float4 _929;
    float2 _930;
    float3 _931;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _907 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _705, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _725)).xyz * View.View_SkyLightColor.xyz;
        float4 _926;
        float2 _927;
        float3 _928;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _920 = _882.xyz + ((_907 * _732.w) * 1.0);
            float2 _925 = _234;
            _925.x = _886 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _729.y);
            _926 = float4(_920.x, _920.y, _920.z, _732.w);
            _927 = _925;
            _928 = float3(0.0);
        }
        else
        {
            _926 = _883;
            _927 = _887;
            _928 = _907 * 1.0;
        }
        _929 = _926;
        _930 = _927;
        _931 = _928;
    }
    else
    {
        _929 = _883;
        _930 = _887;
        _931 = float3(0.0);
    }
    float3 _953 = ((_929.xyz * mix(1.0, fast::min(dot(_646, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_930.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_373 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_931 * _929.w)).xyz;
    float4 _955 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _373) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _956 = _955.x;
    float2 _966 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_956 * _956, exp2((-9.27999973297119140625) * fast::clamp(_348, 0.0, 1.0))) * _956) + _955.y)) + _955.zw;
    float3 _1102;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _1002 = _304 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _1038 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_304, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_1002, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_1002, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _331) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_373 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _1096;
        if (_1038 > 0.0)
        {
            float4 _1067 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_304 + (reflect(reflect(normalize(_304 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _331).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _1074;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _1074 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _1074 = 0u;
            }
            float4 _1091 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_1067.xy / float2(_1067.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1074].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1074].zw), level(0.0));
            float4 _1095 = float4(_1091.x, _1091.y, _1091.z, float4(0.0).w);
            _1095.w = _1038 * _1091.w;
            _1096 = _1095;
        }
        else
        {
            _1096 = float4(0.0);
        }
        _1102 = _1096.xyz + (_953 * (1.0 - _1096.w));
    }
    else
    {
        _1102 = _953;
    }
    bool _1120 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1168;
    if (_1120)
    {
        float4 _1127 = View.View_WorldToClip * float4(_304, 1.0);
        float _1128 = _1127.w;
        float4 _1156;
        if (_1120)
        {
            _1156 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1127.xy / float2(_1128)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1128 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1156 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1168 = float4(_1156.xyz + (in.in_var_TEXCOORD7.xyz * _1156.w), _1156.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1168 = in.in_var_TEXCOORD7;
    }
    float3 _1176 = (_304 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1184 = (_304 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1189 = fast::clamp((float3(0.5) - abs(_1176 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1194 = (_1189.x * _1189.y) * _1189.z;
    float4 _1202 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1184, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1176, level(0.0)), float4(_1194));
    float3 _1213 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1184, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1176, level(0.0)).xyz, float3(_1194)) * 1.0;
    float4 _1215 = _233;
    _1215.x = _1202.x;
    float4 _1217 = _233;
    _1217.x = _1202.y;
    float4 _1219 = _233;
    _1219.x = _1202.z;
    float3 _1220 = _1202.xyz;
    float3 _1224 = _1220 / float3(dot(_1220, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1226 = _1213 * _1224.x;
    float3 _1229 = _1213 * _1224.y;
    float3 _1232 = _1213 * _1224.z;
    float3 _1235 = _235;
    _1235.x = dot(float4(_1215.x, _1226.x, _1226.y, _1226.z), _549);
    float3 _1237 = _1235;
    _1237.y = dot(float4(_1217.x, _1229.x, _1229.y, _1229.z), _549);
    float3 _1239 = _1237;
    _1239.z = dot(float4(_1219.x, _1232.x, _1232.y, _1232.z), _549);
    float _1241 = _1202.w;
    float3 _1246 = float4(fast::max(float3(0.0), _1239), _1241).xyz;
    float3 _1312;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _1260 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_304, 1.0);
        float2 _1264 = _1260.xy / float2(_1260.w);
        float _1265 = _1260.z;
        float4 _1268 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _1264, level(0.0));
        float3 _1272 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _1265;
        bool2 _1297 = _1264 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _1299 = _1264 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _1312 = _437 * fast::max(_1246 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _1241) * (float3(1.0) - select(fast::clamp(exp((float3((((_1268.x * _1265) * 0.5) + dot((sin(_1272) * _1268.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_1272)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _1264, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_1297.x || _1299.x, _1297.y || _1299.y)))))), float3(0.0));
    }
    else
    {
        _1312 = _437 * _1246;
    }
    float3 _1320 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1351;
    float3 _1352;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1326 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1339 = any(abs(_304 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1326 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1326 + 19u)].xyz + float3(1.0)));
        float3 _1349;
        if (_1339)
        {
            _1349 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_304, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1349 = _1320;
        }
        _1351 = _1339 ? 1.0 : _374;
        _1352 = _1349;
    }
    else
    {
        _1351 = _374;
        _1352 = _1320;
    }
    float4 _1362 = float4((((mix((((_1102 * ((_439 * _966.x) + float3(fast::clamp(50.0 * _439.y, 0.0, 1.0) * _966.y))) * 1.0) * fast::max(float3(1.0), ((((((_439 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_439 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_439 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + _1312, _437 + (_439 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_646 * _437) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1352) * _1168.w) + _1168.xyz, _1351);
    float3 _1366 = _1362.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1366.x, _1366.y, _1366.z, _1362.w);
    return out;
}

