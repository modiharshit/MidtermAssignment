

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

constant float4 _52 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
};

vertex Main_out Main_00000e95_5e3d95f6(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(2)]])
{
    Main_out out = {};
    float3 _70 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _75 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _76 = _70 + _75;
    float3 _81 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _82 = _76 + _81;
    float3 _86 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _87 = _82 + _86;
    float _88 = _87.x;
    float _89 = _87.y;
    float _90 = _87.z;
    float4 _91 = float4(_88, _89, _90, 1.0);
    float3 _92 = _91.xyz;
    float4 _93 = float4(_91.x, _91.y, _91.z, _91.w);
    float4 _94 = View.View_TranslatedWorldToClip * _93;
    float3 _108 = View.View_WorldCameraOrigin - _92;
    float3 _115 = _92 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _86, 1.0).xyz;
    float _126 = cos(in.in_var_ATTRIBUTE2.z);
    float _129 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _135 = cross(_108 / float3(sqrt(fast::max(dot(_108, _108), 0.00999999977648258209228515625))), _115 / float3(sqrt(fast::max(dot(_115, _115), 0.00999999977648258209228515625))));
    bool4 _148 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _151 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _126)) + (BeamTrailVF.BeamTrailVF_CameraRight * _129), float4(_135 / float3(sqrt(fast::max(dot(_135, _135), 0.00999999977648258209228515625))), 0.0), _148).xyz;
    float3 _152 = select((BeamTrailVF.BeamTrailVF_CameraUp * _129) + (BeamTrailVF.BeamTrailVF_CameraRight * _126), float4(0.0), _148).xyz;
    float3x3 _156 = float3x3(_151, _152, -normalize(cross(_151, _152)));
    float3x3 _165 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _156;
    float3 _166 = _165[0];
    float4 _168 = float4(_166.x, _166.y, _166.z, _52.w);
    _168.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _168;
    out.out_var_TEXCOORD11_centroid = float4(_165[2], float(int(sign(determinant(_156)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.gl_Position = _94;
    return out;
}

