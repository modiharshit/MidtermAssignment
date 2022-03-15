

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
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00000c2b_5c5bec08(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(0)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _55 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _56 = _55 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _58 = VertexFetch_InstanceBoneMapBuffer.read(uint(_56));
    uint _59 = _58.x;
    uint _60 = 4u * _59;
    float4 _62 = VertexFetch_InstanceTransformBuffer.read(uint(_60));
    uint _63 = _60 + 1u;
    float4 _64 = VertexFetch_InstanceTransformBuffer.read(uint(_63));
    uint _65 = _60 + 2u;
    float4 _66 = VertexFetch_InstanceTransformBuffer.read(uint(_65));
    uint _67 = _60 + 3u;
    float4 _68 = VertexFetch_InstanceTransformBuffer.read(uint(_67));
    float _77 = _62.x;
    float _78 = _62.y;
    float _79 = _62.z;
    float4 _80 = float4(_77, _78, _79, 0.0);
    float _81 = _64.x;
    float _82 = _64.y;
    float _83 = _64.z;
    float4 _84 = float4(_81, _82, _83, 0.0);
    float _85 = _66.x;
    float _86 = _66.y;
    float _87 = _66.z;
    float4 _88 = float4(_85, _86, _87, 0.0);
    float _89 = _68.x;
    float _90 = _68.y;
    float _91 = _68.z;
    float4 _92 = float4(_89, _90, _91, 1.0);
    float4x4 _93 = float4x4(_80, _84, _88, _92);
    float4 _94 = _93 * in.in_var_ATTRIBUTE0;
    float3 _95 = _94.xxx;
    float3 _96 = Primitive.Primitive_LocalToWorld[0].xyz * _95;
    float3 _97 = _94.yyy;
    float3 _98 = Primitive.Primitive_LocalToWorld[1].xyz * _97;
    float3 _99 = _96 + _98;
    float3 _100 = _94.zzz;
    float3 _101 = Primitive.Primitive_LocalToWorld[2].xyz * _100;
    float3 _102 = _99 + _101;
    float3 _105 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _106 = _102 + _105;
    float _107 = _106.x;
    float _108 = _106.y;
    float _109 = _106.z;
    float4 _110 = float4(_107, _108, _109, 1.0);
    float4 _111 = _110 * 1.0;
    float4 _112 = float4(_111.x, _111.y, _111.z, _111.w);
    float4 _113 = View.View_TranslatedWorldToClip * _112;
    out.gl_Position = _113;
    return out;
}

