

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

constant float3x3 _56 = {};
constant float4 _57 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_0000114c_ed3d1a05(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_GeomCache& GeomCache [[buffer(3)]])
{
    Main_out out = {};
    float3 _70 = (in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension) + GeomCache.GeomCache_MeshOrigin;
    float3 _74 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _77 = _56;
    _77[0] = cross(_74, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _78 = _77;
    _78[1] = _74;
    float3x3 _79 = _78;
    _79[2] = in.in_var_ATTRIBUTE2.xyz;
    float3x3 _93 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _93[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _96 = _93;
    _96[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _99 = _96;
    _99[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _100 = _99 * _79;
    float3 _101 = _100[0];
    float4 _109 = float4(_100[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    float4 _136 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _70.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _70.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _70.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _142 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_136.x, _136.y, _136.z, _136.w);
    float4 _153;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_142.z < 0.0))
    {
        float4 _151 = _142;
        _151.z = 9.9999999747524270787835121154785e-07;
        float4 _152 = _151;
        _152.w = 1.0;
        _153 = _152;
    }
    else
    {
        _153 = _142;
    }
    float _159 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _109.xyz));
    float4 _184 = _153;
    _184.z = ((_153.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_159) > 0.0) ? (sqrt(fast::clamp(1.0 - (_159 * _159), 0.0, 1.0)) / _159) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _153.w;
    float4 _185 = _57;
    _185.w = 0.0;
    out.out_var_TEXCOORD10_centroid = float4(_101.x, _101.y, _101.z, _185.w);
    out.out_var_TEXCOORD11_centroid = _109;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _136.xyz;
    out.gl_Position = _184;
    return out;
}

