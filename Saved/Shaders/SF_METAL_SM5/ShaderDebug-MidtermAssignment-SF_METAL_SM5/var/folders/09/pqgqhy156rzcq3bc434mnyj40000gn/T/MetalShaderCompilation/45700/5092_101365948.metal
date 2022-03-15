

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _56 = {};
constant float4 _57 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000013e4_060ab8bc(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _68 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _69 = _68 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _78 = VertexFetch_InstanceBoneMapBuffer.read(uint(_69));
    uint _79 = _78.x;
    uint _80 = 4u * _79;
    float4 _82 = VertexFetch_InstanceTransformBuffer.read(uint(_80));
    uint _83 = _80 + 1u;
    float4 _84 = VertexFetch_InstanceTransformBuffer.read(uint(_83));
    uint _85 = _80 + 2u;
    float4 _86 = VertexFetch_InstanceTransformBuffer.read(uint(_85));
    uint _87 = _80 + 3u;
    float4 _88 = VertexFetch_InstanceTransformBuffer.read(uint(_87));
    uint _89 = 2u * _69;
    float4 _94 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_89 + 1u)));
    float _95 = _94.w;
    float3 _96 = _94.xyz;
    float3 _98 = cross(_96, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_89)).xyz) * _95;
    float3x3 _101 = _56;
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
    float4 _131 = _57;
    _131.x = 0.0;
    float4 _132 = _131;
    _132.y = 1.0;
    float4 _133 = _132;
    _133.z = 1.0;
    float4 _134 = _133;
    _134.w = 0.0;
    float _135 = _82.x;
    float _136 = _82.y;
    float _137 = _82.z;
    float4 _138 = float4(_135, _136, _137, 0.0);
    float _139 = _84.x;
    float _140 = _84.y;
    float _141 = _84.z;
    float4 _142 = float4(_139, _140, _141, 0.0);
    float _143 = _86.x;
    float _144 = _86.y;
    float _145 = _86.z;
    float4 _146 = float4(_143, _144, _145, 0.0);
    float _147 = _88.x;
    float _148 = _88.y;
    float _149 = _88.z;
    float4 _150 = float4(_147, _148, _149, 1.0);
    float4x4 _151 = float4x4(_138, _142, _146, _150);
    float4 _152 = _151 * in.in_var_ATTRIBUTE0;
    float3 _153 = _152.xxx;
    float3 _154 = Primitive.Primitive_LocalToWorld[0].xyz * _153;
    float3 _155 = _152.yyy;
    float3 _156 = Primitive.Primitive_LocalToWorld[1].xyz * _155;
    float3 _157 = _154 + _156;
    float3 _158 = _152.zzz;
    float3 _159 = Primitive.Primitive_LocalToWorld[2].xyz * _158;
    float3 _160 = _157 + _159;
    float3 _163 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _164 = _160 + _163;
    float _165 = _164.x;
    float _166 = _164.y;
    float _167 = _164.z;
    float4 _168 = float4(_165, _166, _167, 1.0);
    float4 _169 = _168 * 1.0;
    float4 _170 = float4(_169.x, _169.y, _169.z, _169.w);
    float4 _171 = View.View_TranslatedWorldToClip * _170;
    out.out_var_TEXCOORD10_centroid = float4(_127[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_127[2], _95 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_69 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _134;
    out.gl_Position = _171;
    return out;
}

