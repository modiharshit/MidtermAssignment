

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

constant float4 _53 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
};

vertex Main_out Main_00000ed6_106209db(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(2)]])
{
    Main_out out = {};
    float3 _71 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _76 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _77 = _71 + _76;
    float3 _82 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _83 = _77 + _82;
    float3 _87 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _88 = _83 + _87;
    float _89 = _88.x;
    float _90 = _88.y;
    float _91 = _88.z;
    float4 _92 = float4(_89, _90, _91, 1.0);
    float4 _93 = float4(_92.x, _92.y, _92.z, _92.w);
    float4 _94 = View.View_TranslatedWorldToClip * _93;
    float3 _108 = _92.xyz;
    float3 _109 = View.View_WorldCameraOrigin - _108;
    float3 _116 = _108 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _87, 1.0).xyz;
    float _127 = cos(in.in_var_ATTRIBUTE2.z);
    float _130 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _136 = cross(_109 / float3(sqrt(fast::max(dot(_109, _109), 0.00999999977648258209228515625))), _116 / float3(sqrt(fast::max(dot(_116, _116), 0.00999999977648258209228515625))));
    bool4 _149 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _152 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _127)) + (BeamTrailVF.BeamTrailVF_CameraRight * _130), float4(_136 / float3(sqrt(fast::max(dot(_136, _136), 0.00999999977648258209228515625))), 0.0), _149).xyz;
    float3 _153 = select((BeamTrailVF.BeamTrailVF_CameraUp * _130) + (BeamTrailVF.BeamTrailVF_CameraRight * _127), float4(0.0), _149).xyz;
    float3x3 _157 = float3x3(_152, _153, -normalize(cross(_152, _153)));
    float3x3 _166 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _157;
    float3 _167 = _166[0];
    float4 _169 = float4(_167.x, _167.y, _167.z, _53.w);
    _169.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _169;
    out.out_var_TEXCOORD11_centroid = float4(_166[2], float(int(sign(determinant(_157)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD6 = _93;
    out.gl_Position = _94;
    return out;
}

