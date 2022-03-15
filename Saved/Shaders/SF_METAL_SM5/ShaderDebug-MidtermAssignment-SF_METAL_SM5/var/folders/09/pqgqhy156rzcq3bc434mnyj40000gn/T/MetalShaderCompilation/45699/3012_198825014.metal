

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

struct type_Globals
{
    uint InstanceOffset;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00000bc4_0bd9d436(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _49 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _50 = 3u * _49;
    float4 _52 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_50));
    uint _53 = _50 + 1u;
    float4 _54 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_53));
    uint _55 = _50 + 2u;
    float4 _56 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_55));
    float4 _58 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_49));
    float _59 = _52.x;
    float _60 = _52.y;
    float _61 = _52.z;
    float4 _62 = float4(_59, _60, _61, 0.0);
    float _63 = _54.x;
    float _64 = _54.y;
    float _65 = _54.z;
    float4 _66 = float4(_63, _64, _65, 0.0);
    float _67 = _56.x;
    float _68 = _56.y;
    float _69 = _56.z;
    float4 _70 = float4(_67, _68, _69, 0.0);
    float _71 = _58.x;
    float _72 = _58.y;
    float _73 = _58.z;
    float4 _74 = float4(_71, _72, _73, 1.0);
    float4x4 _75 = float4x4(_62, _66, _70, _74);
    float4 _76 = _75 * in.in_var_ATTRIBUTE0;
    float3 _81 = _76.xxx;
    float3 _82 = Primitive.Primitive_LocalToWorld[0].xyz * _81;
    float3 _85 = _76.yyy;
    float3 _86 = Primitive.Primitive_LocalToWorld[1].xyz * _85;
    float3 _87 = _82 + _86;
    float3 _90 = _76.zzz;
    float3 _91 = Primitive.Primitive_LocalToWorld[2].xyz * _90;
    float3 _92 = _87 + _91;
    float3 _95 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _96 = _92 + _95;
    float _97 = _96.x;
    float _98 = _96.y;
    float _99 = _96.z;
    float4 _100 = float4(_97, _98, _99, 1.0);
    float4 _101 = View.View_TranslatedWorldToClip * _100;
    out.gl_Position = _101;
    return out;
}

