

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
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_GeomCache
{
    float3 GeomCache_MeshOrigin;
    float3 GeomCache_MeshExtension;
};

struct type_Globals
{
    uint LayerId;
};

constant float3x3 _61 = {};
constant float4 _62 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex MainForGS_out Main_0000141c_29deaf18(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_GeomCache& GeomCache [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]])
{
    MainForGS_out out = {};
    float3 _72 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _75 = _72 + GeomCache.GeomCache_MeshOrigin;
    float3 _79 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _82 = _61;
    _82[0] = cross(_79, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _83 = _82;
    _83[1] = _79;
    float3x3 _84 = _83;
    _84[2] = in.in_var_ATTRIBUTE2.xyz;
    float3x3 _98 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _98[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _101 = _98;
    _101[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _104 = _101;
    _104[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _105 = _104 * _84;
    float3 _106 = _105[0];
    float4 _114 = float4(_105[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    float3 _119 = _75.xxx;
    float3 _120 = Primitive.Primitive_LocalToWorld[0u].xyz * _119;
    float3 _124 = _75.yyy;
    float3 _125 = Primitive.Primitive_LocalToWorld[1u].xyz * _124;
    float3 _126 = _120 + _125;
    float3 _130 = _75.zzz;
    float3 _131 = Primitive.Primitive_LocalToWorld[2u].xyz * _130;
    float3 _132 = _126 + _131;
    float3 _136 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _137 = _132 + _136;
    float _138 = _137.x;
    float _139 = _137.y;
    float _140 = _137.z;
    float4 _141 = float4(_138, _139, _140, 1.0);
    float4 _142 = float4(_141.x, _141.y, _141.z, _141.w);
    float4 _143 = _62;
    _143.w = 0.0;
    float4 _150 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _142;
    out.out_var_TEXCOORD10_centroid = float4(_106.x, _106.y, _106.z, _143.w);
    out.out_var_TEXCOORD11_centroid = _114;
    out.out_var_TEXCOORD7 = _141.xyz;
    out.out_var_TEXCOORD6 = _150;
    out.out_var_TEXCOORD8 = _114.xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _150;
    return out;
}

