

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
};

constant float3x3 _69 = {};
constant float4 _70 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001b89_4200e31e(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(7)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(2)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _81 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _82 = _81 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _84 = VertexFetch_InstanceBoneMapBuffer.read(uint(_82));
    uint _85 = _84.x;
    uint _86 = 4u * _85;
    float4 _88 = VertexFetch_InstanceTransformBuffer.read(uint(_86));
    uint _89 = _86 + 1u;
    float4 _90 = VertexFetch_InstanceTransformBuffer.read(uint(_89));
    uint _91 = _86 + 2u;
    float4 _92 = VertexFetch_InstanceTransformBuffer.read(uint(_91));
    uint _93 = _86 + 3u;
    float4 _94 = VertexFetch_InstanceTransformBuffer.read(uint(_93));
    uint _95 = 2u * _82;
    float4 _100 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_95 + 1u)));
    float _101 = _100.w;
    float3 _102 = _100.xyz;
    float3 _104 = cross(_102, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_95)).xyz) * _101;
    float3x3 _107 = _69;
    _107[0] = cross(_104, _102) * _101;
    float3x3 _108 = _107;
    _108[1] = _104;
    float3x3 _109 = _108;
    _109[2] = _102;
    float3x3 _123 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_88.xyz, _90.xyz, _92.xyz);
    float3x3 _126 = _123;
    _126[0] = normalize(_123[0]);
    float3x3 _129 = _126;
    _129[1] = normalize(_123[1]);
    float3x3 _132 = _129;
    _132[2] = normalize(_123[2]);
    float3x3 _133 = _132 * _109;
    float4 _137 = _70;
    _137.x = 0.0;
    float4 _138 = _137;
    _138.y = 1.0;
    float4 _139 = _138;
    _139.z = 1.0;
    float4 _140 = _139;
    _140.w = 0.0;
    float _141 = _88.x;
    float _142 = _88.y;
    float _143 = _88.z;
    float4 _144 = float4(_141, _142, _143, 0.0);
    float _145 = _90.x;
    float _146 = _90.y;
    float _147 = _90.z;
    float4 _148 = float4(_145, _146, _147, 0.0);
    float _149 = _92.x;
    float _150 = _92.y;
    float _151 = _92.z;
    float4 _152 = float4(_149, _150, _151, 0.0);
    float _153 = _94.x;
    float _154 = _94.y;
    float _155 = _94.z;
    float4 _156 = float4(_153, _154, _155, 1.0);
    float4x4 _157 = float4x4(_144, _148, _152, _156);
    float4 _158 = _157 * in.in_var_ATTRIBUTE0;
    float3 _159 = _158.xxx;
    float3 _160 = Primitive.Primitive_LocalToWorld[0].xyz * _159;
    float3 _161 = _158.yyy;
    float3 _162 = Primitive.Primitive_LocalToWorld[1].xyz * _161;
    float3 _163 = _160 + _162;
    float3 _164 = _158.zzz;
    float3 _165 = Primitive.Primitive_LocalToWorld[2].xyz * _164;
    float3 _166 = _163 + _165;
    float3 _169 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _170 = _166 + _169;
    float _171 = _170.x;
    float _172 = _170.y;
    float _173 = _170.z;
    float4 _174 = float4(_171, _172, _173, 1.0);
    float4 _175 = _174 * 1.0;
    uint _178 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _181 = _178 * _82;
    float4 _184 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_181 + min(0u, (_178 - 1u)))));
    float4 _185 = float4(_175.x, _175.y, _175.z, _175.w);
    float4 _186 = View.View_TranslatedWorldToClip * _185;
    float2 _197 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_181 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy;
    spvUnsafeArray<float4, 1> _209 = { float4(_184.x, _184.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_133[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_133[2], _101 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _140;
    out_var_TEXCOORD0 = _209;
    out.out_var_TEXCOORD4 = float4(_197.x, _197.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _185;
    out.gl_Position = _186;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

