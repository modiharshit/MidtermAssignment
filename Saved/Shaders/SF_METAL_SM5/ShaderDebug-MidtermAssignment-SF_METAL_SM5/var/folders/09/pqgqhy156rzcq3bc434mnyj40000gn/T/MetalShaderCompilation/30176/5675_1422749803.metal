

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

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
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
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_0000162b_54cd706b(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(0)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    PositionOnlyMain_out out = {};
    uint _71 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _72 = _71 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _74 = VertexFetch_InstanceBoneMapBuffer.read(uint(_72));
    uint _75 = _74.x;
    uint _76 = 4u * _75;
    float4 _78 = VertexFetch_InstanceTransformBuffer.read(uint(_76));
    uint _79 = _76 + 1u;
    float4 _80 = VertexFetch_InstanceTransformBuffer.read(uint(_79));
    uint _81 = _76 + 2u;
    float4 _82 = VertexFetch_InstanceTransformBuffer.read(uint(_81));
    uint _83 = _76 + 3u;
    float4 _84 = VertexFetch_InstanceTransformBuffer.read(uint(_83));
    float _85 = _78.x;
    float _86 = _78.y;
    float _87 = _78.z;
    float4 _88 = float4(_85, _86, _87, 0.0);
    float _89 = _80.x;
    float _90 = _80.y;
    float _91 = _80.z;
    float4 _92 = float4(_89, _90, _91, 0.0);
    float _93 = _82.x;
    float _94 = _82.y;
    float _95 = _82.z;
    float4 _96 = float4(_93, _94, _95, 0.0);
    float _97 = _84.x;
    float _98 = _84.y;
    float _99 = _84.z;
    float4 _100 = float4(_97, _98, _99, 1.0);
    float4x4 _101 = float4x4(_88, _92, _96, _100);
    float4 _102 = _101 * in.in_var_ATTRIBUTE0;
    float3 _107 = _102.xxx;
    float3 _108 = Primitive.Primitive_LocalToWorld[0].xyz * _107;
    float3 _111 = _102.yyy;
    float3 _112 = Primitive.Primitive_LocalToWorld[1].xyz * _111;
    float3 _113 = _108 + _112;
    float3 _116 = _102.zzz;
    float3 _117 = Primitive.Primitive_LocalToWorld[2].xyz * _116;
    float3 _118 = _113 + _117;
    float3 _121 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _122 = _118 + _121;
    float _123 = _122.x;
    float _124 = _122.y;
    float _125 = _122.z;
    float4 _126 = float4(_123, _124, _125, 1.0);
    uint _133 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_72)).x;
    float4 _158 = float4x4(float4(VertexFetch_InstanceTransformBuffer.read(uint(_133)).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_133 + 1u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_133 + 2u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_133 + 3u))).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _179 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _126;
    out.gl_Layer = _Globals.LayerId;
    out.out_var_TEXCOORD6 = _126;
    out.out_var_TEXCOORD8 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _158.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _158.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _158.zzz);
    out.gl_Position = _179;
    return out;
}

