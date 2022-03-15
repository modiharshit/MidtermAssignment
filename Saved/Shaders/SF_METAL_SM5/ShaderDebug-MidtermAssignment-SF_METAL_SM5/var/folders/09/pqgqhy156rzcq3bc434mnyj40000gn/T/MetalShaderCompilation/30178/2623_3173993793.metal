

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1008];
    float3 View_WorldCameraOrigin;
    char _m2_pad[368];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[640];
    int View_NumSceneColorMSAASamples;
};

struct type_VectorFieldVis
{
    float4x4 VectorFieldVis_VolumeToWorld;
    float4x4 VectorFieldVis_VolumeToWorldNoScale;
    packed_float3 VectorFieldVis_VoxelSize;
    float VectorFieldVis_Scale;
};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float2 out_var_TEXCOORD0 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

vertex MainVertexShader_out Main_00000a3f_bd2f4d41(constant type_View& View [[buffer(0)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(1)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    float3 _75 = fract(floor(float3(uint3((gl_InstanceIndex - gl_BaseInstance))) * float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1])) * float3(VectorFieldVis.VectorFieldVis_VoxelSize)) + (float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5);
    float3 _80 = VectorFieldTexture.sample(VectorFieldTextureSampler, _75, level(0.0)).xyz;
    float4 _111 = float4(((VectorFieldVis.VectorFieldVis_VolumeToWorld * float4(_75, 1.0)).xyz - View.View_WorldCameraOrigin) + ((VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * float4(normalize(_80) * fast::min(length(_80) * VectorFieldVis.VectorFieldVis_Scale, 10.0), 0.0)).xyz * float((gl_VertexIndex - gl_BaseVertex))), 1.0);
    float4 _113 = View.View_TranslatedWorldToClip * _111;
    float4 _122 = _113;
    _122.z = _113.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _113.w) : 0.0);
    out.gl_Position = _122;
    out.out_var_TEXCOORD6 = _113;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * _111;
    out.out_var_TEXCOORD0 = float2(0.0);
    return out;
}

