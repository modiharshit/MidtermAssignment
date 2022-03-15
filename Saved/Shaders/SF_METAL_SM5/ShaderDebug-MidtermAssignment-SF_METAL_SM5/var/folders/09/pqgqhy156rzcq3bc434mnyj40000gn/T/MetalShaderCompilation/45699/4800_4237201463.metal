

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
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

struct PositionOnlyMain_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_000012c0_fc8e9037(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(0)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    PositionOnlyMain_out out = {};
    uint _75 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _79 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_75)).x;
    float4 _105 = float4x4(float4(VertexFetch_InstanceTransformBuffer.read(uint(_79)).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_79 + 1u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_79 + 2u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_79 + 3u))).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _129 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _105.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _105.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _105.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    uint _136 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_75)).x;
    float4 _161 = float4x4(float4(VertexFetch_InstanceTransformBuffer.read(uint(_136)).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_136 + 1u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_136 + 2u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_136 + 3u))).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _182 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * _129;
    float4 _193;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_182.z < 0.0))
    {
        float4 _191 = _182;
        _191.z = 9.9999999747524270787835121154785e-07;
        float4 _192 = _191;
        _192.w = 1.0;
        _193 = _192;
    }
    else
    {
        _193 = _182;
    }
    float _199 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _161.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _161.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _161.zzz)));
    float4 _224 = _193;
    _224.z = ((_193.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_199) > 0.0) ? (sqrt(fast::clamp(1.0 - (_199 * _199), 0.0, 1.0)) / _199) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _193.w;
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_COLOR1 = float4(0.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _129.xyz;
    out.gl_Position = _224;
    return out;
}

