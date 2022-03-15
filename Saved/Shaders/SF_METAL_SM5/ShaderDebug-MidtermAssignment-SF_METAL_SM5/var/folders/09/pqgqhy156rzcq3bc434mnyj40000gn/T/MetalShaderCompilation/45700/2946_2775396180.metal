

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
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00000b82_a56d2f54(constant type_View& View [[buffer(0)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(1)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _55 = float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5;
    float _58 = VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1];
    float3 _59 = float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], _58);
    uint3 _60 = uint3((gl_InstanceIndex - gl_BaseInstance));
    float3 _61 = float3(_60);
    float3 _62 = _61 * _59;
    float3 _63 = floor(_62);
    float3 _64 = _63 * float3(VectorFieldVis.VectorFieldVis_VoxelSize);
    float3 _65 = fract(_64);
    float3 _66 = _65 + _55;
    float4 _70 = VectorFieldTexture.sample(VectorFieldTextureSampler, _66, level(0.0));
    float3 _71 = _70.xyz;
    float _72 = length(_71);
    float _75 = _72 * VectorFieldVis.VectorFieldVis_Scale;
    float _76 = fast::min(_75, 10.0);
    float3 _77 = normalize(_71);
    float3 _78 = _77 * _76;
    float _79 = _66.x;
    float _80 = _66.y;
    float _81 = _66.z;
    float4 _82 = float4(_79, _80, _81, 1.0);
    float4 _85 = VectorFieldVis.VectorFieldVis_VolumeToWorld * _82;
    float3 _86 = _85.xyz;
    float3 _87 = _86 - View.View_WorldCameraOrigin;
    float _88 = _78.x;
    float _89 = _78.y;
    float _90 = _78.z;
    float4 _91 = float4(_88, _89, _90, 0.0);
    float4 _94 = VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * _91;
    float3 _95 = _94.xyz;
    float _96 = float((gl_VertexIndex - gl_BaseVertex));
    float3 _97 = _95 * _96;
    float3 _98 = _87 + _97;
    float _99 = _98.x;
    float _100 = _98.y;
    float _101 = _98.z;
    float4 _102 = float4(_99, _100, _101, 1.0);
    float4 _103 = float4(_102.x, _102.y, _102.z, _102.w);
    float4 _104 = View.View_TranslatedWorldToClip * _103;
    out.out_var_TEXCOORD0 = float2(0.0);
    out.gl_Position = _104;
    return out;
}

