

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
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00000b18_32069f8f(constant type_View& View [[buffer(0)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(1)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _51 = float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5;
    float _54 = VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1];
    float3 _55 = float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], _54);
    uint3 _56 = uint3((gl_InstanceIndex - gl_BaseInstance));
    float3 _57 = float3(_56);
    float3 _58 = _57 * _55;
    float3 _59 = floor(_58);
    float3 _60 = _59 * float3(VectorFieldVis.VectorFieldVis_VoxelSize);
    float3 _61 = fract(_60);
    float3 _62 = _61 + _51;
    float4 _66 = VectorFieldTexture.sample(VectorFieldTextureSampler, _62, level(0.0));
    float3 _67 = _66.xyz;
    float _68 = length(_67);
    float _71 = _68 * VectorFieldVis.VectorFieldVis_Scale;
    float _72 = fast::min(_71, 10.0);
    float3 _73 = normalize(_67);
    float3 _74 = _73 * _72;
    float _75 = _62.x;
    float _76 = _62.y;
    float _77 = _62.z;
    float4 _78 = float4(_75, _76, _77, 1.0);
    float4 _81 = VectorFieldVis.VectorFieldVis_VolumeToWorld * _78;
    float3 _82 = _81.xyz;
    float3 _83 = _82 - View.View_WorldCameraOrigin;
    float _84 = _74.x;
    float _85 = _74.y;
    float _86 = _74.z;
    float4 _87 = float4(_84, _85, _86, 0.0);
    float4 _90 = VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * _87;
    float3 _91 = _90.xyz;
    float _92 = float((gl_VertexIndex - gl_BaseVertex));
    float3 _93 = _91 * _92;
    float3 _94 = _83 + _93;
    float _95 = _94.x;
    float _96 = _94.y;
    float _97 = _94.z;
    float4 _98 = float4(_95, _96, _97, 1.0);
    float4 _99 = float4(_98.x, _98.y, _98.z, _98.w);
    float4 _100 = View.View_TranslatedWorldToClip * _99;
    out.gl_Position = _100;
    return out;
}

