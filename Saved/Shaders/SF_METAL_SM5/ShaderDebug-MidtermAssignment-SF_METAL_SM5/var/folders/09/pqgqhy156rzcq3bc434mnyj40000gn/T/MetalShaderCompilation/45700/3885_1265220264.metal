

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

constant float4 _64 = {};

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
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex Main_out Main_00000f2d_4b69baa8(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]])
{
    Main_out out = {};
    float4x4 _78 = transpose(float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0)));
    float4 _86 = float4((_78 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _93 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_86.x, _86.y, _86.z, _86.w);
    float4 _104;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_93.z < 0.0))
    {
        float4 _102 = _93;
        _102.z = 9.9999999747524270787835121154785e-07;
        float4 _103 = _102;
        _103.w = 1.0;
        _104 = _103;
    }
    else
    {
        _104 = _93;
    }
    float _110 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), in.in_var_ATTRIBUTE2.xyz));
    float4 _135 = _104;
    _135.z = ((_104.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_110) > 0.0) ? (sqrt(fast::clamp(1.0 - (_110 * _110), 0.0, 1.0)) / _110) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _104.w;
    float4 _136 = _64;
    _136.w = 0.0;
    float3x3 _137 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _137[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _140 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _141 = _137;
    _141[1] = _140;
    float3x3 _144 = _141;
    _144[0] = cross(_140, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _152 = float3x3(_78[0].xyz, _78[1].xyz, _78[2].xyz) * _144;
    float3 _154 = normalize(_152[0]);
    out.out_var_TEXCOORD10_centroid = float4(_154.x, _154.y, _154.z, _136.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_152[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _86.xyz;
    out.gl_Position = _135;
    return out;
}

