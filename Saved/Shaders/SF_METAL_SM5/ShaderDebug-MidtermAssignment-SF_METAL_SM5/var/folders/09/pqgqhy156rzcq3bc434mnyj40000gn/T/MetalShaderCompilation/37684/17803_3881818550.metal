

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
    char _m19_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m21_pad[16];
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

constant float4 _162 = {};
constant float3 _163 = {};

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

fragment MainPS_out Main_0000458b_e75fd9b6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(5)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(6)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(7)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(8)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner [[texture(9)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter [[texture(10)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(11)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    float3 _241 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _267 = _224.w;
    float4 _277 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_224.xy / float2(_267)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _278 = _277.x;
    float _308;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _308 = _267;
                break;
            }
            else
            {
                float _301 = _224.z;
                _308 = ((_301 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_301 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _314 = fast::clamp(_255.xyz + _259.xyz, float3(0.0), float3(1.0));
    float _315 = fast::clamp(fast::min(fast::max(_259.w, 0.0), 1.0) * fast::min(fast::max(((((_278 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_278 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _308) * 0.006666666828095912933349609375, 0.0), 1.0), 0.0, 1.0);
    float3 _325 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _336 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_325.x), int(_325.y), int(_325.z), 0).xyz), 0));
    float3 _351 = (((_336.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_325 / float3(_336.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _358 = (_314 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _365 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _368 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _373;
    if (_368)
    {
        _373 = _358 + (_365 * 0.449999988079071044921875);
    }
    else
    {
        _373 = _358;
    }
    float4 _379 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _351, level(0.0));
    float _395 = _379.x;
    float _398 = _379.y;
    float _401 = _379.z;
    float4 _418 = _162;
    _418.y = (-0.48860299587249755859375) * _241.y;
    float4 _421 = _418;
    _421.z = 0.48860299587249755859375 * _241.z;
    float4 _424 = _421;
    _424.w = (-0.48860299587249755859375) * _241.x;
    float4 _425 = _424;
    _425.x = 0.886227548122406005859375;
    float3 _427 = _425.yzw * 2.094395160675048828125;
    float4 _428 = float4(_425.x, _427.x, _427.y, _427.z);
    float3 _430 = _163;
    _430.x = dot(float4(_395, ((((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _351, level(0.0)) * 2.0) - float4(1.0)) * _395) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _428);
    float3 _432 = _430;
    _432.y = dot(float4(_398, ((((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _351, level(0.0)) * 2.0) - float4(1.0)) * _398) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _428);
    float3 _434 = _432;
    _434.z = dot(float4(_401, ((((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _351, level(0.0)) * 2.0) - float4(1.0)) * _401) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625)).xyz), _428);
    bool _456 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _504;
    if (_456)
    {
        float4 _463 = View.View_WorldToClip * float4(_233, 1.0);
        float _464 = _463.w;
        float4 _492;
        if (_456)
        {
            _492 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_463.xy / float2(_464)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_464 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _492 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _504 = float4(_492.xyz + (in.in_var_TEXCOORD7.xyz * _492.w), _492.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _504 = in.in_var_TEXCOORD7;
    }
    float3 _512 = (_233 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _520 = (_233 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz;
    float3 _525 = fast::clamp((float3(0.5) - abs(_512 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float _530 = (_525.x * _525.y) * _525.z;
    float4 _538 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, _520, level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _512, level(0.0)), float4(_530));
    float3 _549 = mix(TranslucentBasePass_TranslucencyLightingVolumeDirectionalOuter.sample(View_SharedBilinearClampedSampler, _520, level(0.0)).xyz, TranslucentBasePass_TranslucencyLightingVolumeDirectionalInner.sample(View_SharedBilinearClampedSampler, _512, level(0.0)).xyz, float3(_530)) * 1.0;
    float4 _551 = _162;
    _551.x = _538.x;
    float4 _553 = _162;
    _553.x = _538.y;
    float4 _555 = _162;
    _555.x = _538.z;
    float3 _556 = _538.xyz;
    float3 _560 = _556 / float3(dot(_556, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) + 9.9999997473787516355514526367188e-06);
    float3 _562 = _549 * _560.x;
    float3 _565 = _549 * _560.y;
    float3 _568 = _549 * _560.z;
    float3 _571 = _163;
    _571.x = dot(float4(_551.x, _562.x, _562.y, _562.z), _428);
    float3 _573 = _571;
    _573.y = dot(float4(_553.x, _565.x, _565.y, _565.z), _428);
    float3 _575 = _573;
    _575.z = dot(float4(_555.x, _568.x, _568.y, _568.z), _428);
    float _577 = _538.w;
    float3 _582 = float4(fast::max(float3(0.0), _575), _577).xyz;
    float3 _648;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _596 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_233, 1.0);
        float2 _600 = _596.xy / float2(_596.w);
        float _601 = _596.z;
        float4 _604 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _600, level(0.0));
        float3 _608 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _601;
        bool2 _633 = _600 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _635 = _600 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _648 = _373 * fast::max(_582 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _577) * (float3(1.0) - select(fast::clamp(exp((float3((((_604.x * _601) * 0.5) + dot((sin(_608) * _604.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_608)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _600, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_633.x || _635.x, _633.y || _635.y)))))), float3(0.0));
    }
    else
    {
        _648 = _373 * _582;
    }
    float3 _655 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _686;
    float3 _687;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _661 = in.in_var_PRIMITIVE_ID * 36u;
        bool _674 = any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _661 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _661 + 19u)].xyz + float3(1.0)));
        float3 _684;
        if (_674)
        {
            _684 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _684 = _655;
        }
        _686 = _674 ? 1.0 : _315;
        _687 = _684;
    }
    else
    {
        _686 = _315;
        _687 = _655;
    }
    float4 _697 = float4((((mix(_648, _373 + (select(_365, float3(0.0), bool3(_368)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _434) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _373) * fast::max(float3(1.0), ((((((_314 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_314 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_314 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _687) * _504.w) + _504.xyz, _686);
    float3 _701 = _697.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_701.x, _701.y, _701.z, _697.w);
    return out;
}

