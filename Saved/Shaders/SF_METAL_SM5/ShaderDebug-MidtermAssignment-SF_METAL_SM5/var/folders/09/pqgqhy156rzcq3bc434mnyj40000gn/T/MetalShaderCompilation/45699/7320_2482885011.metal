

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
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct type_Globals
{
    uint LayerId;
};

constant float3x3 _72 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
    float4 out_var_TEXCOORD6 [[user(locn6)]];
    float3 out_var_TEXCOORD8 [[user(locn7)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex MainForGS_out Main_00001c98_93fdd193(MainForGS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(8)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _84 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _92 = 2u * _84;
    float4 _97 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_92 + 1u)));
    float _98 = _97.w;
    float3 _99 = _97.xyz;
    float3 _101 = cross(_99, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_92)).xyz) * _98;
    float3x3 _104 = _72;
    _104[0] = cross(_101, _99) * _98;
    float3x3 _105 = _104;
    _105[1] = _101;
    float3x3 _106 = _105;
    _106[2] = _99;
    uint _107 = in.in_var_ATTRIBUTE13 * 36u;
    uint _110 = _107 + 1u;
    uint _113 = _107 + 2u;
    uint _116 = _107 + 4u;
    float3x3 _125 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _107)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _110)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _113)].xyz);
    _125[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _107)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _116)].x;
    float3x3 _128 = _125;
    _128[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _110)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _116)].y;
    float3x3 _131 = _128;
    _131[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _113)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _116)].z;
    float3x3 _132 = _131 * _106;
    uint _139 = _107 + 3u;
    float3 _144 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _107)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _147 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _110)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _148 = _144 + _147;
    float3 _151 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _113)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _152 = _148 + _151;
    float3 _154 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _139)].xyz + View.View_PreViewTranslation;
    float3 _155 = _152 + _154;
    float _156 = _155.x;
    float _157 = _155.y;
    float _158 = _155.z;
    float4 _159 = float4(_156, _157, _158, 1.0);
    uint _162 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _168 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_162 * _84) + min(0u, (_162 - 1u)))));
    float3 _169 = _132[2];
    float4 _170 = float4(_159.x, _159.y, _159.z, _159.w);
    spvUnsafeArray<float4, 1> _181 = { float4(_168.x, _168.y, float4(0.0).z, float4(0.0).w) };
    float4 _187 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _170;
    out.out_var_TEXCOORD10_centroid = float4(_132[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_169, _98 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _116)].w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_84 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _181;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _159.xyz;
    out.out_var_TEXCOORD6 = _187;
    out.out_var_TEXCOORD8 = _169;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _187;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

