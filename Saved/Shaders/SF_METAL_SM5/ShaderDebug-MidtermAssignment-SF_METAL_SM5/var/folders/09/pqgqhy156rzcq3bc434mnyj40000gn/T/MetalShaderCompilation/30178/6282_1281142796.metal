

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

vertex Main_out Main_0000188a_4c5cb00c(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _69 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _70 = 2u * _69;
    float4 _75 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_70 + 1u)));
    float _76 = _75.w;
    float3 _77 = _75.xyz;
    float3 _79 = cross(_77, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_70)).xyz) * _76;
    float3x3 _82 = _56;
    _82[0] = cross(_79, _77) * _76;
    float3x3 _83 = _82;
    _83[1] = _79;
    float3x3 _84 = _83;
    _84[2] = _77;
    uint _85 = in.in_var_ATTRIBUTE13 * 36u;
    uint _88 = _85 + 1u;
    uint _91 = _85 + 2u;
    uint _94 = _85 + 4u;
    float3x3 _103 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _85)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _88)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _91)].xyz);
    _103[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _85)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].x;
    float3x3 _106 = _103;
    _106[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _88)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].y;
    float3x3 _109 = _106;
    _109[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _91)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].z;
    float3x3 _110 = _109 * _84;
    uint _117 = _85 + 3u;
    float3 _122 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _85)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _125 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _88)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _126 = _122 + _125;
    float3 _129 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _91)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _130 = _126 + _129;
    float3 _132 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _117)].xyz + View.View_PreViewTranslation;
    float3 _133 = _130 + _132;
    float _134 = _133.x;
    float _135 = _133.y;
    float _136 = _133.z;
    float4 _137 = float4(_134, _135, _136, 1.0);
    uint _140 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _141 = _140 - 1u;
    uint _143 = _140 * _69;
    float4 _146 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_143 + min(0u, _141))));
    float4 _149 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_143 + min(1u, _141))));
    float4 _150 = float4(_137.x, _137.y, _137.z, _137.w);
    float4 _151 = View.View_TranslatedWorldToClip * _150;
    spvUnsafeArray<float4, 1> _163 = { float4(_146.x, _146.y, _149.x, _149.y) };
    out.out_var_TEXCOORD10_centroid = float4(_110[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_110[2], _76 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].w);
    out_var_TEXCOORD0 = _163;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.gl_Position = _151;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

