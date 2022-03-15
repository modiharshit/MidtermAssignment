

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00000607_fe44589e(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]])
{
    Main_out out = {};
    float3 _46 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _51 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _52 = _46 + _51;
    float3 _57 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _58 = _52 + _57;
    float3 _62 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _63 = _58 + _62;
    float _64 = _63.x;
    float _65 = _63.y;
    float _66 = _63.z;
    float4 _67 = float4(_64, _65, _66, 1.0);
    float4 _68 = float4(_67.x, _67.y, _67.z, _67.w);
    float4 _69 = View.View_TranslatedWorldToClip * _68;
    out.gl_Position = _69;
    return out;
}

