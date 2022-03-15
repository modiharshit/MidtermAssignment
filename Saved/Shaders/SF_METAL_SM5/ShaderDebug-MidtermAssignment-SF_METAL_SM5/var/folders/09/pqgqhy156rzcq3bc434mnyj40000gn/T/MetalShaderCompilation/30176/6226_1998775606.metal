

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

constant float3x3 _57 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00001852_7722e536(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _71 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _72 = 2u * _71;
    float4 _77 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_72 + 1u)));
    float _78 = _77.w;
    float3 _79 = _77.xyz;
    float3 _81 = cross(_79, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_72)).xyz) * _78;
    float3x3 _84 = _57;
    _84[0] = cross(_81, _79) * _78;
    float3x3 _85 = _84;
    _85[1] = _81;
    float3x3 _86 = _85;
    _86[2] = _79;
    uint _87 = in.in_var_ATTRIBUTE13 * 36u;
    uint _90 = _87 + 1u;
    uint _93 = _87 + 2u;
    uint _96 = _87 + 4u;
    float3x3 _105 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _87)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _90)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz);
    _105[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _87)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].x;
    float3x3 _108 = _105;
    _108[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _90)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].y;
    float3x3 _111 = _108;
    _111[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].z;
    float3x3 _112 = _111 * _86;
    uint _119 = _87 + 3u;
    float3 _124 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _87)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _127 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _90)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _128 = _124 + _127;
    float3 _131 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _132 = _128 + _131;
    float3 _134 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _119)].xyz + View.View_PreViewTranslation;
    float3 _135 = _132 + _134;
    float _136 = _135.x;
    float _137 = _135.y;
    float _138 = _135.z;
    float4 _139 = float4(_136, _137, _138, 1.0);
    uint _142 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _148 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_142 * _71) + min(0u, (_142 - 1u)))));
    float4 _149 = float4(_139.x, _139.y, _139.z, _139.w);
    float4 _150 = View.View_TranslatedWorldToClip * _149;
    spvUnsafeArray<float4, 1> _162 = { float4(_148.x, _148.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_112[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_112[2], _78 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].w);
    out_var_TEXCOORD0 = _162;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _149;
    out.gl_Position = _150;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

