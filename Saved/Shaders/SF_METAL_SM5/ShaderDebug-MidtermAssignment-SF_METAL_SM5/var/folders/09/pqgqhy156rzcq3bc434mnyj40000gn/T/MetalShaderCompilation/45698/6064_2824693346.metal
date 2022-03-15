

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
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float3 out_var_TEXCOORD8 [[user(locn5)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_000017b0_a85d6662(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(0)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    PositionOnlyMain_out out = {};
    uint _76 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _77 = _76 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _79 = VertexFetch_InstanceBoneMapBuffer.read(uint(_77));
    uint _80 = _79.x;
    uint _81 = 4u * _80;
    float4 _83 = VertexFetch_InstanceTransformBuffer.read(uint(_81));
    uint _84 = _81 + 1u;
    float4 _85 = VertexFetch_InstanceTransformBuffer.read(uint(_84));
    uint _86 = _81 + 2u;
    float4 _87 = VertexFetch_InstanceTransformBuffer.read(uint(_86));
    uint _88 = _81 + 3u;
    float4 _89 = VertexFetch_InstanceTransformBuffer.read(uint(_88));
    float _90 = _83.x;
    float _91 = _83.y;
    float _92 = _83.z;
    float4 _93 = float4(_90, _91, _92, 0.0);
    float _94 = _85.x;
    float _95 = _85.y;
    float _96 = _85.z;
    float4 _97 = float4(_94, _95, _96, 0.0);
    float _98 = _87.x;
    float _99 = _87.y;
    float _100 = _87.z;
    float4 _101 = float4(_98, _99, _100, 0.0);
    float _102 = _89.x;
    float _103 = _89.y;
    float _104 = _89.z;
    float4 _105 = float4(_102, _103, _104, 1.0);
    float4x4 _106 = float4x4(_93, _97, _101, _105);
    float4 _107 = _106 * in.in_var_ATTRIBUTE0;
    float3 _112 = _107.xxx;
    float3 _113 = Primitive.Primitive_LocalToWorld[0].xyz * _112;
    float3 _116 = _107.yyy;
    float3 _117 = Primitive.Primitive_LocalToWorld[1].xyz * _116;
    float3 _118 = _113 + _117;
    float3 _121 = _107.zzz;
    float3 _122 = Primitive.Primitive_LocalToWorld[2].xyz * _121;
    float3 _123 = _118 + _122;
    float3 _126 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _127 = _123 + _126;
    float _128 = _127.x;
    float _129 = _127.y;
    float _130 = _127.z;
    float4 _131 = float4(_128, _129, _130, 1.0);
    uint _138 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_77)).x;
    float4 _163 = float4x4(float4(VertexFetch_InstanceTransformBuffer.read(uint(_138)).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_138 + 1u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_138 + 2u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_138 + 3u))).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _184 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _131;
    out.gl_Layer = _Globals.LayerId;
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_COLOR1 = float4(0.0);
    out.out_var_TEXCOORD7 = _131.xyz;
    out.out_var_TEXCOORD6 = _184;
    out.out_var_TEXCOORD8 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _163.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _163.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _163.zzz);
    out.gl_Position = _184;
    return out;
}

