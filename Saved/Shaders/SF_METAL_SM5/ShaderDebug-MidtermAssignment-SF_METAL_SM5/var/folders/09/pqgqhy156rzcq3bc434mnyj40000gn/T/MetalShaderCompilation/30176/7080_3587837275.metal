

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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
    float4 PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias;
};

constant float3x3 _67 = {};
constant float4 _68 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001ba8_d5da0d5b(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _79 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _80 = _79 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _82 = VertexFetch_InstanceBoneMapBuffer.read(uint(_80));
    uint _83 = _82.x;
    uint _84 = 4u * _83;
    float4 _86 = VertexFetch_InstanceTransformBuffer.read(uint(_84));
    uint _87 = _84 + 1u;
    float4 _88 = VertexFetch_InstanceTransformBuffer.read(uint(_87));
    uint _89 = _84 + 2u;
    float4 _90 = VertexFetch_InstanceTransformBuffer.read(uint(_89));
    uint _91 = _84 + 3u;
    float4 _92 = VertexFetch_InstanceTransformBuffer.read(uint(_91));
    uint _93 = 2u * _80;
    float4 _98 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_93 + 1u)));
    float _99 = _98.w;
    float3 _100 = _98.xyz;
    float3 _102 = cross(_100, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_93)).xyz) * _99;
    float3x3 _105 = _67;
    _105[0] = cross(_102, _100) * _99;
    float3x3 _106 = _105;
    _106[1] = _102;
    float3x3 _107 = _106;
    _107[2] = _100;
    float3x3 _121 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_86.xyz, _88.xyz, _90.xyz);
    float3x3 _124 = _121;
    _124[0] = normalize(_121[0]);
    float3x3 _127 = _124;
    _127[1] = normalize(_121[1]);
    float3x3 _130 = _127;
    _130[2] = normalize(_121[2]);
    float3x3 _131 = _130 * _107;
    float4 _135 = _68;
    _135.x = 0.0;
    float4 _136 = _135;
    _136.y = 1.0;
    float4 _137 = _136;
    _137.z = 1.0;
    float4 _138 = _137;
    _138.w = 0.0;
    float _139 = _86.x;
    float _140 = _86.y;
    float _141 = _86.z;
    float4 _142 = float4(_139, _140, _141, 0.0);
    float _143 = _88.x;
    float _144 = _88.y;
    float _145 = _88.z;
    float4 _146 = float4(_143, _144, _145, 0.0);
    float _147 = _90.x;
    float _148 = _90.y;
    float _149 = _90.z;
    float4 _150 = float4(_147, _148, _149, 0.0);
    float _151 = _92.x;
    float _152 = _92.y;
    float _153 = _92.z;
    float4 _154 = float4(_151, _152, _153, 1.0);
    float4x4 _155 = float4x4(_142, _146, _150, _154);
    float4 _156 = _155 * in.in_var_ATTRIBUTE0;
    float3 _157 = _156.xxx;
    float3 _158 = Primitive.Primitive_LocalToWorld[0].xyz * _157;
    float3 _159 = _156.yyy;
    float3 _160 = Primitive.Primitive_LocalToWorld[1].xyz * _159;
    float3 _161 = _158 + _160;
    float3 _162 = _156.zzz;
    float3 _163 = Primitive.Primitive_LocalToWorld[2].xyz * _162;
    float3 _164 = _161 + _163;
    float3 _167 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _168 = _164 + _167;
    float _169 = _168.x;
    float _170 = _168.y;
    float _171 = _168.z;
    float4 _172 = float4(_169, _170, _171, 1.0);
    float4 _173 = _172 * 1.0;
    uint _176 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _179 = _176 * _80;
    float4 _182 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_179 + min(0u, (_176 - 1u)))));
    float4 _183 = float4(_173.x, _173.y, _173.z, _173.w);
    float4 _184 = View.View_TranslatedWorldToClip * _183;
    float2 _191 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_179 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    float2 _195 = _191 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy;
    float2 _199 = _191 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy;
    spvUnsafeArray<float4, 1> _211 = { float4(_182.x, _182.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_131[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_131[2], _99 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _138;
    out_var_TEXCOORD0 = _211;
    out.out_var_TEXCOORD4 = float4(_195.x, _195.y, _199.x, _199.y);
    out.gl_Position = _184;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

