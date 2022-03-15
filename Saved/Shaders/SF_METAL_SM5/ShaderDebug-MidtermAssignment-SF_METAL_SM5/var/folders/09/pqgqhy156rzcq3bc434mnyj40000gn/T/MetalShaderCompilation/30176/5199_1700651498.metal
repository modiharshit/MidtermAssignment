

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

constant spvUnsafeArray<float2, 1> _55 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _56 = {};
constant float4 _57 = {};

struct MainVertexShader_out
{
    float2 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
};

vertex MainVertexShader_out Main_0000144f_655de1ea(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float2, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float3 _72 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _75 = _72 + GeomCache.GeomCache_MeshOrigin;
    float3 _79 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _82 = _56;
    _82[0] = cross(_79, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _83 = _82;
    _83[1] = _79;
    float3x3 _84 = _83;
    _84[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _89 = _75.xxx;
    float3 _90 = Primitive.Primitive_LocalToWorld[0u].xyz * _89;
    float3 _94 = _75.yyy;
    float3 _95 = Primitive.Primitive_LocalToWorld[1u].xyz * _94;
    float3 _96 = _90 + _95;
    float3 _100 = _75.zzz;
    float3 _101 = Primitive.Primitive_LocalToWorld[2u].xyz * _100;
    float3 _102 = _96 + _101;
    float3 _106 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _107 = _102 + _106;
    float _108 = _107.x;
    float _109 = _107.y;
    float _110 = _107.z;
    float4 _111 = float4(_108, _109, _110, 1.0);
    spvUnsafeArray<float2, 1> _59;
    _59 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _60 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _113 = 0; _113 < 1; )
    {
        _60[_113] = _59[_113];
        _113++;
        continue;
    }
    float4 _122 = float4(_111.x, _111.y, _111.z, _111.w);
    float4 _123 = View.View_TranslatedWorldToClip * _122;
    float4 _124 = _57;
    _124.w = 0.0;
    float3x3 _137 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _137[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _140 = _137;
    _140[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _143 = _140;
    _143[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _144 = _143 * _84;
    float3 _145 = _144[0];
    out_var_TEXCOORD0 = _60;
    out.out_var_TEXCOORD10_centroid = float4(_145.x, _145.y, _145.z, _124.w);
    out.out_var_TEXCOORD11_centroid = float4(_144[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _122;
    out.gl_Position = _123;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

