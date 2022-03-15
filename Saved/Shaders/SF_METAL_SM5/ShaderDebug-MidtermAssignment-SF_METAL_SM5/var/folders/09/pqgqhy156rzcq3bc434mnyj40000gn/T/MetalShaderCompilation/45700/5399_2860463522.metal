

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

constant float3x3 _59 = {};
constant float4 _60 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_HIT_PROXY_ID [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001517_aa7f35a2(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], texture_buffer<float> VertexFetch_HitProxyIdBuffer [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _71 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _72 = _71 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _81 = VertexFetch_InstanceBoneMapBuffer.read(uint(_72));
    uint _82 = _81.x;
    uint _83 = 4u * _82;
    float4 _85 = VertexFetch_InstanceTransformBuffer.read(uint(_83));
    uint _86 = _83 + 1u;
    float4 _87 = VertexFetch_InstanceTransformBuffer.read(uint(_86));
    uint _88 = _83 + 2u;
    float4 _89 = VertexFetch_InstanceTransformBuffer.read(uint(_88));
    uint _90 = _83 + 3u;
    float4 _91 = VertexFetch_InstanceTransformBuffer.read(uint(_90));
    uint _92 = 2u * _72;
    float4 _97 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_92 + 1u)));
    float _98 = _97.w;
    float3 _99 = _97.xyz;
    float3 _101 = cross(_99, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_92)).xyz) * _98;
    float3x3 _104 = _59;
    _104[0] = cross(_101, _99) * _98;
    float3x3 _105 = _104;
    _105[1] = _101;
    float3x3 _106 = _105;
    _106[2] = _99;
    float3x3 _120 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_85.xyz, _87.xyz, _89.xyz);
    float3x3 _123 = _120;
    _123[0] = normalize(_120[0]);
    float3x3 _126 = _123;
    _126[1] = normalize(_120[1]);
    float3x3 _129 = _126;
    _129[2] = normalize(_120[2]);
    float3x3 _130 = _129 * _106;
    float4 _134 = _60;
    _134.x = 0.0;
    float4 _135 = _134;
    _135.y = 1.0;
    float4 _136 = _135;
    _136.z = 1.0;
    float4 _137 = _136;
    _137.w = 0.0;
    float _138 = _85.x;
    float _139 = _85.y;
    float _140 = _85.z;
    float4 _141 = float4(_138, _139, _140, 0.0);
    float _142 = _87.x;
    float _143 = _87.y;
    float _144 = _87.z;
    float4 _145 = float4(_142, _143, _144, 0.0);
    float _146 = _89.x;
    float _147 = _89.y;
    float _148 = _89.z;
    float4 _149 = float4(_146, _147, _148, 0.0);
    float _150 = _91.x;
    float _151 = _91.y;
    float _152 = _91.z;
    float4 _153 = float4(_150, _151, _152, 1.0);
    float4x4 _154 = float4x4(_141, _145, _149, _153);
    float4 _155 = _154 * in.in_var_ATTRIBUTE0;
    float3 _156 = _155.xxx;
    float3 _157 = Primitive.Primitive_LocalToWorld[0].xyz * _156;
    float3 _158 = _155.yyy;
    float3 _159 = Primitive.Primitive_LocalToWorld[1].xyz * _158;
    float3 _160 = _157 + _159;
    float3 _161 = _155.zzz;
    float3 _162 = Primitive.Primitive_LocalToWorld[2].xyz * _161;
    float3 _163 = _160 + _162;
    float3 _166 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _167 = _163 + _166;
    float _168 = _167.x;
    float _169 = _167.y;
    float _170 = _167.z;
    float4 _171 = float4(_168, _169, _170, 1.0);
    float4 _172 = _171 * 1.0;
    float4 _173 = float4(_172.x, _172.y, _172.z, _172.w);
    float4 _178 = View.View_TranslatedWorldToClip * _173;
    out.out_var_TEXCOORD10_centroid = float4(_130[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_130[2], _98 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_72 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _137;
    out.out_var_HIT_PROXY_ID = VertexFetch_HitProxyIdBuffer.read(uint((3u + (gl_VertexIndex - gl_BaseVertex)))).zyxw;
    out.out_var_TEXCOORD6 = _173;
    out.gl_Position = _178;
    return out;
}

