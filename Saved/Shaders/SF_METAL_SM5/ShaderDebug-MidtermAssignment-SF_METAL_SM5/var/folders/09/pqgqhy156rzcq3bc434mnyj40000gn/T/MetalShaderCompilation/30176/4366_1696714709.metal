

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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_0000110e_6521cfd5(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(0)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    PositionOnlyMain_out out = {};
    uint _69 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _73 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_69)).x;
    float4 _99 = float4x4(float4(VertexFetch_InstanceTransformBuffer.read(uint(_73)).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_73 + 1u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_73 + 2u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_73 + 3u))).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    uint _130 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_69)).x;
    float4 _155 = float4x4(float4(VertexFetch_InstanceTransformBuffer.read(uint(_130)).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_130 + 1u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_130 + 2u))).xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_130 + 3u))).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _176 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4((((Primitive.Primitive_LocalToWorld[0].xyz * _99.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _99.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _99.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _187;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_176.z < 0.0))
    {
        float4 _185 = _176;
        _185.z = 9.9999999747524270787835121154785e-07;
        float4 _186 = _185;
        _186.w = 1.0;
        _187 = _186;
    }
    else
    {
        _187 = _176;
    }
    float _193 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _155.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _155.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _155.zzz)));
    out.out_var_TEXCOORD6 = _187.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_193) > 0.0) ? (sqrt(fast::clamp(1.0 - (_193 * _193), 0.0, 1.0)) / _193) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _187;
    return out;
}

