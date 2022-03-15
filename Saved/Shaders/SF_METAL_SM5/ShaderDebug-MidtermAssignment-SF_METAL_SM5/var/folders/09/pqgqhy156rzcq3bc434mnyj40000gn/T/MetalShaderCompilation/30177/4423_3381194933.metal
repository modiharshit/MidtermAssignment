

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

constant float3x3 _59 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001147_c988f0b5(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _69 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _73 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_69)).x;
    float4 _75 = VertexFetch_InstanceTransformBuffer.read(uint(_73));
    float4 _77 = VertexFetch_InstanceTransformBuffer.read(uint((_73 + 1u)));
    float4 _79 = VertexFetch_InstanceTransformBuffer.read(uint((_73 + 2u)));
    uint _82 = 2u * _69;
    float4 _87 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_82 + 1u)));
    float3 _88 = _87.xyz;
    float _90 = _87.w;
    float3 _91 = cross(_88, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_82)).xyz) * _90;
    float3x3 _94 = _59;
    _94[0] = cross(_91, _88) * _90;
    float3x3 _95 = _94;
    _95[1] = _91;
    float3x3 _96 = _95;
    _96[2] = _88;
    float3x3 _110 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_75.xyz, _77.xyz, _79.xyz);
    float3x3 _113 = _110;
    _113[0] = normalize(_110[0]);
    float3x3 _116 = _113;
    _116[1] = normalize(_110[1]);
    float3x3 _119 = _116;
    _119[2] = normalize(_110[2]);
    float4 _138 = float4x4(float4(_75.xyz, 0.0), float4(_77.xyz, 0.0), float4(_79.xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_73 + 3u))).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _155 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _138.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _138.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _138.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * 1.0;
    float4 _162 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_155.x, _155.y, _155.z, _155.w);
    float4 _173;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_162.z < 0.0))
    {
        float4 _171 = _162;
        _171.z = 9.9999999747524270787835121154785e-07;
        float4 _172 = _171;
        _172.w = 1.0;
        _173 = _172;
    }
    else
    {
        _173 = _162;
    }
    float _179 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (_119 * _96)[2]));
    out.out_var_TEXCOORD6 = _173.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_179) > 0.0) ? (sqrt(fast::clamp(1.0 - (_179 * _179), 0.0, 1.0)) / _179) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _173;
    return out;
}

