

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
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

constant spvUnsafeArray<float2, 1> _63 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _65 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex MainVertexShader_out Main_000012f0_be449093(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _69;
    _69 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _70 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _84 = 0; _84 < 1; )
    {
        _70[_84] = _69[_84];
        _84++;
        continue;
    }
    float4x4 _93 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _94 = transpose(_93);
    float4 _95 = _94 * in.in_var_ATTRIBUTE0;
    float3 _96 = _95.xyz;
    float3 _97 = _96 + View.View_PreViewTranslation;
    float _99 = _97.x;
    float _100 = _97.y;
    float _101 = _97.z;
    float4 _102 = float4(_99, _100, _101, in.in_var_ATTRIBUTE0.w);
    spvUnsafeArray<float2, 1> _68;
    _68 = _70;
    spvUnsafeArray<float2, 1> _71 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _104 = 0; _104 < 1; )
    {
        _71[_104] = _68[_104];
        _104++;
        continue;
    }
    float4 _113 = float4(_102.x, _102.y, _102.z, _102.w);
    float4 _114 = View.View_TranslatedWorldToClip * _113;
    float4 _117 = _65;
    _117.w = 0.0;
    float3x3 _119 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _119[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _122 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _123 = _119;
    _123[1] = _122;
    float3x3 _126 = _123;
    _126[0] = cross(_122, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _134 = float3x3(_94[0].xyz, _94[1].xyz, _94[2].xyz) * _126;
    float3 _136 = normalize(_134[0]);
    spvUnsafeArray<float4, 1> _147 = { float4(_71[0].x, _71[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_136.x, _136.y, _136.z, _117.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_134[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _147;
    out.out_var_TEXCOORD6 = _113;
    out.gl_Position = _114;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

