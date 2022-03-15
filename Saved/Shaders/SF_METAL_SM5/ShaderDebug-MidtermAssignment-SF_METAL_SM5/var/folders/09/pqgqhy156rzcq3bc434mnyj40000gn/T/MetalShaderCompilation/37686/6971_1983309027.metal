

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

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
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

constant float3x3 _70 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
    float3 out_var_TEXCOORD8 [[user(locn6)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainForGS_out Main_00001b3b_7636e4e3(MainForGS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _82 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _83 = 2u * _82;
    float4 _88 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_83 + 1u)));
    float _89 = _88.w;
    float3 _90 = _88.xyz;
    float3 _92 = cross(_90, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_83)).xyz) * _89;
    float3x3 _95 = _70;
    _95[0] = cross(_92, _90) * _89;
    float3x3 _96 = _95;
    _96[1] = _92;
    float3x3 _97 = _96;
    _97[2] = _90;
    uint _98 = in.in_var_ATTRIBUTE13 * 36u;
    uint _101 = _98 + 1u;
    uint _104 = _98 + 2u;
    uint _107 = _98 + 4u;
    float3x3 _116 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _98)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _101)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].xyz);
    _116[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _98)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _107)].x;
    float3x3 _119 = _116;
    _119[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _101)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _107)].y;
    float3x3 _122 = _119;
    _122[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _107)].z;
    float3x3 _123 = _122 * _97;
    uint _130 = _98 + 3u;
    float3 _135 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _98)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _138 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _101)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _139 = _135 + _138;
    float3 _142 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _143 = _139 + _142;
    float3 _145 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _130)].xyz + View.View_PreViewTranslation;
    float3 _146 = _143 + _145;
    float _147 = _146.x;
    float _148 = _146.y;
    float _149 = _146.z;
    float4 _150 = float4(_147, _148, _149, 1.0);
    uint _153 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _159 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_153 * _82) + min(0u, (_153 - 1u)))));
    float3 _160 = _123[2];
    float4 _161 = float4(_150.x, _150.y, _150.z, _150.w);
    spvUnsafeArray<float4, 1> _172 = { float4(_159.x, _159.y, float4(0.0).z, float4(0.0).w) };
    float4 _178 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _161;
    out.out_var_TEXCOORD10_centroid = float4(_123[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_160, _89 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _107)].w);
    out_var_TEXCOORD0 = _172;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _150.xyz;
    out.out_var_TEXCOORD6 = _178;
    out.out_var_TEXCOORD8 = _160;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _178;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

