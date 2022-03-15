

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
    char _m1_pad[4];
    uint LocalVF_LODLightmapDataIndex;
};

constant float3x3 _59 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD4 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    uint out_var_LIGHTMAP_ID [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00001b8a_3d088805(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _72 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _73 = 2u * _72;
    float4 _78 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_73 + 1u)));
    float _79 = _78.w;
    float3 _80 = _78.xyz;
    float3 _82 = cross(_80, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_73)).xyz) * _79;
    float3x3 _85 = _59;
    _85[0] = cross(_82, _80) * _79;
    float3x3 _86 = _85;
    _86[1] = _82;
    float3x3 _87 = _86;
    _87[2] = _80;
    uint _88 = in.in_var_ATTRIBUTE13 * 36u;
    uint _91 = _88 + 1u;
    uint _94 = _88 + 2u;
    uint _97 = _88 + 4u;
    float3x3 _106 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _88)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _91)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].xyz);
    _106[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _88)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].x;
    float3x3 _109 = _106;
    _109[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _91)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].y;
    float3x3 _112 = _109;
    _112[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].z;
    float3x3 _113 = _112 * _87;
    uint _120 = _88 + 3u;
    float3 _125 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _88)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _128 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _91)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _129 = _125 + _128;
    float3 _132 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _133 = _129 + _132;
    float3 _135 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _120)].xyz + View.View_PreViewTranslation;
    float3 _136 = _133 + _135;
    float _137 = _136.x;
    float _138 = _136.y;
    float _139 = _136.z;
    float4 _140 = float4(_137, _138, _139, 1.0);
    float4 _141 = float4(_140.x, _140.y, _140.z, _140.w);
    float4 _142 = View.View_TranslatedWorldToClip * _141;
    float2 _153 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _72) + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    uint _161 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _88 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _162 = _161 * 15u;
    uint _163 = _162 + 2u;
    uint _166 = _162 + 3u;
    float2 _171 = (_153 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _163)].zw;
    float2 _176 = (_153 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _166)].zw;
    out.out_var_TEXCOORD10_centroid = float4(_113[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_113[2], _79 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].w);
    out.out_var_TEXCOORD4 = float4(_171.x, _171.y, _176.x, _176.y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _161;
    out.gl_Position = _142;
    return out;
}

