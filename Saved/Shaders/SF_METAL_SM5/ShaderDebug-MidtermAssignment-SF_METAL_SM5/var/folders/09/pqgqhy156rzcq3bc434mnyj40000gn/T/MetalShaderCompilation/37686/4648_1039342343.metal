

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
    float TranslucentDepthPass_InvMaxSubjectDepth;
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

vertex MainVS_out Main_00001228_3df31b07(MainVS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]])
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
    float _117 = _113.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _120 = _113;
    _120.z = _117 * _113.w;
    float3 _134 = _98.xyz;
    float3 _135 = View.View_WorldCameraOrigin - _134;
    float3 _142 = _134 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _93, 1.0).xyz;
    float _153 = cos(in.in_var_ATTRIBUTE2.z);
    float _156 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _162 = cross(_135 / float3(sqrt(fast::max(dot(_135, _135), 0.00999999977648258209228515625))), _142 / float3(sqrt(fast::max(dot(_142, _142), 0.00999999977648258209228515625))));
    bool4 _175 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _178 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _153)) + (BeamTrailVF.BeamTrailVF_CameraRight * _156), float4(_162 / float3(sqrt(fast::max(dot(_162, _162), 0.00999999977648258209228515625))), 0.0), _175).xyz;
    float3 _179 = select((BeamTrailVF.BeamTrailVF_CameraUp * _156) + (BeamTrailVF.BeamTrailVF_CameraRight * _153), float4(0.0), _175).xyz;
    float3x3 _183 = float3x3(_178, _179, -normalize(cross(_178, _179)));
    float3x3 _192 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _183;
    float3 _193 = _192[0];
    float4 _195 = float4(_193.x, _193.y, _193.z, _61.w);
    _195.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _195;
    out.out_var_TEXCOORD11_centroid = float4(_192[2], float(int(sign(determinant(_183)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD3 = in.in_var_ATTRIBUTE4;
    out.out_var_TEXCOORD6 = _117;
    out.out_var_TEXCOORD7 = _99;
    out.gl_Position = _120;
    return out;
}

