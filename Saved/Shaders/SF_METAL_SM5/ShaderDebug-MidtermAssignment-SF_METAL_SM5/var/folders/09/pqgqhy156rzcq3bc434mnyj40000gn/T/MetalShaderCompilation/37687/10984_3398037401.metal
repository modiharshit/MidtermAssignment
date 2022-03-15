

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

constant float3 _123 = {};

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
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

fragment MainPS_out Main_00002ae8_ca89ef99(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _152 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _157 = (_152.xyz / float3(_152.w)) - View.View_PreViewTranslation;
    float4 _168 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _170 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _177 = fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0));
    float _178 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_168, _170, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _194 = ((_177 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _212;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _207 = _123;
        _207.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _209 = _207;
        _209.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _211 = _209;
        _211.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _212 = _211;
    }
    else
    {
        _212 = float3(0.0);
    }
    bool _232 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _281;
    if (_232)
    {
        float4 _239 = View.View_WorldToClip * float4(_157, 1.0);
        float _240 = _239.w;
        float4 _269;
        if (_232)
        {
            _269 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_239.xy / float2(_240)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_240 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _269 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _281 = float4(_269.xyz + (in.in_var_TEXCOORD7.xyz * _269.w), _269.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _281 = in.in_var_TEXCOORD7;
    }
    float3 _282 = _157 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _290 = (_282 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _303 = fast::clamp((float3(0.5) - abs(_290 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _317 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_282 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _290, level(0.0)), float4((_303.x * _303.y) * _303.z));
    float _324 = _317.w;
    float3 _326 = float4(_317.x * 0.886227548122406005859375, _317.y * 0.886227548122406005859375, _317.z * 0.886227548122406005859375, _324).xyz;
    float3 _392;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _340 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_282, 1.0);
        float2 _344 = _340.xy / float2(_340.w);
        float _345 = _340.z;
        float4 _348 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _344, level(0.0));
        float3 _352 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _345;
        bool2 _377 = _344 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _379 = _344 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _392 = _194 * fast::max(_326 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _324) * (float3(1.0) - select(fast::clamp(exp((float3((((_348.x * _345) * 0.5) + dot((sin(_352) * _348.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_352)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _344, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_377.x || _379.x, _377.y || _379.y)))))), float3(0.0));
    }
    else
    {
        _392 = _194 * _326;
    }
    float3 _397 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _424;
    float3 _425;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _412 = any(abs(_157 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _422;
        if (_412)
        {
            _422 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_157, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _422 = _397;
        }
        _424 = _412 ? 1.0 : _178;
        _425 = _422;
    }
    else
    {
        _424 = _178;
        _425 = _397;
    }
    float4 _435 = float4((((mix(_392, _194, float3(View.View_UnlitViewmodeMask)) + (((_212 * View.View_IndirectLightingColorScale) * _194) * fast::max(float3(1.0), ((((((_177 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_177 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_177 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _425) * _281.w) + _281.xyz, _424);
    float3 _439 = _435.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_439.x, _439.y, _439.z, _435.w);
    return out;
}

