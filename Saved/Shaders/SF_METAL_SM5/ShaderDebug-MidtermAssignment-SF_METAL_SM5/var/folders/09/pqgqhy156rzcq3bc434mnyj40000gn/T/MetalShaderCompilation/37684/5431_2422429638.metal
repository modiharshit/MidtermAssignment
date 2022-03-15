

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

constant float _75 = {};

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

fragment MainPS_out Main_00001537_906357c6(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _96 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _101 = (_96.xyz / float3(_96.w)) - View.View_PreViewTranslation;
    float _111 = in_var_TEXCOORD0[0].x - 0.5;
    float _114 = in_var_TEXCOORD0[0].y - 0.5;
    float _117 = 1.0 - ((_111 * _111) + (_114 * _114));
    float _125 = fast::clamp(fast::min(fast::max((_117 <= 0.0) ? 0.0 : pow(_117, 30.0), 0.0), 1.0) * in.in_var_TEXCOORD5.w, 0.0, 1.0);
    bool _128 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _170;
    if (_128)
    {
        float4 _135 = View.View_WorldToClip * float4(_101, 1.0);
        float _136 = _135.w;
        float4 _165;
        if (_128)
        {
            _165 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_135.xy / float2(_136)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_136 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _165 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _170 = float4(_75, _75, _75, _165.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _170 = in.in_var_TEXCOORD7;
    }
    float3 _171 = fast::max(mix(in.in_var_TEXCOORD5.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _198;
    float3 _199;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _186 = any(abs(_101 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _196;
        if (_186)
        {
            _196 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_101, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _196 = _171;
        }
        _198 = _186 ? 1.0 : _125;
        _199 = _196;
    }
    else
    {
        _198 = _125;
        _199 = _171;
    }
    float4 _206 = float4((_199 * _170.w) * _198, 0.0);
    float3 _210 = _206.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_210.x, _210.y, _210.z, _206.w);
    return out;
}

