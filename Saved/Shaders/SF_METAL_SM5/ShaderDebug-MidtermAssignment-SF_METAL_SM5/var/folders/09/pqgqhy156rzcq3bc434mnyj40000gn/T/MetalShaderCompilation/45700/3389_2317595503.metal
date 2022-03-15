

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

struct PositionOnlyMain_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
};

vertex PositionOnlyMain_out Main_00000d3d_8a23b36f(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]])
{
    PositionOnlyMain_out out = {};
    float4 _79 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _100 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * _79;
    float4 _111;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_100.z < 0.0))
    {
        float4 _109 = _100;
        _109.z = 9.9999999747524270787835121154785e-07;
        float4 _110 = _109;
        _110.w = 1.0;
        _111 = _110;
    }
    else
    {
        _111 = _100;
    }
    float _117 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE1.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE1.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE1.zzz)));
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_TEXCOORD6 = _111.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_117) > 0.0) ? (sqrt(fast::clamp(1.0 - (_117 * _117), 0.0, 1.0)) / _117) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _79.xyz;
    out.gl_Position = _111;
    return out;
}

