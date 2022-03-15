

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

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
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_BeamTrailVF
{
    float4 BeamTrailVF_CameraRight;
    float4 BeamTrailVF_CameraUp;
    float4 BeamTrailVF_ScreenAlignment;
};

struct type_Globals
{
    uint LayerId;
};

constant float4 _67 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float3 out_var_TEXCOORD8 [[user(locn5)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
};

vertex Main_out Main_00001558_bd70ac06(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]])
{
    Main_out out = {};
    float3 _84 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _89 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _90 = _84 + _89;
    float3 _95 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _96 = _90 + _95;
    float3 _100 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _101 = _96 + _100;
    float _102 = _101.x;
    float _103 = _101.y;
    float _104 = _101.z;
    float4 _105 = float4(_102, _103, _104, 1.0);
    float3 _119 = _105.xyz;
    float3 _120 = View.View_WorldCameraOrigin - _119;
    float3 _127 = _119 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _100, 1.0).xyz;
    float _138 = cos(in.in_var_ATTRIBUTE2.z);
    float _141 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _147 = cross(_120 / float3(sqrt(fast::max(dot(_120, _120), 0.00999999977648258209228515625))), _127 / float3(sqrt(fast::max(dot(_127, _127), 0.00999999977648258209228515625))));
    bool4 _160 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float3 _163 = select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _138)) + (BeamTrailVF.BeamTrailVF_CameraRight * _141), float4(_147 / float3(sqrt(fast::max(dot(_147, _147), 0.00999999977648258209228515625))), 0.0), _160).xyz;
    float3 _164 = select((BeamTrailVF.BeamTrailVF_CameraUp * _141) + (BeamTrailVF.BeamTrailVF_CameraRight * _138), float4(0.0), _160).xyz;
    float3 _167 = -normalize(cross(_163, _164));
    float3x3 _168 = float3x3(_163, _164, _167);
    float4 _169 = float4(_105.x, _105.y, _105.z, _105.w);
    float3x3 _178 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * _168;
    float3 _179 = _178[0];
    float4 _181 = float4(_179.x, _179.y, _179.z, _67.w);
    _181.w = 0.0;
    float4 _196 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _169;
    out.out_var_TEXCOORD10_centroid = _181;
    out.out_var_TEXCOORD11_centroid = float4(_178[2], float(int(sign(determinant(_168)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_TEXCOORD7 = _105.xyz;
    out.out_var_TEXCOORD6 = _196;
    out.out_var_TEXCOORD8 = _167;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _196;
    return out;
}

