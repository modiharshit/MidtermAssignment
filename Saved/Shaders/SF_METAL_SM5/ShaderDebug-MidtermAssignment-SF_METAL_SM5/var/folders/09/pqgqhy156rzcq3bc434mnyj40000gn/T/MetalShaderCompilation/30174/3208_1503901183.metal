

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00000c88_59a3b5ff(constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(2)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _71 = fract(floor(float3(uint3((gl_InstanceIndex - gl_BaseInstance))) * float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1])) * float3(VectorFieldVis.VectorFieldVis_VoxelSize)) + (float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5);
    float3 _76 = VectorFieldTexture.sample(VectorFieldTextureSampler, _71, level(0.0)).xyz;
    float4 _107 = float4(((VectorFieldVis.VectorFieldVis_VolumeToWorld * float4(_71, 1.0)).xyz - View.View_WorldCameraOrigin) + ((VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * float4(normalize(_76) * fast::min(length(_76) * VectorFieldVis.VectorFieldVis_Scale, 10.0), 0.0)).xyz * float((gl_VertexIndex - gl_BaseVertex))), 1.0);
    float4 _113 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_107.x, _107.y, _107.z, _107.w);
    float4 _124;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_113.z < 0.0))
    {
        float4 _122 = _113;
        _122.z = 9.9999999747524270787835121154785e-07;
        float4 _123 = _122;
        _123.w = 1.0;
        _124 = _123;
    }
    else
    {
        _124 = _113;
    }
    float _126 = abs(ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z);
    out.out_var_TEXCOORD6 = _124.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_126) > 0.0) ? (sqrt(fast::clamp(1.0 - (_126 * _126), 0.0, 1.0)) / _126) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _124;
    return out;
}

