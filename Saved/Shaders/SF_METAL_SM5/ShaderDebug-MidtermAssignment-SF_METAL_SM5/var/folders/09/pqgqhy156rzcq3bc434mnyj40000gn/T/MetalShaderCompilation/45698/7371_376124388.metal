

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

constant float3x3 _61 = {};
constant float4x4 _62 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR0 [[user(locn4)]];
    uint out_var_PRIMITIVE_ID [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVertexShader_out Main_00001ccb_166b33e4(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _81 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _89 = 2u * _81;
    float4 _94 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_89 + 1u)));
    float _95 = _94.w;
    float3 _96 = _94.xyz;
    float3 _98 = cross(_96, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_89)).xyz) * _95;
    float3x3 _101 = _61;
    _101[0] = cross(_98, _96) * _95;
    float3x3 _102 = _101;
    _102[1] = _98;
    float3x3 _103 = _102;
    _103[2] = _96;
    uint _104 = in.in_var_ATTRIBUTE13 * 36u;
    uint _107 = _104 + 1u;
    uint _110 = _104 + 2u;
    uint _113 = _104 + 4u;
    float3x3 _122 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _107)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _110)].xyz);
    _122[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _113)].x;
    float3x3 _125 = _122;
    _125[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _107)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _113)].y;
    float3x3 _128 = _125;
    _128[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _110)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _113)].z;
    float3x3 _129 = _128 * _103;
    float4x4 _169 = _62;
    _169[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104 + 10u)];
    float4x4 _173 = _169;
    _173[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104 + 11u)];
    float4x4 _177 = _173;
    _177[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104 + 12u)];
    uint _178 = _104 + 13u;
    float4x4 _181 = _177;
    _181[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _178)];
    float4x4 _185 = _181;
    _185[3].x = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _178)].x + View.View_PrevPreViewTranslation.x;
    float4x4 _189 = _185;
    _189[3].y = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _178)].y + View.View_PrevPreViewTranslation.y;
    float4x4 _193 = _189;
    _193[3].z = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _178)].z + View.View_PrevPreViewTranslation.z;
    float4 _201 = View.View_TranslatedWorldToClip * float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _107)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _110)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _104 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    float4 _208 = _201;
    _208.z = _201.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _201.w) : 0.0);
    out.gl_Position = _208;
    out.out_var_TEXCOORD6 = _201;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_193 * in.in_var_ATTRIBUTE0).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_129[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_129[2], _95 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _113)].w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_81 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    return out;
}

