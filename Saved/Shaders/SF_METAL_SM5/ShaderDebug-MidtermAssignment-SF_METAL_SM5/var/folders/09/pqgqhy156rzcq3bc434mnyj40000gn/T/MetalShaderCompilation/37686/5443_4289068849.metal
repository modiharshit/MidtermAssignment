

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
};

struct type_MeshParticleVF
{
    float4 MeshParticleVF_SubImageSize;
};

constant float4 _71 = {};

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

vertex MainVS_out Main_00001543_ffa5ff31(MainVS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(2)]], constant type_MeshParticleVF& MeshParticleVF [[buffer(3)]])
{
    MainVS_out out = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    float2 _96 = (float2(float(in.in_var_ATTRIBUTE11.x), float(in.in_var_ATTRIBUTE11.y)) + in_var_ATTRIBUTE4[0]) * MeshParticleVF.MeshParticleVF_SubImageSize.xy;
    float2 _103 = (float2(float(in.in_var_ATTRIBUTE11.z), float(in.in_var_ATTRIBUTE11.w)) + in_var_ATTRIBUTE4[0]) * MeshParticleVF.MeshParticleVF_SubImageSize.xy;
    float4x4 _106 = transpose(float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0)));
    float4 _114 = float4((_106 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _115 = float4(_114.x, _114.y, _114.z, _114.w);
    float4 _118 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _115;
    float4 _129;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_118.z < 0.0))
    {
        float4 _127 = _118;
        _127.z = 9.9999999747524270787835121154785e-07;
        float4 _128 = _127;
        _128.w = 1.0;
        _129 = _128;
    }
    else
    {
        _129 = _118;
    }
    float2 _131 = float2(in.in_var_ATTRIBUTE12.x);
    float4 _134 = _71;
    _134.w = 0.0;
    float3x3 _136 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _136[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _139 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _140 = _136;
    _140[1] = _139;
    float3x3 _143 = _140;
    _143[0] = cross(_139, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _151 = float3x3(_106[0].xyz, _106[1].xyz, _106[2].xyz) * _143;
    float3 _153 = normalize(_151[0]);
    out.out_var_TEXCOORD10_centroid = float4(_153.x, _153.y, _153.z, _134.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_151[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD1 = float4(_96.x, _96.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD2 = float4(_103.x, _103.y, _131.x, _131.y);
    out.out_var_COLOR1 = in.in_var_ATTRIBUTE14;
    out.out_var_TEXCOORD6 = _129.z;
    out.out_var_TEXCOORD7 = _115;
    out.gl_Position = _129;
    return out;
}

