

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

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _45 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVS_out Main_00001233_38c1e8c0(MainVS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_LocalVF& LocalVF [[buffer(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    bool _50 = (gl_VertexIndex - gl_BaseVertex) == 2u;
    bool _51 = (gl_VertexIndex - gl_BaseVertex) == 1u;
    bool _52 = _50 || _51;
    float _53 = _52 ? 1.0 : (-3.0);
    float _54 = _51 ? (-3.0) : 1.0;
    float4 _55 = float4(_53, _54, 0.5, 1.0);
    uint _60 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _65 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_60 + 1u)));
    float _66 = _65.w;
    float3 _67 = _65.xyz;
    float3 _69 = cross(_67, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_60)).xyz) * _66;
    float3x3 _72 = _45;
    _72[0] = cross(_69, _67) * _66;
    float3x3 _73 = _72;
    _73[1] = _69;
    float3x3 _74 = _73;
    _74[2] = _67;
    uint _75 = in.in_var_ATTRIBUTE13 * 36u;
    uint _84 = _75 + 4u;
    float3x3 _93 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _75)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _75 + 1u)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _75 + 2u)].xyz);
    _93[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _75)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _84)].x;
    float3x3 _96 = _93;
    _96[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _75 + 1u)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _84)].y;
    float3x3 _99 = _96;
    _99[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _75 + 2u)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _84)].z;
    float3x3 _100 = _99 * _74;
    out.out_var_TEXCOORD10_centroid = float4(_100[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_100[2], _66 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _84)].w);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.gl_Position = _55;
    return out;
}

