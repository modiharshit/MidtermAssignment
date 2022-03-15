

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

constant float3x3 _63 = {};
constant float4 _64 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001457_68e43e16(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _76 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _80 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_76)).x;
    float4 _82 = VertexFetch_InstanceTransformBuffer.read(uint(_80));
    float4 _84 = VertexFetch_InstanceTransformBuffer.read(uint((_80 + 1u)));
    float4 _86 = VertexFetch_InstanceTransformBuffer.read(uint((_80 + 2u)));
    uint _89 = 2u * _76;
    float4 _94 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_89 + 1u)));
    float _95 = _94.w;
    float3 _96 = _94.xyz;
    float3 _98 = cross(_96, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_89)).xyz) * _95;
    float3x3 _101 = _63;
    _101[0] = cross(_98, _96) * _95;
    float3x3 _102 = _101;
    _102[1] = _98;
    float3x3 _103 = _102;
    _103[2] = _96;
    float3x3 _117 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_82.xyz, _84.xyz, _86.xyz);
    float3x3 _120 = _117;
    _120[0] = normalize(_117[0]);
    float3x3 _123 = _120;
    _123[1] = normalize(_117[1]);
    float3x3 _126 = _123;
    _126[2] = normalize(_117[2]);
    float3x3 _127 = _126 * _103;
    float4 _131 = _64;
    _131.x = 0.0;
    float4 _132 = _131;
    _132.y = 1.0;
    float4 _133 = _132;
    _133.z = 1.0;
    float4 _134 = _133;
    _134.w = 0.0;
    float4 _152 = float4x4(float4(_82.xyz, 0.0), float4(_84.xyz, 0.0), float4(_86.xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_80 + 3u))).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _169 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _152.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _152.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _152.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * 1.0;
    float3 _170 = _127[2];
    float4 _176 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_169.x, _169.y, _169.z, _169.w);
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
    float _193 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _170));
    float4 _218 = _187;
    _218.z = ((_187.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_193) > 0.0) ? (sqrt(fast::clamp(1.0 - (_193 * _193), 0.0, 1.0)) / _193) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _187.w;
    out.out_var_TEXCOORD10_centroid = float4(_127[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_170, _95 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _134;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _169.xyz;
    out.gl_Position = _218;
    return out;
}

