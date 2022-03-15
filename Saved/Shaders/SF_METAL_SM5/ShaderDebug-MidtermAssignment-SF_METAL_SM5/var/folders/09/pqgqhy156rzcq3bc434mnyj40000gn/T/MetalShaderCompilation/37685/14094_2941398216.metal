

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
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m16_pad[16];
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

constant float3 _134 = {};

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

fragment MainPS_out Main_0000370e_af522cc8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _176 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _181 = (_176.xyz / float3(_176.w)) - View.View_PreViewTranslation;
    float4 _200 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _202 = fast::clamp(_200.x, 0.0, 1.0);
    float3 _212 = fast::clamp((_181 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _223 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_212.x), int(_212.y), int(_212.z), 0).xyz), 0));
    float3 _238 = (((_223.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_212 / float3(_223.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _254 = ((float3(1.0) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _258 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _238, level(0.0));
    float3 _263 = _134;
    _263.x = _258.x * 0.886227548122406005859375;
    float3 _265 = _263;
    _265.y = _258.y * 0.886227548122406005859375;
    float3 _267 = _265;
    _267.z = _258.z * 0.886227548122406005859375;
    float _288;
    float3 _289;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _283 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _238, level(0.0)).xyz * 2.0) - float3(1.0);
        float _284 = length(_283);
        _288 = _284;
        _289 = _283 / float3(fast::max(_284, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _288 = 1.0;
        _289 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _293 = float4(_289, 1.0);
    float3 _297 = _134;
    _297.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _293);
    float3 _301 = _297;
    _301.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _293);
    float3 _305 = _301;
    _305.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _293);
    float4 _308 = _293.xyzz * _293.yzzx;
    float3 _312 = _134;
    _312.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _308);
    float3 _316 = _312;
    _316.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _308);
    float3 _320 = _316;
    _320.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _308);
    bool _339 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _387;
    if (_339)
    {
        float4 _346 = View.View_WorldToClip * float4(_181, 1.0);
        float _347 = _346.w;
        float4 _375;
        if (_339)
        {
            _375 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_346.xy / float2(_347)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_347 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _375 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _387 = float4(_375.xyz + (in.in_var_TEXCOORD7.xyz * _375.w), _375.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _387 = in.in_var_TEXCOORD7;
    }
    float3 _395 = (_181 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _408 = fast::clamp((float3(0.5) - abs(_395 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _421 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_181 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _395, level(0.0)), float4((_408.x * _408.y) * _408.z));
    float _428 = _421.w;
    float3 _430 = float4(_421.x * 0.886227548122406005859375, _421.y * 0.886227548122406005859375, _421.z * 0.886227548122406005859375, _428).xyz;
    float3 _496;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _444 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_181, 1.0);
        float2 _448 = _444.xy / float2(_444.w);
        float _449 = _444.z;
        float4 _452 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _448, level(0.0));
        float3 _456 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _449;
        bool2 _481 = _448 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _483 = _448 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _496 = _254 * fast::max(_430 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _428) * (float3(1.0) - select(fast::clamp(exp((float3((((_452.x * _449) * 0.5) + dot((sin(_456) * _452.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_456)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _448, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_481.x || _483.x, _481.y || _483.y)))))), float3(0.0));
    }
    else
    {
        _496 = _254 * _430;
    }
    float3 _501 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _532;
    float3 _533;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _507 = in.in_var_PRIMITIVE_ID * 36u;
        bool _520 = any(abs(_181 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _507 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _507 + 19u)].xyz + float3(1.0)));
        float3 _530;
        if (_520)
        {
            _530 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_181, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _530 = _501;
        }
        _532 = _520 ? 1.0 : _202;
        _533 = _530;
    }
    else
    {
        _532 = _202;
        _533 = _501;
    }
    float4 _543 = float4((((mix(_496, _254, float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _267) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_305 + _320) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_289.x * _289.x) - (_289.y * _289.y)))) * View.View_SkyLightColor.xyz) * _288)) * _254) * float3(1.000099658966064453125))) + _533) * _387.w) + _387.xyz, _532);
    float3 _547 = _543.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_547.x, _547.y, _547.z, _543.w);
    return out;
}

