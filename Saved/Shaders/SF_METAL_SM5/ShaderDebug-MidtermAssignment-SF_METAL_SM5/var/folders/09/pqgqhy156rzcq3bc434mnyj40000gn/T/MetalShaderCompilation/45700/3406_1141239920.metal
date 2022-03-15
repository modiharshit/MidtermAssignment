

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
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float out_var_TEXCOORD6 [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00000d4e_4405f070(constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(2)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _77 = fract(floor(float3(uint3((gl_InstanceIndex - gl_BaseInstance))) * float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1])) * float3(VectorFieldVis.VectorFieldVis_VoxelSize)) + (float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5);
    float3 _82 = VectorFieldTexture.sample(VectorFieldTextureSampler, _77, level(0.0)).xyz;
    float4 _113 = float4(((VectorFieldVis.VectorFieldVis_VolumeToWorld * float4(_77, 1.0)).xyz - View.View_WorldCameraOrigin) + ((VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * float4(normalize(_82) * fast::min(length(_82) * VectorFieldVis.VectorFieldVis_Scale, 10.0), 0.0)).xyz * float((gl_VertexIndex - gl_BaseVertex))), 1.0);
    float4 _119 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_113.x, _113.y, _113.z, _113.w);
    float4 _130;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_119.z < 0.0))
    {
        float4 _128 = _119;
        _128.z = 9.9999999747524270787835121154785e-07;
        float4 _129 = _128;
        _129.w = 1.0;
        _130 = _129;
    }
    else
    {
        _130 = _119;
    }
    float _132 = abs(ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z);
    float4 _157 = _130;
    _157.z = ((_130.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_132) > 0.0) ? (sqrt(fast::clamp(1.0 - (_132 * _132), 0.0, 1.0)) / _132) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _130.w;
    out.out_var_TEXCOORD0 = float2(0.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _113.xyz;
    out.gl_Position = _157;
    return out;
}

