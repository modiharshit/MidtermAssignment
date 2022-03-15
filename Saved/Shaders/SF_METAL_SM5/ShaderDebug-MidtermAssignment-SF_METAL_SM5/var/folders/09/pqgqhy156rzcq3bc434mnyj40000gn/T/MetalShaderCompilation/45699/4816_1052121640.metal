

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

constant float3x3 _54 = {};
constant float4 _55 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000012d0_3eb61a28(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _66 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _67 = _66 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _69 = VertexFetch_InstanceBoneMapBuffer.read(uint(_67));
    uint _70 = _69.x;
    uint _71 = 4u * _70;
    float4 _73 = VertexFetch_InstanceTransformBuffer.read(uint(_71));
    uint _74 = _71 + 1u;
    float4 _75 = VertexFetch_InstanceTransformBuffer.read(uint(_74));
    uint _76 = _71 + 2u;
    float4 _77 = VertexFetch_InstanceTransformBuffer.read(uint(_76));
    uint _78 = _71 + 3u;
    float4 _79 = VertexFetch_InstanceTransformBuffer.read(uint(_78));
    uint _80 = 2u * _67;
    float4 _85 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_80 + 1u)));
    float _86 = _85.w;
    float3 _87 = _85.xyz;
    float3 _89 = cross(_87, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_80)).xyz) * _86;
    float3x3 _92 = _54;
    _92[0] = cross(_89, _87) * _86;
    float3x3 _93 = _92;
    _93[1] = _89;
    float3x3 _94 = _93;
    _94[2] = _87;
    float3x3 _108 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_73.xyz, _75.xyz, _77.xyz);
    float3x3 _111 = _108;
    _111[0] = normalize(_108[0]);
    float3x3 _114 = _111;
    _114[1] = normalize(_108[1]);
    float3x3 _117 = _114;
    _117[2] = normalize(_108[2]);
    float3x3 _118 = _117 * _94;
    float4 _122 = _55;
    _122.x = 0.0;
    float4 _123 = _122;
    _123.y = 1.0;
    float4 _124 = _123;
    _124.z = 1.0;
    float4 _125 = _124;
    _125.w = 0.0;
    float _126 = _73.x;
    float _127 = _73.y;
    float _128 = _73.z;
    float4 _129 = float4(_126, _127, _128, 0.0);
    float _130 = _75.x;
    float _131 = _75.y;
    float _132 = _75.z;
    float4 _133 = float4(_130, _131, _132, 0.0);
    float _134 = _77.x;
    float _135 = _77.y;
    float _136 = _77.z;
    float4 _137 = float4(_134, _135, _136, 0.0);
    float _138 = _79.x;
    float _139 = _79.y;
    float _140 = _79.z;
    float4 _141 = float4(_138, _139, _140, 1.0);
    float4x4 _142 = float4x4(_129, _133, _137, _141);
    float4 _143 = _142 * in.in_var_ATTRIBUTE0;
    float3 _144 = _143.xxx;
    float3 _145 = Primitive.Primitive_LocalToWorld[0].xyz * _144;
    float3 _146 = _143.yyy;
    float3 _147 = Primitive.Primitive_LocalToWorld[1].xyz * _146;
    float3 _148 = _145 + _147;
    float3 _149 = _143.zzz;
    float3 _150 = Primitive.Primitive_LocalToWorld[2].xyz * _149;
    float3 _151 = _148 + _150;
    float3 _154 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _155 = _151 + _154;
    float _156 = _155.x;
    float _157 = _155.y;
    float _158 = _155.z;
    float4 _159 = float4(_156, _157, _158, 1.0);
    float4 _160 = _159 * 1.0;
    float4 _161 = float4(_160.x, _160.y, _160.z, _160.w);
    float4 _162 = View.View_TranslatedWorldToClip * _161;
    out.gl_Position = _162;
    out.out_var_TEXCOORD10_centroid = float4(_118[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_118[2], _86 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _125;
    out.out_var_TEXCOORD6 = _161;
    return out;
}

