

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
    char _m0_pad[4];
    uint LayerId;
};

constant float3x3 _61 = {};

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
};

vertex MainForGS_out Main_0000168c_770aef1c(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
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
    uint _85 = 2u * _72;
    float4 _90 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_85 + 1u)));
    float _91 = _90.w;
    float3 _92 = _90.xyz;
    float3 _94 = cross(_92, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_85)).xyz) * _91;
    float3x3 _97 = _61;
    _97[0] = cross(_94, _92) * _91;
    float3x3 _98 = _97;
    _98[1] = _94;
    float3x3 _99 = _98;
    _99[2] = _92;
    float3x3 _113 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_78.xyz, _80.xyz, _82.xyz);
    float3x3 _116 = _113;
    _116[0] = normalize(_113[0]);
    float3x3 _119 = _116;
    _119[1] = normalize(_113[1]);
    float3x3 _122 = _119;
    _122[2] = normalize(_113[2]);
    float _124 = _78.x;
    float _125 = _78.y;
    float _126 = _78.z;
    float4 _127 = float4(_124, _125, _126, 0.0);
    float _128 = _80.x;
    float _129 = _80.y;
    float _130 = _80.z;
    float4 _131 = float4(_128, _129, _130, 0.0);
    float _132 = _82.x;
    float _133 = _82.y;
    float _134 = _82.z;
    float4 _135 = float4(_132, _133, _134, 0.0);
    float _136 = _84.x;
    float _137 = _84.y;
    float _138 = _84.z;
    float4 _139 = float4(_136, _137, _138, 1.0);
    float4x4 _140 = float4x4(_127, _131, _135, _139);
    float4 _141 = _140 * in.in_var_ATTRIBUTE0;
    float3 _142 = _141.xxx;
    float3 _143 = Primitive.Primitive_LocalToWorld[0].xyz * _142;
    float3 _144 = _141.yyy;
    float3 _145 = Primitive.Primitive_LocalToWorld[1].xyz * _144;
    float3 _146 = _143 + _145;
    float3 _147 = _141.zzz;
    float3 _148 = Primitive.Primitive_LocalToWorld[2].xyz * _147;
    float3 _149 = _146 + _148;
    float3 _152 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _153 = _149 + _152;
    float _154 = _153.x;
    float _155 = _153.y;
    float _156 = _153.z;
    float4 _157 = float4(_154, _155, _156, 1.0);
    float4 _158 = _157 * 1.0;
    float4 _160 = float4(_158.x, _158.y, _158.z, _158.w);
    float4 _165 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _160;
    out.out_var_TEXCOORD6 = _160;
    out.out_var_TEXCOORD8 = (_122 * _99)[2];
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _165;
    return out;
}

