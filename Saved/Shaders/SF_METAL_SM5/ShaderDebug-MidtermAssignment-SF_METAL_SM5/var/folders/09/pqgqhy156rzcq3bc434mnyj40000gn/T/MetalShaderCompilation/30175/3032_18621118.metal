

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

vertex Main_out Main_00000bd8_011c22be(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> VertexFetch_InstanceTransformBuffer [[texture(0)]], texture_buffer<uint> VertexFetch_InstanceBoneMapBuffer [[texture(1)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _54 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w);
    uint _55 = _54 + (gl_VertexIndex - gl_BaseVertex);
    uint4 _57 = VertexFetch_InstanceBoneMapBuffer.read(uint(_55));
    uint _58 = _57.x;
    uint _59 = 4u * _58;
    float4 _61 = VertexFetch_InstanceTransformBuffer.read(uint(_59));
    uint _62 = _59 + 1u;
    float4 _63 = VertexFetch_InstanceTransformBuffer.read(uint(_62));
    uint _64 = _59 + 2u;
    float4 _65 = VertexFetch_InstanceTransformBuffer.read(uint(_64));
    uint _66 = _59 + 3u;
    float4 _67 = VertexFetch_InstanceTransformBuffer.read(uint(_66));
    float _68 = _61.x;
    float _69 = _61.y;
    float _70 = _61.z;
    float4 _71 = float4(_68, _69, _70, 0.0);
    float _72 = _63.x;
    float _73 = _63.y;
    float _74 = _63.z;
    float4 _75 = float4(_72, _73, _74, 0.0);
    float _76 = _65.x;
    float _77 = _65.y;
    float _78 = _65.z;
    float4 _79 = float4(_76, _77, _78, 0.0);
    float _80 = _67.x;
    float _81 = _67.y;
    float _82 = _67.z;
    float4 _83 = float4(_80, _81, _82, 1.0);
    float4x4 _84 = float4x4(_71, _75, _79, _83);
    float4 _85 = _84 * in.in_var_ATTRIBUTE0;
    float3 _90 = _85.xxx;
    float3 _91 = Primitive.Primitive_LocalToWorld[0].xyz * _90;
    float3 _94 = _85.yyy;
    float3 _95 = Primitive.Primitive_LocalToWorld[1].xyz * _94;
    float3 _96 = _91 + _95;
    float3 _99 = _85.zzz;
    float3 _100 = Primitive.Primitive_LocalToWorld[2].xyz * _99;
    float3 _101 = _96 + _100;
    float3 _104 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _105 = _101 + _104;
    float _106 = _105.x;
    float _107 = _105.y;
    float _108 = _105.z;
    float4 _109 = float4(_106, _107, _108, 1.0);
    float4 _110 = View.View_TranslatedWorldToClip * _109;
    out.gl_Position = _110;
    return out;
}

