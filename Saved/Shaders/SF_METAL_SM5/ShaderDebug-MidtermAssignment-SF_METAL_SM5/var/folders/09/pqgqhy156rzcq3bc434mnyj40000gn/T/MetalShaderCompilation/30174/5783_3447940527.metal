

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

constant float3x3 _58 = {};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00001697_cd8365af(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _71 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _76 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_71 + 1u)));
    float _77 = _76.w;
    float3 _78 = _76.xyz;
    float3 _80 = cross(_78, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_71)).xyz) * _77;
    float3x3 _83 = _58;
    _83[0] = cross(_80, _78) * _77;
    float3x3 _84 = _83;
    _84[1] = _80;
    float3x3 _85 = _84;
    _85[2] = _78;
    uint _86 = in.in_var_ATTRIBUTE13 * 36u;
    uint _89 = _86 + 1u;
    uint _92 = _86 + 2u;
    uint _95 = _86 + 4u;
    float3x3 _104 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].xyz);
    _104[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _95)].x;
    float3x3 _107 = _104;
    _107[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _95)].y;
    float3x3 _110 = _107;
    _110[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _95)].z;
    uint _115 = _86 + 3u;
    float3 _120 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _86)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _123 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _89)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _124 = _120 + _123;
    float3 _127 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _92)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _128 = _124 + _127;
    float3 _130 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _115)].xyz + View.View_PreViewTranslation;
    float3 _131 = _128 + _130;
    float _132 = _131.x;
    float _133 = _131.y;
    float _134 = _131.z;
    float4 _135 = float4(_132, _133, _134, 1.0);
    float4 _137 = float4(_135.x, _135.y, _135.z, _135.w);
    float4 _142 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _137;
    out.out_var_TEXCOORD6 = _137;
    out.out_var_TEXCOORD8 = (_110 * _85)[2];
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _142;
    return out;
}

