

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
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_HIT_PROXY_ID [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000013d3_59d66568(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], texture_buffer<float> VertexFetch_HitProxyIdBuffer [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _68 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _69 = _68 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _71 = VertexFetch_InstanceBoneMapBuffer.read(uint(_69));
    uint _72 = _71.x;
    uint _73 = 4u * _72;
    float4 _75 = VertexFetch_InstanceTransformBuffer.read(uint(_73));
    uint _76 = _73 + 1u;
    float4 _77 = VertexFetch_InstanceTransformBuffer.read(uint(_76));
    uint _78 = _73 + 2u;
    float4 _79 = VertexFetch_InstanceTransformBuffer.read(uint(_78));
    uint _80 = _73 + 3u;
    float4 _81 = VertexFetch_InstanceTransformBuffer.read(uint(_80));
    uint _82 = 2u * _69;
    float4 _87 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_82 + 1u)));
    float _88 = _87.w;
    float3 _89 = _87.xyz;
    float3 _91 = cross(_89, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_82)).xyz) * _88;
    float3x3 _94 = _56;
    _94[0] = cross(_91, _89) * _88;
    float3x3 _95 = _94;
    _95[1] = _91;
    float3x3 _96 = _95;
    _96[2] = _89;
    float3x3 _110 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_75.xyz, _77.xyz, _79.xyz);
    float3x3 _113 = _110;
    _113[0] = normalize(_110[0]);
    float3x3 _116 = _113;
    _116[1] = normalize(_110[1]);
    float3x3 _119 = _116;
    _119[2] = normalize(_110[2]);
    float3x3 _120 = _119 * _96;
    float4 _124 = _57;
    _124.x = 0.0;
    float4 _125 = _124;
    _125.y = 1.0;
    float4 _126 = _125;
    _126.z = 1.0;
    float4 _127 = _126;
    _127.w = 0.0;
    float _128 = _75.x;
    float _129 = _75.y;
    float _130 = _75.z;
    float4 _131 = float4(_128, _129, _130, 0.0);
    float _132 = _77.x;
    float _133 = _77.y;
    float _134 = _77.z;
    float4 _135 = float4(_132, _133, _134, 0.0);
    float _136 = _79.x;
    float _137 = _79.y;
    float _138 = _79.z;
    float4 _139 = float4(_136, _137, _138, 0.0);
    float _140 = _81.x;
    float _141 = _81.y;
    float _142 = _81.z;
    float4 _143 = float4(_140, _141, _142, 1.0);
    float4x4 _144 = float4x4(_131, _135, _139, _143);
    float4 _145 = _144 * in.in_var_ATTRIBUTE0;
    float3 _146 = _145.xxx;
    float3 _147 = Primitive.Primitive_LocalToWorld[0].xyz * _146;
    float3 _148 = _145.yyy;
    float3 _149 = Primitive.Primitive_LocalToWorld[1].xyz * _148;
    float3 _150 = _147 + _149;
    float3 _151 = _145.zzz;
    float3 _152 = Primitive.Primitive_LocalToWorld[2].xyz * _151;
    float3 _153 = _150 + _152;
    float3 _156 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _157 = _153 + _156;
    float _158 = _157.x;
    float _159 = _157.y;
    float _160 = _157.z;
    float4 _161 = float4(_158, _159, _160, 1.0);
    float4 _162 = _161 * 1.0;
    float4 _163 = float4(_162.x, _162.y, _162.z, _162.w);
    float4 _168 = View.View_TranslatedWorldToClip * _163;
    out.out_var_TEXCOORD10_centroid = float4(_120[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_120[2], _88 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _127;
    out.out_var_HIT_PROXY_ID = VertexFetch_HitProxyIdBuffer.read(uint((3u + (gl_VertexIndex - gl_BaseVertex)))).zyxw;
    out.out_var_TEXCOORD6 = _163;
    out.gl_Position = _168;
    return out;
}

