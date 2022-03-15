

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

constant float3x3 _62 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00001a2d_fe21f3c1(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _76 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _81 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_76 + 1u)));
    float _82 = _81.w;
    float3 _83 = _81.xyz;
    float3 _85 = cross(_83, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_76)).xyz) * _82;
    float3x3 _88 = _62;
    _88[0] = cross(_85, _83) * _82;
    float3x3 _89 = _88;
    _89[1] = _85;
    float3x3 _90 = _89;
    _90[2] = _83;
    uint _91 = in.in_var_ATTRIBUTE13 * 36u;
    uint _94 = _91 + 1u;
    uint _97 = _91 + 2u;
    uint _100 = _91 + 4u;
    float3x3 _109 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _91)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _97)].xyz);
    _109[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _91)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _100)].x;
    float3x3 _112 = _109;
    _112[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _100)].y;
    float3x3 _115 = _112;
    _115[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _97)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _100)].z;
    float3x3 _116 = _115 * _90;
    float4 _143 = float4((((View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _91)].xyz * in.in_var_ATTRIBUTE0.xxx) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _94)].xyz * in.in_var_ATTRIBUTE0.yyy)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _97)].xyz * in.in_var_ATTRIBUTE0.zzz)) + (View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _91 + 3u)].xyz + View.View_PreViewTranslation), 1.0);
    float3 _144 = _116[2];
    float4 _150 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_143.x, _143.y, _143.z, _143.w);
    float4 _161;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_150.z < 0.0))
    {
        float4 _159 = _150;
        _159.z = 9.9999999747524270787835121154785e-07;
        float4 _160 = _159;
        _160.w = 1.0;
        _161 = _160;
    }
    else
    {
        _161 = _150;
    }
    float _167 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _144));
    float4 _192 = _161;
    _192.z = ((_161.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_167) > 0.0) ? (sqrt(fast::clamp(1.0 - (_167 * _167), 0.0, 1.0)) / _167) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _161.w;
    out.out_var_TEXCOORD10_centroid = float4(_116[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_144, _82 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _100)].w);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _143.xyz;
    out.gl_Position = _192;
    return out;
}

