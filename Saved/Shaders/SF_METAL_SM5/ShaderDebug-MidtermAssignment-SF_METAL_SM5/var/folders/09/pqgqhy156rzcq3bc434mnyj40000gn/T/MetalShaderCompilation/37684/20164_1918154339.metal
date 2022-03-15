

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
    char _m23_pad[16];
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

constant float4 _166 = {};
constant float3 _167 = {};

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

fragment MainPS_out Main_00004ec4_7254b663(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(6)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(10)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(11)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(12)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(13)]], texture2d<float> Material_Texture2D_0 [[texture(14)]], texture2d<float> Material_Texture2D_1 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float3 _248 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _274 = _231.w;
    float4 _284 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_231.xy / float2(_274)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _285 = _284.x;
    float _315;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _315 = _274;
                break;
            }
            else
            {
                float _308 = _231.z;
                _315 = ((_308 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_308 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _321 = fast::clamp(_262.xyz + _266.xyz, float3(0.0), float3(1.0));
    float _322 = fast::clamp(fast::min(fast::max(_266.w, 0.0), 1.0) * fast::min(fast::max(((((_285 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_285 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _315) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _332 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _343 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_332.x), int(_332.y), int(_332.z), 0).xyz), 0));
    float3 _358 = (((_343.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_332 / float3(_343.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _365 = (_321 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _372 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    float4 _386 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _358, level(0.0));
    float _402 = _386.x;
    float _405 = _386.y;
    float _408 = _386.z;
    float4 _425 = _166;
    _425.y = (-0.48860299587249755859375) * _248.y;
    float4 _428 = _425;
    _428.z = 0.48860299587249755859375 * _248.z;
    float4 _431 = _428;
    _431.w = (-0.48860299587249755859375) * _248.x;
    float4 _432 = _431;
    _432.x = 0.886227548122406005859375;
    float3 _434 = _432.yzw * 2.094395160675048828125;
    float4 _435 = float4(_432.x, _434.x, _434.y, _434.z);
    float3 _437 = _167;
    _437.x = dot(float4(_402, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _358, level(0.0)) * 2.0) - float4(1.0)) * _402) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _435);
    float3 _439 = _437;
    _439.y = dot(float4(_405, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _358, level(0.0)) * 2.0) - float4(1.0)) * _405) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _435);
    float3 _441 = _439;
    _441.z = dot(float4(_408, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _358, level(0.0)) * 2.0) - float4(1.0)) * _408) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _435);
    float _470;
    float _471;
    float3 _472;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _457 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _358, level(0.0)).xyz * 2.0) - float3(1.0);
        float _458 = length(_457);
        float3 _461 = _457 / float3(fast::max(_458, 9.9999997473787516355514526367188e-05));
        float _462 = 1.0 - _458;
        float _464 = 1.0 - (_462 * _462);
        _470 = mix(fast::clamp(dot(_461, _248), 0.0, 1.0), 1.0, _464);
        _471 = _458;
        _472 = mix(_461, _248, float3(_464));
    }
    else
    {
        _470 = 1.0;
        _471 = 1.0;
        _472 = _248;
    }
    float4 _476 = float4(_472, 1.0);
    float3 _480 = _167;
    _480.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _476);
    float3 _484 = _480;
    _484.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _476);
    float3 _488 = _484;
    _488.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _476);
    float4 _491 = _476.xyzz * _476.yzzx;
    float3 _495 = _167;
    _495.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _491);
    float3 _499 = _495;
    _499.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _491);
    float3 _503 = _499;
    _503.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _491);
    bool _535 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _583;
    if (_535)
    {
        float4 _542 = View.View_WorldToClip * float4(_240, 1.0);
        float _543 = _542.w;
        float4 _571;
        if (_535)
        {
            _571 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_542.xy / float2(_543)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_543 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _571 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _583 = float4(_571.xyz + (in.in_var_TEXCOORD7.xyz * _571.w), _571.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _583 = in.in_var_TEXCOORD7;
    }
    float3 _591 = (_240 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _599 = (_240 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _604 = fast::clamp((float3(0.5) - abs(_591 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _609 = (_604.x * _604.y) * _604.z;
    float4 _617 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _599, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _591, level(0.0)), float4(_609));
    float3 _628 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _599, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _591, level(0.0)).xyz, float3(_609)) * 1.0;
    float4 _630 = _166;
    _630.x = _617.x;
    float4 _632 = _166;
    _632.x = _617.y;
    float4 _634 = _166;
    _634.x = _617.z;
    float3 _635 = _617.xyz;
    float3 _639 = _635 / float3(dot(_635, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _641 = _628 * _639.x;
    float3 _644 = _628 * _639.y;
    float3 _647 = _628 * _639.z;
    float3 _650 = _167;
    _650.x = dot(float4(_630.x, _641.x, _641.y, _641.z), _435);
    float3 _652 = _650;
    _652.y = dot(float4(_632.x, _644.x, _644.y, _644.z), _435);
    float3 _654 = _652;
    _654.z = dot(float4(_634.x, _647.x, _647.y, _647.z), _435);
    float _656 = _617.w;
    float3 _661 = float4(fast::max(float3(0.0), _654), _656).xyz;
    float3 _727;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _675 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_240, 1.0);
        float2 _679 = _675.xy / float2(_675.w);
        float _680 = _675.z;
        float4 _683 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _679, level(0.0));
        float3 _687 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _680;
        bool2 _712 = _679 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _714 = _679 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _727 = _380 * fast::max(_661 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _656) * (float3(1.0) - select(fast::clamp(exp((float3((((_683.x * _680) * 0.5) + dot((sin(_687) * _683.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_687)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _679, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_712.x || _714.x, _712.y || _714.y)))))), float3(0.0));
    }
    else
    {
        _727 = _380 * _661;
    }
    float3 _734 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _765;
    float3 _766;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _740 = in.in_var_PRIMITIVE_ID * 36u;
        bool _753 = any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _740 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _740 + 19u)].xyz + float3(1.0)));
        float3 _763;
        if (_753)
        {
            _763 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _763 = _734;
        }
        _765 = _753 ? 1.0 : _322;
        _766 = _763;
    }
    else
    {
        _765 = _322;
        _766 = _734;
    }
    float4 _776 = float4((((mix(_727, _380 + (select(_372, float3(0.0), bool3(_375)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _441) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_488 + _503) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_472.x * _472.x) - (_472.y * _472.y)))) * View.View_SkyLightColor.xyz) * (_471 * _470))) * _380) * fast::max(float3(1.0), ((((((_321 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_321 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_321 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _766) * _583.w) + _583.xyz, _765);
    float3 _780 = _776.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_780.x, _780.y, _780.z, _776.w);
    return out;
}

