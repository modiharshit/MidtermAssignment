

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

constant float3x3 _66 = {};
constant float4 _67 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float out_var_TEXCOORD8 [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000143c_e8d7e9aa(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _77 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _81 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_77)).x;
    float4 _83 = VertexFetch_InstanceTransformBuffer.read(uint(_81));
    float4 _85 = VertexFetch_InstanceTransformBuffer.read(uint((_81 + 1u)));
    float4 _87 = VertexFetch_InstanceTransformBuffer.read(uint((_81 + 2u)));
    uint _90 = 2u * _77;
    float4 _95 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_90 + 1u)));
    float _96 = _95.w;
    float3 _97 = _95.xyz;
    float3 _99 = cross(_97, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_90)).xyz) * _96;
    float3x3 _102 = _66;
    _102[0] = cross(_99, _97) * _96;
    float3x3 _103 = _102;
    _103[1] = _99;
    float3x3 _104 = _103;
    _104[2] = _97;
    float3x3 _118 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_83.xyz, _85.xyz, _87.xyz);
    float3x3 _121 = _118;
    _121[0] = normalize(_118[0]);
    float3x3 _124 = _121;
    _124[1] = normalize(_118[1]);
    float3x3 _127 = _124;
    _127[2] = normalize(_118[2]);
    float3x3 _128 = _127 * _104;
    float4 _132 = _67;
    _132.x = 0.0;
    float4 _133 = _132;
    _133.y = 1.0;
    float4 _134 = _133;
    _134.z = 1.0;
    float4 _135 = _134;
    _135.w = 0.0;
    float4 _153 = float4x4(float4(_83.xyz, 0.0), float4(_85.xyz, 0.0), float4(_87.xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint((_81 + 3u))).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _170 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _153.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _153.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _153.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * 1.0;
    float3 _171 = _128[2];
    float4 _177 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_170.x, _170.y, _170.z, _170.w);
    float4 _188;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_177.z < 0.0))
    {
        float4 _186 = _177;
        _186.z = 9.9999999747524270787835121154785e-07;
        float4 _187 = _186;
        _187.w = 1.0;
        _188 = _187;
    }
    else
    {
        _188 = _177;
    }
    float _194 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _171));
    out.out_var_TEXCOORD10_centroid = float4(_128[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_171, _96 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _135;
    out.out_var_TEXCOORD6 = _188.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_194) > 0.0) ? (sqrt(fast::clamp(1.0 - (_194 * _194), 0.0, 1.0)) / _194) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _170.xyz;
    out.gl_Position = _188;
    return out;
}

