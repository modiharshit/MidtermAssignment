

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
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m12_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[384];
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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[64];
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapScale;
    spvUnsafeArray<float4, 2> PrecomputedLightingBuffer_LightMapAdd;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _103 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

fragment MainPS_out Main_0000257d_d46427b7(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _141 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _146 = (_141.xyz / float3(_141.w)) - View.View_PreViewTranslation;
    float4 _160 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _181 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _184 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _189;
    if (_184)
    {
        _189 = View.View_DiffuseOverrideParameter.xyz + (_181 * 0.449999988079071044921875);
    }
    else
    {
        _189 = View.View_DiffuseOverrideParameter.xyz;
    }
    float2 _193 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _198 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _193);
    float4 _200 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_193 + float2(0.0, 0.5)));
    float3 _214 = _198.xyz;
    bool _244 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _293;
    if (_244)
    {
        float4 _251 = View.View_WorldToClip * float4(_146, 1.0);
        float _252 = _251.w;
        float4 _281;
        if (_244)
        {
            _281 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_251.xy / float2(_252)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_252 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _281 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _293 = float4(_281.xyz + (in.in_var_TEXCOORD7.xyz * _281.w), _281.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _293 = in.in_var_TEXCOORD7;
    }
    float3 _301 = (_146 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _314 = fast::clamp((float3(0.5) - abs(_301 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _328 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_146 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _301, level(0.0)), float4((_314.x * _314.y) * _314.z));
    float3 _344 = fast::max(mix(float3(_160.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _370;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _369;
        if (any(abs(_146 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _369 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_146, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _369 = _344;
        }
        _370 = _369;
    }
    else
    {
        _370 = _344;
    }
    float4 _380 = float4((((mix(_189 * float4(_328.x * 0.886227548122406005859375, _328.y * 0.886227548122406005859375, _328.z * 0.886227548122406005859375, _103).xyz, _189 + (select(_181, float3(0.0), bool3(_184)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((((_214 * _214) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].xyz) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].xyz) * ((exp2(((_198.w + ((_200.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[0].w) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[0].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_200 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapScale[1]) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapAdd[1], float4((normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0).yzx, 1.0))))) * View.View_IndirectLightingColorScale) * _189)) + _370) * _293.w) + _293.xyz, 1.0);
    float3 _384 = _380.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_384.x, _384.y, _384.z, _380.w);
    return out;
}

