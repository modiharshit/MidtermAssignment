

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

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _71 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    float out_var_TEXCOORD6 [[user(locn4)]];
    float out_var_TEXCOORD8 [[user(locn5)]];
    float3 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00001c52_0db45fe3(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _81 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _82 = 2u * _81;
    float4 _87 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_82 + 1u)));
    float _88 = _87.w;
    float3 _89 = _87.xyz;
    float3 _91 = cross(_89, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_82)).xyz) * _88;
    float3x3 _94 = _71;
    _94[0] = cross(_91, _89) * _88;
    float3x3 _95 = _94;
    _95[1] = _91;
    float3x3 _96 = _95;
    _96[2] = _89;
    uint _97 = in.in_var_ATTRIBUTE13 * 36u;
    uint _100 = _97 + 1u;
    uint _103 = _97 + 2u;
    uint _112 = _97 + 4u;
    float3x3 _117 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _100)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _103)].xyz);
    _117[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _112)].x;
    float3x3 _120 = _117;
    _120[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _100)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _112)].y;
    float3x3 _123 = _120;
    _123[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _103)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _112)].z;
    float3x3 _124 = _123 * _96;
    float4 _149 = float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _100)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _103)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _97 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    uint _152 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _158 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_152 * _81) + min(0u, (_152 - 1u)))));
    float3 _159 = _124[2];
    float4 _165 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_149.x, _149.y, _149.z, _149.w);
    float4 _176;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_165.z < 0.0))
    {
        float4 _174 = _165;
        _174.z = 9.9999999747524270787835121154785e-07;
        float4 _175 = _174;
        _175.w = 1.0;
        _176 = _175;
    }
    else
    {
        _176 = _165;
    }
    float _182 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _159));
    spvUnsafeArray<float4, 1> _211 = { float4(_158.x, _158.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_124[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_159, _88 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _112)].w);
    out_var_TEXCOORD0 = _211;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _176.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_182) > 0.0) ? (sqrt(fast::clamp(1.0 - (_182 * _182), 0.0, 1.0)) / _182) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _149.xyz;
    out.gl_Position = _176;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

