

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

struct type_Globals
{
    uint InstanceOffset;
    uint LayerId;
};

struct PositionOnlyMain_out
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

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_000016cd_533a0b2a(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    PositionOnlyMain_out out = {};
    uint _67 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _68 = 3u * _67;
    float4 _70 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_68));
    uint _71 = _68 + 1u;
    float4 _72 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_71));
    uint _73 = _68 + 2u;
    float4 _74 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_73));
    float4 _76 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_67));
    float _77 = _70.x;
    float _78 = _70.y;
    float _79 = _70.z;
    float4 _80 = float4(_77, _78, _79, 0.0);
    float _81 = _72.x;
    float _82 = _72.y;
    float _83 = _72.z;
    float4 _84 = float4(_81, _82, _83, 0.0);
    float _85 = _74.x;
    float _86 = _74.y;
    float _87 = _74.z;
    float4 _88 = float4(_85, _86, _87, 0.0);
    float _89 = _76.x;
    float _90 = _76.y;
    float _91 = _76.z;
    float4 _92 = float4(_89, _90, _91, 1.0);
    float4x4 _93 = float4x4(_80, _84, _88, _92);
    float4 _94 = _93 * in.in_var_ATTRIBUTE0;
    float3 _99 = _94.xxx;
    float3 _100 = Primitive.Primitive_LocalToWorld[0].xyz * _99;
    float3 _103 = _94.yyy;
    float3 _104 = Primitive.Primitive_LocalToWorld[1].xyz * _103;
    float3 _105 = _100 + _104;
    float3 _108 = _94.zzz;
    float3 _109 = Primitive.Primitive_LocalToWorld[2].xyz * _108;
    float3 _110 = _105 + _109;
    float3 _113 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _114 = _110 + _113;
    float _115 = _114.x;
    float _116 = _114.y;
    float _117 = _114.z;
    float4 _118 = float4(_115, _116, _117, 1.0);
    float4 _144 = float4x4(float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_68)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_71)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_73)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_67)).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _165 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _118;
    out.gl_Layer = _Globals.LayerId;
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_COLOR1 = float4(0.0);
    out.out_var_TEXCOORD7 = _118.xyz;
    out.out_var_TEXCOORD6 = _165;
    out.out_var_TEXCOORD8 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _144.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _144.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _144.zzz);
    out.gl_Position = _165;
    return out;
}

