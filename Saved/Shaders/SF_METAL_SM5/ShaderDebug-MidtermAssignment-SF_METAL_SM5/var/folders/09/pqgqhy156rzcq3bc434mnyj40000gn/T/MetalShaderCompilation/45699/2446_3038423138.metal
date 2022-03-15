

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

struct type_Material
{
    char _m0_pad[96];
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    float4 HitProxyId;
};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

fragment Main_out Main_0000098e_b51aa862(Main_in in [[stage_in]], constant type_Material& Material [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    if (((mix(1.0, Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)).w, Material.Material_ScalarExpressions[0].y) * Material.Material_ScalarExpressions[0].z) - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    out.out_var_SV_Target0 = _Globals.HitProxyId;
    return out;
}

