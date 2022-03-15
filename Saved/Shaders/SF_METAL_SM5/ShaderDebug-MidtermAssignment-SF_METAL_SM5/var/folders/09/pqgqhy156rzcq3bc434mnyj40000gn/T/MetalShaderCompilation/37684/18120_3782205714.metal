

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
    char _m1_pad[320];
    float4x4 View_ViewToClip;
    char _m2_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m5_pad[48];
    float3 View_PreViewTranslation;
    char _m6_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m8_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m12_pad[16];
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
    char _m21_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m23_pad[80];
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _137 = {};
constant float4 _138 = {};
constant float4 _140 = {};
constant float3 _141 = {};

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

fragment MainPS_out Main_000046c8_e16fe112(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _201 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float3 _218 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _232 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _236 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _244 = _201.w;
    float4 _254 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_201.xy / float2(_244)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _255 = _254.x;
    float _285;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _285 = _244;
                break;
            }
            else
            {
                float _278 = _201.z;
                _285 = ((_278 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_278 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _291 = fast::clamp(_232.xyz + _236.xyz, float3(0.0), float3(1.0));
    float _292 = fast::clamp(fast::min(fast::max(_236.w, 0.0), 1.0) * fast::min(fast::max(((((_255 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_255 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _285) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _299 = (_291 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _306 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _309 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _314;
    if (_309)
    {
        _314 = _299 + (_306 * 0.449999988079071044921875);
    }
    else
    {
        _314 = _299;
    }
    bool _319 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _392;
    if (_319)
    {
        float _340 = _218.y;
        float4 _342 = _140;
        _342.y = (-0.48860299587249755859375) * _340;
        float _343 = _218.z;
        float4 _345 = _342;
        _345.z = 0.48860299587249755859375 * _343;
        float _346 = _218.x;
        float4 _348 = _345;
        _348.w = (-0.48860299587249755859375) * _346;
        float3 _349 = _218 * _218;
        float4 _352 = _138;
        _352.x = (1.09254801273345947265625 * _346) * _340;
        float4 _355 = _352;
        _355.y = ((-1.09254801273345947265625) * _340) * _343;
        float4 _360 = _355;
        _360.z = 0.3153919875621795654296875 * ((3.0 * _349.z) - 1.0);
        float4 _363 = _360;
        _363.w = ((-1.09254801273345947265625) * _346) * _343;
        float4 _367 = _348;
        _367.x = 0.886227548122406005859375;
        float3 _369 = _367.yzw * 2.094395160675048828125;
        float4 _370 = float4(_367.x, _369.x, _369.y, _369.z);
        float4 _371 = _363 * 0.785398185253143310546875;
        float _372 = (_349.x - _349.y) * 0.4290426075458526611328125;
        float3 _378 = _141;
        _378.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _370) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _371)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _372);
        float3 _384 = _378;
        _384.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _370) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _371)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _372);
        float3 _390 = _384;
        _390.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _370) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _371)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _372);
        _392 = fast::max(float3(0.0), _390);
    }
    else
    {
        _392 = float3(0.0);
    }
    float _418;
    float _419;
    float3 _420;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _408;
        float _409;
        if (_319)
        {
            _408 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _409 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _408 = _218;
            _409 = 1.0;
        }
        float _410 = 1.0 - _409;
        float _412 = 1.0 - (_410 * _410);
        _418 = mix(fast::clamp(dot(_408, _218), 0.0, 1.0), 1.0, _412);
        _419 = _409;
        _420 = mix(_408, _218, float3(_412));
    }
    else
    {
        _418 = 1.0;
        _419 = 1.0;
        _420 = _218;
    }
    float4 _424 = float4(_420, 1.0);
    float3 _428 = _141;
    _428.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _424);
    float3 _432 = _428;
    _432.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _424);
    float3 _436 = _432;
    _436.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _424);
    float4 _439 = _424.xyzz * _424.yzzx;
    float3 _443 = _141;
    _443.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _439);
    float3 _447 = _443;
    _447.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _439);
    float3 _451 = _447;
    _451.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _439);
    bool _483 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _532;
    if (_483)
    {
        float4 _490 = View.View_WorldToClip * float4(_210, 1.0);
        float _491 = _490.w;
        float4 _520;
        if (_483)
        {
            _520 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_490.xy / float2(_491)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_491 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _520 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _532 = float4(_520.xyz + (in.in_var_TEXCOORD7.xyz * _520.w), _520.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _532 = in.in_var_TEXCOORD7;
    }
    float3 _540 = (_210 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _548 = (_210 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _553 = fast::clamp((float3(0.5) - abs(_540 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _558 = (_553.x * _553.y) * _553.z;
    float4 _567 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _548, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _540, level(0.0)), float4(_558));
    float3 _578 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _548, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _540, level(0.0)).xyz, float3(_558)) * 1.0;
    float4 _580 = _140;
    _580.x = _567.x;
    float4 _582 = _140;
    _582.x = _567.y;
    float4 _584 = _140;
    _584.x = _567.z;
    float3 _585 = _567.xyz;
    float3 _589 = _585 / float3(dot(_585, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _591 = _578 * _589.x;
    float3 _594 = _578 * _589.y;
    float3 _597 = _578 * _589.z;
    float4 _601 = _140;
    _601.y = (-0.48860299587249755859375) * _218.y;
    float4 _604 = _601;
    _604.z = 0.48860299587249755859375 * _218.z;
    float4 _607 = _604;
    _607.w = (-0.48860299587249755859375) * _218.x;
    float4 _608 = _607;
    _608.x = 0.886227548122406005859375;
    float3 _610 = _608.yzw * 2.094395160675048828125;
    float4 _611 = float4(_608.x, _610.x, _610.y, _610.z);
    float3 _613 = _141;
    _613.x = dot(float4(_580.x, _591.x, _591.y, _591.z), _611);
    float3 _615 = _613;
    _615.y = dot(float4(_582.x, _594.x, _594.y, _594.z), _611);
    float3 _617 = _615;
    _617.z = dot(float4(_584.x, _597.x, _597.y, _597.z), _611);
    float3 _631 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _662;
    float3 _663;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _637 = in.in_var_PRIMITIVE_ID * 36u;
        bool _650 = any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _637 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _637 + 19u)].xyz + float3(1.0)));
        float3 _660;
        if (_650)
        {
            _660 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _660 = _631;
        }
        _662 = _650 ? 1.0 : _292;
        _663 = _660;
    }
    else
    {
        _662 = _292;
        _663 = _631;
    }
    float4 _673 = float4((((mix(_314 * float4(fast::max(float3(0.0), _617), _137).xyz, _314 + (select(_306, float3(0.0), bool3(_309)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((_392 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_436 + _451) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_420.x * _420.x) - (_420.y * _420.y)))) * View.View_SkyLightColor.xyz) * (_419 * _418))) * _314) * fast::max(float3(1.0), ((((((_291 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_291 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_291 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _663) * _532.w) + _532.xyz, _662);
    float3 _677 = _673.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_677.x, _677.y, _677.z, _673.w);
    return out;
}

