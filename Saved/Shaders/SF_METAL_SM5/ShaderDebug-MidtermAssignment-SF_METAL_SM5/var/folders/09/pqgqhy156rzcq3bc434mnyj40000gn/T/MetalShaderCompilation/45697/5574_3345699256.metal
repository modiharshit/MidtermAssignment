

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

constant float3x3 _49 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_000015c6_c76b51b8(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_LocalVF& LocalVF [[buffer(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _63 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _68 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_63 + 1u)));
    float _69 = _68.w;
    float3 _70 = _68.xyz;
    float3 _72 = cross(_70, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_63)).xyz) * _69;
    float3x3 _75 = _49;
    _75[0] = cross(_72, _70) * _69;
    float3x3 _76 = _75;
    _76[1] = _72;
    float3x3 _77 = _76;
    _77[2] = _70;
    uint _78 = in.in_var_ATTRIBUTE13 * 36u;
    uint _81 = _78 + 1u;
    uint _84 = _78 + 2u;
    uint _87 = _78 + 4u;
    float3x3 _96 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _78)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _81)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _84)].xyz);
    _96[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _78)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _87)].x;
    float3x3 _99 = _96;
    _99[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _81)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _87)].y;
    float3x3 _102 = _99;
    _102[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _84)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _87)].z;
    float3x3 _103 = _102 * _77;
    uint _110 = _78 + 3u;
    float3 _115 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _78)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _118 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _81)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _119 = _115 + _118;
    float3 _122 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _84)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _123 = _119 + _122;
    float3 _125 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _110)].xyz + View.View_PreViewTranslation;
    float3 _126 = _123 + _125;
    float _127 = _126.x;
    float _128 = _126.y;
    float _129 = _126.z;
    float4 _130 = float4(_127, _128, _129, 1.0);
    float4 _131 = float4(_130.x, _130.y, _130.z, _130.w);
    float4 _132 = View.View_TranslatedWorldToClip * _131;
    out.out_var_TEXCOORD10_centroid = float4(_103[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_103[2], _69 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _87)].w);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.gl_Position = _132;
    return out;
}

