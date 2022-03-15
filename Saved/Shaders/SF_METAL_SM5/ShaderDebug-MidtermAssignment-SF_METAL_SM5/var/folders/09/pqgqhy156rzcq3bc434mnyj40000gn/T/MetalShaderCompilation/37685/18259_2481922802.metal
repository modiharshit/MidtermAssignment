

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _150 = {};
constant float4 _152 = {};
constant float3 _153 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_TEXCOORD3_0 [[user(locn3)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn4)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004753_93ef22f2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(6)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(10)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _226 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _231 = (_226.xyz / float3(_226.w)) - View.View_PreViewTranslation;
    float3 _239 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _253 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _261 = mix(_257, _259, float4(in.in_var_TEXCOORD10.w));
    float _273 = _222.w;
    float4 _283 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_222.xy / float2(_273)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _284 = _283.x;
    float _314;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _314 = _273;
                break;
            }
            else
            {
                float _307 = _222.z;
                _314 = ((_307 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_307 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _320 = fast::clamp((_253.xyz + _261.xyz) * in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _321 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD2.w * _261.w, 0.0), 1.0) * fast::min(fast::max(((((_284 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_284 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _314) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _331 = fast::clamp((_231 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _342 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_331.x), int(_331.y), int(_331.z), 0).xyz), 0));
    float3 _357 = (((_342.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_331 / float3(_342.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _364 = (_320 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _371 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _374 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _379;
    if (_374)
    {
        _379 = _364 + (_371 * 0.449999988079071044921875);
    }
    else
    {
        _379 = _364;
    }
    float4 _385 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _357, level(0.0));
    float _401 = _385.x;
    float _404 = _385.y;
    float _407 = _385.z;
    float4 _424 = _152;
    _424.y = (-0.48860299587249755859375) * _239.y;
    float4 _427 = _424;
    _427.z = 0.48860299587249755859375 * _239.z;
    float4 _430 = _427;
    _430.w = (-0.48860299587249755859375) * _239.x;
    float4 _431 = _430;
    _431.x = 0.886227548122406005859375;
    float3 _433 = _431.yzw * 2.094395160675048828125;
    float4 _434 = float4(_431.x, _433.x, _433.y, _433.z);
    float3 _436 = _153;
    _436.x = dot(float4(_401, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _357, level(0.0)) * 2.0) - float4(1.0)) * _401) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _434);
    float3 _438 = _436;
    _438.y = dot(float4(_404, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _357, level(0.0)) * 2.0) - float4(1.0)) * _404) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _434);
    float3 _440 = _438;
    _440.z = dot(float4(_407, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _357, level(0.0)) * 2.0) - float4(1.0)) * _407) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _434);
    float _469;
    float _470;
    float3 _471;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _456 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _357, level(0.0)).xyz * 2.0) - float3(1.0);
        float _457 = length(_456);
        float3 _460 = _456 / float3(fast::max(_457, 9.9999997473787516355514526367188e-05));
        float _461 = 1.0 - _457;
        float _463 = 1.0 - (_461 * _461);
        _469 = mix(fast::clamp(dot(_460, _239), 0.0, 1.0), 1.0, _463);
        _470 = _457;
        _471 = mix(_460, _239, float3(_463));
    }
    else
    {
        _469 = 1.0;
        _470 = 1.0;
        _471 = _239;
    }
    float4 _475 = float4(_471, 1.0);
    float3 _479 = _153;
    _479.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _475);
    float3 _483 = _479;
    _483.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _475);
    float3 _487 = _483;
    _487.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _475);
    float4 _490 = _475.xyzz * _475.yzzx;
    float3 _494 = _153;
    _494.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _490);
    float3 _498 = _494;
    _498.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _490);
    float3 _502 = _498;
    _502.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _490);
    bool _534 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _582;
    if (_534)
    {
        float4 _541 = View.View_WorldToClip * float4(_231, 1.0);
        float _542 = _541.w;
        float4 _570;
        if (_534)
        {
            _570 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_541.xy / float2(_542)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_542 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _570 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _582 = float4(_570.xyz + (in.in_var_TEXCOORD7.xyz * _570.w), _570.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _582 = in.in_var_TEXCOORD7;
    }
    float3 _583 = _231 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _591 = (_583 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _599 = (_583 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _604 = fast::clamp((float3(0.5) - abs(_591 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _609 = (_604.x * _604.y) * _604.z;
    float4 _617 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _599, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _591, level(0.0)), float4(_609));
    float3 _628 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _599, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _591, level(0.0)).xyz, float3(_609)) * 1.0;
    float4 _630 = _152;
    _630.x = _617.x;
    float4 _632 = _152;
    _632.x = _617.y;
    float4 _634 = _152;
    _634.x = _617.z;
    float3 _635 = _617.xyz;
    float3 _639 = _635 / float3(dot(_635, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _641 = _628 * _639.x;
    float3 _644 = _628 * _639.y;
    float3 _647 = _628 * _639.z;
    float3 _650 = _153;
    _650.x = dot(float4(_630.x, _641.x, _641.y, _641.z), _434);
    float3 _652 = _650;
    _652.y = dot(float4(_632.x, _644.x, _644.y, _644.z), _434);
    float3 _654 = _652;
    _654.z = dot(float4(_634.x, _647.x, _647.y, _647.z), _434);
    float3 _668 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _695;
    float3 _696;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _683 = any(abs(_231 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _693;
        if (_683)
        {
            _693 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_231, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _693 = _668;
        }
        _695 = _683 ? 1.0 : _321;
        _696 = _693;
    }
    else
    {
        _695 = _321;
        _696 = _668;
    }
    float4 _706 = float4((((mix(_379 * float4(fast::max(float3(0.0), _654), _150).xyz, _379 + (select(_371, float3(0.0), bool3(_374)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _440) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_487 + _502) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_471.x * _471.x) - (_471.y * _471.y)))) * View.View_SkyLightColor.xyz) * (_470 * _469))) * _379) * fast::max(float3(1.0), ((((((_320 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_320 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_320 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _696) * _582.w) + _582.xyz, _695);
    float3 _710 = _706.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_710.x, _710.y, _710.z, _706.w);
    return out;
}

