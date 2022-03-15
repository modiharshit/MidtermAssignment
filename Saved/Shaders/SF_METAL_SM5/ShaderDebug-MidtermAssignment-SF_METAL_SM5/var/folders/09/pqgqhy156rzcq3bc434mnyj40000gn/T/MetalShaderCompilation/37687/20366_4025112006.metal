

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

constant float4 _170 = {};
constant float3 _171 = {};

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

fragment MainPS_out Main_00004f8e_efea55c6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(6)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(10)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(11)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(12)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(13)]], texture2d<float> Material_Texture2D_0 [[texture(14)]], texture2d<float> Material_Texture2D_1 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _241 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _245 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _250 = (_245.xyz / float3(_245.w)) - View.View_PreViewTranslation;
    float3 _258 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _272 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _280 = mix(_276, _278, float4(in.in_var_TEXCOORD4.x));
    float _292 = _241.w;
    float4 _302 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_241.xy / float2(_292)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _303 = _302.x;
    float _333;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _333 = _292;
                break;
            }
            else
            {
                float _326 = _241.z;
                _333 = ((_326 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_326 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _339 = fast::clamp((_272.xyz + _280.xyz) * in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _340 = fast::clamp(fast::min(fast::max(in.in_var_TEXCOORD5.w * _280.w, 0.0), 1.0) * fast::min(fast::max(((((_303 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_303 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _333) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _350 = fast::clamp((_250 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _361 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_350.x), int(_350.y), int(_350.z), 0).xyz), 0));
    float3 _376 = (((_361.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_350 / float3(_361.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _383 = (_339 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _390 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _393 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _398;
    if (_393)
    {
        _398 = _383 + (_390 * 0.449999988079071044921875);
    }
    else
    {
        _398 = _383;
    }
    float4 _404 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _376, level(0.0));
    float _420 = _404.x;
    float _423 = _404.y;
    float _426 = _404.z;
    float4 _443 = _170;
    _443.y = (-0.48860299587249755859375) * _258.y;
    float4 _446 = _443;
    _446.z = 0.48860299587249755859375 * _258.z;
    float4 _449 = _446;
    _449.w = (-0.48860299587249755859375) * _258.x;
    float4 _450 = _449;
    _450.x = 0.886227548122406005859375;
    float3 _452 = _450.yzw * 2.094395160675048828125;
    float4 _453 = float4(_450.x, _452.x, _452.y, _452.z);
    float3 _455 = _171;
    _455.x = dot(float4(_420, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _376, level(0.0)) * 2.0) - float4(1.0)) * _420) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _453);
    float3 _457 = _455;
    _457.y = dot(float4(_423, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _376, level(0.0)) * 2.0) - float4(1.0)) * _423) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _453);
    float3 _459 = _457;
    _459.z = dot(float4(_426, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _376, level(0.0)) * 2.0) - float4(1.0)) * _426) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _453);
    float _488;
    float _489;
    float3 _490;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _475 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _376, level(0.0)).xyz * 2.0) - float3(1.0);
        float _476 = length(_475);
        float3 _479 = _475 / float3(fast::max(_476, 9.9999997473787516355514526367188e-05));
        float _480 = 1.0 - _476;
        float _482 = 1.0 - (_480 * _480);
        _488 = mix(fast::clamp(dot(_479, _258), 0.0, 1.0), 1.0, _482);
        _489 = _476;
        _490 = mix(_479, _258, float3(_482));
    }
    else
    {
        _488 = 1.0;
        _489 = 1.0;
        _490 = _258;
    }
    float4 _494 = float4(_490, 1.0);
    float3 _498 = _171;
    _498.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _494);
    float3 _502 = _498;
    _502.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _494);
    float3 _506 = _502;
    _506.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _494);
    float4 _509 = _494.xyzz * _494.yzzx;
    float3 _513 = _171;
    _513.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _509);
    float3 _517 = _513;
    _517.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _509);
    float3 _521 = _517;
    _521.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _509);
    bool _553 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _601;
    if (_553)
    {
        float4 _560 = View.View_WorldToClip * float4(_250, 1.0);
        float _561 = _560.w;
        float4 _589;
        if (_553)
        {
            _589 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_560.xy / float2(_561)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_561 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _589 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _601 = float4(_589.xyz + (in.in_var_TEXCOORD7.xyz * _589.w), _589.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _601 = in.in_var_TEXCOORD7;
    }
    float3 _602 = _250 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _610 = (_602 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _618 = (_602 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _623 = fast::clamp((float3(0.5) - abs(_610 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _628 = (_623.x * _623.y) * _623.z;
    float4 _636 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _618, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _610, level(0.0)), float4(_628));
    float3 _647 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _618, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _610, level(0.0)).xyz, float3(_628)) * 1.0;
    float4 _649 = _170;
    _649.x = _636.x;
    float4 _651 = _170;
    _651.x = _636.y;
    float4 _653 = _170;
    _653.x = _636.z;
    float3 _654 = _636.xyz;
    float3 _658 = _654 / float3(dot(_654, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _660 = _647 * _658.x;
    float3 _663 = _647 * _658.y;
    float3 _666 = _647 * _658.z;
    float3 _669 = _171;
    _669.x = dot(float4(_649.x, _660.x, _660.y, _660.z), _453);
    float3 _671 = _669;
    _671.y = dot(float4(_651.x, _663.x, _663.y, _663.z), _453);
    float3 _673 = _671;
    _673.z = dot(float4(_653.x, _666.x, _666.y, _666.z), _453);
    float _675 = _636.w;
    float3 _680 = float4(fast::max(float3(0.0), _673), _675).xyz;
    float3 _746;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _694 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_602, 1.0);
        float2 _698 = _694.xy / float2(_694.w);
        float _699 = _694.z;
        float4 _702 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _698, level(0.0));
        float3 _706 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _699;
        bool2 _731 = _698 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _733 = _698 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _746 = _398 * fast::max(_680 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _675) * (float3(1.0) - select(fast::clamp(exp((float3((((_702.x * _699) * 0.5) + dot((sin(_706) * _702.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_706)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _698, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_731.x || _733.x, _731.y || _733.y)))))), float3(0.0));
    }
    else
    {
        _746 = _398 * _680;
    }
    float3 _753 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _780;
    float3 _781;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _768 = any(abs(_250 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _778;
        if (_768)
        {
            _778 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_250, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _778 = _753;
        }
        _780 = _768 ? 1.0 : _340;
        _781 = _778;
    }
    else
    {
        _780 = _340;
        _781 = _753;
    }
    float4 _791 = float4((((mix(_746, _398 + (select(_390, float3(0.0), bool3(_393)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _459) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_506 + _521) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_490.x * _490.x) - (_490.y * _490.y)))) * View.View_SkyLightColor.xyz) * (_489 * _488))) * _398) * fast::max(float3(1.0), ((((((_339 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_339 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_339 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _781) * _601.w) + _601.xyz, _780);
    float3 _795 = _791.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_795.x, _795.y, _795.z, _791.w);
    return out;
}

