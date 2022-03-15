

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

constant float3x3 _53 = {};
constant float4 _54 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001288_746dc0e2(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _65 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _66 = _65 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _68 = VertexFetch_InstanceBoneMapBuffer.read(uint(_66));
    uint _69 = _68.x;
    uint _70 = 4u * _69;
    float4 _72 = VertexFetch_InstanceTransformBuffer.read(uint(_70));
    uint _73 = _70 + 1u;
    float4 _74 = VertexFetch_InstanceTransformBuffer.read(uint(_73));
    uint _75 = _70 + 2u;
    float4 _76 = VertexFetch_InstanceTransformBuffer.read(uint(_75));
    uint _77 = _70 + 3u;
    float4 _78 = VertexFetch_InstanceTransformBuffer.read(uint(_77));
    uint _79 = 2u * _66;
    float4 _84 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_79 + 1u)));
    float _85 = _84.w;
    float3 _86 = _84.xyz;
    float3 _88 = cross(_86, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_79)).xyz) * _85;
    float3x3 _91 = _53;
    _91[0] = cross(_88, _86) * _85;
    float3x3 _92 = _91;
    _92[1] = _88;
    float3x3 _93 = _92;
    _93[2] = _86;
    float3x3 _107 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_72.xyz, _74.xyz, _76.xyz);
    float3x3 _110 = _107;
    _110[0] = normalize(_107[0]);
    float3x3 _113 = _110;
    _113[1] = normalize(_107[1]);
    float3x3 _116 = _113;
    _116[2] = normalize(_107[2]);
    float3x3 _117 = _116 * _93;
    float4 _121 = _54;
    _121.x = 0.0;
    float4 _122 = _121;
    _122.y = 1.0;
    float4 _123 = _122;
    _123.z = 1.0;
    float4 _124 = _123;
    _124.w = 0.0;
    float _125 = _72.x;
    float _126 = _72.y;
    float _127 = _72.z;
    float4 _128 = float4(_125, _126, _127, 0.0);
    float _129 = _74.x;
    float _130 = _74.y;
    float _131 = _74.z;
    float4 _132 = float4(_129, _130, _131, 0.0);
    float _133 = _76.x;
    float _134 = _76.y;
    float _135 = _76.z;
    float4 _136 = float4(_133, _134, _135, 0.0);
    float _137 = _78.x;
    float _138 = _78.y;
    float _139 = _78.z;
    float4 _140 = float4(_137, _138, _139, 1.0);
    float4x4 _141 = float4x4(_128, _132, _136, _140);
    float4 _142 = _141 * in.in_var_ATTRIBUTE0;
    float3 _143 = _142.xxx;
    float3 _144 = Primitive.Primitive_LocalToWorld[0].xyz * _143;
    float3 _145 = _142.yyy;
    float3 _146 = Primitive.Primitive_LocalToWorld[1].xyz * _145;
    float3 _147 = _144 + _146;
    float3 _148 = _142.zzz;
    float3 _149 = Primitive.Primitive_LocalToWorld[2].xyz * _148;
    float3 _150 = _147 + _149;
    float3 _153 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _154 = _150 + _153;
    float _155 = _154.x;
    float _156 = _154.y;
    float _157 = _154.z;
    float4 _158 = float4(_155, _156, _157, 1.0);
    float4 _159 = _158 * 1.0;
    float4 _160 = float4(_159.x, _159.y, _159.z, _159.w);
    float4 _161 = View.View_TranslatedWorldToClip * _160;
    out.out_var_TEXCOORD10_centroid = float4(_117[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_117[2], _85 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _124;
    out.gl_Position = _161;
    return out;
}

