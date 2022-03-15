

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
    char _m11_pad[560];
    float4 View_SkyLightColor;
    char _m12_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
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

constant float3 _127 = {};

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

fragment MainPS_out Main_00002f9f_4d563550(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _164 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _169 = (_164.xyz / float3(_164.w)) - View.View_PreViewTranslation;
    float3 _177 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _188 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _190 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float3 _197 = fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0));
    float _198 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_188, _190, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _214 = ((_197 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float _215 = _177.x;
    float _216 = _177.y;
    float4 _218 = float4(_215, _216, _177.z, 1.0);
    float3 _222 = _127;
    _222.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _218);
    float3 _226 = _222;
    _226.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _218);
    float3 _230 = _226;
    _230.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _218);
    float4 _233 = _218.xyzz * _218.yzzx;
    float3 _237 = _127;
    _237.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _233);
    float3 _241 = _237;
    _241.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _233);
    float3 _245 = _241;
    _245.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _233);
    bool _275 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _324;
    if (_275)
    {
        float4 _282 = View.View_WorldToClip * float4(_169, 1.0);
        float _283 = _282.w;
        float4 _312;
        if (_275)
        {
            _312 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_282.xy / float2(_283)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_283 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _312 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _324 = float4(_312.xyz + (in.in_var_TEXCOORD7.xyz * _312.w), _312.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _324 = in.in_var_TEXCOORD7;
    }
    float3 _325 = _169 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _333 = (_325 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _346 = fast::clamp((float3(0.5) - abs(_333 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _360 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_325 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _333, level(0.0)), float4((_346.x * _346.y) * _346.z));
    float _367 = _360.w;
    float3 _369 = float4(_360.x * 0.886227548122406005859375, _360.y * 0.886227548122406005859375, _360.z * 0.886227548122406005859375, _367).xyz;
    float3 _435;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _383 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_325, 1.0);
        float2 _387 = _383.xy / float2(_383.w);
        float _388 = _383.z;
        float4 _391 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _387, level(0.0));
        float3 _395 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _388;
        bool2 _420 = _387 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _422 = _387 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _435 = _214 * fast::max(_369 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _367) * (float3(1.0) - select(fast::clamp(exp((float3((((_391.x * _388) * 0.5) + dot((sin(_395) * _391.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_395)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _387, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_420.x || _422.x, _420.y || _422.y)))))), float3(0.0));
    }
    else
    {
        _435 = _214 * _369;
    }
    float3 _440 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _467;
    float3 _468;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _455 = any(abs(_169 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _465;
        if (_455)
        {
            _465 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_169, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _465 = _440;
        }
        _467 = _455 ? 1.0 : _198;
        _468 = _465;
    }
    else
    {
        _467 = _198;
        _468 = _440;
    }
    float4 _478 = float4((((mix(_435, _214, float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_230 + _245) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_215 * _215) - (_216 * _216)))) * View.View_SkyLightColor.xyz) * 1.0) * _214) * fast::max(float3(1.0), ((((((_197 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_197 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_197 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _468) * _324.w) + _324.xyz, _467);
    float3 _482 = _478.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_482.x, _482.y, _482.z, _478.w);
    return out;
}

