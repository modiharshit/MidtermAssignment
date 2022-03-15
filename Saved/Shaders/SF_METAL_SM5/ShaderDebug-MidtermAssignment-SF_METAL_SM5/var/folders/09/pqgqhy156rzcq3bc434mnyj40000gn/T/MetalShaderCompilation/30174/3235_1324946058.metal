

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
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00000ca3_4ef9128a(constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(2)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _70 = fract(floor(float3(uint3((gl_InstanceIndex - gl_BaseInstance))) * float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1])) * float3(VectorFieldVis.VectorFieldVis_VoxelSize)) + (float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5);
    float3 _75 = VectorFieldTexture.sample(VectorFieldTextureSampler, _70, level(0.0)).xyz;
    float4 _106 = float4(((VectorFieldVis.VectorFieldVis_VolumeToWorld * float4(_70, 1.0)).xyz - View.View_WorldCameraOrigin) + ((VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * float4(normalize(_75) * fast::min(length(_75) * VectorFieldVis.VectorFieldVis_Scale, 10.0), 0.0)).xyz * float((gl_VertexIndex - gl_BaseVertex))), 1.0);
    float4 _112 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_106.x, _106.y, _106.z, _106.w);
    float4 _123;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_112.z < 0.0))
    {
        float4 _121 = _112;
        _121.z = 9.9999999747524270787835121154785e-07;
        float4 _122 = _121;
        _122.w = 1.0;
        _123 = _122;
    }
    else
    {
        _123 = _112;
    }
    float _125 = abs(ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z);
    float4 _150 = _123;
    _150.z = ((_123.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_125) > 0.0) ? (sqrt(fast::clamp(1.0 - (_125 * _125), 0.0, 1.0)) / _125) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _123.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _150;
    return out;
}

