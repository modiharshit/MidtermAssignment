

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

constant float3x3 _66 = {};
constant float4 _67 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR1 [[user(locn4)]];
    float4 out_var_TEXCOORD0_0 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001af4_124c280d(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<float> VertexFetch_InstancePrevTransformBuffer [[texture(3)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _85 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _89 = 4u * VertexFetch_InstanceBoneMapBuffer.read(uint(_85)).x;
    float4 _91 = VertexFetch_InstanceTransformBuffer.read(uint(_89));
    uint _92 = _89 + 1u;
    float4 _93 = VertexFetch_InstanceTransformBuffer.read(uint(_92));
    uint _94 = _89 + 2u;
    float4 _95 = VertexFetch_InstanceTransformBuffer.read(uint(_94));
    uint _96 = _89 + 3u;
    uint _103 = 2u * _85;
    float4 _108 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_103 + 1u)));
    float _109 = _108.w;
    float3 _110 = _108.xyz;
    float3 _112 = cross(_110, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_103)).xyz) * _109;
    float3x3 _115 = _66;
    _115[0] = cross(_112, _110) * _109;
    float3x3 _116 = _115;
    _116[1] = _112;
    float3x3 _117 = _116;
    _117[2] = _110;
    float3x3 _131 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_91.xyz, _93.xyz, _95.xyz);
    float3x3 _134 = _131;
    _134[0] = normalize(_131[0]);
    float3x3 _137 = _134;
    _137[1] = normalize(_131[1]);
    float3x3 _140 = _137;
    _140[2] = normalize(_131[2]);
    float3x3 _141 = _140 * _117;
    float4 _145 = _67;
    _145.x = 0.0;
    float4 _146 = _145;
    _146.y = 1.0;
    float4 _147 = _146;
    _147.z = 1.0;
    float4 _148 = _147;
    _148.w = 0.0;
    float4 _166 = float4x4(float4(_91.xyz, 0.0), float4(_93.xyz, 0.0), float4(_95.xyz, 0.0), float4(VertexFetch_InstanceTransformBuffer.read(uint(_96)).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    uint _188 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _194 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_188 * _85) + min(0u, (_188 - 1u)))));
    spvUnsafeArray<float4, 1> _206 = { float4(_194.x, _194.y, float4(0.0).z, float4(0.0).w) };
    float4x4 _210 = Primitive.Primitive_PreviousLocalToWorld;
    _210[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _214 = _210;
    _214[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _218 = _214;
    _218[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _247 = View.View_TranslatedWorldToClip * float4((float4((((Primitive.Primitive_LocalToWorld[0].xyz * _166.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _166.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _166.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * 1.0).xyz, 1.0);
    float4 _254 = _247;
    _254.z = _247.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _247.w) : 0.0);
    out.gl_Position = _254;
    out.out_var_TEXCOORD6 = _247;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_218 * (float4x4(float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_89)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_92)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_94)).xyz, 0.0), float4(VertexFetch_InstancePrevTransformBuffer.read(uint(_96)).xyz, 1.0)) * in.in_var_ATTRIBUTE0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_141[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_141[2], _109 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _148;
    out_var_TEXCOORD0 = _206;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

