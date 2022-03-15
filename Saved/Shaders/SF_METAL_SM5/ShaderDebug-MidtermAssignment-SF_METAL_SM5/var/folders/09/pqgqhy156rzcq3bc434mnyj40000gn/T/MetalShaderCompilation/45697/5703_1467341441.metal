

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _61 = {};
constant float4 _62 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR0 [[user(locn4)]];
    float4 out_var_COLOR1 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001647_5775da81(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<float> VertexFetch_InstancePrevTransformBuffer [[texture(3)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    uint _80 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _91 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_80)).x;
    float4 _93 = VertexFetch_InstanceTransformBuffer.read(uint(_91));
    uint _94 = _91 + 1u;
    float4 _95 = VertexFetch_InstanceTransformBuffer.read(uint(_94));
    uint _96 = _91 + 2u;
    float4 _97 = VertexFetch_InstanceTransformBuffer.read(uint(_96));
    uint _98 = _91 + 3u;
    uint _105 = 2u * _80;
    float4 _110 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_105 + 1u)));
    float _111 = _110.w;
    float3 _112 = _110.xyz;
    float3 _114 = cross(_112, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_105)).xyz) * _111;
    float3x3 _117 = _61;
    _117[0] = cross(_114, _112) * _111;
    float3x3 _118 = _117;
    _118[1] = _114;
    float3x3 _119 = _118;
    _119[2] = _112;
    float3x3 _133 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_93.xyz, _95.xyz, _97.xyz);
    float3x3 _136 = _133;
    _136[0] = normalize(_133[0]);
    float3x3 _139 = _136;
    _139[1] = normalize(_133[1]);
    float3x3 _142 = _139;
    _142[2] = normalize(_133[2]);
    float3x3 _143 = _142 * _119;
    float4 _147 = _62;
    _147.x = 0.0;
    float4 _148 = _147;
    _148.y = 1.0;
    float4 _149 = _148;
    _149.z = 1.0;
    float4 _150 = _149;
    _150.w = 0.0;
    float4 _168 = float4x4(float4(_93.xyz, 0.0), float4(_95.xyz, 0.0), float4(_97.xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint(_98)).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4x4 _201 = Primitive.Primitive_PreviousLocalToWorld;
    _201[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _205 = _201;
    _205[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _209 = _205;
    _209[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _238 = View.View_TranslatedWorldToClip * float4((float4((((Primitive.Primitive_LocalToWorld[0].xyz * _168.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _168.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _168.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * 1.0).xyz, 1.0);
    float4 _245 = _238;
    _245.z = _238.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _238.w) : 0.0);
    out.gl_Position = _245;
    out.out_var_TEXCOORD6 = _238;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_209 * (float4x4(float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_91)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_94)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_96)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_98)).xyz, 1.0)) * in.in_var_ATTRIBUTE0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_143[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_143[2], _111 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_80 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _150;
    return out;
}

