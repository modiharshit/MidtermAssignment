

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex Main_out Main_00000a7f_99704cbb(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]])
{
    Main_out out = {};
    float4 _76 = float4((transpose(float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0))) * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _83 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_76.x, _76.y, _76.z, _76.w);
    float4 _94;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_83.z < 0.0))
    {
        float4 _92 = _83;
        _92.z = 9.9999999747524270787835121154785e-07;
        float4 _93 = _92;
        _93.w = 1.0;
        _94 = _93;
    }
    else
    {
        _94 = _83;
    }
    float _100 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), in.in_var_ATTRIBUTE2.xyz));
    float4 _125 = _94;
    _125.z = ((_94.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_100) > 0.0) ? (sqrt(fast::clamp(1.0 - (_100 * _100), 0.0, 1.0)) / _100) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _94.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _125;
    return out;
}

