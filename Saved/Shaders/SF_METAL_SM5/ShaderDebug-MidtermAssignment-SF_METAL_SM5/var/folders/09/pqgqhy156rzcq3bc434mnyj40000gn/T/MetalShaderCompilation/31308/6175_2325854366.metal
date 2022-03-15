

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
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _56 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_0000181f_8aa1b89e(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _70 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _71 = 2u * _70;
    float4 _76 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_71 + 1u)));
    float _77 = _76.w;
    float3 _78 = _76.xyz;
    float3 _80 = cross(_78, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_71)).xyz) * _77;
    float3x3 _83 = _56;
    _83[0] = cross(_80, _78) * _77;
    float3x3 _84 = _83;
    _84[1] = _80;
    float3x3 _85 = _84;
    _85[2] = _78;
    uint _86 = in.in_var_ATTRIBUTE13 * 36u;
    uint _89 = _86 + 1u;
    uint _92 = _86 + 2u;
    uint _95 = _86 + 4u;
    float3x3 _104 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _86)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _89)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _92)].xyz);
    _104[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _86)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95)].x;
    float3x3 _107 = _104;
    _107[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _89)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95)].y;
    float3x3 _110 = _107;
    _110[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _92)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95)].z;
    float3x3 _111 = _110 * _85;
    uint _118 = _86 + 3u;
    float3 _123 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _86)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _126 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _89)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _127 = _123 + _126;
    float3 _130 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _92)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _131 = _127 + _130;
    float3 _133 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _118)].xyz + View.View_PreViewTranslation;
    float3 _134 = _131 + _133;
    float _135 = _134.x;
    float _136 = _134.y;
    float _137 = _134.z;
    float4 _138 = float4(_135, _136, _137, 1.0);
    uint _141 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _147 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_141 * _70) + min(0u, (_141 - 1u)))));
    float4 _148 = float4(_138.x, _138.y, _138.z, _138.w);
    float4 _149 = View.View_TranslatedWorldToClip * _148;
    spvUnsafeArray<float4, 1> _161 = { float4(_147.x, _147.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_111[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_111[2], _77 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95)].w);
    out_var_TEXCOORD0 = _161;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.gl_Position = _149;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

