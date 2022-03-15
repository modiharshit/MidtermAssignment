

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

constant float3 _141 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 in_var_TEXCOORD4 [[user(locn1)]];
    float4 in_var_TEXCOORD5 [[user(locn2)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 in_var_TANGENTX [[user(locn4)]];
    float4 in_var_TANGENTZ [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003842_bcf01ca0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _186 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _191 = (_186.xyz / float3(_186.w)) - View.View_PreViewTranslation;
    float4 _210 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _212 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _219 = fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _220 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_210, _212, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _230 = fast::clamp((_191 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _241 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_230.x), int(_230.y), int(_230.z), 0).xyz), 0));
    float3 _256 = (((_241.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_230 / float3(_241.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _272 = ((_219 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _276 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _256, level(0.0));
    float3 _281 = _141;
    _281.x = _276.x * 0.886227548122406005859375;
    float3 _283 = _281;
    _283.y = _276.y * 0.886227548122406005859375;
    float3 _285 = _283;
    _285.z = _276.z * 0.886227548122406005859375;
    float _306;
    float3 _307;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _301 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _256, level(0.0)).xyz * 2.0) - float3(1.0);
        float _302 = length(_301);
        _306 = _302;
        _307 = _301 / float3(fast::max(_302, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _306 = 1.0;
        _307 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _311 = float4(_307, 1.0);
    float3 _315 = _141;
    _315.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _311);
    float3 _319 = _315;
    _319.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _311);
    float3 _323 = _319;
    _323.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _311);
    float4 _326 = _311.xyzz * _311.yzzx;
    float3 _330 = _141;
    _330.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _326);
    float3 _334 = _330;
    _334.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _326);
    float3 _338 = _334;
    _338.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _326);
    bool _369 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _417;
    if (_369)
    {
        float4 _376 = View.View_WorldToClip * float4(_191, 1.0);
        float _377 = _376.w;
        float4 _405;
        if (_369)
        {
            _405 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_376.xy / float2(_377)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_377 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _405 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _417 = float4(_405.xyz + (in.in_var_TEXCOORD7.xyz * _405.w), _405.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _417 = in.in_var_TEXCOORD7;
    }
    float3 _418 = _191 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _426 = (_418 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _439 = fast::clamp((float3(0.5) - abs(_426 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _452 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_418 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _426, level(0.0)), float4((_439.x * _439.y) * _439.z));
    float _459 = _452.w;
    float3 _461 = float4(_452.x * 0.886227548122406005859375, _452.y * 0.886227548122406005859375, _452.z * 0.886227548122406005859375, _459).xyz;
    float3 _527;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _475 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_418, 1.0);
        float2 _479 = _475.xy / float2(_475.w);
        float _480 = _475.z;
        float4 _483 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _479, level(0.0));
        float3 _487 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _480;
        bool2 _512 = _479 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _514 = _479 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _527 = _272 * fast::max(_461 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _459) * (float3(1.0) - select(fast::clamp(exp((float3((((_483.x * _480) * 0.5) + dot((sin(_487) * _483.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_487)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _479, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_512.x || _514.x, _512.y || _514.y)))))), float3(0.0));
    }
    else
    {
        _527 = _272 * _461;
    }
    float3 _532 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _559;
    float3 _560;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _547 = any(abs(_191 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _557;
        if (_547)
        {
            _557 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_191, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _557 = _532;
        }
        _559 = _547 ? 1.0 : _220;
        _560 = _557;
    }
    else
    {
        _559 = _220;
        _560 = _532;
    }
    float4 _570 = float4((((mix(_527, _272, float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _285) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_323 + _338) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_307.x * _307.x) - (_307.y * _307.y)))) * View.View_SkyLightColor.xyz) * _306)) * _272) * fast::max(float3(1.0), ((((((_219 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_219 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_219 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _560) * _417.w) + _417.xyz, _559);
    float3 _574 = _570.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_574.x, _574.y, _574.z, _570.w);
    return out;
}

