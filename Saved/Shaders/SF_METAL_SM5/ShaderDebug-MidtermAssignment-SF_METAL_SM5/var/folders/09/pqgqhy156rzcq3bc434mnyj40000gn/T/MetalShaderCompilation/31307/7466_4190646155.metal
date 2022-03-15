

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

constant float3x3 _63 = {};

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

vertex Main_out Main_00001d2a_f9c82f8b(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _77 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _78 = 2u * _77;
    float4 _83 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_78 + 1u)));
    float _84 = _83.w;
    float3 _85 = _83.xyz;
    float3 _87 = cross(_85, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_78)).xyz) * _84;
    float3x3 _90 = _63;
    _90[0] = cross(_87, _85) * _84;
    float3x3 _91 = _90;
    _91[1] = _87;
    float3x3 _92 = _91;
    _92[2] = _85;
    uint _93 = in.in_var_ATTRIBUTE13 * 36u;
    uint _96 = _93 + 1u;
    uint _99 = _93 + 2u;
    uint _102 = _93 + 4u;
    float3x3 _111 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _99)].xyz);
    _111[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102)].x;
    float3x3 _114 = _111;
    _114[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102)].y;
    float3x3 _117 = _114;
    _117[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _99)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102)].z;
    float3x3 _118 = _117 * _92;
    uint _125 = _93 + 3u;
    float3 _130 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _133 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _134 = _130 + _133;
    float3 _137 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _99)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _138 = _134 + _137;
    float3 _140 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _125)].xyz + View.View_PreViewTranslation;
    float3 _141 = _138 + _140;
    float _142 = _141.x;
    float _143 = _141.y;
    float _144 = _141.z;
    float4 _145 = float4(_142, _143, _144, 1.0);
    uint _150 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _153 = _150 * _77;
    float4 _156 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_153 + min(0u, (_150 - 1u)))));
    float4 _157 = float4(_145.x, _145.y, _145.z, _145.w);
    float4 _158 = View.View_TranslatedWorldToClip * _157;
    float2 _165 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_153 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    uint _171 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _172 = _171 * 15u;
    uint _173 = _172 + 2u;
    uint _176 = _172 + 3u;
    float2 _181 = (_165 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _173)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _173)].zw;
    float2 _186 = (_165 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _176)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _176)].zw;
    spvUnsafeArray<float4, 1> _198 = { float4(_156.x, _156.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_118[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_118[2], _84 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102)].w);
    out_var_TEXCOORD0 = _198;
    out.out_var_TEXCOORD4 = float4(_181.x, _181.y, _186.x, _186.y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _171;
    out.gl_Position = _158;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

