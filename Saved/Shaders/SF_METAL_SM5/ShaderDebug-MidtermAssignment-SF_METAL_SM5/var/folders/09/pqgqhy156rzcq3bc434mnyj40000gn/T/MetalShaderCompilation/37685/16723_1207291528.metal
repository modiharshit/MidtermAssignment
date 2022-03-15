

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _150 = {};
constant float4 _151 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 in_var_TEXCOORD4 [[user(locn2)]];
    float4 in_var_TEXCOORD5 [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TANGENTX [[user(locn5)]];
    float4 in_var_TANGENTZ [[user(locn6)]];
    float4 in_var_TEXCOORD7 [[user(locn7)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004153_47f5ce88(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float3 _231 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _249 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _253 = mix(_249, _251, float4(in.in_var_TEXCOORD4.x));
    float _265 = _214.w;
    float4 _275 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_214.xy / float2(_265)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _276 = _275.x;
    float _306;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _306 = _265;
                break;
            }
            else
            {
                float _299 = _214.z;
                _306 = ((_299 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_299 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _312 = fast::clamp((_245.xyz + _253.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _313 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _253.w, 0.0), 1.0) * fast::min(fast::max(((((_276 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_276 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _306) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _320 = (_312 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _327 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _330 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _335;
    if (_330)
    {
        _335 = _320 + (_327 * 0.449999988079071044921875);
    }
    else
    {
        _335 = _320;
    }
    float _338 = _231.x;
    float _339 = _231.y;
    float4 _341 = float4(_338, _339, _231.z, 1.0);
    float3 _345 = _150;
    _345.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _341);
    float3 _349 = _345;
    _349.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _341);
    float3 _353 = _349;
    _353.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _341);
    float4 _356 = _341.xyzz * _341.yzzx;
    float3 _360 = _150;
    _360.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _356);
    float3 _364 = _360;
    _364.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _356);
    float3 _368 = _364;
    _368.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _356);
    bool _398 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _447;
    if (_398)
    {
        float4 _405 = View.View_WorldToClip * float4(_223, 1.0);
        float _406 = _405.w;
        float4 _435;
        if (_398)
        {
            _435 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_405.xy / float2(_406)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_406 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _435 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _447 = float4(_435.xyz + (in.in_var_TEXCOORD7.xyz * _435.w), _435.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _447 = in.in_var_TEXCOORD7;
    }
    float3 _448 = _223 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _456 = (_448 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _464 = (_448 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _469 = fast::clamp((float3(0.5) - abs(_456 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _474 = (_469.x * _469.y) * _469.z;
    float4 _483 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _464, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _456, level(0.0)), float4(_474));
    float3 _494 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _464, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _456, level(0.0)).xyz, float3(_474)) * 1.0;
    float4 _496 = _151;
    _496.x = _483.x;
    float4 _498 = _151;
    _498.x = _483.y;
    float4 _500 = _151;
    _500.x = _483.z;
    float3 _501 = _483.xyz;
    float3 _505 = _501 / float3(dot(_501, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _507 = _494 * _505.x;
    float3 _510 = _494 * _505.y;
    float3 _513 = _494 * _505.z;
    float4 _516 = _151;
    _516.y = (-0.48860299587249755859375) * _339;
    float4 _518 = _516;
    _518.z = 0.48860299587249755859375 * _231.z;
    float4 _520 = _518;
    _520.w = (-0.48860299587249755859375) * _338;
    float4 _521 = _520;
    _521.x = 0.886227548122406005859375;
    float3 _523 = _521.yzw * 2.094395160675048828125;
    float4 _524 = float4(_521.x, _523.x, _523.y, _523.z);
    float3 _526 = _150;
    _526.x = dot(float4(_496.x, _507.x, _507.y, _507.z), _524);
    float3 _528 = _526;
    _528.y = dot(float4(_498.x, _510.x, _510.y, _510.z), _524);
    float3 _530 = _528;
    _530.z = dot(float4(_500.x, _513.x, _513.y, _513.z), _524);
    float _532 = _483.w;
    float3 _537 = float4(fast::max(float3(0.0), _530), _532).xyz;
    float3 _603;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _551 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_448, 1.0);
        float2 _555 = _551.xy / float2(_551.w);
        float _556 = _551.z;
        float4 _559 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _555, level(0.0));
        float3 _563 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _556;
        bool2 _588 = _555 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _590 = _555 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _603 = _335 * fast::max(_537 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _532) * (float3(1.0) - select(fast::clamp(exp((float3((((_559.x * _556) * 0.5) + dot((sin(_563) * _559.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_563)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _555, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_588.x || _590.x, _588.y || _590.y)))))), float3(0.0));
    }
    else
    {
        _603 = _335 * _537;
    }
    float3 _610 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _637;
    float3 _638;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _625 = any(abs(_223 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _635;
        if (_625)
        {
            _635 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _635 = _610;
        }
        _637 = _625 ? 1.0 : _313;
        _638 = _635;
    }
    else
    {
        _637 = _313;
        _638 = _610;
    }
    float4 _648 = float4((((mix(_603, _335 + (select(_327, float3(0.0), bool3(_330)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_353 + _368) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_338 * _338) - (_339 * _339)))) * View.View_SkyLightColor.xyz) * 1.0) * _335) * fast::max(float3(1.0), ((((((_312 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_312 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_312 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _638) * _447.w) + _447.xyz, _637);
    float3 _652 = _648.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_652.x, _652.y, _652.z, _648.w);
    return out;
}

