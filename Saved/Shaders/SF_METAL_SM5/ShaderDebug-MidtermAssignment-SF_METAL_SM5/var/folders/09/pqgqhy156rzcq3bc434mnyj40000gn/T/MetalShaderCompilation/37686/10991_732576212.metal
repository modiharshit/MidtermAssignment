

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
    char _m6_pad[32];
    float View_OutOfBoundsMask;
    char _m7_pad[80];
    float View_UnlitViewmodeMask;
    char _m8_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m10_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[800];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m13_pad[80];
    float View_IndirectLightingCacheShowFlag;
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
    char _m0_pad[96];
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

constant float3 _122 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

fragment MainPS_out Main_00002aef_2baa39d4(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _151 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _156 = (_151.xyz / float3(_151.w)) - View.View_PreViewTranslation;
    float4 _167 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _169 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _176 = fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _177 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_167, _169, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _193 = ((_176 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _211;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _206 = _122;
        _206.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _208 = _206;
        _208.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _210 = _208;
        _210.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _211 = _210;
    }
    else
    {
        _211 = float3(0.0);
    }
    bool _231 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _280;
    if (_231)
    {
        float4 _238 = View.View_WorldToClip * float4(_156, 1.0);
        float _239 = _238.w;
        float4 _268;
        if (_231)
        {
            _268 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_238.xy / float2(_239)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_239 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _268 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _280 = float4(_268.xyz + (in.in_var_TEXCOORD7.xyz * _268.w), _268.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _280 = in.in_var_TEXCOORD7;
    }
    float3 _281 = _156 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _289 = (_281 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _302 = fast::clamp((float3(0.5) - abs(_289 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _316 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_281 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _289, level(0.0)), float4((_302.x * _302.y) * _302.z));
    float _323 = _316.w;
    float3 _325 = float4(_316.x * 0.886227548122406005859375, _316.y * 0.886227548122406005859375, _316.z * 0.886227548122406005859375, _323).xyz;
    float3 _391;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _339 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_281, 1.0);
        float2 _343 = _339.xy / float2(_339.w);
        float _344 = _339.z;
        float4 _347 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _343, level(0.0));
        float3 _351 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _344;
        bool2 _376 = _343 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _378 = _343 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _391 = _193 * fast::max(_325 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _323) * (float3(1.0) - select(fast::clamp(exp((float3((((_347.x * _344) * 0.5) + dot((sin(_351) * _347.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_351)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _343, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_376.x || _378.x, _376.y || _378.y)))))), float3(0.0));
    }
    else
    {
        _391 = _193 * _325;
    }
    float3 _396 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _423;
    float3 _424;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _411 = any(abs(_156 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _421;
        if (_411)
        {
            _421 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_156, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _421 = _396;
        }
        _423 = _411 ? 1.0 : _177;
        _424 = _421;
    }
    else
    {
        _423 = _177;
        _424 = _396;
    }
    float4 _434 = float4((((mix(_391, _193, float3(View.View_UnlitViewmodeMask)) + (((_211 * View.View_IndirectLightingColorScale) * _193) * fast::max(float3(1.0), ((((((_176 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_176 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_176 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _424) * _280.w) + _280.xyz, _423);
    float3 _438 = _434.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_438.x, _438.y, _438.z, _434.w);
    return out;
}

