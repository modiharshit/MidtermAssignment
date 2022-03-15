

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
};

vertex Main_out Main_00000d5b_657a5986(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    Main_out out = {};
    float3 _57 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _60 = _57 + GeomCache.GeomCache_MeshOrigin;
    float3 _64 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _67 = _46;
    _67[0] = cross(_64, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _68 = _67;
    _68[1] = _64;
    float3x3 _69 = _68;
    _69[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _74 = _60.xxx;
    float3 _75 = Primitive.Primitive_LocalToWorld[0u].xyz * _74;
    float3 _79 = _60.yyy;
    float3 _80 = Primitive.Primitive_LocalToWorld[1u].xyz * _79;
    float3 _81 = _75 + _80;
    float3 _85 = _60.zzz;
    float3 _86 = Primitive.Primitive_LocalToWorld[2u].xyz * _85;
    float3 _87 = _81 + _86;
    float3 _91 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _92 = _87 + _91;
    float _93 = _92.x;
    float _94 = _92.y;
    float _95 = _92.z;
    float4 _96 = float4(_93, _94, _95, 1.0);
    float4 _97 = float4(_96.x, _96.y, _96.z, _96.w);
    float4 _100 = View.View_TranslatedWorldToClip * _97;
    float4 _101 = _47;
    _101.w = 0.0;
    float3x3 _114 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _114[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _117 = _114;
    _117[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _120 = _117;
    _120[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _121 = _120 * _69;
    float3 _122 = _121[0];
    out.out_var_TEXCOORD10_centroid = float4(_122.x, _122.y, _122.z, _101.w);
    out.out_var_TEXCOORD11_centroid = float4(_121[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _97;
    out.gl_Position = _100;
    return out;
}

