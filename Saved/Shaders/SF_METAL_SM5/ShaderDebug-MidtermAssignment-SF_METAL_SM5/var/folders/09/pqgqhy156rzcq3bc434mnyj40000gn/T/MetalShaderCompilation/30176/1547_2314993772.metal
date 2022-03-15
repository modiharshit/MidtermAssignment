

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex Main_out Main_0000060b_89fc006c(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]])
{
    Main_out out = {};
    float4x4 _54 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _55 = transpose(_54);
    float4 _56 = _55 * in.in_var_ATTRIBUTE0;
    float3 _57 = _56.xyz;
    float3 _58 = _57 + View.View_PreViewTranslation;
    float _60 = _58.x;
    float _61 = _58.y;
    float _62 = _58.z;
    float4 _63 = float4(_60, _61, _62, in.in_var_ATTRIBUTE0.w);
    float4 _64 = float4(_63.x, _63.y, _63.z, _63.w);
    float4 _65 = View.View_TranslatedWorldToClip * _64;
    out.gl_Position = _65;
    return out;
}

