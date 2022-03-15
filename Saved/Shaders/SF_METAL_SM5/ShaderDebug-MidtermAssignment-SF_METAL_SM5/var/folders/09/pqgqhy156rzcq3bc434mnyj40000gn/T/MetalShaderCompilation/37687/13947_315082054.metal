

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

constant float3 _132 = {};

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

fragment MainPS_out Main_0000367b_12c7c546(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _173 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _178 = (_173.xyz / float3(_173.w)) - View.View_PreViewTranslation;
    float3 _186 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _197 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _199 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _206 = fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _207 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_197, _199, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _223 = ((_206 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _226 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _241;
    if (_226)
    {
        float3 _236 = _132;
        _236.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _238 = _236;
        _238.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _240 = _238;
        _240.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _241 = _240;
    }
    else
    {
        _241 = float3(0.0);
    }
    float _259;
    float3 _260;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _257;
        float3 _258;
        if (_226)
        {
            _257 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _258 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _257 = 1.0;
            _258 = _186;
        }
        _259 = _257;
        _260 = _258;
    }
    else
    {
        _259 = 1.0;
        _260 = _186;
    }
    float4 _264 = float4(_260, 1.0);
    float3 _268 = _132;
    _268.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _264);
    float3 _272 = _268;
    _272.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _264);
    float3 _276 = _272;
    _276.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _264);
    float4 _279 = _264.xyzz * _264.yzzx;
    float3 _283 = _132;
    _283.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _279);
    float3 _287 = _283;
    _287.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _279);
    float3 _291 = _287;
    _291.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _279);
    bool _322 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _371;
    if (_322)
    {
        float4 _329 = View.View_WorldToClip * float4(_178, 1.0);
        float _330 = _329.w;
        float4 _359;
        if (_322)
        {
            _359 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_329.xy / float2(_330)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_330 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _359 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _371 = float4(_359.xyz + (in.in_var_TEXCOORD7.xyz * _359.w), _359.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _371 = in.in_var_TEXCOORD7;
    }
    float3 _372 = _178 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _380 = (_372 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _393 = fast::clamp((float3(0.5) - abs(_380 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _407 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_372 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _380, level(0.0)), float4((_393.x * _393.y) * _393.z));
    float _414 = _407.w;
    float3 _416 = float4(_407.x * 0.886227548122406005859375, _407.y * 0.886227548122406005859375, _407.z * 0.886227548122406005859375, _414).xyz;
    float3 _482;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _430 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_372, 1.0);
        float2 _434 = _430.xy / float2(_430.w);
        float _435 = _430.z;
        float4 _438 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _434, level(0.0));
        float3 _442 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _435;
        bool2 _467 = _434 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _469 = _434 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _482 = _223 * fast::max(_416 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _414) * (float3(1.0) - select(fast::clamp(exp((float3((((_438.x * _435) * 0.5) + dot((sin(_442) * _438.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_442)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _434, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_467.x || _469.x, _467.y || _469.y)))))), float3(0.0));
    }
    else
    {
        _482 = _223 * _416;
    }
    float3 _487 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _514;
    float3 _515;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _502 = any(abs(_178 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _512;
        if (_502)
        {
            _512 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_178, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _512 = _487;
        }
        _514 = _502 ? 1.0 : _207;
        _515 = _512;
    }
    else
    {
        _514 = _207;
        _515 = _487;
    }
    float4 _525 = float4((((mix(_482, _223, float3(View.View_UnlitViewmodeMask)) + ((((_241 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_276 + _291) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_260.x * _260.x) - (_260.y * _260.y)))) * View.View_SkyLightColor.xyz) * _259)) * _223) * fast::max(float3(1.0), ((((((_206 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_206 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_206 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _515) * _371.w) + _371.xyz, _514);
    float3 _529 = _525.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_529.x, _529.y, _529.z, _525.w);
    return out;
}

