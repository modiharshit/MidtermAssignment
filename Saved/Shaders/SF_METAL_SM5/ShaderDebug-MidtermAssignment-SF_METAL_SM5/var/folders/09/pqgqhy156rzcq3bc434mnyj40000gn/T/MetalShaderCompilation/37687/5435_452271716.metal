

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
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_TEXCOORD3_0 [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

fragment MainPS_out Main_0000153b_1af51e64(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _98 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _103 = (_98.xyz / float3(_98.w)) - View.View_PreViewTranslation;
    float2 _112 = float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) - float2(0.5);
    float _118 = fast::min(fast::max(1.0 - (sqrt(dot(_112, _112)) * 2.0), 0.0), 1.0);
    float _124 = fast::clamp(in.in_var_TEXCOORD2.w * ((_118 <= 0.0) ? 0.0 : pow(_118, 4.0)), 0.0, 1.0);
    bool _127 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _176;
    if (_127)
    {
        float4 _134 = View.View_WorldToClip * float4(_103, 1.0);
        float _135 = _134.w;
        float4 _164;
        if (_127)
        {
            _164 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_134.xy / float2(_135)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_135 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _164 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _176 = float4(_164.xyz + (in.in_var_TEXCOORD7.xyz * _164.w), _164.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _176 = in.in_var_TEXCOORD7;
    }
    float3 _177 = fast::max(mix(in.in_var_TEXCOORD2.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _204;
    float3 _205;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _192 = any(abs(_103 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _202;
        if (_192)
        {
            _202 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_103, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _202 = _177;
        }
        _204 = _192 ? 1.0 : _124;
        _205 = _202;
    }
    else
    {
        _204 = _124;
        _205 = _177;
    }
    float4 _213 = float4((_205 * _176.w) + _176.xyz, _204);
    float3 _217 = _213.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_217.x, _217.y, _217.z, _213.w);
    return out;
}

