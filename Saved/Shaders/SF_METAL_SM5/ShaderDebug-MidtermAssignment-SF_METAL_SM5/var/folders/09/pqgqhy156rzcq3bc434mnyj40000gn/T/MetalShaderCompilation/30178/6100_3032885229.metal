

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

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

constant spvUnsafeArray<float2, 1> _59 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _60 = {};
constant float4 _61 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float2 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
};

vertex MainVertexShader_out Main_000017d4_b4c627ed(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float2, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float3 _84 = (in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension) + GeomCache.GeomCache_MeshOrigin;
    float3 _88 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _91 = _60;
    _91[0] = cross(_88, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _92 = _91;
    _92[1] = _88;
    float3x3 _93 = _92;
    _93[2] = in.in_var_ATTRIBUTE2.xyz;
    spvUnsafeArray<float2, 1> _63;
    _63 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _64 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _121 = 0; _121 < 1; )
    {
        _64[_121] = _63[_121];
        _121++;
        continue;
    }
    float4 _130 = _61;
    _130.w = 0.0;
    float3x3 _143 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _143[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _146 = _143;
    _146[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _149 = _146;
    _149[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _150 = _149 * _93;
    float3 _151 = _150[0];
    float4x4 _166 = Primitive.Primitive_PreviousLocalToWorld;
    _166[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _170 = _166;
    _170[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _174 = _170;
    _174[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _197 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _84.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _84.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _84.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _206 = _197;
    _206.z = _197.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _197.w) : 0.0);
    out.gl_Position = _206;
    out.out_var_TEXCOORD6 = _197;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_174 * float4(((in.in_var_ATTRIBUTE4.xyz * float3(GeomCache.GeomCache_MotionBlurDataExtension)) + GeomCache.GeomCache_MotionBlurDataOrigin) + (_84 * GeomCache.GeomCache_MotionBlurPositionScale), 1.0)).xyz, 1.0);
    out_var_TEXCOORD0 = _64;
    out.out_var_TEXCOORD10_centroid = float4(_151.x, _151.y, _151.z, _130.w);
    out.out_var_TEXCOORD11_centroid = float4(_150[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

