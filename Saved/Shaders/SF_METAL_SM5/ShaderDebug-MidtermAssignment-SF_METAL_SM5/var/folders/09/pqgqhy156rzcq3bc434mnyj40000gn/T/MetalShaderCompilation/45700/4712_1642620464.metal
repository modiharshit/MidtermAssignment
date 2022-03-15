

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

struct MainForGS_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float3 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD8 [[user(locn3)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

vertex MainForGS_out Main_00001268_61e86630(constant type_View& View [[buffer(0)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(1)]], constant type_VectorFieldVis& VectorFieldVis [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture3d<float> VectorFieldTexture [[texture(0)]], sampler VectorFieldTextureSampler [[sampler(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainForGS_out out = {};
    float3 _70 = float3(VectorFieldVis.VectorFieldVis_VoxelSize) * 0.5;
    float _73 = VectorFieldVis.VectorFieldVis_VoxelSize[0] * VectorFieldVis.VectorFieldVis_VoxelSize[1];
    float3 _74 = float3(1.0, VectorFieldVis.VectorFieldVis_VoxelSize[0], _73);
    uint3 _75 = uint3((gl_InstanceIndex - gl_BaseInstance));
    float3 _76 = float3(_75);
    float3 _77 = _76 * _74;
    float3 _78 = floor(_77);
    float3 _79 = _78 * float3(VectorFieldVis.VectorFieldVis_VoxelSize);
    float3 _80 = fract(_79);
    float3 _81 = _80 + _70;
    float4 _85 = VectorFieldTexture.sample(VectorFieldTextureSampler, _81, level(0.0));
    float3 _86 = _85.xyz;
    float _87 = length(_86);
    float _90 = _87 * VectorFieldVis.VectorFieldVis_Scale;
    float _91 = fast::min(_90, 10.0);
    float3 _92 = normalize(_86);
    float3 _93 = _92 * _91;
    float _94 = _81.x;
    float _95 = _81.y;
    float _96 = _81.z;
    float4 _97 = float4(_94, _95, _96, 1.0);
    float4 _100 = VectorFieldVis.VectorFieldVis_VolumeToWorld * _97;
    float3 _101 = _100.xyz;
    float3 _102 = _101 - View.View_WorldCameraOrigin;
    float _103 = _93.x;
    float _104 = _93.y;
    float _105 = _93.z;
    float4 _106 = float4(_103, _104, _105, 0.0);
    float4 _109 = VectorFieldVis.VectorFieldVis_VolumeToWorldNoScale * _106;
    float3 _110 = _109.xyz;
    float _111 = float((gl_VertexIndex - gl_BaseVertex));
    float3 _112 = _110 * _111;
    float3 _113 = _102 + _112;
    float _114 = _113.x;
    float _115 = _113.y;
    float _116 = _113.z;
    float4 _117 = float4(_114, _115, _116, 1.0);
    float4 _118 = float4(_117.x, _117.y, _117.z, _117.w);
    float4 _124 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _118;
    out.out_var_TEXCOORD0 = float2(0.0);
    out.out_var_TEXCOORD7 = _117.xyz;
    out.out_var_TEXCOORD6 = _124;
    out.out_var_TEXCOORD8 = float3(0.0, 0.0, 1.0);
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _124;
    return out;
}

