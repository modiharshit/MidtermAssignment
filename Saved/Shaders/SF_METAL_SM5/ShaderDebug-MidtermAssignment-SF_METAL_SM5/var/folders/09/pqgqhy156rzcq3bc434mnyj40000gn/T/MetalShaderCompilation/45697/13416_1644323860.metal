

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
    char _m1_pad[576];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[352];
    float3 View_PreViewTranslation;
    char _m3_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m7_pad[16];
    float View_OutOfBoundsMask;
    char _m8_pad[80];
    float View_UnlitViewmodeMask;
    char _m9_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m15_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m17_pad[16];
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

constant float3 _122 = {};
constant float _123 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003468_62026414(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _163 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _168 = (_163.xyz / float3(_163.w)) - View.View_PreViewTranslation;
    float3 _186 = fast::clamp((_168 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _197 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_186.x), int(_186.y), int(_186.z), 0).xyz), 0));
    float3 _212 = (((_197.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_186 / float3(_197.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _222 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _225 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _230;
    if (_225)
    {
        _230 = View.View_DiffuseOverrideParameter.xyz + (_222 * 0.449999988079071044921875);
    }
    else
    {
        _230 = View.View_DiffuseOverrideParameter.xyz;
    }
    float4 _236 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _212, level(0.0));
    float3 _241 = _122;
    _241.x = _236.x * 0.886227548122406005859375;
    float3 _243 = _241;
    _243.y = _236.y * 0.886227548122406005859375;
    float3 _245 = _243;
    _245.z = _236.z * 0.886227548122406005859375;
    float _266;
    float3 _267;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _261 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _212, level(0.0)).xyz * 2.0) - float3(1.0);
        float _262 = length(_261);
        _266 = _262;
        _267 = _261 / float3(fast::max(_262, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _266 = 1.0;
        _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _271 = float4(_267, 1.0);
    float3 _275 = _122;
    _275.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _271);
    float3 _279 = _275;
    _279.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _271);
    float3 _283 = _279;
    _283.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _271);
    float4 _286 = _271.xyzz * _271.yzzx;
    float3 _290 = _122;
    _290.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _286);
    float3 _294 = _290;
    _294.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _286);
    float3 _298 = _294;
    _298.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _286);
    bool _316 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _357;
    if (_316)
    {
        float4 _323 = View.View_WorldToClip * float4(_168, 1.0);
        float _324 = _323.w;
        float4 _352;
        if (_316)
        {
            _352 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_323.xy / float2(_324)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_324 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _352 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _357 = float4(_123, _123, _123, _352.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _357 = in.in_var_TEXCOORD7;
    }
    float3 _365 = (_168 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _378 = fast::clamp((float3(0.5) - abs(_365 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _391 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_168 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _365, level(0.0)), float4((_378.x * _378.y) * _378.z));
    float _398 = _391.w;
    float3 _400 = float4(_391.x * 0.886227548122406005859375, _391.y * 0.886227548122406005859375, _391.z * 0.886227548122406005859375, _398).xyz;
    float3 _466;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _414 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_168, 1.0);
        float2 _418 = _414.xy / float2(_414.w);
        float _419 = _414.z;
        float4 _422 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _418, level(0.0));
        float3 _426 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _419;
        bool2 _451 = _418 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _453 = _418 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _466 = _230 * fast::max(_400 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _398) * (float3(1.0) - select(fast::clamp(exp((float3((((_422.x * _419) * 0.5) + dot((sin(_426) * _422.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_426)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _418, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_451.x || _453.x, _451.y || _453.y)))))), float3(0.0));
    }
    else
    {
        _466 = _230 * _400;
    }
    float3 _502;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _478 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _501;
        if (any(abs(_168 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _478 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _478 + 19u)].xyz + float3(1.0))))
        {
            _501 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_168, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _501 = float3(0.0);
        }
        _502 = _501;
    }
    else
    {
        _502 = float3(0.0);
    }
    float4 _511 = float4((((mix(_466, _230 + (select(_222, float3(0.0), bool3(_225)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), _245) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_283 + _298) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_267.x * _267.x) - (_267.y * _267.y)))) * View.View_SkyLightColor.xyz) * _266)) * _230)) + _502) * _357.w) * 1.0, 0.0);
    float3 _515 = _511.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_515.x, _515.y, _515.z, _511.w);
    return out;
}

