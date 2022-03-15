

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_GeomCache
{
    float3 GeomCache_MeshOrigin;
    float3 GeomCache_MeshExtension;
    float3 GeomCache_MotionBlurDataOrigin;
    packed_float3 GeomCache_MotionBlurDataExtension;
    float GeomCache_MotionBlurPositionScale;
};

constant float3x3 _52 = {};
constant float4 _53 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex MainVertexShader_out Main_000011f2_d2e5108a(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    MainVertexShader_out out = {};
    float3 _74 = (in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension) + GeomCache.GeomCache_MeshOrigin;
    float3 _78 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _81 = _52;
    _81[0] = cross(_78, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _82 = _81;
    _82[1] = _78;
    float3x3 _83 = _82;
    _83[2] = in.in_var_ATTRIBUTE2.xyz;
    float4 _110 = _53;
    _110.w = 0.0;
    float3x3 _123 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _123[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _126 = _123;
    _126[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _129 = _126;
    _129[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _130 = _129 * _83;
    float3 _131 = _130[0];
    float4x4 _146 = Primitive.Primitive_PreviousLocalToWorld;
    _146[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _150 = _146;
    _150[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _154 = _150;
    _154[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _177 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _74.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _74.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _74.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _186 = _177;
    _186.z = _177.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _177.w) : 0.0);
    out.gl_Position = _186;
    out.out_var_TEXCOORD6 = _177;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_154 * float4(((in.in_var_ATTRIBUTE4.xyz * float3(GeomCache.GeomCache_MotionBlurDataExtension)) + GeomCache.GeomCache_MotionBlurDataOrigin) + (_74 * GeomCache.GeomCache_MotionBlurPositionScale), 1.0)).xyz, 1.0);
    out.out_var_COLOR0 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD10_centroid = float4(_131.x, _131.y, _131.z, _110.w);
    out.out_var_TEXCOORD11_centroid = float4(_130[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

