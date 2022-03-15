

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

vertex Main_out Main_00000bbf_d97d16f7(constant type_View& View [[buffer(0)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(1)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _54 = float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5;
    float _57 = VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1];
    float3 _58 = float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], _57);
    uint3 _59 = uint3((gl_InstanceIndex - gl_BaseInstance));
    float3 _60 = float3(_59);
    float3 _61 = _60 * _58;
    float3 _62 = floor(_61);
    float3 _63 = _62 * float3(VectorFieldVis.VectorFieldVis_VoxelSize);
    float3 _64 = fract(_63);
    float3 _65 = _64 + _54;
    float4 _69 = VectorFieldTexture.sample(VectorFieldTextureSampler, _65, level(0.0));
    float3 _70 = _69.xyz;
    float _71 = length(_70);
    float _74 = _71 * VectorFieldVis.VectorFieldVis_Scale;
    float _75 = fast::min(_74, 10.0);
    float3 _76 = normalize(_70);
    float3 _77 = _76 * _75;
    float _78 = _65.x;
    float _79 = _65.y;
    float _80 = _65.z;
    float4 _81 = float4(_78, _79, _80, 1.0);
    float4 _84 = VectorFieldVis.VectorFieldVis_VolumeToWorld * _81;
    float3 _85 = _84.xyz;
    float3 _86 = _85 - View.View_WorldCameraOrigin;
    float _87 = _77.x;
    float _88 = _77.y;
    float _89 = _77.z;
    float4 _90 = float4(_87, _88, _89, 0.0);
    float4 _93 = VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * _90;
    float3 _94 = _93.xyz;
    float _95 = float((gl_VertexIndex - gl_BaseVertex));
    float3 _96 = _94 * _95;
    float3 _97 = _86 + _96;
    float _98 = _97.x;
    float _99 = _97.y;
    float _100 = _97.z;
    float4 _101 = float4(_98, _99, _100, 1.0);
    float4 _102 = float4(_101.x, _101.y, _101.z, _101.w);
    float4 _105 = View.View_TranslatedWorldToClip * _102;
    out.out_var_TEXCOORD0 = float2(0.0);
    out.out_var_TEXCOORD6 = _102;
    out.gl_Position = _105;
    return out;
}

