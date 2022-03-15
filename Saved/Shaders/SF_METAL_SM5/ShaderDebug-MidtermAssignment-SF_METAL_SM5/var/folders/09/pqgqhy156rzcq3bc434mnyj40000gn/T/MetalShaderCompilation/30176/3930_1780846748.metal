

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_GeomCache
{
    float3 GeomCache_MeshOrigin;
    float3 GeomCache_MeshExtension;
};

constant float3x3 _55 = {};
constant float _56 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00000f5a_6a25909c(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_GeomCache& GeomCache [[buffer(3)]])
{
    Main_out out = {};
    float3 _69 = (in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension) + GeomCache.GeomCache_MeshOrigin;
    float3 _73 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _76 = _55;
    _76[0] = cross(_73, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _77 = _76;
    _77[1] = _73;
    float3x3 _78 = _77;
    _78[2] = in.in_var_ATTRIBUTE2.xyz;
    float3x3 _92 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _92[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _95 = _92;
    _95[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _98 = _95;
    _98[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _131 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _69.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _69.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _69.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _137 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_131.x, _131.y, _131.z, _131.w);
    float4 _148;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_137.z < 0.0))
    {
        float4 _146 = _137;
        _146.z = 9.9999999747524270787835121154785e-07;
        float4 _147 = _146;
        _147.w = 1.0;
        _148 = _147;
    }
    else
    {
        _148 = _137;
    }
    float _154 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_98 * _78)[2], _56).xyz));
    float4 _179 = _148;
    _179.z = ((_148.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_154) > 0.0) ? (sqrt(fast::clamp(1.0 - (_154 * _154), 0.0, 1.0)) / _154) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _148.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _179;
    return out;
}

