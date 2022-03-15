

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

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00000fa4_eac86cd5(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]])
{
    Main_out out = {};
    float3 _84 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float4 _89 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz)) + _84, 1.0);
    float3 _103 = _89.xyz;
    float3 _104 = View.View_WorldCameraOrigin - _103;
    float3 _111 = _103 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _84, 1.0).xyz;
    float _122 = cos(in.in_var_ATTRIBUTE2.z);
    float _125 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _131 = cross(_104 / float3(sqrt(fast::max(dot(_104, _104), 0.00999999977648258209228515625))), _111 / float3(sqrt(fast::max(dot(_111, _111), 0.00999999977648258209228515625))));
    bool4 _144 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float4 _157 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_89.x, _89.y, _89.z, _89.w);
    float4 _168;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_157.z < 0.0))
    {
        float4 _166 = _157;
        _166.z = 9.9999999747524270787835121154785e-07;
        float4 _167 = _166;
        _167.w = 1.0;
        _168 = _167;
    }
    else
    {
        _168 = _157;
    }
    float _174 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), -normalize(cross(select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _122)) + (BeamTrailVF.BeamTrailVF_CameraRight * _125), float4(_131 / float3(sqrt(fast::max(dot(_131, _131), 0.00999999977648258209228515625))), 0.0), _144).xyz, select((BeamTrailVF.BeamTrailVF_CameraUp * _125) + (BeamTrailVF.BeamTrailVF_CameraRight * _122), float4(0.0), _144).xyz))));
    out.out_var_TEXCOORD6 = _168.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_174) > 0.0) ? (sqrt(fast::clamp(1.0 - (_174 * _174), 0.0, 1.0)) / _174) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _168;
    return out;
}

