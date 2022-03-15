

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
    float out_var_TEXCOORD8 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00000d33_8a6872f1(constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(2)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _78 = fract(floor(float3(uint3((gl_InstanceIndex - gl_BaseInstance))) * float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1])) * float3(VectorFieldVis.VectorFieldVis_VoxelSize)) + (float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5);
    float3 _83 = VectorFieldTexture.sample(VectorFieldTextureSampler, _78, level(0.0)).xyz;
    float4 _114 = float4(((VectorFieldVis.VectorFieldVis_VolumeToWorld * float4(_78, 1.0)).xyz - View.View_WorldCameraOrigin) + ((VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * float4(normalize(_83) * fast::min(length(_83) * VectorFieldVis.VectorFieldVis_Scale, 10.0), 0.0)).xyz * float((gl_VertexIndex - gl_BaseVertex))), 1.0);
    float4 _120 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_114.x, _114.y, _114.z, _114.w);
    float4 _131;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_120.z < 0.0))
    {
        float4 _129 = _120;
        _129.z = 9.9999999747524270787835121154785e-07;
        float4 _130 = _129;
        _130.w = 1.0;
        _131 = _130;
    }
    else
    {
        _131 = _120;
    }
    float _133 = abs(ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z);
    out.out_var_TEXCOORD0 = float2(0.0);
    out.out_var_TEXCOORD6 = _131.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_133) > 0.0) ? (sqrt(fast::clamp(1.0 - (_133 * _133), 0.0, 1.0)) / _133) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _114.xyz;
    out.gl_Position = _131;
    return out;
}

