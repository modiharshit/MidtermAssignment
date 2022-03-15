

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

constant float4 _51 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
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

vertex Main_out Main_00000a63_c39906cc(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]])
{
    Main_out out = {};
    float4x4 _65 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _66 = transpose(_65);
    float4 _67 = _66 * in.in_var_ATTRIBUTE0;
    float3 _68 = _67.xyz;
    float3 _69 = _68 + View.View_PreViewTranslation;
    float _71 = _69.x;
    float _72 = _69.y;
    float _73 = _69.z;
    float4 _74 = float4(_71, _72, _73, in.in_var_ATTRIBUTE0.w);
    float4 _75 = float4(_74.x, _74.y, _74.z, _74.w);
    float4 _76 = View.View_TranslatedWorldToClip * _75;
    float4 _77 = _51;
    _77.w = 0.0;
    float3x3 _79 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _79[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _82 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _83 = _79;
    _83[1] = _82;
    float3x3 _86 = _83;
    _86[0] = cross(_82, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _94 = float3x3(_66[0].xyz, _66[1].xyz, _66[2].xyz) * _86;
    float3 _96 = normalize(_94[0]);
    out.out_var_TEXCOORD10_centroid = float4(_96.x, _96.y, _96.z, _77.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_94[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _76;
    return out;
}

