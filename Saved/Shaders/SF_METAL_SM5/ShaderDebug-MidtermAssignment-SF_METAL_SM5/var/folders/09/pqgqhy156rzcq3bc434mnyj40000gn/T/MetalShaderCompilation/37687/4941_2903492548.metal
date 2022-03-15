

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
    char _m4_pad[72];
    float View_OutOfBoundsMask;
    char _m5_pad[1072];
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
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

fragment MainPS_out Main_0000134d_ad0fc7c4(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _90 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _95 = (_90.xyz / float3(_90.w)) - View.View_PreViewTranslation;
    bool _105 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _154;
    if (_105)
    {
        float4 _112 = View.View_WorldToClip * float4(_95, 1.0);
        float _113 = _112.w;
        float4 _142;
        if (_105)
        {
            _142 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_112.xy / float2(_113)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_113 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _142 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _154 = float4(_142.xyz + (in.in_var_TEXCOORD7.xyz * _142.w), _142.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _154 = in.in_var_TEXCOORD7;
    }
    float3 _155 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _182;
    float3 _183;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _170 = any(abs(_95 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _180;
        if (_170)
        {
            _180 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_95, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _180 = _155;
        }
        _182 = float(_170);
        _183 = _180;
    }
    else
    {
        _182 = 0.0;
        _183 = _155;
    }
    float4 _191 = float4((_183 * _154.w) + _154.xyz, _182);
    float3 _195 = _191.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_195.x, _195.y, _195.z, _191.w);
    return out;
}

