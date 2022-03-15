

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_Globals
{
    uint LayerId;
};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex Main_out Main_00000c92_4da2e2a9(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    Main_out out = {};
    float4x4 _68 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _69 = transpose(_68);
    float4 _70 = _69 * in.in_var_ATTRIBUTE0;
    float3 _71 = _70.xyz;
    float3 _72 = _71 + View.View_PreViewTranslation;
    float _74 = _72.x;
    float _75 = _72.y;
    float _76 = _72.z;
    float4 _77 = float4(_74, _75, _76, in.in_var_ATTRIBUTE0.w);
    float4 _79 = float4(_77.x, _77.y, _77.z, _77.w);
    float4 _84 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _79;
    out.out_var_TEXCOORD6 = _79;
    out.out_var_TEXCOORD8 = in.in_var_ATTRIBUTE2.xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _84;
    return out;
}

