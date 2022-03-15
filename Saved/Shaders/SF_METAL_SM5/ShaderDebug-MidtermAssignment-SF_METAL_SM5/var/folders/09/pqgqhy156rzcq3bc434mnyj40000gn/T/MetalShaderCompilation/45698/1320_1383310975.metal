

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_DrawRectangleParameters
{
    float4 DrawRectangleParameters_PosScaleBias;
    char _m1_pad[16];
    float4 DrawRectangleParameters_InvTargetSizeAndTextureSize;
};

struct MainVS_out
{
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVS_out Main_00000528_5273a67f(MainVS_in in [[stage_in]], constant type_DrawRectangleParameters& DrawRectangleParameters [[buffer(0)]])
{
    MainVS_out out = {};
    float2 _32 = in.in_var_ATTRIBUTE0.xy * DrawRectangleParameters.DrawRectangleParameters_PosScaleBias.xy;
    float2 _33 = DrawRectangleParameters.DrawRectangleParameters_PosScaleBias.zw + _32;
    float2 _34 = _33 * 2.0;
    float2 _38 = _34 * DrawRectangleParameters.DrawRectangleParameters_InvTargetSizeAndTextureSize.xy;
    float2 _39 = float2(-1.0) + _38;
    float2 _40 = _39.xy;
    float2 _41 = _40 * float2(1.0, -1.0);
    float4 _42 = float4(_41.x, _41.y, in.in_var_ATTRIBUTE0.z, in.in_var_ATTRIBUTE0.w);
    out.gl_Position = _42;
    return out;
}

