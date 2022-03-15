

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_Globals
{
    uint LayerId;
};

struct PositionOnlyMain_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
};

vertex PositionOnlyMain_out Main_00000e3f_e6f37d40(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    PositionOnlyMain_out out = {};
    float3 _55 = Primitive.Primitive_LocalToWorld[0u].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _60 = Primitive.Primitive_LocalToWorld[1u].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _61 = _55 + _60;
    float3 _66 = Primitive.Primitive_LocalToWorld[2u].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _67 = _61 + _66;
    float3 _71 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _72 = _67 + _71;
    float _73 = _72.x;
    float _74 = _72.y;
    float _75 = _72.z;
    float4 _76 = float4(_73, _74, _75, 1.0);
    float4 _97 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _76;
    out.gl_Layer = _Globals.LayerId;
    out.out_var_TEXCOORD6 = _76;
    out.out_var_TEXCOORD8 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE1.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE1.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE1.zzz);
    out.gl_Position = _97;
    return out;
}

