

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

constant float3x3 _46 = {};
constant float4 _47 = {};

struct Main_out
{
    float4 out_var_COLOR0 [[user(locn0)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
};

vertex Main_out Main_00000daa_e5f09e99(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    Main_out out = {};
    float3 _60 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _63 = _60 + GeomCache.GeomCache_MeshOrigin;
    float3 _67 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _70 = _46;
    _70[0] = cross(_67, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _71 = _70;
    _71[1] = _67;
    float3x3 _72 = _71;
    _72[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _77 = _63.xxx;
    float3 _78 = Primitive.Primitive_LocalToWorld[0u].xyz * _77;
    float3 _82 = _63.yyy;
    float3 _83 = Primitive.Primitive_LocalToWorld[1u].xyz * _82;
    float3 _84 = _78 + _83;
    float3 _88 = _63.zzz;
    float3 _89 = Primitive.Primitive_LocalToWorld[2u].xyz * _88;
    float3 _90 = _84 + _89;
    float3 _94 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _95 = _90 + _94;
    float _96 = _95.x;
    float _97 = _95.y;
    float _98 = _95.z;
    float4 _99 = float4(_96, _97, _98, 1.0);
    float4 _100 = float4(_99.x, _99.y, _99.z, _99.w);
    float4 _101 = View.View_TranslatedWorldToClip * _100;
    float4 _102 = _47;
    _102.w = 0.0;
    float3x3 _115 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _115[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _118 = _115;
    _118[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _121 = _118;
    _121[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _122 = _121 * _72;
    float3 _123 = _122[0];
    out.out_var_COLOR0 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD10_centroid = float4(_123.x, _123.y, _123.z, _102.w);
    out.out_var_TEXCOORD11_centroid = float4(_122[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _101;
    return out;
}

