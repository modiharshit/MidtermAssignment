

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

struct type_TranslucentDepthPass
{
    char _m0_pad[112];
    float4x4 TranslucentDepthPass_ProjectionMatrix;
    float TranslucentDepthPass_bClampToNearPlane;
};

struct type_BeamTrailVF
{
    float4 BeamTrailVF_CameraRight;
    float4 BeamTrailVF_CameraUp;
    float4 BeamTrailVF_ScreenAlignment;
};

constant float4 _61 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float out_var_TEXCOORD6 [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex MainVS_out Main_00001175_f7ebea5e(MainVS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]])
{
    MainVS_out out = {};
    float3 _93 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float4 _98 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz)) + _93, 1.0);
    float4 _99 = float4(_98.x, _98.y, _98.z, _98.w);
    float4 _102 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _99;
    float4 _113;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_102.z < 0.0))
    {
        float4 _111 = _102;
        _111.z = 9.9999999747524270787835121154785e-07;
        float4 _112 = _111;
        _112.w = 1.0;
        _113 = _112;
    }
    else
    {
        _113 = _102;
    }
    float3 _128 = _98.xyz;
    float3 _129 = View.View_WorldCameraOrigin - _128;
    float3 _136 = _128 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _93, 1.0).xyz;
    float _147 = cos(in.in_var_ATTRIBUTE2.z);
    float _150 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _156 = cross(_129 / float3(sqrt(fast::max(dot(_129, _129), 0.00999999977648258209228515625))), _136 / float3(sqrt(fast::max(dot(_136, _136), 0.00999999977648258209228515625))));
    bool4 _169 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _172 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _147)) + (BeamTrailVF.BeamTrailVF_CameraRight * _150), float4(_156 / float3(sqrt(fast::max(dot(_156, _156), 0.00999999977648258209228515625))), 0.0), _169).xyz;
    float3 _173 = select((BeamTrailVF.BeamTrailVF_CameraUp * _150) + (BeamTrailVF.BeamTrailVF_CameraRight * _147), float4(0.0), _169).xyz;
    float3x3 _177 = float3x3(_172, _173, -normalize(cross(_172, _173)));
    float3x3 _186 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _177;
    float3 _187 = _186[0];
    float4 _189 = float4(_187.x, _187.y, _187.z, _61.w);
    _189.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _189;
    out.out_var_TEXCOORD11_centroid = float4(_186[2], float(int(sign(determinant(_177)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD3 = in.in_var_ATTRIBUTE4;
    out.out_var_TEXCOORD6 = _113.z;
    out.out_var_TEXCOORD7 = _99;
    out.gl_Position = _113;
    return out;
}

