

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

constant float3x3 _68 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainVS_out Main_00001c39_eca1a537(MainVS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _79 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _87 = 2u * _79;
    float4 _92 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_87 + 1u)));
    float _93 = _92.w;
    float3 _94 = _92.xyz;
    float3 _96 = cross(_94, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_87)).xyz) * _93;
    float3x3 _99 = _68;
    _99[0] = cross(_96, _94) * _93;
    float3x3 _100 = _99;
    _100[1] = _96;
    float3x3 _101 = _100;
    _101[2] = _94;
    uint _102 = in.in_var_ATTRIBUTE13 * 36u;
    uint _105 = _102 + 1u;
    uint _108 = _102 + 2u;
    uint _117 = _102 + 4u;
    float3x3 _122 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _102)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _105)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _108)].xyz);
    _122[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _102)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _117)].x;
    float3x3 _125 = _122;
    _125[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _105)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _117)].y;
    float3x3 _128 = _125;
    _128[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _108)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _117)].z;
    float3x3 _129 = _128 * _101;
    float4 _154 = float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _102)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _105)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _108)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _102 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    uint _157 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _163 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_157 * _79) + min(0u, (_157 - 1u)))));
    float4 _164 = float4(_154.x, _154.y, _154.z, _154.w);
    float4 _167 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _164;
    float4 _178;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_167.z < 0.0))
    {
        float4 _176 = _167;
        _176.z = 9.9999999747524270787835121154785e-07;
        float4 _177 = _176;
        _177.w = 1.0;
        _178 = _177;
    }
    else
    {
        _178 = _167;
    }
    float _182 = _178.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _185 = _178;
    _185.z = _182 * _178.w;
    spvUnsafeArray<float4, 1> _197 = { float4(_163.x, _163.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_129[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_129[2], _93 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _117)].w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_79 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _197;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = _182;
    out.out_var_TEXCOORD7 = _164;
    out.gl_Position = _185;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

