

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1008];
    float3 View_WorldCameraOrigin;
};

struct type_VectorFieldVis
{
    float4x4 VectorFieldVis_VolumeToWorld;
    float4x4 VectorFieldVis_VolumeToWorldNoScale;
    packed_float3 VectorFieldVis_VoxelSize;
    float VectorFieldVis_Scale;
};

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD6 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00000bcc_fe332c46(constant type_View& View [[buffer(0)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(1)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _56 = float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5;
    float _59 = VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1];
    float3 _60 = float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], _59);
    uint3 _61 = uint3((gl_InstanceIndex - gl_BaseInstance));
    float3 _62 = float3(_61);
    float3 _63 = _62 * _60;
    float3 _64 = floor(_63);
    float3 _65 = _64 * float3(VectorFieldVis.VectorFieldVis_VoxelSize);
    float3 _66 = fract(_65);
    float3 _67 = _66 + _56;
    float4 _71 = VectorFieldTexture.sample(VectorFieldTextureSampler, _67, level(0.0));
    float3 _72 = _71.xyz;
    float _73 = length(_72);
    float _76 = _73 * VectorFieldVis.VectorFieldVis_Scale;
    float _77 = fast::min(_76, 10.0);
    float3 _78 = normalize(_72);
    float3 _79 = _78 * _77;
    float _80 = _67.x;
    float _81 = _67.y;
    float _82 = _67.z;
    float4 _83 = float4(_80, _81, _82, 1.0);
    float4 _86 = VectorFieldVis.VectorFieldVis_VolumeToWorld * _83;
    float3 _87 = _86.xyz;
    float3 _88 = _87 - View.View_WorldCameraOrigin;
    float _89 = _79.x;
    float _90 = _79.y;
    float _91 = _79.z;
    float4 _92 = float4(_89, _90, _91, 0.0);
    float4 _95 = VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * _92;
    float3 _96 = _95.xyz;
    float _97 = float((gl_VertexIndex - gl_BaseVertex));
    float3 _98 = _96 * _97;
    float3 _99 = _88 + _98;
    float _100 = _99.x;
    float _101 = _99.y;
    float _102 = _99.z;
    float4 _103 = float4(_100, _101, _102, 1.0);
    float4 _104 = float4(_103.x, _103.y, _103.z, _103.w);
    float4 _105 = View.View_TranslatedWorldToClip * _104;
    out.gl_Position = _105;
    out.out_var_TEXCOORD0 = float2(0.0);
    out.out_var_TEXCOORD6 = _104;
    return out;
}

