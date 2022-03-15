

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

constant float3x3 _51 = {};
constant float4 _52 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex MainVertexShader_out Main_00001167_572f577d(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    MainVertexShader_out out = {};
    float3 _72 = (in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension) + GeomCache.GeomCache_MeshOrigin;
    float3 _76 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _79 = _51;
    _79[0] = cross(_76, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _80 = _79;
    _80[1] = _76;
    float3x3 _81 = _80;
    _81[2] = in.in_var_ATTRIBUTE2.xyz;
    float4 _108 = _52;
    _108.w = 0.0;
    float3x3 _121 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _121[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _124 = _121;
    _124[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _127 = _124;
    _127[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _128 = _127 * _81;
    float3 _129 = _128[0];
    float4x4 _144 = Primitive.Primitive_PreviousLocalToWorld;
    _144[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _148 = _144;
    _148[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _152 = _148;
    _152[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _175 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _72.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _72.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _72.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _184 = _175;
    _184.z = _175.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _175.w) : 0.0);
    out.gl_Position = _184;
    out.out_var_TEXCOORD6 = _175;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_152 * float4(((in.in_var_ATTRIBUTE4.xyz * float3(GeomCache.GeomCache_MotionBlurDataExtension)) + GeomCache.GeomCache_MotionBlurDataOrigin) + (_72 * GeomCache.GeomCache_MotionBlurPositionScale), 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_129.x, _129.y, _129.z, _108.w);
    out.out_var_TEXCOORD11_centroid = float4(_128[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

