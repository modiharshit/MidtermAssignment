

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
    char _m0_pad[64];
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

constant float4 _65 = {};

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
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex Main_out Main_00000f12_912d6647(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]])
{
    Main_out out = {};
    float4x4 _79 = transpose(float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0)));
    float4 _87 = float4((_79 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _94 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_87.x, _87.y, _87.z, _87.w);
    float4 _105;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_94.z < 0.0))
    {
        float4 _103 = _94;
        _103.z = 9.9999999747524270787835121154785e-07;
        float4 _104 = _103;
        _104.w = 1.0;
        _105 = _104;
    }
    else
    {
        _105 = _94;
    }
    float _111 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), in.in_var_ATTRIBUTE2.xyz));
    float4 _130 = _65;
    _130.w = 0.0;
    float3x3 _131 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _131[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _134 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _135 = _131;
    _135[1] = _134;
    float3x3 _138 = _135;
    _138[0] = cross(_134, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _146 = float3x3(_79[0].xyz, _79[1].xyz, _79[2].xyz) * _138;
    float3 _148 = normalize(_146[0]);
    out.out_var_TEXCOORD10_centroid = float4(_148.x, _148.y, _148.z, _130.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_146[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _105.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_111) > 0.0) ? (sqrt(fast::clamp(1.0 - (_111 * _111), 0.0, 1.0)) / _111) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _87.xyz;
    out.gl_Position = _105;
    return out;
}

