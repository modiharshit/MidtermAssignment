

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

constant float3 _146 = {};
constant float4 _147 = {};

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

fragment MainPS_out Main_00004089_afb01e35(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(2)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _204 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _213 = (_208.xyz / float3(_208.w)) - View.View_PreViewTranslation;
    float3 _221 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _239 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _247 = _204.w;
    float4 _257 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_204.xy / float2(_247)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _258 = _257.x;
    float _288;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _288 = _247;
                break;
            }
            else
            {
                float _281 = _204.z;
                _288 = ((_281 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_281 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _294 = fast::clamp(_235.xyz + _239.xyz, float3(0.0), float3(1.0));
    float _295 = fast::clamp(fast::min(fast::max(_239.w, 0.0), 1.0) * fast::min(fast::max(((((_258 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_258 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _288) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _302 = (_294 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _309 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _312 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _317;
    if (_312)
    {
        _317 = _302 + (_309 * 0.449999988079071044921875);
    }
    else
    {
        _317 = _302;
    }
    float _320 = _221.x;
    float _321 = _221.y;
    float4 _323 = float4(_320, _321, _221.z, 1.0);
    float3 _327 = _146;
    _327.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _323);
    float3 _331 = _327;
    _331.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _323);
    float3 _335 = _331;
    _335.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _323);
    float4 _338 = _323.xyzz * _323.yzzx;
    float3 _342 = _146;
    _342.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _338);
    float3 _346 = _342;
    _346.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _338);
    float3 _350 = _346;
    _350.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _338);
    bool _380 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _429;
    if (_380)
    {
        float4 _387 = View.View_WorldToClip * float4(_213, 1.0);
        float _388 = _387.w;
        float4 _417;
        if (_380)
        {
            _417 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_387.xy / float2(_388)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_388 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _417 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _429 = float4(_417.xyz + (in.in_var_TEXCOORD7.xyz * _417.w), _417.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _429 = in.in_var_TEXCOORD7;
    }
    float3 _437 = (_213 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _445 = (_213 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _450 = fast::clamp((float3(0.5) - abs(_437 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _455 = (_450.x * _450.y) * _450.z;
    float4 _464 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _445, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _437, level(0.0)), float4(_455));
    float3 _475 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _445, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _437, level(0.0)).xyz, float3(_455)) * 1.0;
    float4 _477 = _147;
    _477.x = _464.x;
    float4 _479 = _147;
    _479.x = _464.y;
    float4 _481 = _147;
    _481.x = _464.z;
    float3 _482 = _464.xyz;
    float3 _486 = _482 / float3(dot(_482, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _488 = _475 * _486.x;
    float3 _491 = _475 * _486.y;
    float3 _494 = _475 * _486.z;
    float4 _497 = _147;
    _497.y = (-0.48860299587249755859375) * _321;
    float4 _499 = _497;
    _499.z = 0.48860299587249755859375 * _221.z;
    float4 _501 = _499;
    _501.w = (-0.48860299587249755859375) * _320;
    float4 _502 = _501;
    _502.x = 0.886227548122406005859375;
    float3 _504 = _502.yzw * 2.094395160675048828125;
    float4 _505 = float4(_502.x, _504.x, _504.y, _504.z);
    float3 _507 = _146;
    _507.x = dot(float4(_477.x, _488.x, _488.y, _488.z), _505);
    float3 _509 = _507;
    _509.y = dot(float4(_479.x, _491.x, _491.y, _491.z), _505);
    float3 _511 = _509;
    _511.z = dot(float4(_481.x, _494.x, _494.y, _494.z), _505);
    float _513 = _464.w;
    float3 _518 = float4(fast::max(float3(0.0), _511), _513).xyz;
    float3 _584;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _532 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_213, 1.0);
        float2 _536 = _532.xy / float2(_532.w);
        float _537 = _532.z;
        float4 _540 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _536, level(0.0));
        float3 _544 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _537;
        bool2 _569 = _536 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _571 = _536 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _584 = _317 * fast::max(_518 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _513) * (float3(1.0) - select(fast::clamp(exp((float3((((_540.x * _537) * 0.5) + dot((sin(_544) * _540.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_544)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _536, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_569.x || _571.x, _569.y || _571.y)))))), float3(0.0));
    }
    else
    {
        _584 = _317 * _518;
    }
    float3 _591 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _622;
    float3 _623;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _597 = in.in_var_PRIMITIVE_ID * 36u;
        bool _610 = any(abs(_213 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _597 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _597 + 19u)].xyz + float3(1.0)));
        float3 _620;
        if (_610)
        {
            _620 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _620 = _591;
        }
        _622 = _610 ? 1.0 : _295;
        _623 = _620;
    }
    else
    {
        _622 = _295;
        _623 = _591;
    }
    float4 _633 = float4((((mix(_584, _317 + (select(_309, float3(0.0), bool3(_312)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_335 + _350) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_320 * _320) - (_321 * _321)))) * View.View_SkyLightColor.xyz) * 1.0) * _317) * fast::max(float3(1.0), ((((((_294 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_294 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_294 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _623) * _429.w) + _429.xyz, _622);
    float3 _637 = _633.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_637.x, _637.y, _637.z, _633.w);
    return out;
}

