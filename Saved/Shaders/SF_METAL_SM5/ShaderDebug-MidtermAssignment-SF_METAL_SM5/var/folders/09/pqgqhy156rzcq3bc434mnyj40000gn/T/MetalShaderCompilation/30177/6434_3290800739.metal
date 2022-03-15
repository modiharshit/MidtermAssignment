

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

constant float3x3 _62 = {};
constant float4 _63 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001922_c425a263(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _74 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _75 = _74 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _77 = VertexFetch_InstanceBoneMapBuffer.read(uint(_75));
    uint _78 = _77.x;
    uint _79 = 4u * _78;
    float4 _81 = VertexFetch_InstanceTransformBuffer.read(uint(_79));
    uint _82 = _79 + 1u;
    float4 _83 = VertexFetch_InstanceTransformBuffer.read(uint(_82));
    uint _84 = _79 + 2u;
    float4 _85 = VertexFetch_InstanceTransformBuffer.read(uint(_84));
    uint _86 = _79 + 3u;
    float4 _87 = VertexFetch_InstanceTransformBuffer.read(uint(_86));
    uint _88 = 2u * _75;
    float4 _93 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_88 + 1u)));
    float _94 = _93.w;
    float3 _95 = _93.xyz;
    float3 _97 = cross(_95, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_88)).xyz) * _94;
    float3x3 _100 = _62;
    _100[0] = cross(_97, _95) * _94;
    float3x3 _101 = _100;
    _101[1] = _97;
    float3x3 _102 = _101;
    _102[2] = _95;
    float3x3 _116 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_81.xyz, _83.xyz, _85.xyz);
    float3x3 _119 = _116;
    _119[0] = normalize(_116[0]);
    float3x3 _122 = _119;
    _122[1] = normalize(_116[1]);
    float3x3 _125 = _122;
    _125[2] = normalize(_116[2]);
    float3x3 _126 = _125 * _102;
    float4 _130 = _63;
    _130.x = 0.0;
    float4 _131 = _130;
    _131.y = 1.0;
    float4 _132 = _131;
    _132.z = 1.0;
    float4 _133 = _132;
    _133.w = 0.0;
    float _134 = _81.x;
    float _135 = _81.y;
    float _136 = _81.z;
    float4 _137 = float4(_134, _135, _136, 0.0);
    float _138 = _83.x;
    float _139 = _83.y;
    float _140 = _83.z;
    float4 _141 = float4(_138, _139, _140, 0.0);
    float _142 = _85.x;
    float _143 = _85.y;
    float _144 = _85.z;
    float4 _145 = float4(_142, _143, _144, 0.0);
    float _146 = _87.x;
    float _147 = _87.y;
    float _148 = _87.z;
    float4 _149 = float4(_146, _147, _148, 1.0);
    float4x4 _150 = float4x4(_137, _141, _145, _149);
    float4 _151 = _150 * in.in_var_ATTRIBUTE0;
    float3 _152 = _151.xxx;
    float3 _153 = Primitive.Primitive_LocalToWorld[0].xyz * _152;
    float3 _154 = _151.yyy;
    float3 _155 = Primitive.Primitive_LocalToWorld[1].xyz * _154;
    float3 _156 = _153 + _155;
    float3 _157 = _151.zzz;
    float3 _158 = Primitive.Primitive_LocalToWorld[2].xyz * _157;
    float3 _159 = _156 + _158;
    float3 _162 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _163 = _159 + _162;
    float _164 = _163.x;
    float _165 = _163.y;
    float _166 = _163.z;
    float4 _167 = float4(_164, _165, _166, 1.0);
    float4 _168 = _167 * 1.0;
    uint _171 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _177 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_171 * _75) + min(0u, (_171 - 1u)))));
    float4 _178 = float4(_168.x, _168.y, _168.z, _168.w);
    float4 _179 = View.View_TranslatedWorldToClip * _178;
    spvUnsafeArray<float4, 1> _191 = { float4(_177.x, _177.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_126[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_126[2], _94 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _133;
    out_var_TEXCOORD0 = _191;
    out.out_var_TEXCOORD6 = _178;
    out.gl_Position = _179;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

