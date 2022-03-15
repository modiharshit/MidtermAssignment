

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

constant float3 _139 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD1 [[user(locn2)]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_COLOR1 [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000037fe_784a8d58(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _183 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _188 = (_183.xyz / float3(_183.w)) - View.View_PreViewTranslation;
    float4 _207 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD1.xy);
    float4 _209 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_TEXCOORD2.xy);
    float3 _216 = fast::clamp(in.in_var_COLOR1.xyz, float3(0.0), float3(1.0));
    float _217 = fast::clamp(in.in_var_COLOR1.w * mix(_207, _209, float4(in.in_var_TEXCOORD2.z)).x, 0.0, 1.0);
    float3 _227 = fast::clamp((_188 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _238 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_227.x), int(_227.y), int(_227.z), 0).xyz), 0));
    float3 _253 = (((_238.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_227 / float3(_238.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _269 = ((_216 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _273 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _253, level(0.0));
    float3 _278 = _139;
    _278.x = _273.x * 0.886227548122406005859375;
    float3 _280 = _278;
    _280.y = _273.y * 0.886227548122406005859375;
    float3 _282 = _280;
    _282.z = _273.z * 0.886227548122406005859375;
    float _303;
    float3 _304;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _298 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _253, level(0.0)).xyz * 2.0) - float3(1.0);
        float _299 = length(_298);
        _303 = _299;
        _304 = _298 / float3(fast::max(_299, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _303 = 1.0;
        _304 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _308 = float4(_304, 1.0);
    float3 _312 = _139;
    _312.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _308);
    float3 _316 = _312;
    _316.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _308);
    float3 _320 = _316;
    _320.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _308);
    float4 _323 = _308.xyzz * _308.yzzx;
    float3 _327 = _139;
    _327.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _323);
    float3 _331 = _327;
    _331.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _323);
    float3 _335 = _331;
    _335.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _323);
    bool _366 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _414;
    if (_366)
    {
        float4 _373 = View.View_WorldToClip * float4(_188, 1.0);
        float _374 = _373.w;
        float4 _402;
        if (_366)
        {
            _402 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_373.xy / float2(_374)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_374 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _402 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _414 = float4(_402.xyz + (in.in_var_TEXCOORD7.xyz * _402.w), _402.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _414 = in.in_var_TEXCOORD7;
    }
    float3 _422 = (_188 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _435 = fast::clamp((float3(0.5) - abs(_422 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _448 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_188 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _422, level(0.0)), float4((_435.x * _435.y) * _435.z));
    float _455 = _448.w;
    float3 _457 = float4(_448.x * 0.886227548122406005859375, _448.y * 0.886227548122406005859375, _448.z * 0.886227548122406005859375, _455).xyz;
    float3 _523;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _471 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_188, 1.0);
        float2 _475 = _471.xy / float2(_471.w);
        float _476 = _471.z;
        float4 _479 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _475, level(0.0));
        float3 _483 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _476;
        bool2 _508 = _475 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _510 = _475 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _523 = _269 * fast::max(_457 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _455) * (float3(1.0) - select(fast::clamp(exp((float3((((_479.x * _476) * 0.5) + dot((sin(_483) * _479.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_483)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _475, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_508.x || _510.x, _508.y || _510.y)))))), float3(0.0));
    }
    else
    {
        _523 = _269 * _457;
    }
    float3 _528 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _555;
    float3 _556;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _543 = any(abs(_188 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _553;
        if (_543)
        {
            _553 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_188, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _553 = _528;
        }
        _555 = _543 ? 1.0 : _217;
        _556 = _553;
    }
    else
    {
        _555 = _217;
        _556 = _528;
    }
    float4 _566 = float4((((mix(_523, _269, float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _282) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_320 + _335) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_304.x * _304.x) - (_304.y * _304.y)))) * View.View_SkyLightColor.xyz) * _303)) * _269) * fast::max(float3(1.0), ((((((_216 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_216 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_216 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _556) * _414.w) + _414.xyz, _555);
    float3 _570 = _566.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_570.x, _570.y, _570.z, _566.w);
    return out;
}

