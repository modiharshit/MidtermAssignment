

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
    char _m8_pad[24];
    float View_CullingSign;
    char _m9_pad[52];
    float View_UnlitViewmodeMask;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m12_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m18_pad[16];
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

constant float3 _146 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003c8d_1a78e3c4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _194 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _199 = (_194.xyz / float3(_194.w)) - View.View_PreViewTranslation;
    uint _200 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _232 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _233 = dfdx(_232);
    float _234 = dot(_233, _233);
    float3 _235 = dfdy(_232);
    float _236 = dot(_235, _235);
    float _244 = 1.0 / sqrt((abs(_234 - _236) > 9.9999997473787516355514526367188e-06) ? ((_234 >= _236) ? _234 : _236) : _236);
    float3 _253 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _254 = fast::clamp((((_227.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _244)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _244), 0.0), 1.0), 0.0, 1.0);
    float3 _264 = fast::clamp((_199 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _275 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_264.x), int(_264.y), int(_264.z), 0).xyz), 0));
    float3 _290 = (((_275.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_264 / float3(_275.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _297 = (_253 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _304 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _307 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _312;
    if (_307)
    {
        _312 = _297 + (_304 * 0.449999988079071044921875);
    }
    else
    {
        _312 = _297;
    }
    float4 _318 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _290, level(0.0));
    float3 _323 = _146;
    _323.x = _318.x * 0.886227548122406005859375;
    float3 _325 = _323;
    _325.y = _318.y * 0.886227548122406005859375;
    float3 _327 = _325;
    _327.z = _318.z * 0.886227548122406005859375;
    float _348;
    float3 _349;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _343 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _290, level(0.0)).xyz * 2.0) - float3(1.0);
        float _344 = length(_343);
        _348 = _344;
        _349 = _343 / float3(fast::max(_344, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _348 = 1.0;
        _349 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    }
    float4 _353 = float4(_349, 1.0);
    float3 _357 = _146;
    _357.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _353);
    float3 _361 = _357;
    _361.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _353);
    float3 _365 = _361;
    _365.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _353);
    float4 _368 = _353.xyzz * _353.yzzx;
    float3 _372 = _146;
    _372.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _368);
    float3 _376 = _372;
    _376.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _368);
    float3 _380 = _376;
    _380.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _368);
    bool _411 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _459;
    if (_411)
    {
        float4 _418 = View.View_WorldToClip * float4(_199, 1.0);
        float _419 = _418.w;
        float4 _447;
        if (_411)
        {
            _447 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_418.xy / float2(_419)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_419 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _447 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _459 = float4(_447.xyz + (in.in_var_TEXCOORD7.xyz * _447.w), _447.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _459 = in.in_var_TEXCOORD7;
    }
    float3 _467 = (_199 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _480 = fast::clamp((float3(0.5) - abs(_467 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _493 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_199 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _467, level(0.0)), float4((_480.x * _480.y) * _480.z));
    float _500 = _493.w;
    float3 _502 = float4(_493.x * 0.886227548122406005859375, _493.y * 0.886227548122406005859375, _493.z * 0.886227548122406005859375, _500).xyz;
    float3 _568;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _516 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_199, 1.0);
        float2 _520 = _516.xy / float2(_516.w);
        float _521 = _516.z;
        float4 _524 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _520, level(0.0));
        float3 _528 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _521;
        bool2 _553 = _520 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _555 = _520 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _568 = _312 * fast::max(_502 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _500) * (float3(1.0) - select(fast::clamp(exp((float3((((_524.x * _521) * 0.5) + dot((sin(_528) * _524.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_528)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _520, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_553.x || _555.x, _553.y || _555.y)))))), float3(0.0));
    }
    else
    {
        _568 = _312 * _502;
    }
    float3 _575 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _605;
    float3 _606;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _593 = any(abs(_199 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200 + 19u)].xyz + float3(1.0)));
        float3 _603;
        if (_593)
        {
            _603 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_199, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _603 = _575;
        }
        _605 = _593 ? 1.0 : _254;
        _606 = _603;
    }
    else
    {
        _605 = _254;
        _606 = _575;
    }
    float4 _616 = float4((((mix(_568, _312 + (select(_304, float3(0.0), bool3(_307)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _327) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_365 + _380) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_349.x * _349.x) - (_349.y * _349.y)))) * View.View_SkyLightColor.xyz) * _348)) * _312) * fast::max(float3(1.0), ((((((_253 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_253 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_253 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _606) * _459.w) + _459.xyz, _605);
    float3 _620 = _616.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_620.x, _620.y, _620.z, _616.w);
    return out;
}

