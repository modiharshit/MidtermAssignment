

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

constant spvUnsafeArray<float2, 1> _62 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _64 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex Main_out Main_0000125d_75824bc6(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _68;
    _68 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _69 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _83 = 0; _83 < 1; )
    {
        _69[_83] = _68[_83];
        _83++;
        continue;
    }
    float4x4 _92 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _93 = transpose(_92);
    float4 _94 = _93 * in.in_var_ATTRIBUTE0;
    float3 _95 = _94.xyz;
    float3 _96 = _95 + View.View_PreViewTranslation;
    float _98 = _96.x;
    float _99 = _96.y;
    float _100 = _96.z;
    float4 _101 = float4(_98, _99, _100, in.in_var_ATTRIBUTE0.w);
    spvUnsafeArray<float2, 1> _67;
    _67 = _69;
    spvUnsafeArray<float2, 1> _70 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _103 = 0; _103 < 1; )
    {
        _70[_103] = _67[_103];
        _103++;
        continue;
    }
    float4 _112 = float4(_101.x, _101.y, _101.z, _101.w);
    float4 _113 = View.View_TranslatedWorldToClip * _112;
    float4 _116 = _64;
    _116.w = 0.0;
    float3x3 _118 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _118[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _121 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _122 = _118;
    _122[1] = _121;
    float3x3 _125 = _122;
    _125[0] = cross(_121, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _133 = float3x3(_93[0].xyz, _93[1].xyz, _93[2].xyz) * _125;
    float3 _135 = normalize(_133[0]);
    spvUnsafeArray<float4, 1> _146 = { float4(_70[0].x, _70[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_135.x, _135.y, _135.z, _116.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_133[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _146;
    out.gl_Position = _113;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

