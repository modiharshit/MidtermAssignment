

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
    char _m0_pad[2164];
    float View_PreExposure;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    uint2 PostProcessOutput_ViewportMin;
    float2 PostProcessOutput_ViewportSizeInverse;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment MainPS_out Main_00000a59_6a793ce8(constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _75 = float4(fast::max(mix(Material_Texture2D_0.sample(Material_Texture2D_0Sampler, ((gl_FragCoord.xy - float2(_Globals.PostProcessOutput_ViewportMin)) * _Globals.PostProcessOutput_ViewportSizeInverse)).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), 1.0);
    float3 _79 = _75.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_79.x, _79.y, _79.z, _75.w);
    return out;
}

