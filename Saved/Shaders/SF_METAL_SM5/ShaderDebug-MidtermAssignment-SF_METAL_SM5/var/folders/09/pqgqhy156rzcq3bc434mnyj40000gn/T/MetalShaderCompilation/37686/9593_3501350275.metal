

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 in_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

fragment MainPS_out Main_00002579_d0b25d83(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _135 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _140 = (_135.xyz / float3(_135.w)) - View.View_PreViewTranslation;
    float4 _151 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _153 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float _161 = fast::clamp(in.in_var_TEXCOORD2.w * mix(_151, _153, float4(in.in_var_TEXCOORD10.w)).x, 0.0, 1.0);
    float3 _177 = ((fast::clamp(in.in_var_TEXCOORD2.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    bool _180 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _229;
    if (_180)
    {
        float4 _187 = View.View_WorldToClip * float4(_140, 1.0);
        float _188 = _187.w;
        float4 _217;
        if (_180)
        {
            _217 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_187.xy / float2(_188)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_188 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _217 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _229 = float4(_217.xyz + (in.in_var_TEXCOORD7.xyz * _217.w), _217.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _229 = in.in_var_TEXCOORD7;
    }
    float3 _230 = _140 + in.in_var_PARTICLE_LIGHTING_OFFSET;
    float3 _238 = (_230 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _251 = fast::clamp((float3(0.5) - abs(_238 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _265 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_230 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _238, level(0.0)), float4((_251.x * _251.y) * _251.z));
    float _272 = _265.w;
    float3 _274 = float4(_265.x * 0.886227548122406005859375, _265.y * 0.886227548122406005859375, _265.z * 0.886227548122406005859375, _272).xyz;
    float3 _340;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _288 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_230, 1.0);
        float2 _292 = _288.xy / float2(_288.w);
        float _293 = _288.z;
        float4 _296 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _292, level(0.0));
        float3 _300 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _293;
        bool2 _325 = _292 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _327 = _292 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _340 = _177 * fast::max(_274 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _272) * (float3(1.0) - select(fast::clamp(exp((float3((((_296.x * _293) * 0.5) + dot((sin(_300) * _296.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_300)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _292, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_325.x || _327.x, _325.y || _327.y)))))), float3(0.0));
    }
    else
    {
        _340 = _177 * _274;
    }
    float3 _345 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _372;
    float3 _373;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _360 = any(abs(_140 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _370;
        if (_360)
        {
            _370 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_140, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _370 = _345;
        }
        _372 = _360 ? 1.0 : _161;
        _373 = _370;
    }
    else
    {
        _372 = _161;
        _373 = _345;
    }
    float4 _382 = float4(((mix(_340, _177, float3(View.View_UnlitViewmodeMask)) + _373) * _229.w) + _229.xyz, _372);
    float3 _386 = _382.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_386.x, _386.y, _386.z, _382.w);
    return out;
}

