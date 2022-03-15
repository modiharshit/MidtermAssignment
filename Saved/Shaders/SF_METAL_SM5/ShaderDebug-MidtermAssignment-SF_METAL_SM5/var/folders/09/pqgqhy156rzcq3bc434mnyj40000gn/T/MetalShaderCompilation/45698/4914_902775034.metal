

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
    char _m1_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_BeamTrailVF
{
    float4 BeamTrailVF_CameraRight;
    float4 BeamTrailVF_CameraUp;
    float4 BeamTrailVF_ScreenAlignment;
};

constant float4 _62 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
};

vertex Main_out Main_00001332_35cf40fa(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]])
{
    Main_out out = {};
    float3 _94 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float4 _99 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz)) + _94, 1.0);
    float3 _113 = _99.xyz;
    float3 _114 = View.View_WorldCameraOrigin - _113;
    float3 _121 = _113 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _94, 1.0).xyz;
    float _132 = cos(in.in_var_ATTRIBUTE2.z);
    float _135 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _141 = cross(_114 / float3(sqrt(fast::max(dot(_114, _114), 0.00999999977648258209228515625))), _121 / float3(sqrt(fast::max(dot(_121, _121), 0.00999999977648258209228515625))));
    bool4 _154 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _157 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _132)) + (BeamTrailVF.BeamTrailVF_CameraRight * _135), float4(_141 / float3(sqrt(fast::max(dot(_141, _141), 0.00999999977648258209228515625))), 0.0), _154).xyz;
    float3 _158 = select((BeamTrailVF.BeamTrailVF_CameraUp * _135) + (BeamTrailVF.BeamTrailVF_CameraRight * _132), float4(0.0), _154).xyz;
    float3 _161 = -normalize(cross(_157, _158));
    float4 _167 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_99.x, _99.y, _99.z, _99.w);
    float4 _178;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_167.z < 0.0))
    {
        float4 _176 = _167;
        _176.z = 9.9999999747524270787835121154785e-07;
        float4 _177 = _176;
        _177.w = 1.0;
        _178 = _177;
    }
    else
    {
        _178 = _167;
    }
    float _184 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _161));
    float4 _209 = _178;
    _209.z = ((_178.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_184) > 0.0) ? (sqrt(fast::clamp(1.0 - (_184 * _184), 0.0, 1.0)) / _184) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _178.w;
    float3x3 _210 = float3x3(_157, _158, _161);
    float3x3 _219 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _210;
    float3 _220 = _219[0];
    float4 _222 = float4(_220.x, _220.y, _220.z, _62.w);
    _222.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _222;
    out.out_var_TEXCOORD11_centroid = float4(_219[2], float(int(sign(determinant(_210)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _99.xyz;
    out.gl_Position = _209;
    return out;
}

