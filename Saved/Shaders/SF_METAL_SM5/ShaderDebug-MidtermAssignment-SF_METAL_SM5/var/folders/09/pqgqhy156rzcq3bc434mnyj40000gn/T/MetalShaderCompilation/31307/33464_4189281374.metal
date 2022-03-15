

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

constant float _199 = {};
constant float4 _200 = {};
constant float3 _201 = {};
constant float4 _203 = {};
constant float2 _204 = {};
constant float3 _205 = {};

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

fragment MainPS_out Main_000082b8_f9b35c5e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(6)]], constant type_Material& Material [[buffer(7)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(7)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(8)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(9)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(10)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(11)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(12)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(13)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(14)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(15)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(16)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(17)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(18)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _265 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _269 = _265.xyz / float3(_265.w);
    float3 _270 = _269 - View.View_PreViewTranslation;
    float3 _272 = normalize(-_269);
    float3 _280 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _297 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _303 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _304 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float3 _314 = fast::clamp((_270 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _325 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_314.x), int(_314.y), int(_314.z), 0).xyz), 0));
    float3 _340 = (((_325.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_314 / float3(_325.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _349 = (_297 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _356 = (float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    float4 _370 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _340, level(0.0));
    float _386 = _370.x;
    float4 _388 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _386) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _389 = _370.y;
    float4 _391 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _389) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _392 = _370.z;
    float4 _394 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _392) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _411 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _386) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _413 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _389) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _415 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _392) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _446 = _280.y;
    float4 _448 = _203;
    _448.y = (-0.48860299587249755859375) * _446;
    float _449 = _280.z;
    float4 _451 = _448;
    _451.z = 0.48860299587249755859375 * _449;
    float _452 = _280.x;
    float4 _454 = _451;
    _454.w = (-0.48860299587249755859375) * _452;
    float3 _455 = _280 * _280;
    float4 _458 = _200;
    _458.x = (1.09254801273345947265625 * _452) * _446;
    float4 _461 = _458;
    _461.y = ((-1.09254801273345947265625) * _446) * _449;
    float4 _466 = _461;
    _466.z = 0.3153919875621795654296875 * ((3.0 * _455.z) - 1.0);
    float4 _469 = _466;
    _469.w = ((-1.09254801273345947265625) * _452) * _449;
    float4 _473 = _454;
    _473.x = 0.886227548122406005859375;
    float3 _475 = _473.yzw * 2.094395160675048828125;
    float4 _476 = float4(_473.x, _475.x, _475.y, _475.z);
    float4 _477 = _469 * 0.785398185253143310546875;
    float _478 = (_455.x - _455.y) * 0.4290426075458526611328125;
    float3 _484 = float3(0.0);
    _484.x = (dot(float4(_386, _388.xyz), _476) + dot(float4(_388.w, _411.xyz), _477)) + (_411.w * _478);
    float3 _490 = _484;
    _490.y = (dot(float4(_389, _391.xyz), _476) + dot(float4(_391.w, _413.xyz), _477)) + (_413.w * _478);
    float3 _496 = _490;
    _496.z = (dot(float4(_392, _394.xyz), _476) + dot(float4(_394.w, _415.xyz), _477)) + (_415.w * _478);
    float _525;
    float _526;
    float3 _527;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _512 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _340, level(0.0)).xyz * 2.0) - float3(1.0);
        float _513 = length(_512);
        float3 _516 = _512 / float3(fast::max(_513, 9.9999997473787516355514526367188e-05));
        float _517 = 1.0 - _513;
        float _519 = 1.0 - (_517 * _517);
        _525 = mix(fast::clamp(dot(_516, _280), 0.0, 1.0), 1.0, _519);
        _526 = _513;
        _527 = mix(_516, _280, float3(_519));
    }
    else
    {
        _525 = 1.0;
        _526 = 1.0;
        _527 = _280;
    }
    float4 _531 = float4(_527, 1.0);
    float3 _535 = _201;
    _535.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _531);
    float3 _539 = _535;
    _539.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _531);
    float3 _543 = _539;
    _543.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _531);
    float4 _546 = _531.xyzz * _531.yzzx;
    float3 _550 = _201;
    _550.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _546);
    float3 _554 = _550;
    _554.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _546);
    float3 _558 = _554;
    _558.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _546);
    float3 _573 = ((fast::max(float3(0.0), _496) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_543 + _558) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_527.x * _527.x) - (_527.y * _527.y)))) * View.View_SkyLightColor.xyz) * (_526 * _525));
    uint2 _618 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _632 = (_280 * (2.0 * dot(_272, _280))) - _272;
    uint _638 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _618.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _618.x)) * 2u;
    float _653 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_303, 0.001000000047497451305389404296875)));
    float2 _657;
    float4 _660;
    _657 = float2(0.0, 1.0);
    _660 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _658;
    float4 _661;
    for (uint _662 = 0u; _662 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_638)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _657 = _658, _660 = _661, _662++)
    {
        if (_660.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _673 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_638 + 1u))).x + _662)));
        uint _674 = _673.x;
        float3 _680 = _270 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_674].xyz;
        float _681 = dot(_680, _680);
        float _682 = sqrt(_681);
        if (_682 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_674].w)
        {
            float _773;
            float3 _774;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_674].z > 0.0)
            {
                float3 _730 = (ReflectionCapture.ReflectionCapture_BoxTransform[_674] * float4(_270, 1.0)).xyz;
                float3 _736 = (ReflectionCapture.ReflectionCapture_BoxTransform[_674] * float4(_632, 0.0)).xyz;
                float3 _737 = float3(1.0) / _736;
                float3 _739 = _730 * _737;
                float3 _742 = fast::max((float3(-1.0) / _736) - _739, _737 - _739);
                float3 _756 = ReflectionCapture.ReflectionCapture_BoxScales[_674].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_674].w);
                float3 _757 = -_756;
                float3 _758 = _730 * ReflectionCapture.ReflectionCapture_BoxScales[_674].xyz;
                _773 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_674].w, dot(select(float3(0.0), abs(_758 - _757), _758 < _757), float3(1.0)) + dot(select(float3(0.0), abs(_758 - _756), _758 > _756), float3(1.0)));
                _774 = (_270 + (_632 * fast::min(_742.x, fast::min(_742.y, _742.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_674].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_674].xyz);
            }
            else
            {
                float _698 = dot(_632, _680);
                float _701 = (_698 * _698) - (_681 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_674].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_674].w));
                float _718;
                float3 _719;
                if (_701 >= 0.0)
                {
                    float _712 = fast::clamp((2.5 * fast::clamp(_682 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_674].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _718 = 1.0 - ((_712 * _712) * (3.0 - (2.0 * _712)));
                    _719 = (_680 + (_632 * (sqrt(_701) - _698))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_674].xyz;
                }
                else
                {
                    _718 = 0.0;
                    _719 = _632;
                }
                _773 = _718;
                _774 = _719;
            }
            float4 _781 = float4(_774, ReflectionCapture.ReflectionCapture_CaptureProperties[_674].y);
            float4 _783 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _781.xyz, uint(round(_781.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _653));
            float3 _786 = _783.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_674].x;
            float4 _788 = float4(_786.x, _786.y, _786.z, _783.w) * _773;
            float3 _793 = _660.xyz + ((_788.xyz * _660.w) * 1.0);
            float4 _798 = float4(_793.x, _793.y, _793.z, _660.w);
            _798.w = _660.w * (1.0 - _788.w);
            float2 _805 = _204;
            _805.x = _657.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_674].w * _773) * _657.y);
            float2 _808 = _805;
            _808.y = _657.y * (1.0 - _773);
            _658 = _808;
            _661 = _798;
        }
        else
        {
            _658 = _657;
            _661 = _660;
        }
    }
    float3 _810 = _660.xyz * View.View_IndirectLightingColorScale;
    float4 _811 = float4(_810.x, _810.y, _810.z, _660.w);
    float _814 = _657.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _815 = _204;
    _815.x = _814;
    float4 _857;
    float2 _858;
    float3 _859;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _835 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _632, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _653)).xyz * View.View_SkyLightColor.xyz;
        float4 _854;
        float2 _855;
        float3 _856;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _848 = _810.xyz + ((_835 * _660.w) * 1.0);
            float2 _853 = _204;
            _853.x = _814 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _657.y);
            _854 = float4(_848.x, _848.y, _848.z, _660.w);
            _855 = _853;
            _856 = float3(0.0);
        }
        else
        {
            _854 = _811;
            _855 = _815;
            _856 = _835 * 1.0;
        }
        _857 = _854;
        _858 = _855;
        _859 = _856;
    }
    else
    {
        _857 = _811;
        _858 = _815;
        _859 = float3(0.0);
    }
    float3 _881 = ((_857.xyz * mix(1.0, fast::min(dot(_573, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_858.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_303 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_859 * _857.w)).xyz;
    float4 _883 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _303) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _884 = _883.x;
    float2 _894 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_884 * _884, exp2((-9.27999973297119140625) * fast::clamp(dot(_280, _272), 0.0, 1.0))) * _884) + _883.y)) + _883.zw;
    float3 _1030;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _930 = _270 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _966 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_270, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_930, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_930, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _280) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_303 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _1024;
        if (_966 > 0.0)
        {
            float4 _995 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_270 + (reflect(reflect(normalize(_270 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _280).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _1002;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _1002 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _1002 = 0u;
            }
            float4 _1019 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_995.xy / float2(_995.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1002].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_1002].zw), level(0.0));
            float4 _1023 = float4(_1019.x, _1019.y, _1019.z, float4(0.0).w);
            _1023.w = _966 * _1019.w;
            _1024 = _1023;
        }
        else
        {
            _1024 = float4(0.0);
        }
        _1030 = _1024.xyz + (_881 * (1.0 - _1024.w));
    }
    else
    {
        _1030 = _881;
    }
    bool _1048 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1096;
    if (_1048)
    {
        float4 _1055 = View.View_WorldToClip * float4(_270, 1.0);
        float _1056 = _1055.w;
        float4 _1084;
        if (_1048)
        {
            _1084 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_1055.xy / float2(_1056)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_1056 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1084 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1096 = float4(_1084.xyz + (in.in_var_TEXCOORD7.xyz * _1084.w), _1084.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1096 = in.in_var_TEXCOORD7;
    }
    float3 _1104 = (_270 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1112 = (_270 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1117 = fast::clamp((float3(0.5) - abs(_1104 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1122 = (_1117.x * _1117.y) * _1117.z;
    float4 _1130 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1112, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1104, level(0.0)), float4(_1122));
    float3 _1141 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1112, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1104, level(0.0)).xyz, float3(_1122)) * 1.0;
    float4 _1143 = _203;
    _1143.x = _1130.x;
    float4 _1145 = _203;
    _1145.x = _1130.y;
    float4 _1147 = _203;
    _1147.x = _1130.z;
    float3 _1148 = _1130.xyz;
    float3 _1152 = _1148 / float3(dot(_1148, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1154 = _1141 * _1152.x;
    float3 _1157 = _1141 * _1152.y;
    float3 _1160 = _1141 * _1152.z;
    float3 _1163 = _205;
    _1163.x = dot(float4(_1143.x, _1154.x, _1154.y, _1154.z), _476);
    float3 _1165 = _1163;
    _1165.y = dot(float4(_1145.x, _1157.x, _1157.y, _1157.z), _476);
    float3 _1167 = _1165;
    _1167.z = dot(float4(_1147.x, _1160.x, _1160.y, _1160.z), _476);
    float3 _1182 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1213;
    float3 _1214;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1188 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1201 = any(abs(_270 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1188 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1188 + 19u)].xyz + float3(1.0)));
        float3 _1211;
        if (_1201)
        {
            _1211 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_270, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1211 = _1182;
        }
        _1213 = _1201 ? 1.0 : _304;
        _1214 = _1211;
    }
    else
    {
        _1213 = _304;
        _1214 = _1182;
    }
    float4 _1224 = float4((((mix((((_1030 * ((_366 * _894.x) + float3(fast::clamp(50.0 * _366.y, 0.0, 1.0) * _894.y))) * 1.0) * fast::max(float3(1.0), ((((((_366 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_366 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_366 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_364 * float4(fast::max(float3(0.0), _1167), _199).xyz), _364 + (_366 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_573 * _364) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1214) * _1096.w) + _1096.xyz, _1213);
    float3 _1228 = _1224.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1228.x, _1228.y, _1228.z, _1224.w);
    return out;
}

