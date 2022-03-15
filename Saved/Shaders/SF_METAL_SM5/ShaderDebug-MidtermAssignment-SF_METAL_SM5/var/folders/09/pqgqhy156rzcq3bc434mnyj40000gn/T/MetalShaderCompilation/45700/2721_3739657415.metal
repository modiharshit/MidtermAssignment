

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
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

constant float4 _52 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex Main_out Main_00000aa1_dee6a4c7(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]])
{
    Main_out out = {};
    float4x4 _64 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _65 = transpose(_64);
    float4 _66 = _65 * in.in_var_ATTRIBUTE0;
    float3 _67 = _66.xyz;
    float3 _68 = _67 + View.View_PreViewTranslation;
    float _70 = _68.x;
    float _71 = _68.y;
    float _72 = _68.z;
    float4 _73 = float4(_70, _71, _72, in.in_var_ATTRIBUTE0.w);
    float4 _74 = float4(_73.x, _73.y, _73.z, _73.w);
    float4 _77 = View.View_TranslatedWorldToClip * _74;
    float4 _78 = _52;
    _78.w = 0.0;
    float3x3 _80 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _80[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _83 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _84 = _80;
    _84[1] = _83;
    float3x3 _87 = _84;
    _87[0] = cross(_83, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _95 = float3x3(_65[0].xyz, _65[1].xyz, _65[2].xyz) * _87;
    float3 _97 = normalize(_95[0]);
    out.out_var_TEXCOORD10_centroid = float4(_97.x, _97.y, _97.z, _78.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_95[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _74;
    out.gl_Position = _77;
    return out;
}

