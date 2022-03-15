

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

constant float3x3 _65 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    uint out_var_LIGHTMAP_ID [[user(locn5)]];
    float4 out_var_TEXCOORD6 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVertexShader_out Main_00001cad_34e7b70d(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _79 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _80 = 2u * _79;
    float4 _85 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_80 + 1u)));
    float _86 = _85.w;
    float3 _87 = _85.xyz;
    float3 _89 = cross(_87, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_80)).xyz) * _86;
    float3x3 _92 = _65;
    _92[0] = cross(_89, _87) * _86;
    float3x3 _93 = _92;
    _93[1] = _89;
    float3x3 _94 = _93;
    _94[2] = _87;
    uint _95 = in.in_var_ATTRIBUTE13 * 36u;
    uint _98 = _95 + 1u;
    uint _101 = _95 + 2u;
    uint _104 = _95 + 4u;
    float3x3 _113 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _98)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _101)].xyz);
    _113[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].x;
    float3x3 _116 = _113;
    _116[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _98)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].y;
    float3x3 _119 = _116;
    _119[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _101)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].z;
    float3x3 _120 = _119 * _94;
    uint _127 = _95 + 3u;
    float3 _132 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _135 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _98)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _136 = _132 + _135;
    float3 _139 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _101)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _140 = _136 + _139;
    float3 _142 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _127)].xyz + View.View_PreViewTranslation;
    float3 _143 = _140 + _142;
    float _144 = _143.x;
    float _145 = _143.y;
    float _146 = _143.z;
    float4 _147 = float4(_144, _145, _146, 1.0);
    uint _152 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _155 = _152 * _79;
    float4 _158 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_155 + min(0u, (_152 - 1u)))));
    float4 _159 = float4(_147.x, _147.y, _147.z, _147.w);
    float4 _160 = View.View_TranslatedWorldToClip * _159;
    uint _173 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _95 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _175 = (_173 * 15u) + 2u;
    float2 _181 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint((_155 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _175)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _175)].zw;
    spvUnsafeArray<float4, 1> _193 = { float4(_158.x, _158.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_120[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_120[2], _86 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].w);
    out_var_TEXCOORD0 = _193;
    out.out_var_TEXCOORD4 = float4(_181.x, _181.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _173;
    out.out_var_TEXCOORD6 = _159;
    out.gl_Position = _160;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

