

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_TranslucentDepthPass
{
    char _m0_pad[112];
    float4x4 TranslucentDepthPass_ProjectionMatrix;
    float TranslucentDepthPass_bClampToNearPlane;
    float TranslucentDepthPass_InvMaxSubjectDepth;
};

struct type_MeshParticleVF
{
    float4 MeshParticleVF_SubImageSize;
};

constant float4 _72 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_COLOR1 [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
    int4 in_var_ATTRIBUTE11 [[attribute(11)]];
    float2 in_var_ATTRIBUTE12 [[attribute(12)]];
    float4 in_var_ATTRIBUTE14 [[attribute(14)]];
};

vertex MainVS_out Main_000015f6_fd66b67c(MainVS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(2)]], constant type_MeshParticleVF& MeshParticleVF [[buffer(3)]])
{
    MainVS_out out = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    float2 _97 = (float2(float(in.in_var_ATTRIBUTE11.x), float(in.in_var_ATTRIBUTE11.y)) + in_var_ATTRIBUTE4[0]) * MeshParticleVF.MeshParticleVF_SubImageSize.xy;
    float2 _104 = (float2(float(in.in_var_ATTRIBUTE11.z), float(in.in_var_ATTRIBUTE11.w)) + in_var_ATTRIBUTE4[0]) * MeshParticleVF.MeshParticleVF_SubImageSize.xy;
    float4x4 _107 = transpose(float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0)));
    float4 _115 = float4((_107 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _116 = float4(_115.x, _115.y, _115.z, _115.w);
    float4 _119 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _116;
    float4 _130;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_119.z < 0.0))
    {
        float4 _128 = _119;
        _128.z = 9.9999999747524270787835121154785e-07;
        float4 _129 = _128;
        _129.w = 1.0;
        _130 = _129;
    }
    else
    {
        _130 = _119;
    }
    float _134 = _130.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _137 = _130;
    _137.z = _134 * _130.w;
    float2 _138 = float2(in.in_var_ATTRIBUTE12.x);
    float4 _141 = _72;
    _141.w = 0.0;
    float3x3 _143 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _143[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _146 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _147 = _143;
    _147[1] = _146;
    float3x3 _150 = _147;
    _150[0] = cross(_146, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _158 = float3x3(_107[0].xyz, _107[1].xyz, _107[2].xyz) * _150;
    float3 _160 = normalize(_158[0]);
    out.out_var_TEXCOORD10_centroid = float4(_160.x, _160.y, _160.z, _141.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_158[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD1 = float4(_97.x, _97.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD2 = float4(_104.x, _104.y, _138.x, _138.y);
    out.out_var_COLOR1 = in.in_var_ATTRIBUTE14;
    out.out_var_TEXCOORD6 = _134;
    out.out_var_TEXCOORD7 = _116;
    out.gl_Position = _137;
    return out;
}

