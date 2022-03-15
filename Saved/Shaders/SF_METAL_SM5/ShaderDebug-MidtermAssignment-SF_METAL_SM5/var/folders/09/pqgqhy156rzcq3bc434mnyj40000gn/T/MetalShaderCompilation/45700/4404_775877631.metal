

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

constant float3x3 _57 = {};
constant float4 _58 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001134_2e3ef3ff(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_GeomCache& GeomCache [[buffer(3)]])
{
    Main_out out = {};
    float3 _71 = (in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension) + GeomCache.GeomCache_MeshOrigin;
    float3 _75 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _78 = _57;
    _78[0] = cross(_75, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _79 = _78;
    _79[1] = _75;
    float3x3 _80 = _79;
    _80[2] = in.in_var_ATTRIBUTE2.xyz;
    float3x3 _94 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _94[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _97 = _94;
    _97[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _100 = _97;
    _100[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _101 = _100 * _80;
    float3 _102 = _101[0];
    float4 _110 = float4(_101[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    float4 _137 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _71.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _71.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _71.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _143 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_137.x, _137.y, _137.z, _137.w);
    float4 _154;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_143.z < 0.0))
    {
        float4 _152 = _143;
        _152.z = 9.9999999747524270787835121154785e-07;
        float4 _153 = _152;
        _153.w = 1.0;
        _154 = _153;
    }
    else
    {
        _154 = _143;
    }
    float _160 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _110.xyz));
    float4 _179 = _58;
    _179.w = 0.0;
    out.out_var_TEXCOORD10_centroid = float4(_102.x, _102.y, _102.z, _179.w);
    out.out_var_TEXCOORD11_centroid = _110;
    out.out_var_TEXCOORD6 = _154.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_160) > 0.0) ? (sqrt(fast::clamp(1.0 - (_160 * _160), 0.0, 1.0)) / _160) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _137.xyz;
    out.gl_Position = _154;
    return out;
}

