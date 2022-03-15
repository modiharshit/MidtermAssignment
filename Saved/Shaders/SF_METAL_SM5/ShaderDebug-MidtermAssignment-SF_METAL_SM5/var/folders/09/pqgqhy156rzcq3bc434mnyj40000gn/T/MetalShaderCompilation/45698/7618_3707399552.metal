

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

constant float3x3 _65 = {};
constant float4x4 _66 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
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

vertex MainVertexShader_out Main_00001dc2_dcfa6d80(MainVertexShader_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _86 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _87 = 2u * _86;
    float4 _92 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_87 + 1u)));
    float _93 = _92.w;
    float3 _94 = _92.xyz;
    float3 _96 = cross(_94, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_87)).xyz) * _93;
    float3x3 _99 = _65;
    _99[0] = cross(_96, _94) * _93;
    float3x3 _100 = _99;
    _100[1] = _96;
    float3x3 _101 = _100;
    _101[2] = _94;
    uint _102 = in.in_var_ATTRIBUTE13 * 36u;
    uint _105 = _102 + 1u;
    uint _108 = _102 + 2u;
    uint _111 = _102 + 4u;
    float3x3 _120 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _105)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _108)].xyz);
    _120[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _111)].x;
    float3x3 _123 = _120;
    _123[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _105)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _111)].y;
    float3x3 _126 = _123;
    _126[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _108)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _111)].z;
    float3x3 _127 = _126 * _101;
    uint _160 = _102 + 13u;
    uint _164 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _170 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_164 * _86) + min(0u, (_164 - 1u)))));
    spvUnsafeArray<float4, 1> _182 = { float4(_170.x, _170.y, float4(0.0).z, float4(0.0).w) };
    float4x4 _184 = _66;
    _184[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102 + 10u)];
    float4x4 _186 = _184;
    _186[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102 + 11u)];
    float4x4 _188 = _186;
    _188[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102 + 12u)];
    float4x4 _190 = _188;
    _190[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)];
    float4x4 _194 = _190;
    _194[3].x = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].x + View.View_PrevPreViewTranslation.x;
    float4x4 _198 = _194;
    _198[3].y = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].y + View.View_PrevPreViewTranslation.y;
    float4x4 _202 = _198;
    _202[3].z = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _160)].z + View.View_PrevPreViewTranslation.z;
    float4 _210 = View.View_TranslatedWorldToClip * float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _105)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _108)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _102 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    float4 _217 = _210;
    _217.z = _210.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _210.w) : 0.0);
    out.gl_Position = _217;
    out.out_var_TEXCOORD6 = _210;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_202 * in.in_var_ATTRIBUTE0).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_127[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_127[2], _93 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _111)].w);
    out_var_TEXCOORD0 = _182;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

