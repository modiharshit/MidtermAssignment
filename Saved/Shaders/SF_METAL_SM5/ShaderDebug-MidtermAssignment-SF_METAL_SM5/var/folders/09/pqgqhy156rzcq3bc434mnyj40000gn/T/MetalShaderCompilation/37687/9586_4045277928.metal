

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
    char _m10_pad[896];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
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

fragment MainPS_out Main_00002572_f11e0ae8(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _136 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _141 = (_136.xyz / float3(_136.w)) - View.View_PreViewTranslation;
    float4 _152 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _154 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _162 = fast::clamp(in.in_var_TEXCOORD5.w * mix(_152, _154, float4(in.in_var_TEXCOORD4.x)).x, 0.0, 1.0);
    float3 _178 = ((fast::clamp(in.in_var_TEXCOORD5.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _181 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _230;
    if (_181)
    {
        float4 _188 = View.View_WorldToClip * float4(_141, 1.0);
        float _189 = _188.w;
        float4 _218;
        if (_181)
        {
            _218 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_188.xy / float2(_189)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_189 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _218 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _230 = float4(_218.xyz + (in.in_var_TEXCOORD7.xyz * _218.w), _218.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _230 = in.in_var_TEXCOORD7;
    }
    float3 _231 = _141 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _239 = (_231 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _252 = fast::clamp((float3(0.5) - abs(_239 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _266 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_231 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _239, level(0.0)), float4((_252.x * _252.y) * _252.z));
    float _273 = _266.w;
    float3 _275 = float4(_266.x * 0.886227548122406005859375, _266.y * 0.886227548122406005859375, _266.z * 0.886227548122406005859375, _273).xyz;
    float3 _341;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _289 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_231, 1.0);
        float2 _293 = _289.xy / float2(_289.w);
        float _294 = _289.z;
        float4 _297 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _293, level(0.0));
        float3 _301 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _294;
        bool2 _326 = _293 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _328 = _293 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _341 = _178 * fast::max(_275 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _273) * (float3(1.0) - select(fast::clamp(exp((float3((((_297.x * _294) * 0.5) + dot((sin(_301) * _297.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_301)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _293, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_326.x || _328.x, _326.y || _328.y)))))), float3(0.0));
    }
    else
    {
        _341 = _178 * _275;
    }
    float3 _346 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _373;
    float3 _374;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _361 = any(abs(_141 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _371;
        if (_361)
        {
            _371 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_141, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _371 = _346;
        }
        _373 = _361 ? 1.0 : _162;
        _374 = _371;
    }
    else
    {
        _373 = _162;
        _374 = _346;
    }
    float4 _383 = float4(((mix(_341, _178, float3(View.View_UnlitViewmodeMask)) + _374) * _230.w) + _230.xyz, _373);
    float3 _387 = _383.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_387.x, _387.y, _387.z, _383.w);
    return out;
}

