

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

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex MainForGS_out Main_00001203_1013e529(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_BeamTrailVF& BeamTrailVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]])
{
    MainForGS_out out = {};
    float3 _75 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _80 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _81 = _75 + _80;
    float3 _86 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _87 = _81 + _86;
    float3 _91 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _92 = _87 + _91;
    float _93 = _92.x;
    float _94 = _92.y;
    float _95 = _92.z;
    float4 _96 = float4(_93, _94, _95, 1.0);
    float3 _110 = _96.xyz;
    float3 _111 = View.View_WorldCameraOrigin - _110;
    float3 _118 = _110 - float4((((Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE1.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE1.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE1.zzz)) + _91, 1.0).xyz;
    float _129 = cos(in.in_var_ATTRIBUTE2.z);
    float _132 = sin(in.in_var_ATTRIBUTE2.z);
    float3 _138 = cross(_111 / float3(sqrt(fast::max(dot(_111, _111), 0.00999999977648258209228515625))), _118 / float3(sqrt(fast::max(dot(_118, _118), 0.00999999977648258209228515625))));
    bool4 _151 = bool4(BeamTrailVF.BeamTrailVF_ScreenAlignment.x > 1.5);
    float4 _159 = float4(_96.x, _96.y, _96.z, _96.w);
    float4 _164 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _159;
    out.out_var_TEXCOORD6 = _159;
    out.out_var_TEXCOORD8 = -normalize(cross(select((BeamTrailVF.BeamTrailVF_CameraUp * ((-1.0) * _129)) + (BeamTrailVF.BeamTrailVF_CameraRight * _132), float4(_138 / float3(sqrt(fast::max(dot(_138, _138), 0.00999999977648258209228515625))), 0.0), _151).xyz, select((BeamTrailVF.BeamTrailVF_CameraUp * _132) + (BeamTrailVF.BeamTrailVF_CameraRight * _129), float4(0.0), _151).xyz));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _164;
    return out;
}

