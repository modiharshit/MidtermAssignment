

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
    char _m17_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[48];
    float4 View_SkyLightColor;
    char _m19_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _127 = {};
constant float3 _129 = {};
constant float4 _130 = {};

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

fragment MainPS_out Main_00003856_103ef87f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _187 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _191 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _196 = (_191.xyz / float3(_191.w)) - View.View_PreViewTranslation;
    float3 _204 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _218 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _222 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _230 = _187.w;
    float4 _240 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_187.xy / float2(_230)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _241 = _240.x;
    float _271;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _271 = _230;
                break;
            }
            else
            {
                float _264 = _187.z;
                _271 = ((_264 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_264 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _277 = fast::clamp(_218.xyz + _222.xyz, float3(0.0), float3(1.0));
    float _278 = fast::clamp(fast::min(fast::max(_222.w, 0.0), 1.0) * fast::min(fast::max(((((_241 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_241 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _271) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _285 = (_277 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _292 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _295 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _300;
    if (_295)
    {
        _300 = _285 + (_292 * 0.449999988079071044921875);
    }
    else
    {
        _300 = _285;
    }
    float _303 = _204.x;
    float _304 = _204.y;
    float4 _306 = float4(_303, _304, _204.z, 1.0);
    float3 _310 = _129;
    _310.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _306);
    float3 _314 = _310;
    _314.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _306);
    float3 _318 = _314;
    _318.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _306);
    float4 _321 = _306.xyzz * _306.yzzx;
    float3 _325 = _129;
    _325.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _321);
    float3 _329 = _325;
    _329.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _321);
    float3 _333 = _329;
    _333.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _321);
    bool _363 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _412;
    if (_363)
    {
        float4 _370 = View.View_WorldToClip * float4(_196, 1.0);
        float _371 = _370.w;
        float4 _400;
        if (_363)
        {
            _400 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_370.xy / float2(_371)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_371 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _400 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _412 = float4(_400.xyz + (in.in_var_TEXCOORD7.xyz * _400.w), _400.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _412 = in.in_var_TEXCOORD7;
    }
    float3 _420 = (_196 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _428 = (_196 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _433 = fast::clamp((float3(0.5) - abs(_420 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _438 = (_433.x * _433.y) * _433.z;
    float4 _447 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _428, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _420, level(0.0)), float4(_438));
    float3 _458 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _428, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _420, level(0.0)).xyz, float3(_438)) * 1.0;
    float4 _460 = _130;
    _460.x = _447.x;
    float4 _462 = _130;
    _462.x = _447.y;
    float4 _464 = _130;
    _464.x = _447.z;
    float3 _465 = _447.xyz;
    float3 _469 = _465 / float3(dot(_465, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _471 = _458 * _469.x;
    float3 _474 = _458 * _469.y;
    float3 _477 = _458 * _469.z;
    float4 _480 = _130;
    _480.y = (-0.48860299587249755859375) * _304;
    float4 _482 = _480;
    _482.z = 0.48860299587249755859375 * _204.z;
    float4 _484 = _482;
    _484.w = (-0.48860299587249755859375) * _303;
    float4 _485 = _484;
    _485.x = 0.886227548122406005859375;
    float3 _487 = _485.yzw * 2.094395160675048828125;
    float4 _488 = float4(_485.x, _487.x, _487.y, _487.z);
    float3 _490 = _129;
    _490.x = dot(float4(_460.x, _471.x, _471.y, _471.z), _488);
    float3 _492 = _490;
    _492.y = dot(float4(_462.x, _474.x, _474.y, _474.z), _488);
    float3 _494 = _492;
    _494.z = dot(float4(_464.x, _477.x, _477.y, _477.z), _488);
    float3 _508 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _539;
    float3 _540;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _514 = in.in_var_PRIMITIVE_ID * 36u;
        bool _527 = any(abs(_196 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _514 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _514 + 19u)].xyz + float3(1.0)));
        float3 _537;
        if (_527)
        {
            _537 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_196, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _537 = _508;
        }
        _539 = _527 ? 1.0 : _278;
        _540 = _537;
    }
    else
    {
        _539 = _278;
        _540 = _508;
    }
    float4 _550 = float4((((mix(_300 * float4(fast::max(float3(0.0), _494), _127).xyz, _300 + (select(_292, float3(0.0), bool3(_295)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_318 + _333) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_303 * _303) - (_304 * _304)))) * View.View_SkyLightColor.xyz) * 1.0) * _300) * fast::max(float3(1.0), ((((((_277 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_277 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_277 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _540) * _412.w) + _412.xyz, _539);
    float3 _554 = _550.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_554.x, _554.y, _554.z, _550.w);
    return out;
}

