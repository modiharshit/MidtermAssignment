

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

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_PARTICLE_VELOCITY [[user(locn3)]];
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
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000012e6_6ed477a5(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _69;
    _69 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _70 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _85 = 0; _85 < 1; )
    {
        _70[_85] = _69[_85];
        _85++;
        continue;
    }
    float4x4 _94 = float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0));
    float4x4 _95 = transpose(_94);
    float4 _96 = _95 * in.in_var_ATTRIBUTE0;
    float3 _97 = _96.xyz;
    float3 _98 = _97 + View.View_PreViewTranslation;
    float _100 = _98.x;
    float _101 = _98.y;
    float _102 = _98.z;
    float4 _103 = float4(_100, _101, _102, in.in_var_ATTRIBUTE0.w);
    spvUnsafeArray<float2, 1> _68;
    _68 = _70;
    spvUnsafeArray<float2, 1> _71 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _105 = 0; _105 < 1; )
    {
        _71[_105] = _68[_105];
        _105++;
        continue;
    }
    float4 _114 = float4(_103.x, _103.y, _103.z, _103.w);
    float4 _115 = View.View_TranslatedWorldToClip * _114;
    float4 _118 = _65;
    _118.w = 0.0;
    float3x3 _120 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _120[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _123 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _124 = _120;
    _124[1] = _123;
    float3x3 _127 = _124;
    _127[0] = cross(_123, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _135 = float3x3(_95[0].xyz, _95[1].xyz, _95[2].xyz) * _127;
    float3 _137 = normalize(_135[0]);
    spvUnsafeArray<float4, 1> _148 = { float4(_71[0].x, _71[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_137.x, _137.y, _137.z, _118.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_135[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _148;
    out.out_var_PARTICLE_VELOCITY = in.in_var_ATTRIBUTE15;
    out.gl_Position = _115;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

