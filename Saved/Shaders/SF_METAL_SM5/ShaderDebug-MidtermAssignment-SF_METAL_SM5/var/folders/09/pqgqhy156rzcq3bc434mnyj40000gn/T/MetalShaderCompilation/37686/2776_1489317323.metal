

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

struct type_DrawRectangleParameters
{
    float4 DrawRectangleParameters_PosScaleBias;
    char _m1_pad[16];
    float4 DrawRectangleParameters_InvTargetSizeAndTextureSize;
};

struct MainVS_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVS_out Main_00000ad8_58c52dcb(MainVS_in in [[stage_in]], constant type_DrawRectangleParameters& DrawRectangleParameters [[buffer(0)]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float2 _37 = in.in_var_ATTRIBUTE0.xy * DrawRectangleParameters.DrawRectangleParameters_PosScaleBias.xy;
    float2 _38 = DrawRectangleParameters.DrawRectangleParameters_PosScaleBias.zw + _37;
    float2 _39 = _38 * 2.0;
    float2 _43 = _39 * DrawRectangleParameters.DrawRectangleParameters_InvTargetSizeAndTextureSize.xy;
    float2 _44 = float2(-1.0) + _43;
    float2 _45 = _44.xy;
    float2 _46 = _45 * float2(1.0, -1.0);
    float4 _47 = float4(_46.x, _46.y, in.in_var_ATTRIBUTE0.z, in.in_var_ATTRIBUTE0.w);
    float4 _56;
    if ((uint(0) % 2u) == 1u)
    {
        _56 = float4(float4(0.0).x, float4(0.0).y, in.in_var_ATTRIBUTE0.x, in.in_var_ATTRIBUTE0.y);
    }
    else
    {
        _56 = float4(in.in_var_ATTRIBUTE0.x, in.in_var_ATTRIBUTE0.y, float4(0.0).z, float4(0.0).w);
    }
    spvUnsafeArray<float4, 1> _57 = { _56 };
    out.gl_Position = _47;
    out_var_TEXCOORD0 = _57;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

