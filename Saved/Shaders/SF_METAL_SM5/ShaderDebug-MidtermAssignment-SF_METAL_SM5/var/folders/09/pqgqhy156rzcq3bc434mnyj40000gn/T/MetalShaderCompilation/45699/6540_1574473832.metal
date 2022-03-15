

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct type_Globals
{
    char _m0_pad[4];
    uint LayerId;
};

constant float3x3 _68 = {};
constant float4 _69 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float3 out_var_TEXCOORD8 [[user(locn5)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainForGS_out Main_0000198c_5dd89068(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
    uint _80 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _81 = _80 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _83 = VertexFetch_InstanceBoneMapBuffer.read(uint(_81));
    uint _84 = _83.x;
    uint _85 = 4u * _84;
    float4 _87 = VertexFetch_InstanceTransformBuffer.read(uint(_85));
    uint _88 = _85 + 1u;
    float4 _89 = VertexFetch_InstanceTransformBuffer.read(uint(_88));
    uint _90 = _85 + 2u;
    float4 _91 = VertexFetch_InstanceTransformBuffer.read(uint(_90));
    uint _92 = _85 + 3u;
    float4 _93 = VertexFetch_InstanceTransformBuffer.read(uint(_92));
    uint _94 = 2u * _81;
    float4 _99 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_94 + 1u)));
    float _100 = _99.w;
    float3 _101 = _99.xyz;
    float3 _103 = cross(_101, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_94)).xyz) * _100;
    float3x3 _106 = _68;
    _106[0] = cross(_103, _101) * _100;
    float3x3 _107 = _106;
    _107[1] = _103;
    float3x3 _108 = _107;
    _108[2] = _101;
    float3x3 _122 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_87.xyz, _89.xyz, _91.xyz);
    float3x3 _125 = _122;
    _125[0] = normalize(_122[0]);
    float3x3 _128 = _125;
    _128[1] = normalize(_122[1]);
    float3x3 _131 = _128;
    _131[2] = normalize(_122[2]);
    float3x3 _132 = _131 * _108;
    float4 _136 = _69;
    _136.x = 0.0;
    float4 _137 = _136;
    _137.y = 1.0;
    float4 _138 = _137;
    _138.z = 1.0;
    float4 _139 = _138;
    _139.w = 0.0;
    float _140 = _87.x;
    float _141 = _87.y;
    float _142 = _87.z;
    float4 _143 = float4(_140, _141, _142, 0.0);
    float _144 = _89.x;
    float _145 = _89.y;
    float _146 = _89.z;
    float4 _147 = float4(_144, _145, _146, 0.0);
    float _148 = _91.x;
    float _149 = _91.y;
    float _150 = _91.z;
    float4 _151 = float4(_148, _149, _150, 0.0);
    float _152 = _93.x;
    float _153 = _93.y;
    float _154 = _93.z;
    float4 _155 = float4(_152, _153, _154, 1.0);
    float4x4 _156 = float4x4(_143, _147, _151, _155);
    float4 _157 = _156 * in.in_var_ATTRIBUTE0;
    float3 _158 = _157.xxx;
    float3 _159 = Primitive.Primitive_LocalToWorld[0].xyz * _158;
    float3 _160 = _157.yyy;
    float3 _161 = Primitive.Primitive_LocalToWorld[1].xyz * _160;
    float3 _162 = _159 + _161;
    float3 _163 = _157.zzz;
    float3 _164 = Primitive.Primitive_LocalToWorld[2].xyz * _163;
    float3 _165 = _162 + _164;
    float3 _168 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _169 = _165 + _168;
    float _170 = _169.x;
    float _171 = _169.y;
    float _172 = _169.z;
    float4 _173 = float4(_170, _171, _172, 1.0);
    float4 _174 = _173 * 1.0;
    float3 _175 = _132[2];
    float4 _176 = float4(_174.x, _174.y, _174.z, _174.w);
    float4 _191 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _176;
    out.out_var_TEXCOORD10_centroid = float4(_132[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_175, _100 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _139;
    out.out_var_TEXCOORD7 = _174.xyz;
    out.out_var_TEXCOORD6 = _191;
    out.out_var_TEXCOORD8 = _175;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _191;
    return out;
}

