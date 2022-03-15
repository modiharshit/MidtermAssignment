

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_TranslucentDepthPass
{
    char _m0_pad[112];
    float4x4 TranslucentDepthPass_ProjectionMatrix;
    float TranslucentDepthPass_bClampToNearPlane;
    float TranslucentDepthPass_InvMaxSubjectDepth;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _66 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    float out_var_TEXCOORD6 [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVS_out Main_00001ad5_dd4b8be5(MainVS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _77 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _78 = 2u * _77;
    float4 _83 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_78 + 1u)));
    float _84 = _83.w;
    float3 _85 = _83.xyz;
    float3 _87 = cross(_85, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_78)).xyz) * _84;
    float3x3 _90 = _66;
    _90[0] = cross(_87, _85) * _84;
    float3x3 _91 = _90;
    _91[1] = _87;
    float3x3 _92 = _91;
    _92[2] = _85;
    uint _93 = in.in_var_ATTRIBUTE13 * 36u;
    uint _96 = _93 + 1u;
    uint _99 = _93 + 2u;
    uint _108 = _93 + 4u;
    float3x3 _113 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _99)].xyz);
    _113[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _108)].x;
    float3x3 _116 = _113;
    _116[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _108)].y;
    float3x3 _119 = _116;
    _119[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _99)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _108)].z;
    float3x3 _120 = _119 * _92;
    float4 _145 = float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _96)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _99)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _93 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    uint _148 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _154 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_148 * _77) + min(0u, (_148 - 1u)))));
    float4 _155 = float4(_145.x, _145.y, _145.z, _145.w);
    float4 _158 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _155;
    float4 _169;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_158.z < 0.0))
    {
        float4 _167 = _158;
        _167.z = 9.9999999747524270787835121154785e-07;
        float4 _168 = _167;
        _168.w = 1.0;
        _169 = _168;
    }
    else
    {
        _169 = _158;
    }
    float _173 = _169.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _176 = _169;
    _176.z = _173 * _169.w;
    spvUnsafeArray<float4, 1> _188 = { float4(_154.x, _154.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_120[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_120[2], _84 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _108)].w);
    out_var_TEXCOORD0 = _188;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _173;
    out.out_var_TEXCOORD7 = _155;
    out.gl_Position = _176;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

