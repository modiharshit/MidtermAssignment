

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

constant float3x3 _58 = {};
constant float _59 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex MainForGS_out Main_00001227_80466550(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_GeomCache& GeomCache [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]])
{
    MainForGS_out out = {};
    float3 _69 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _72 = _69 + GeomCache.GeomCache_MeshOrigin;
    float3 _76 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _79 = _58;
    _79[0] = cross(_76, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _80 = _79;
    _80[1] = _76;
    float3x3 _81 = _80;
    _81[2] = in.in_var_ATTRIBUTE2.xyz;
    float3x3 _95 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _95[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _98 = _95;
    _98[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _101 = _98;
    _101[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3 _112 = _72.xxx;
    float3 _113 = Primitive.Primitive_LocalToWorld[0u].xyz * _112;
    float3 _117 = _72.yyy;
    float3 _118 = Primitive.Primitive_LocalToWorld[1u].xyz * _117;
    float3 _119 = _113 + _118;
    float3 _123 = _72.zzz;
    float3 _124 = Primitive.Primitive_LocalToWorld[2u].xyz * _123;
    float3 _125 = _119 + _124;
    float3 _129 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _130 = _125 + _129;
    float _131 = _130.x;
    float _132 = _130.y;
    float _133 = _130.z;
    float4 _134 = float4(_131, _132, _133, 1.0);
    float4 _135 = float4(_134.x, _134.y, _134.z, _134.w);
    float4 _140 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _135;
    out.out_var_TEXCOORD6 = _135;
    out.out_var_TEXCOORD8 = float4((_101 * _81)[2], _59).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _140;
    return out;
}

