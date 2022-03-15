

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

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

constant float3x3 _61 = {};
constant float4 _62 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001873_d577016f(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _73 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _74 = _73 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _76 = VertexFetch_InstanceBoneMapBuffer.read(uint(_74));
    uint _77 = _76.x;
    uint _78 = 4u * _77;
    float4 _80 = VertexFetch_InstanceTransformBuffer.read(uint(_78));
    uint _81 = _78 + 1u;
    float4 _82 = VertexFetch_InstanceTransformBuffer.read(uint(_81));
    uint _83 = _78 + 2u;
    float4 _84 = VertexFetch_InstanceTransformBuffer.read(uint(_83));
    uint _85 = _78 + 3u;
    float4 _86 = VertexFetch_InstanceTransformBuffer.read(uint(_85));
    uint _87 = 2u * _74;
    float4 _92 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_87 + 1u)));
    float _93 = _92.w;
    float3 _94 = _92.xyz;
    float3 _96 = cross(_94, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_87)).xyz) * _93;
    float3x3 _99 = _61;
    _99[0] = cross(_96, _94) * _93;
    float3x3 _100 = _99;
    _100[1] = _96;
    float3x3 _101 = _100;
    _101[2] = _94;
    float3x3 _115 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_80.xyz, _82.xyz, _84.xyz);
    float3x3 _118 = _115;
    _118[0] = normalize(_115[0]);
    float3x3 _121 = _118;
    _121[1] = normalize(_115[1]);
    float3x3 _124 = _121;
    _124[2] = normalize(_115[2]);
    float3x3 _125 = _124 * _101;
    float4 _129 = _62;
    _129.x = 0.0;
    float4 _130 = _129;
    _130.y = 1.0;
    float4 _131 = _130;
    _131.z = 1.0;
    float4 _132 = _131;
    _132.w = 0.0;
    float _133 = _80.x;
    float _134 = _80.y;
    float _135 = _80.z;
    float4 _136 = float4(_133, _134, _135, 0.0);
    float _137 = _82.x;
    float _138 = _82.y;
    float _139 = _82.z;
    float4 _140 = float4(_137, _138, _139, 0.0);
    float _141 = _84.x;
    float _142 = _84.y;
    float _143 = _84.z;
    float4 _144 = float4(_141, _142, _143, 0.0);
    float _145 = _86.x;
    float _146 = _86.y;
    float _147 = _86.z;
    float4 _148 = float4(_145, _146, _147, 1.0);
    float4x4 _149 = float4x4(_136, _140, _144, _148);
    float4 _150 = _149 * in.in_var_ATTRIBUTE0;
    float3 _151 = _150.xxx;
    float3 _152 = Primitive.Primitive_LocalToWorld[0].xyz * _151;
    float3 _153 = _150.yyy;
    float3 _154 = Primitive.Primitive_LocalToWorld[1].xyz * _153;
    float3 _155 = _152 + _154;
    float3 _156 = _150.zzz;
    float3 _157 = Primitive.Primitive_LocalToWorld[2].xyz * _156;
    float3 _158 = _155 + _157;
    float3 _161 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _162 = _158 + _161;
    float _163 = _162.x;
    float _164 = _162.y;
    float _165 = _162.z;
    float4 _166 = float4(_163, _164, _165, 1.0);
    float4 _167 = _166 * 1.0;
    uint _170 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _176 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_170 * _74) + min(0u, (_170 - 1u)))));
    float4 _177 = float4(_167.x, _167.y, _167.z, _167.w);
    float4 _178 = View.View_TranslatedWorldToClip * _177;
    spvUnsafeArray<float4, 1> _190 = { float4(_176.x, _176.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_125[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_125[2], _93 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _132;
    out_var_TEXCOORD0 = _190;
    out.gl_Position = _178;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

