

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

constant float3x3 _67 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    uint out_var_PRIMITIVE_ID [[user(locn5)]];
    uint out_var_LIGHTMAP_ID [[user(locn6)]];
    float4 out_var_TEXCOORD6 [[user(locn7)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVertexShader_out Main_00001e0f_f43e5760(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(4)]], constant type_View& View [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[4];
    uint _81 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _89 = 2u * _81;
    float4 _94 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_89 + 1u)));
    float _95 = _94.w;
    float3 _96 = _94.xyz;
    float3 _98 = cross(_96, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_89)).xyz) * _95;
    float3x3 _101 = _67;
    _101[0] = cross(_98, _96) * _95;
    float3x3 _102 = _101;
    _102[1] = _98;
    float3x3 _103 = _102;
    _103[2] = _96;
    uint _104 = in.in_var_ATTRIBUTE13 * 36u;
    uint _107 = _104 + 1u;
    uint _110 = _104 + 2u;
    uint _113 = _104 + 4u;
    float3x3 _122 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _104)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _107)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _110)].xyz);
    _122[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _104)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _113)].x;
    float3x3 _125 = _122;
    _125[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _107)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _113)].y;
    float3x3 _128 = _125;
    _128[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _110)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _113)].z;
    float3x3 _129 = _128 * _103;
    uint _136 = _104 + 3u;
    float3 _141 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _104)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _144 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _107)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _145 = _141 + _144;
    float3 _148 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _110)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _149 = _145 + _148;
    float3 _151 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _136)].xyz + View.View_PreViewTranslation;
    float3 _152 = _149 + _151;
    float _153 = _152.x;
    float _154 = _152.y;
    float _155 = _152.z;
    float4 _156 = float4(_153, _154, _155, 1.0);
    uint _161 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _164 = _161 * _81;
    float4 _167 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_164 + min(0u, (_161 - 1u)))));
    float4 _168 = float4(_156.x, _156.y, _156.z, _156.w);
    float4 _169 = View.View_TranslatedWorldToClip * _168;
    uint _182 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _104 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _184 = (_182 * 15u) + 2u;
    float2 _190 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint((_164 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _184)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(4, spvBufferSizeConstants, float4, _184)].zw;
    spvUnsafeArray<float4, 1> _202 = { float4(_167.x, _167.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_129[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_129[2], _95 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _113)].w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_81 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _202;
    out.out_var_TEXCOORD4 = float4(_190.x, _190.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _182;
    out.out_var_TEXCOORD6 = _168;
    out.gl_Position = _169;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

