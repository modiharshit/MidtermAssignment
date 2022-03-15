

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

constant float3x3 _45 = {};
constant float4 _46 = {};

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
};

vertex Main_out Main_00000d1b_97fc9603(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    Main_out out = {};
    float3 _58 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _61 = _58 + GeomCache.GeomCache_MeshOrigin;
    float3 _65 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _68 = _45;
    _68[0] = cross(_65, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _69 = _68;
    _69[1] = _65;
    float3x3 _70 = _69;
    _70[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _75 = _61.xxx;
    float3 _76 = Primitive.Primitive_LocalToWorld[0u].xyz * _75;
    float3 _80 = _61.yyy;
    float3 _81 = Primitive.Primitive_LocalToWorld[1u].xyz * _80;
    float3 _82 = _76 + _81;
    float3 _86 = _61.zzz;
    float3 _87 = Primitive.Primitive_LocalToWorld[2u].xyz * _86;
    float3 _88 = _82 + _87;
    float3 _92 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _93 = _88 + _92;
    float _94 = _93.x;
    float _95 = _93.y;
    float _96 = _93.z;
    float4 _97 = float4(_94, _95, _96, 1.0);
    float4 _98 = float4(_97.x, _97.y, _97.z, _97.w);
    float4 _99 = View.View_TranslatedWorldToClip * _98;
    float4 _100 = _46;
    _100.w = 0.0;
    float3x3 _113 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _113[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _116 = _113;
    _116[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _119 = _116;
    _119[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _120 = _119 * _70;
    float3 _121 = _120[0];
    out.out_var_TEXCOORD10_centroid = float4(_121.x, _121.y, _121.z, _100.w);
    out.out_var_TEXCOORD11_centroid = float4(_120[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _99;
    return out;
}

