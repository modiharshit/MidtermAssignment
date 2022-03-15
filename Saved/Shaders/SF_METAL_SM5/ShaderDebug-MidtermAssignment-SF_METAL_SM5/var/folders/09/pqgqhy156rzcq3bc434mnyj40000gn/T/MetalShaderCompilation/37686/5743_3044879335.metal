

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
    char _m5_pad[48];
    float View_MaterialTextureMipBias;
    char _m6_pad[1024];
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

constant float _83 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TEXCOORD5 [[user(locn1)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

fragment MainPS_out Main_0000166f_b57d2be7(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _105 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _110 = (_105.xyz / float3(_105.w)) - View.View_PreViewTranslation;
    float4 _124 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _125 = _124.x;
    float _135 = fast::clamp(fast::min(fast::max(((_125 <= 0.0) ? 0.0 : pow(_125, mix(12.0, 1.0, in.in_var_TEXCOORD5.w))) * mix(8.0, 1.0, in.in_var_TEXCOORD5.w), 0.0), 1.0), 0.0, 1.0);
    bool _138 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _180;
    if (_138)
    {
        float4 _145 = View.View_WorldToClip * float4(_110, 1.0);
        float _146 = _145.w;
        float4 _175;
        if (_138)
        {
            _175 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_145.xy / float2(_146)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_146 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _175 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _180 = float4(_83, _83, _83, _175.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _180 = in.in_var_TEXCOORD7;
    }
    float3 _181 = fast::max(mix(in.in_var_TEXCOORD5.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _208;
    float3 _209;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _196 = any(abs(_110 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _206;
        if (_196)
        {
            _206 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_110, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _206 = _181;
        }
        _208 = _196 ? 1.0 : _135;
        _209 = _206;
    }
    else
    {
        _208 = _135;
        _209 = _181;
    }
    float4 _216 = float4((_209 * _180.w) * _208, 0.0);
    float3 _220 = _216.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_220.x, _220.y, _220.z, _216.w);
    return out;
}

