

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_View
{
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_VectorFieldVis
{
    float4x4 VectorFieldVis_VolumeToWorld;
    float4x4 VectorFieldVis_VolumeToWorldNoScale;
    packed_float3 VectorFieldVis_VoxelSize;
    float VectorFieldVis_Scale;
};

struct type_Globals
{
    uint LayerId;
};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00001189_ac29fb49(constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float3 _64 = float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5;
    float _67 = VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1];
    float3 _68 = float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], _67);
    uint3 _69 = uint3((gl_InstanceIndex - gl_BaseInstance));
    float3 _70 = float3(_69);
    float3 _71 = _70 * _68;
    float3 _72 = floor(_71);
    float3 _73 = _72 * float3(VectorFieldVis.VectorFieldVis_VoxelSize);
    float3 _74 = fract(_73);
    float3 _75 = _74 + _64;
    float4 _79 = VectorFieldTexture.sample(VectorFieldTextureSampler, _75, level(0.0));
    float3 _80 = _79.xyz;
    float _81 = length(_80);
    float _84 = _81 * VectorFieldVis.VectorFieldVis_Scale;
    float _85 = fast::min(_84, 10.0);
    float3 _86 = normalize(_80);
    float3 _87 = _86 * _85;
    float _88 = _75.x;
    float _89 = _75.y;
    float _90 = _75.z;
    float4 _91 = float4(_88, _89, _90, 1.0);
    float4 _94 = VectorFieldVis.VectorFieldVis_VolumeToWorld * _91;
    float3 _95 = _94.xyz;
    float3 _96 = _95 - View.View_WorldCameraOrigin;
    float _97 = _87.x;
    float _98 = _87.y;
    float _99 = _87.z;
    float4 _100 = float4(_97, _98, _99, 0.0);
    float4 _103 = VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * _100;
    float3 _104 = _103.xyz;
    float _105 = float((gl_VertexIndex - gl_BaseVertex));
    float3 _106 = _104 * _105;
    float3 _107 = _96 + _106;
    float _108 = _107.x;
    float _109 = _107.y;
    float _110 = _107.z;
    float4 _111 = float4(_108, _109, _110, 1.0);
    float4 _112 = float4(_111.x, _111.y, _111.z, _111.w);
    float4 _117 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _112;
    out.out_var_TEXCOORD6 = _112;
    out.out_var_TEXCOORD8 = float3(0.0, 0.0, 1.0);
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _117;
    return out;
}

