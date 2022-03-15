

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
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_GeomCache
{
    float3 GeomCache_MeshOrigin;
    float3 GeomCache_MeshExtension;
};

constant float3x3 _47 = {};
constant float4 _48 = {};

struct Main_out
{
    float4 out_var_COLOR0 [[user(locn0)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
};

vertex Main_out Main_00000de6_4a89c885(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    Main_out out = {};
    float3 _59 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _62 = _59 + GeomCache.GeomCache_MeshOrigin;
    float3 _66 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _69 = _47;
    _69[0] = cross(_66, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _70 = _69;
    _70[1] = _66;
    float3x3 _71 = _70;
    _71[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _76 = _62.xxx;
    float3 _77 = Primitive.Primitive_LocalToWorld[0u].xyz * _76;
    float3 _81 = _62.yyy;
    float3 _82 = Primitive.Primitive_LocalToWorld[1u].xyz * _81;
    float3 _83 = _77 + _82;
    float3 _87 = _62.zzz;
    float3 _88 = Primitive.Primitive_LocalToWorld[2u].xyz * _87;
    float3 _89 = _83 + _88;
    float3 _93 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _94 = _89 + _93;
    float _95 = _94.x;
    float _96 = _94.y;
    float _97 = _94.z;
    float4 _98 = float4(_95, _96, _97, 1.0);
    float4 _99 = float4(_98.x, _98.y, _98.z, _98.w);
    float4 _102 = View.View_TranslatedWorldToClip * _99;
    float4 _103 = _48;
    _103.w = 0.0;
    float3x3 _116 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _116[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _119 = _116;
    _119[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _122 = _119;
    _122[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _123 = _122 * _71;
    float3 _124 = _123[0];
    out.out_var_COLOR0 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD10_centroid = float4(_124.x, _124.y, _124.z, _103.w);
    out.out_var_TEXCOORD11_centroid = float4(_123[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _99;
    out.gl_Position = _102;
    return out;
}

