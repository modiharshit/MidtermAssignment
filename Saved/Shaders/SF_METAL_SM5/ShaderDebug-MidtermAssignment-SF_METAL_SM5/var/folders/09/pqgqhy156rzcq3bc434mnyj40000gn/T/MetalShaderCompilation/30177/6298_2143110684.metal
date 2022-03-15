

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

constant float3x3 _59 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVS_out Main_0000189a_7fbd461c(MainVS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _71 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _76 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_71 + 1u)));
    float _77 = _76.w;
    float3 _78 = _76.xyz;
    float3 _80 = cross(_78, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_71)).xyz) * _77;
    float3x3 _83 = _59;
    _83[0] = cross(_80, _78) * _77;
    float3x3 _84 = _83;
    _84[1] = _80;
    float3x3 _85 = _84;
    _85[2] = _78;
    uint _86 = in.in_var_ATTRIBUTE13 * 36u;
    uint _89 = _86 + 1u;
    uint _92 = _86 + 2u;
    uint _101 = _86 + 4u;
    float3x3 _106 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].xyz);
    _106[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _101)].x;
    float3x3 _109 = _106;
    _109[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _101)].y;
    float3x3 _112 = _109;
    _112[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _101)].z;
    float3x3 _113 = _112 * _85;
    float4 _138 = float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    float4 _139 = float4(_138.x, _138.y, _138.z, _138.w);
    float4 _142 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _139;
    float4 _153;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_142.z < 0.0))
    {
        float4 _151 = _142;
        _151.z = 9.9999999747524270787835121154785e-07;
        float4 _152 = _151;
        _152.w = 1.0;
        _153 = _152;
    }
    else
    {
        _153 = _142;
    }
    float _157 = _153.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _160 = _153;
    _160.z = _157 * _153.w;
    out.out_var_TEXCOORD10_centroid = float4(_113[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_113[2], _77 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _101)].w);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _157;
    out.out_var_TEXCOORD7 = _139;
    out.gl_Position = _160;
    return out;
}

