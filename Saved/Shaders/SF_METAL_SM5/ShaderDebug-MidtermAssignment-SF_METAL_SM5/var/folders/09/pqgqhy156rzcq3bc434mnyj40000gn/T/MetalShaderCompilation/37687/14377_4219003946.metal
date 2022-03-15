

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

constant float3 _140 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003829_fb78e42a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(6)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _184 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _189 = (_184.xyz / float3(_184.w)) - View.View_PreViewTranslation;
    float4 _208 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _210 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _217 = fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _218 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_208, _210, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _228 = fast::clamp((_189 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _239 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_228.x), int(_228.y), int(_228.z), 0).xyz), 0));
    float3 _254 = (((_239.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_228 / float3(_239.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _270 = ((_217 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _274 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _254, level(0.0));
    float3 _279 = _140;
    _279.x = _274.x * 0.886227548122406005859375;
    float3 _281 = _279;
    _281.y = _274.y * 0.886227548122406005859375;
    float3 _283 = _281;
    _283.z = _274.z * 0.886227548122406005859375;
    float _304;
    float3 _305;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _299 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _254, level(0.0)).xyz * 2.0) - float3(1.0);
        float _300 = length(_299);
        _304 = _300;
        _305 = _299 / float3(fast::max(_300, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _304 = 1.0;
        _305 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _309 = float4(_305, 1.0);
    float3 _313 = _140;
    _313.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _309);
    float3 _317 = _313;
    _317.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _309);
    float3 _321 = _317;
    _321.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _309);
    float4 _324 = _309.xyzz * _309.yzzx;
    float3 _328 = _140;
    _328.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _324);
    float3 _332 = _328;
    _332.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _324);
    float3 _336 = _332;
    _336.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _324);
    bool _367 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _415;
    if (_367)
    {
        float4 _374 = View.View_WorldToClip * float4(_189, 1.0);
        float _375 = _374.w;
        float4 _403;
        if (_367)
        {
            _403 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_374.xy / float2(_375)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_375 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _403 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _415 = float4(_403.xyz + (in.in_var_TEXCOORD7.xyz * _403.w), _403.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _415 = in.in_var_TEXCOORD7;
    }
    float3 _416 = _189 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _424 = (_416 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _437 = fast::clamp((float3(0.5) - abs(_424 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _450 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_416 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _424, level(0.0)), float4((_437.x * _437.y) * _437.z));
    float _457 = _450.w;
    float3 _459 = float4(_450.x * 0.886227548122406005859375, _450.y * 0.886227548122406005859375, _450.z * 0.886227548122406005859375, _457).xyz;
    float3 _525;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _473 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_416, 1.0);
        float2 _477 = _473.xy / float2(_473.w);
        float _478 = _473.z;
        float4 _481 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _477, level(0.0));
        float3 _485 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _478;
        bool2 _510 = _477 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _512 = _477 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _525 = _270 * fast::max(_459 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _457) * (float3(1.0) - select(fast::clamp(exp((float3((((_481.x * _478) * 0.5) + dot((sin(_485) * _481.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_485)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _477, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_510.x || _512.x, _510.y || _512.y)))))), float3(0.0));
    }
    else
    {
        _525 = _270 * _459;
    }
    float3 _530 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _557;
    float3 _558;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _545 = any(abs(_189 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _555;
        if (_545)
        {
            _555 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_189, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _555 = _530;
        }
        _557 = _545 ? 1.0 : _218;
        _558 = _555;
    }
    else
    {
        _557 = _218;
        _558 = _530;
    }
    float4 _568 = float4((((mix(_525, _270, float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _283) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_321 + _336) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_305.x * _305.x) - (_305.y * _305.y)))) * View.View_SkyLightColor.xyz) * _304)) * _270) * fast::max(float3(1.0), ((((((_217 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_217 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_217 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _558) * _415.w) + _415.xyz, _557);
    float3 _572 = _568.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_572.x, _572.y, _572.z, _568.w);
    return out;
}

