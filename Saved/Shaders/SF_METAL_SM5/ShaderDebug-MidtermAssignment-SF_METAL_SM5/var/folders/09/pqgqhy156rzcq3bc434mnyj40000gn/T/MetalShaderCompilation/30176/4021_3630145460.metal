

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1008];
    float3 View_WorldCameraOrigin;
    char _m2_pad[32];
    float3 View_PreViewTranslation;
    char _m3_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m4_pad[640];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_BeamTrailVF
{
    float4 BeamTrailVF_CameraRight;
    float4 BeamTrailVF_CameraUp;
    float4 BeamTrailVF_ScreenAlignment;
};

constant float4 _57 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD2 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
};

vertex MainVertexShader_out Main_00000fb5_d85f9fb4(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(2)]])
{
    MainVertexShader_out out = {};
    float3 _95 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float4 _100 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz)) + _95, 1.0);
    float3 _114 = _100.xyz;
    float3 _115 = View.View_WorldCameraOrigin - _114;
    float3 _122 = _114 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _95, 1.0).xyz;
    float _133 = cos(in.in_var_ATTRIBUTE2.z);
    float _136 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _142 = cross(_115 / float3(sqrt(fast::max(dot(_115, _115), 0.00999999977648258209228515625))), _122 / float3(sqrt(fast::max(dot(_122, _122), 0.00999999977648258209228515625))));
    bool4 _155 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _158 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _133)) + (BeamTrailVF.BeamTrailVF_CameraRight * _136), float4(_142 / float3(sqrt(fast::max(dot(_142, _142), 0.00999999977648258209228515625))), 0.0), _155).xyz;
    float3 _159 = select((BeamTrailVF.BeamTrailVF_CameraUp * _136) + (BeamTrailVF.BeamTrailVF_CameraRight * _133), float4(0.0), _155).xyz;
    float3x3 _163 = float3x3(_158, _159, -normalize(cross(_158, _159)));
    float3x3 _172 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _163;
    float3 _173 = _172[0];
    float4 _175 = float4(_173.x, _173.y, _173.z, _57.w);
    _175.w = 0.0;
    float4 _186 = View.View_TranslatedWorldToClip * _100;
    float4 _193 = _186;
    _193.z = _186.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _186.w) : 0.0);
    out.gl_Position = _193;
    out.out_var_TEXCOORD6 = _186;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * _100;
    out.out_var_TEXCOORD10_centroid = _175;
    out.out_var_TEXCOORD11_centroid = float4(_172[2], float(int(sign(determinant(_163)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    return out;
}

