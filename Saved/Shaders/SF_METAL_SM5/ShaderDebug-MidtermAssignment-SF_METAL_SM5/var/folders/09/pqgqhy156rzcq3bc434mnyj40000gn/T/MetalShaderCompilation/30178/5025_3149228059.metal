

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

constant spvUnsafeArray<float2, 1> _54 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _55 = {};
constant float4 _56 = {};

struct Main_out
{
    float2 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
};

vertex Main_out Main_000013a1_bbb5681b(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    Main_out out = {};
    spvUnsafeArray<float2, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float3 _71 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _74 = _71 + GeomCache.GeomCache_MeshOrigin;
    float3 _78 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _81 = _55;
    _81[0] = cross(_78, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _82 = _81;
    _82[1] = _78;
    float3x3 _83 = _82;
    _83[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _88 = _74.xxx;
    float3 _89 = Primitive.Primitive_LocalToWorld[0u].xyz * _88;
    float3 _93 = _74.yyy;
    float3 _94 = Primitive.Primitive_LocalToWorld[1u].xyz * _93;
    float3 _95 = _89 + _94;
    float3 _99 = _74.zzz;
    float3 _100 = Primitive.Primitive_LocalToWorld[2u].xyz * _99;
    float3 _101 = _95 + _100;
    float3 _105 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _106 = _101 + _105;
    float _107 = _106.x;
    float _108 = _106.y;
    float _109 = _106.z;
    float4 _110 = float4(_107, _108, _109, 1.0);
    spvUnsafeArray<float2, 1> _58;
    _58 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _59 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _112 = 0; _112 < 1; )
    {
        _59[_112] = _58[_112];
        _112++;
        continue;
    }
    float4 _121 = float4(_110.x, _110.y, _110.z, _110.w);
    float4 _122 = View.View_TranslatedWorldToClip * _121;
    float4 _123 = _56;
    _123.w = 0.0;
    float3x3 _136 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _136[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _139 = _136;
    _139[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _142 = _139;
    _142[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _143 = _142 * _83;
    float3 _144 = _143[0];
    out_var_TEXCOORD0 = _59;
    out.out_var_TEXCOORD10_centroid = float4(_144.x, _144.y, _144.z, _123.w);
    out.out_var_TEXCOORD11_centroid = float4(_143[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _122;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

