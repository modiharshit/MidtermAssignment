

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

constant float3x3 _64 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    uint out_var_LIGHTMAP_ID [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00001c0b_9d00737d(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _78 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _79 = 2u * _78;
    float4 _84 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_79 + 1u)));
    float _85 = _84.w;
    float3 _86 = _84.xyz;
    float3 _88 = cross(_86, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_79)).xyz) * _85;
    float3x3 _91 = _64;
    _91[0] = cross(_88, _86) * _85;
    float3x3 _92 = _91;
    _92[1] = _88;
    float3x3 _93 = _92;
    _93[2] = _86;
    uint _94 = in.in_var_ATTRIBUTE13 * 36u;
    uint _97 = _94 + 1u;
    uint _100 = _94 + 2u;
    uint _103 = _94 + 4u;
    float3x3 _112 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _100)].xyz);
    _112[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _103)].x;
    float3x3 _115 = _112;
    _115[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _103)].y;
    float3x3 _118 = _115;
    _118[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _100)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _103)].z;
    float3x3 _119 = _118 * _93;
    uint _126 = _94 + 3u;
    float3 _131 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _134 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _135 = _131 + _134;
    float3 _138 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _100)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _139 = _135 + _138;
    float3 _141 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _126)].xyz + View.View_PreViewTranslation;
    float3 _142 = _139 + _141;
    float _143 = _142.x;
    float _144 = _142.y;
    float _145 = _142.z;
    float4 _146 = float4(_143, _144, _145, 1.0);
    uint _151 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _154 = _151 * _78;
    float4 _157 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_154 + min(0u, (_151 - 1u)))));
    float4 _158 = float4(_146.x, _146.y, _146.z, _146.w);
    float4 _159 = View.View_TranslatedWorldToClip * _158;
    uint _172 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _94 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _174 = (_172 * 15u) + 2u;
    float2 _180 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint((_154 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _174)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _174)].zw;
    spvUnsafeArray<float4, 1> _192 = { float4(_157.x, _157.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_119[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_119[2], _85 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _103)].w);
    out_var_TEXCOORD0 = _192;
    out.out_var_TEXCOORD4 = float4(_180.x, _180.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _172;
    out.gl_Position = _159;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

