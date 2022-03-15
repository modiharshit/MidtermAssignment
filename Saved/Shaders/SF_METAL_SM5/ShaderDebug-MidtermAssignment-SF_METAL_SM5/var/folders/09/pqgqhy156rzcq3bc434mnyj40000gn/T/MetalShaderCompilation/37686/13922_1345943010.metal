

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
    char _m16_pad[80];
    float View_IndirectLightingCacheShowFlag;
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

struct type_IndirectLightingCache
{
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
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

constant float3 _131 = {};

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

fragment MainPS_out Main_00003662_503975e2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _171 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _176 = (_171.xyz / float3(_171.w)) - View.View_PreViewTranslation;
    float3 _184 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _195 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _197 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _204 = fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _205 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_195, _197, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _221 = ((_204 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _224 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _239;
    if (_224)
    {
        float3 _234 = _131;
        _234.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _236 = _234;
        _236.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _238 = _236;
        _238.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _239 = _238;
    }
    else
    {
        _239 = float3(0.0);
    }
    float _257;
    float3 _258;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _255;
        float3 _256;
        if (_224)
        {
            _255 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _256 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _255 = 1.0;
            _256 = _184;
        }
        _257 = _255;
        _258 = _256;
    }
    else
    {
        _257 = 1.0;
        _258 = _184;
    }
    float4 _262 = float4(_258, 1.0);
    float3 _266 = _131;
    _266.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _262);
    float3 _270 = _266;
    _270.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _262);
    float3 _274 = _270;
    _274.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _262);
    float4 _277 = _262.xyzz * _262.yzzx;
    float3 _281 = _131;
    _281.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _277);
    float3 _285 = _281;
    _285.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _277);
    float3 _289 = _285;
    _289.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _277);
    bool _320 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _369;
    if (_320)
    {
        float4 _327 = View.View_WorldToClip * float4(_176, 1.0);
        float _328 = _327.w;
        float4 _357;
        if (_320)
        {
            _357 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_327.xy / float2(_328)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_328 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _357 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _369 = float4(_357.xyz + (in.in_var_TEXCOORD7.xyz * _357.w), _357.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _369 = in.in_var_TEXCOORD7;
    }
    float3 _370 = _176 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _378 = (_370 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _391 = fast::clamp((float3(0.5) - abs(_378 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _405 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_370 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _378, level(0.0)), float4((_391.x * _391.y) * _391.z));
    float _412 = _405.w;
    float3 _414 = float4(_405.x * 0.886227548122406005859375, _405.y * 0.886227548122406005859375, _405.z * 0.886227548122406005859375, _412).xyz;
    float3 _480;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _428 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_370, 1.0);
        float2 _432 = _428.xy / float2(_428.w);
        float _433 = _428.z;
        float4 _436 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _432, level(0.0));
        float3 _440 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _433;
        bool2 _465 = _432 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _467 = _432 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _480 = _221 * fast::max(_414 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _412) * (float3(1.0) - select(fast::clamp(exp((float3((((_436.x * _433) * 0.5) + dot((sin(_440) * _436.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_440)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _432, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_465.x || _467.x, _465.y || _467.y)))))), float3(0.0));
    }
    else
    {
        _480 = _221 * _414;
    }
    float3 _485 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _512;
    float3 _513;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _500 = any(abs(_176 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _510;
        if (_500)
        {
            _510 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_176, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _510 = _485;
        }
        _512 = _500 ? 1.0 : _205;
        _513 = _510;
    }
    else
    {
        _512 = _205;
        _513 = _485;
    }
    float4 _523 = float4((((mix(_480, _221, float3(View.View_UnlitViewmodeMask)) + ((((_239 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_274 + _289) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_258.x * _258.x) - (_258.y * _258.y)))) * View.View_SkyLightColor.xyz) * _257)) * _221) * fast::max(float3(1.0), ((((((_204 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_204 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_204 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _513) * _369.w) + _369.xyz, _512);
    float3 _527 = _523.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_527.x, _527.y, _527.z, _523.w);
    return out;
}

