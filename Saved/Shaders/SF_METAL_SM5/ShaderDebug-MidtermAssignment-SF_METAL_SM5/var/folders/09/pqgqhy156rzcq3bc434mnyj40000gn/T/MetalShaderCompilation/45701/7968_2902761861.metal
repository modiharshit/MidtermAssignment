

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

constant float3x3 _67 = {};
constant float4x4 _68 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR0 [[user(locn4)]];
    float4 out_var_TEXCOORD0_0 [[user(locn5)]];
    uint out_var_PRIMITIVE_ID [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVertexShader_out Main_00001f20_ad04a185(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _88 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _96 = 2u * _88;
    float4 _101 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_96 + 1u)));
    float _102 = _101.w;
    float3 _103 = _101.xyz;
    float3 _105 = cross(_103, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_96)).xyz) * _102;
    float3x3 _108 = _67;
    _108[0] = cross(_105, _103) * _102;
    float3x3 _109 = _108;
    _109[1] = _105;
    float3x3 _110 = _109;
    _110[2] = _103;
    uint _111 = in.in_var_ATTRIBUTE13 * 36u;
    uint _114 = _111 + 1u;
    uint _117 = _111 + 2u;
    uint _120 = _111 + 4u;
    float3x3 _129 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _111)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _114)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _117)].xyz);
    _129[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _111)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _120)].x;
    float3x3 _132 = _129;
    _132[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _114)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _120)].y;
    float3x3 _135 = _132;
    _135[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _117)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _120)].z;
    float3x3 _136 = _135 * _110;
    uint _169 = _111 + 13u;
    uint _173 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _179 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_173 * _88) + min(0u, (_173 - 1u)))));
    spvUnsafeArray<float4, 1> _191 = { float4(_179.x, _179.y, float4(0.0).z, float4(0.0).w) };
    float4x4 _193 = _68;
    _193[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _111 + 10u)];
    float4x4 _195 = _193;
    _195[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _111 + 11u)];
    float4x4 _197 = _195;
    _197[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _111 + 12u)];
    float4x4 _199 = _197;
    _199[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)];
    float4x4 _203 = _199;
    _203[3].x = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].x + View.View_PrevPreViewTranslation.x;
    float4x4 _207 = _203;
    _207[3].y = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].y + View.View_PrevPreViewTranslation.y;
    float4x4 _211 = _207;
    _211[3].z = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _169)].z + View.View_PrevPreViewTranslation.z;
    float4 _219 = View.View_TranslatedWorldToClip * float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _111)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _114)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _117)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _111 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    float4 _226 = _219;
    _226.z = _219.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _219.w) : 0.0);
    out.gl_Position = _226;
    out.out_var_TEXCOORD6 = _219;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_211 * in.in_var_ATTRIBUTE0).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_136[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_136[2], _102 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _120)].w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_88 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _191;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

