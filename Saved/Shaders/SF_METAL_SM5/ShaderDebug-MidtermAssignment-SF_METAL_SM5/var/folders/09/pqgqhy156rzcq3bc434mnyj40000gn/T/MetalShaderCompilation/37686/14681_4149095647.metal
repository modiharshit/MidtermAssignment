

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
    char _m18_pad[384];
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

constant float4 _135 = {};
constant float3 _136 = {};

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

fragment MainPS_out Main_00003959_f74e2cdf(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _191 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _195 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _200 = (_195.xyz / float3(_195.w)) - View.View_PreViewTranslation;
    float3 _208 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _222 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _226 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _234 = _191.w;
    float4 _244 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_191.xy / float2(_234)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _245 = _244.x;
    float _275;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _275 = _234;
                break;
            }
            else
            {
                float _268 = _191.z;
                _275 = ((_268 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_268 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _282 = fast::clamp(fast::min(fast::max(_226.w, 0.0), 1.0) * fast::min(fast::max(((((_245 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_245 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _275) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _289 = (fast::clamp(_222.xyz + _226.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _296 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _299 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _304;
    if (_299)
    {
        _304 = _289 + (_296 * 0.449999988079071044921875);
    }
    else
    {
        _304 = _289;
    }
    bool _309 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _358;
    if (_309)
    {
        float4 _316 = View.View_WorldToClip * float4(_200, 1.0);
        float _317 = _316.w;
        float4 _346;
        if (_309)
        {
            _346 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_316.xy / float2(_317)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_317 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _346 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _358 = float4(_346.xyz + (in.in_var_TEXCOORD7.xyz * _346.w), _346.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _358 = in.in_var_TEXCOORD7;
    }
    float3 _366 = (_200 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _374 = (_200 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _379 = fast::clamp((float3(0.5) - abs(_366 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _384 = (_379.x * _379.y) * _379.z;
    float4 _393 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _374, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _366, level(0.0)), float4(_384));
    float3 _404 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _374, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _366, level(0.0)).xyz, float3(_384)) * 1.0;
    float4 _406 = _135;
    _406.x = _393.x;
    float4 _408 = _135;
    _408.x = _393.y;
    float4 _410 = _135;
    _410.x = _393.z;
    float3 _411 = _393.xyz;
    float3 _415 = _411 / float3(dot(_411, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _417 = _404 * _415.x;
    float3 _420 = _404 * _415.y;
    float3 _423 = _404 * _415.z;
    float4 _427 = _135;
    _427.y = (-0.48860299587249755859375) * _208.y;
    float4 _430 = _427;
    _430.z = 0.48860299587249755859375 * _208.z;
    float4 _433 = _430;
    _433.w = (-0.48860299587249755859375) * _208.x;
    float4 _434 = _433;
    _434.x = 0.886227548122406005859375;
    float3 _436 = _434.yzw * 2.094395160675048828125;
    float4 _437 = float4(_434.x, _436.x, _436.y, _436.z);
    float3 _439 = _136;
    _439.x = dot(float4(_406.x, _417.x, _417.y, _417.z), _437);
    float3 _441 = _439;
    _441.y = dot(float4(_408.x, _420.x, _420.y, _420.z), _437);
    float3 _443 = _441;
    _443.z = dot(float4(_410.x, _423.x, _423.y, _423.z), _437);
    float _445 = _393.w;
    float3 _450 = float4(fast::max(float3(0.0), _443), _445).xyz;
    float3 _516;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _464 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_200, 1.0);
        float2 _468 = _464.xy / float2(_464.w);
        float _469 = _464.z;
        float4 _472 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _468, level(0.0));
        float3 _476 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _469;
        bool2 _501 = _468 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _503 = _468 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _516 = _304 * fast::max(_450 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _445) * (float3(1.0) - select(fast::clamp(exp((float3((((_472.x * _469) * 0.5) + dot((sin(_476) * _472.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_476)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _468, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_501.x || _503.x, _501.y || _503.y)))))), float3(0.0));
    }
    else
    {
        _516 = _304 * _450;
    }
    float3 _523 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _554;
    float3 _555;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _529 = in.in_var_PRIMITIVE_ID * 36u;
        bool _542 = any(abs(_200 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _529 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _529 + 19u)].xyz + float3(1.0)));
        float3 _552;
        if (_542)
        {
            _552 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_200, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _552 = _523;
        }
        _554 = _542 ? 1.0 : _282;
        _555 = _552;
    }
    else
    {
        _554 = _282;
        _555 = _523;
    }
    float4 _564 = float4(((mix(_516, _304 + (select(_296, float3(0.0), bool3(_299)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _555) * _358.w) + _358.xyz, _554);
    float3 _568 = _564.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_568.x, _568.y, _568.z, _564.w);
    return out;
}

