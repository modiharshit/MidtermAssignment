

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
    uint InstanceOffset;
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
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_0000154c_00e9748c(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    PositionOnlyMain_out out = {};
    uint _62 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _63 = 3u * _62;
    float4 _65 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_63));
    uint _66 = _63 + 1u;
    float4 _67 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_66));
    uint _68 = _63 + 2u;
    float4 _69 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_68));
    float4 _71 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_62));
    float _72 = _65.x;
    float _73 = _65.y;
    float _74 = _65.z;
    float4 _75 = float4(_72, _73, _74, 0.0);
    float _76 = _67.x;
    float _77 = _67.y;
    float _78 = _67.z;
    float4 _79 = float4(_76, _77, _78, 0.0);
    float _80 = _69.x;
    float _81 = _69.y;
    float _82 = _69.z;
    float4 _83 = float4(_80, _81, _82, 0.0);
    float _84 = _71.x;
    float _85 = _71.y;
    float _86 = _71.z;
    float4 _87 = float4(_84, _85, _86, 1.0);
    float4x4 _88 = float4x4(_75, _79, _83, _87);
    float4 _89 = _88 * in.in_var_ATTRIBUTE0;
    float3 _94 = _89.xxx;
    float3 _95 = Primitive.Primitive_LocalToWorld[0].xyz * _94;
    float3 _98 = _89.yyy;
    float3 _99 = Primitive.Primitive_LocalToWorld[1].xyz * _98;
    float3 _100 = _95 + _99;
    float3 _103 = _89.zzz;
    float3 _104 = Primitive.Primitive_LocalToWorld[2].xyz * _103;
    float3 _105 = _100 + _104;
    float3 _108 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _109 = _105 + _108;
    float _110 = _109.x;
    float _111 = _109.y;
    float _112 = _109.z;
    float4 _113 = float4(_110, _111, _112, 1.0);
    float4 _139 = float4x4(float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_63)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_66)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_68)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_62)).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _160 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _113;
    out.gl_Layer = _Globals.LayerId;
    out.out_var_TEXCOORD6 = _113;
    out.out_var_TEXCOORD8 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _139.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _139.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _139.zzz);
    out.gl_Position = _160;
    return out;
}

