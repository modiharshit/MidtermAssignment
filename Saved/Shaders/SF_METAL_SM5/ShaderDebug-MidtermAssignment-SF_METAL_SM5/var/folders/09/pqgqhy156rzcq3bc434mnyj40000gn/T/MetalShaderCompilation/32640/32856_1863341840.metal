

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
    char _m26_pad[80];
    float View_IndirectLightingCacheShowFlag;
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

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
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

constant float _195 = {};
constant float4 _196 = {};
constant float3 _197 = {};
constant float4 _199 = {};
constant float2 _200 = {};
constant float3 _201 = {};

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

fragment MainPS_out Main_00008058_6f105710(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(9)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(5)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(6)]], constant type_ReflectionCapture& ReflectionCapture [[buffer(7)]], constant type_Material& Material [[buffer(8)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_NumCulledLightsGrid [[texture(0)]], texture_buffer<uint> TranslucentBasePass_Shared_Forward_CulledLightDataGrid [[texture(1)]], texturecube<float> TranslucentBasePass_Shared_Reflection_SkyLightCubemap [[texture(2)]], texturecube_array<float> TranslucentBasePass_Shared_Reflection_ReflectionCubemap [[texture(3)]], texture2d<float> TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(9)]], texture2d<float> Material_Texture2D_0 [[texture(10)]], texture2d<float> Material_Texture2D_1 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler [[sampler(1)]], sampler TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[3];
    float4 _261 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _265 = _261.xyz / float3(_261.w);
    float3 _266 = _265 - View.View_PreViewTranslation;
    float3 _268 = normalize(-_265);
    float4 _274 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _277 = (_274.xy * float2(2.0)) - float2(1.0);
    float3 _293 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_277, sqrt(fast::clamp(1.0 - dot(_277, _277), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _304 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _310 = dot(_293, _268);
    float _314 = fast::max(abs(1.0 - fast::max(0.0, _310)), 9.9999997473787516355514526367188e-05);
    float3 _329 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _304.x, float3(0.0), float3(1.0));
    float _335 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _336 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_314 <= 0.0) ? 0.0 : pow(_314, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    float3 _348 = ((_329 - (_329 * 0.89999997615814208984375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _355 = (mix(float3(0.07999999821186065673828125 * fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0)), _329, float3(0.89999997615814208984375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _358 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _363;
    if (_358)
    {
        _363 = _348 + (_355 * 0.449999988079071044921875);
    }
    else
    {
        _363 = _348;
    }
    float3 _365 = select(_355, float3(0.0), bool3(_358));
    bool _368 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _441;
    if (_368)
    {
        float _389 = _293.y;
        float4 _391 = _199;
        _391.y = (-0.48860299587249755859375) * _389;
        float _392 = _293.z;
        float4 _394 = _391;
        _394.z = 0.48860299587249755859375 * _392;
        float _395 = _293.x;
        float4 _397 = _394;
        _397.w = (-0.48860299587249755859375) * _395;
        float3 _398 = _293 * _293;
        float4 _401 = _196;
        _401.x = (1.09254801273345947265625 * _395) * _389;
        float4 _404 = _401;
        _404.y = ((-1.09254801273345947265625) * _389) * _392;
        float4 _409 = _404;
        _409.z = 0.3153919875621795654296875 * ((3.0 * _398.z) - 1.0);
        float4 _412 = _409;
        _412.w = ((-1.09254801273345947265625) * _395) * _392;
        float4 _416 = _397;
        _416.x = 0.886227548122406005859375;
        float3 _418 = _416.yzw * 2.094395160675048828125;
        float4 _419 = float4(_416.x, _418.x, _418.y, _418.z);
        float4 _420 = _412 * 0.785398185253143310546875;
        float _421 = (_398.x - _398.y) * 0.4290426075458526611328125;
        float3 _427 = float3(0.0);
        _427.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _419) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _420)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _421);
        float3 _433 = _427;
        _433.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _419) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _420)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _421);
        float3 _439 = _433;
        _439.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _419) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _420)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _421);
        _441 = fast::max(float3(0.0), _439);
    }
    else
    {
        _441 = float3(0.0);
    }
    float _467;
    float _468;
    float3 _469;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _457;
        float _458;
        if (_368)
        {
            _457 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _458 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _457 = _293;
            _458 = 1.0;
        }
        float _459 = 1.0 - _458;
        float _461 = 1.0 - (_459 * _459);
        _467 = mix(fast::clamp(dot(_457, _293), 0.0, 1.0), 1.0, _461);
        _468 = _458;
        _469 = mix(_457, _293, float3(_461));
    }
    else
    {
        _467 = 1.0;
        _468 = 1.0;
        _469 = _293;
    }
    float4 _473 = float4(_469, 1.0);
    float3 _477 = _197;
    _477.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 0u)], _473);
    float3 _481 = _477;
    _481.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 1u)], _473);
    float3 _485 = _481;
    _485.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 2u)], _473);
    float4 _488 = _473.xyzz * _473.yzzx;
    float3 _492 = _197;
    _492.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 3u)], _488);
    float3 _496 = _492;
    _496.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 4u)], _488);
    float3 _500 = _496;
    _500.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 5u)], _488);
    float3 _515 = (_441 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_485 + _500) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, 6u)].xyz * ((_469.x * _469.x) - (_469.y * _469.y)))) * View.View_SkyLightColor.xyz) * (_468 * _467));
    uint2 _560 = uint2((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_LightProbeSizeRatioAndInvSizeRatio.zw) >> (uint2(TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridPixelSizeShift) & uint2(31u));
    float3 _574 = (_293 * (2.0 * dot(_268, _293))) - _268;
    uint _579 = (TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumGridCells + ((((min(uint(fast::max(0.0, log2(((1.0 / gl_FragCoord.w) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.x) + TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.y) * TranslucentBasePass.TranslucentBasePass_Shared_Forward_LightGridZParams.z)), uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.z - 1)) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.y)) + _560.y) * uint(TranslucentBasePass.TranslucentBasePass_Shared_Forward_CulledGridSize.x)) + _560.x)) * 2u;
    float _594 = 1.0 - (1.2000000476837158203125 * log2(fast::max(_335, 0.001000000047497451305389404296875)));
    float2 _598;
    float4 _601;
    _598 = float2(0.0, 1.0);
    _601 = float4(0.0, 0.0, 0.0, 1.0);
    float2 _599;
    float4 _602;
    for (uint _603 = 0u; _603 < min(TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint(_579)).x, TranslucentBasePass.TranslucentBasePass_Shared_Forward_NumReflectionCaptures); _598 = _599, _601 = _602, _603++)
    {
        if (_601.w < 0.001000000047497451305389404296875)
        {
            break;
        }
        uint4 _614 = TranslucentBasePass_Shared_Forward_CulledLightDataGrid.read(uint((TranslucentBasePass_Shared_Forward_NumCulledLightsGrid.read(uint((_579 + 1u))).x + _603)));
        uint _615 = _614.x;
        float3 _621 = _266 - ReflectionCapture.ReflectionCapture_PositionAndRadius[_615].xyz;
        float _622 = dot(_621, _621);
        float _623 = sqrt(_622);
        if (_623 < ReflectionCapture.ReflectionCapture_PositionAndRadius[_615].w)
        {
            float _714;
            float3 _715;
            if (ReflectionCapture.ReflectionCapture_CaptureProperties[_615].z > 0.0)
            {
                float3 _671 = (ReflectionCapture.ReflectionCapture_BoxTransform[_615] * float4(_266, 1.0)).xyz;
                float3 _677 = (ReflectionCapture.ReflectionCapture_BoxTransform[_615] * float4(_574, 0.0)).xyz;
                float3 _678 = float3(1.0) / _677;
                float3 _680 = _671 * _678;
                float3 _683 = fast::max((float3(-1.0) / _677) - _680, _678 - _680);
                float3 _697 = ReflectionCapture.ReflectionCapture_BoxScales[_615].xyz - float3(0.5 * ReflectionCapture.ReflectionCapture_BoxScales[_615].w);
                float3 _698 = -_697;
                float3 _699 = _671 * ReflectionCapture.ReflectionCapture_BoxScales[_615].xyz;
                _714 = 1.0 - smoothstep(0.0, 0.699999988079071044921875 * ReflectionCapture.ReflectionCapture_BoxScales[_615].w, dot(select(float3(0.0), abs(_699 - _698), _699 < _698), float3(1.0)) + dot(select(float3(0.0), abs(_699 - _697), _699 > _697), float3(1.0)));
                _715 = (_266 + (_574 * fast::min(_683.x, fast::min(_683.y, _683.z)))) - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_615].xyz + ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_615].xyz);
            }
            else
            {
                float _639 = dot(_574, _621);
                float _642 = (_639 * _639) - (_622 - (ReflectionCapture.ReflectionCapture_PositionAndRadius[_615].w * ReflectionCapture.ReflectionCapture_PositionAndRadius[_615].w));
                float _659;
                float3 _660;
                if (_642 >= 0.0)
                {
                    float _653 = fast::clamp((2.5 * fast::clamp(_623 / ReflectionCapture.ReflectionCapture_PositionAndRadius[_615].w, 0.0, 1.0)) - 1.5, 0.0, 1.0);
                    _659 = 1.0 - ((_653 * _653) * (3.0 - (2.0 * _653)));
                    _660 = (_621 + (_574 * (sqrt(_642) - _639))) - ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_615].xyz;
                }
                else
                {
                    _659 = 0.0;
                    _660 = _574;
                }
                _714 = _659;
                _715 = _660;
            }
            float4 _722 = float4(_715, ReflectionCapture.ReflectionCapture_CaptureProperties[_615].y);
            float4 _724 = TranslucentBasePass_Shared_Reflection_ReflectionCubemap.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, _722.xyz, uint(round(_722.w)), level((View.View_ReflectionCubemapMaxMip - 1.0) - _594));
            float3 _727 = _724.xyz * ReflectionCapture.ReflectionCapture_CaptureProperties[_615].x;
            float4 _729 = float4(_727.x, _727.y, _727.z, _724.w) * _714;
            float3 _734 = _601.xyz + ((_729.xyz * _601.w) * 1.0);
            float4 _739 = float4(_734.x, _734.y, _734.z, _601.w);
            _739.w = _601.w * (1.0 - _729.w);
            float2 _746 = _200;
            _746.x = _598.x + ((ReflectionCapture.ReflectionCapture_CaptureOffsetAndAverageBrightness[_615].w * _714) * _598.y);
            float2 _749 = _746;
            _749.y = _598.y * (1.0 - _714);
            _599 = _749;
            _602 = _739;
        }
        else
        {
            _599 = _598;
            _602 = _601;
        }
    }
    float3 _751 = _601.xyz * View.View_IndirectLightingColorScale;
    float4 _752 = float4(_751.x, _751.y, _751.z, _601.w);
    float _755 = _598.x * dot(View.View_IndirectLightingColorScale, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float2 _756 = _200;
    _756.x = _755;
    float4 _798;
    float2 _799;
    float3 _800;
    if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.y > 0.0) && true)
    {
        float3 _776 = TranslucentBasePass_Shared_Reflection_SkyLightCubemap.sample(TranslucentBasePass_Shared_Reflection_SkyLightCubemapSampler, _574, level((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.x - 1.0) - _594)).xyz * View.View_SkyLightColor.xyz;
        float4 _795;
        float2 _796;
        float3 _797;
        if ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightParameters.z < 1.0) && true)
        {
            float3 _789 = _751.xyz + ((_776 * _601.w) * 1.0);
            float2 _794 = _200;
            _794.x = _755 + ((TranslucentBasePass.TranslucentBasePass_Shared_Reflection_SkyLightCubemapBrightness * dot(View.View_SkyLightColor.xyz, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))) * _598.y);
            _795 = float4(_789.x, _789.y, _789.z, _601.w);
            _796 = _794;
            _797 = float3(0.0);
        }
        else
        {
            _795 = _752;
            _796 = _756;
            _797 = _776 * 1.0;
        }
        _798 = _795;
        _799 = _796;
        _800 = _797;
    }
    else
    {
        _798 = _752;
        _799 = _756;
        _800 = float3(0.0);
    }
    float3 _822 = ((_798.xyz * mix(1.0, fast::min(dot(_515, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) / fast::max(_799.x, 9.9999997473787516355514526367188e-05), View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[2]), smoothstep(0.0, 1.0, fast::clamp((_335 * View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[0]) + View.View_ReflectionEnvironmentRoughnessMixingScaleBiasAndLargestWeight[1], 0.0, 1.0)))).xyz + (_800 * _798.w)).xyz;
    float4 _824 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _335) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float _825 = _824.x;
    float2 _835 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_825 * _825, exp2((-9.27999973297119140625) * fast::clamp(_310, 0.0, 1.0))) * _825) + _824.y)) + _824.zw;
    float3 _971;
    if (abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, float3(1.0))) > 9.9999997473787516355514526367188e-05)
    {
        float3 _871 = _266 - TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionOrigin.xyz;
        float _907 = (((1.0 - fast::clamp((abs(dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane, float4(_266, -1.0))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.y, 0.0, 1.0)) * (fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.w - abs(dot(_871, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionXAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0) * fast::clamp((TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.w - abs(dot(_871, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionYAxis.xyz))) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.x, 0.0, 1.0))) * fast::clamp((dot(TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz, _293) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.x) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters2.y, 0.0, 1.0)) * (1.0 - fast::clamp((_335 - 0.20000000298023223876953125) * 10.0, 0.0, 1.0));
        float4 _965;
        if (_907 > 0.0)
        {
            float4 _936 = TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ProjectionWithExtraFOV[View.View_StereoPassIndex] * float4((View.View_TranslatedWorldToView * float4((_266 + (reflect(reflect(normalize(_266 - View.View_WorldCameraOrigin), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_ReflectionPlane.xyz), (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_InverseTransposeMirrorMatrix * _293).xyz) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionParameters.z)) + View.View_PreViewTranslation, 1.0)).xyz, 1.0);
            uint _943;
            if (TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_bIsStereo != 0u)
            {
                _943 = uint(View.View_StereoPassIndex);
            }
            else
            {
                _943 = 0u;
            }
            float4 _960 = TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionTexture.sample(TranslucentBasePass_Shared_Reflection_ReflectionCubemapSampler, ((fast::clamp(_936.xy / float2(_936.w), -TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound, TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenBound) * TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_943].xy) + TranslucentBasePass.TranslucentBasePass_Shared_PlanarReflection_PlanarReflectionScreenScaleBias[_943].zw), level(0.0));
            float4 _964 = float4(_960.x, _960.y, _960.z, float4(0.0).w);
            _964.w = _907 * _960.w;
            _965 = _964;
        }
        else
        {
            _965 = float4(0.0);
        }
        _971 = _965.xyz + (_822 * (1.0 - _965.w));
    }
    else
    {
        _971 = _822;
    }
    bool _989 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _1038;
    if (_989)
    {
        float4 _996 = View.View_WorldToClip * float4(_266, 1.0);
        float _997 = _996.w;
        float4 _1026;
        if (_989)
        {
            _1026 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_996.xy / float2(_997)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_997 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _1026 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _1038 = float4(_1026.xyz + (in.in_var_TEXCOORD7.xyz * _1026.w), _1026.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _1038 = in.in_var_TEXCOORD7;
    }
    float3 _1046 = (_266 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _1054 = (_266 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _1059 = fast::clamp((float3(0.5) - abs(_1046 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _1064 = (_1059.x * _1059.y) * _1059.z;
    float4 _1073 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _1054, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _1046, level(0.0)), float4(_1064));
    float3 _1084 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _1054, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _1046, level(0.0)).xyz, float3(_1064)) * 1.0;
    float4 _1086 = _199;
    _1086.x = _1073.x;
    float4 _1088 = _199;
    _1088.x = _1073.y;
    float4 _1090 = _199;
    _1090.x = _1073.z;
    float3 _1091 = _1073.xyz;
    float3 _1095 = _1091 / float3(dot(_1091, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _1097 = _1084 * _1095.x;
    float3 _1100 = _1084 * _1095.y;
    float3 _1103 = _1084 * _1095.z;
    float4 _1107 = _199;
    _1107.y = (-0.48860299587249755859375) * _293.y;
    float4 _1110 = _1107;
    _1110.z = 0.48860299587249755859375 * _293.z;
    float4 _1113 = _1110;
    _1113.w = (-0.48860299587249755859375) * _293.x;
    float4 _1114 = _1113;
    _1114.x = 0.886227548122406005859375;
    float3 _1116 = _1114.yzw * 2.094395160675048828125;
    float4 _1117 = float4(_1114.x, _1116.x, _1116.y, _1116.z);
    float3 _1119 = _201;
    _1119.x = dot(float4(_1086.x, _1097.x, _1097.y, _1097.z), _1117);
    float3 _1121 = _1119;
    _1121.y = dot(float4(_1088.x, _1100.x, _1100.y, _1100.z), _1117);
    float3 _1123 = _1121;
    _1123.z = dot(float4(_1090.x, _1103.x, _1103.y, _1103.z), _1117);
    float3 _1138 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _1169;
    float3 _1170;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _1144 = in.in_var_PRIMITIVE_ID * 36u;
        bool _1157 = any(abs(_266 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1144 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _1144 + 19u)].xyz + float3(1.0)));
        float3 _1167;
        if (_1157)
        {
            _1167 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_266, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1167 = _1138;
        }
        _1169 = _1157 ? 1.0 : _336;
        _1170 = _1167;
    }
    else
    {
        _1169 = _336;
        _1170 = _1138;
    }
    float4 _1180 = float4((((mix((((_971 * ((_365 * _835.x) + float3(fast::clamp(50.0 * _365.y, 0.0, 1.0) * _835.y))) * 1.0) * fast::max(float3(1.0), ((((((_365 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_365 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_365 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0)) + (_363 * float4(fast::max(float3(0.0), _1123), _195).xyz), _363 + (_365 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_515 * _363) * fast::max(float3(1.0), ((((((_329 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_329 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_329 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1170) * _1038.w) + _1038.xyz, _1169);
    float3 _1184 = _1180.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_1184.x, _1184.y, _1184.z, _1180.w);
    return out;
}

