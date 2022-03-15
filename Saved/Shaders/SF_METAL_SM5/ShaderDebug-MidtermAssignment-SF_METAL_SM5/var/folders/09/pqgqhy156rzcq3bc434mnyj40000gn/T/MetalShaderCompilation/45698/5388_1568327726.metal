

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

constant float3x3 _58 = {};
constant float4 _59 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR1 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_0000150c_5d7ac82e(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstancePrevTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    uint _77 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _81 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_77)).x;
    float4 _83 = VertexFetch_InstanceTransformBuffer.read(uint(_81));
    uint _84 = _81 + 1u;
    float4 _85 = VertexFetch_InstanceTransformBuffer.read(uint(_84));
    uint _86 = _81 + 2u;
    float4 _87 = VertexFetch_InstanceTransformBuffer.read(uint(_86));
    uint _88 = _81 + 3u;
    uint _95 = 2u * _77;
    float4 _100 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_95 + 1u)));
    float _101 = _100.w;
    float3 _102 = _100.xyz;
    float3 _104 = cross(_102, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_95)).xyz) * _101;
    float3x3 _107 = _58;
    _107[0] = cross(_104, _102) * _101;
    float3x3 _108 = _107;
    _108[1] = _104;
    float3x3 _109 = _108;
    _109[2] = _102;
    float3x3 _123 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_83.xyz, _85.xyz, _87.xyz);
    float3x3 _126 = _123;
    _126[0] = normalize(_123[0]);
    float3x3 _129 = _126;
    _129[1] = normalize(_123[1]);
    float3x3 _132 = _129;
    _132[2] = normalize(_123[2]);
    float3x3 _133 = _132 * _109;
    float4 _137 = _59;
    _137.x = 0.0;
    float4 _138 = _137;
    _138.y = 1.0;
    float4 _139 = _138;
    _139.z = 1.0;
    float4 _140 = _139;
    _140.w = 0.0;
    float4 _158 = float4x4(float4(_83.xyz, 0.0), float4(_85.xyz, 0.0), float4(_87.xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint(_88)).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4x4 _191 = Primitive.Primitive_PreviousLocalToWorld;
    _191[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _195 = _191;
    _195[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _199 = _195;
    _199[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _228 = View.View_TranslatedWorldToClip * float4((float4((((Primitive.Primitive_LocalToWorld[0].xyz * _158.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _158.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _158.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * 1.0).xyz, 1.0);
    float4 _235 = _228;
    _235.z = _228.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _228.w) : 0.0);
    out.gl_Position = _235;
    out.out_var_TEXCOORD6 = _228;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_199 * (float4x4(float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_81)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_84)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_86)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_88)).xyz, 1.0)) * in.in_var_ATTRIBUTE0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_133[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_133[2], _101 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _140;
    return out;
}

