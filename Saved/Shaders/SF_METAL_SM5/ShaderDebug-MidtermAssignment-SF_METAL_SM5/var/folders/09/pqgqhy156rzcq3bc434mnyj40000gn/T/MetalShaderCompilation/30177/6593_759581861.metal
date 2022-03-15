

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

constant float3x3 _64 = {};
constant float4 _65 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_HIT_PROXY_ID [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000019c1_2d464ca5(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], texture_buffer<float> VertexFetch_HitProxyIdBuffer [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _76 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _77 = _76 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _79 = VertexFetch_InstanceBoneMapBuffer.read(uint(_77));
    uint _80 = _79.x;
    uint _81 = 4u * _80;
    float4 _83 = VertexFetch_InstanceTransformBuffer.read(uint(_81));
    uint _84 = _81 + 1u;
    float4 _85 = VertexFetch_InstanceTransformBuffer.read(uint(_84));
    uint _86 = _81 + 2u;
    float4 _87 = VertexFetch_InstanceTransformBuffer.read(uint(_86));
    uint _88 = _81 + 3u;
    float4 _89 = VertexFetch_InstanceTransformBuffer.read(uint(_88));
    uint _90 = 2u * _77;
    float4 _95 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_90 + 1u)));
    float _96 = _95.w;
    float3 _97 = _95.xyz;
    float3 _99 = cross(_97, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_90)).xyz) * _96;
    float3x3 _102 = _64;
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
    float4 _132 = _65;
    _132.x = 0.0;
    float4 _133 = _132;
    _133.y = 1.0;
    float4 _134 = _133;
    _134.z = 1.0;
    float4 _135 = _134;
    _135.w = 0.0;
    float _136 = _83.x;
    float _137 = _83.y;
    float _138 = _83.z;
    float4 _139 = float4(_136, _137, _138, 0.0);
    float _140 = _85.x;
    float _141 = _85.y;
    float _142 = _85.z;
    float4 _143 = float4(_140, _141, _142, 0.0);
    float _144 = _87.x;
    float _145 = _87.y;
    float _146 = _87.z;
    float4 _147 = float4(_144, _145, _146, 0.0);
    float _148 = _89.x;
    float _149 = _89.y;
    float _150 = _89.z;
    float4 _151 = float4(_148, _149, _150, 1.0);
    float4x4 _152 = float4x4(_139, _143, _147, _151);
    float4 _153 = _152 * in.in_var_ATTRIBUTE0;
    float3 _154 = _153.xxx;
    float3 _155 = Primitive.Primitive_LocalToWorld[0].xyz * _154;
    float3 _156 = _153.yyy;
    float3 _157 = Primitive.Primitive_LocalToWorld[1].xyz * _156;
    float3 _158 = _155 + _157;
    float3 _159 = _153.zzz;
    float3 _160 = Primitive.Primitive_LocalToWorld[2].xyz * _159;
    float3 _161 = _158 + _160;
    float3 _164 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _165 = _161 + _164;
    float _166 = _165.x;
    float _167 = _165.y;
    float _168 = _165.z;
    float4 _169 = float4(_166, _167, _168, 1.0);
    float4 _170 = _169 * 1.0;
    uint _173 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _179 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_173 * _77) + min(0u, (_173 - 1u)))));
    float4 _180 = float4(_170.x, _170.y, _170.z, _170.w);
    float4 _185 = View.View_TranslatedWorldToClip * _180;
    spvUnsafeArray<float4, 1> _197 = { float4(_179.x, _179.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_128[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_128[2], _96 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _135;
    out_var_TEXCOORD0 = _197;
    out.out_var_HIT_PROXY_ID = VertexFetch_HitProxyIdBuffer.read(uint((3u + (gl_VertexIndex - gl_BaseVertex)))).zyxw;
    out.out_var_TEXCOORD6 = _180;
    out.gl_Position = _185;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

