

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
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _58 = {};
constant float4x4 _59 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVertexShader_out Main_00001b6a_00fb1ec6(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_LocalVF& LocalVF [[buffer(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _79 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _84 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_79 + 1u)));
    float _85 = _84.w;
    float3 _86 = _84.xyz;
    float3 _88 = cross(_86, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_79)).xyz) * _85;
    float3x3 _91 = _58;
    _91[0] = cross(_88, _86) * _85;
    float3x3 _92 = _91;
    _92[1] = _88;
    float3x3 _93 = _92;
    _93[2] = _86;
    uint _94 = in.in_var_ATTRIBUTE13 * 36u;
    uint _97 = _94 + 1u;
    uint _100 = _94 + 2u;
    uint _103 = _94 + 4u;
    float3x3 _112 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _97)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _100)].xyz);
    _112[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103)].x;
    float3x3 _115 = _112;
    _115[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _97)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103)].y;
    float3x3 _118 = _115;
    _118[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _100)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103)].z;
    float3x3 _119 = _118 * _93;
    float4x4 _159 = _59;
    _159[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94 + 10u)];
    float4x4 _163 = _159;
    _163[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94 + 11u)];
    float4x4 _167 = _163;
    _167[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94 + 12u)];
    uint _168 = _94 + 13u;
    float4x4 _171 = _167;
    _171[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _168)];
    float4x4 _175 = _171;
    _175[3].x = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _168)].x + View.View_PrevPreViewTranslation.x;
    float4x4 _179 = _175;
    _179[3].y = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _168)].y + View.View_PrevPreViewTranslation.y;
    float4x4 _183 = _179;
    _183[3].z = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _168)].z + View.View_PrevPreViewTranslation.z;
    float4 _191 = View.View_TranslatedWorldToClip * float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _97)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _100)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    float4 _198 = _191;
    _198.z = _191.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _191.w) : 0.0);
    out.gl_Position = _198;
    out.out_var_TEXCOORD6 = _191;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_183 * in.in_var_ATTRIBUTE0).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_119[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_119[2], _85 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _103)].w);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    return out;
}

