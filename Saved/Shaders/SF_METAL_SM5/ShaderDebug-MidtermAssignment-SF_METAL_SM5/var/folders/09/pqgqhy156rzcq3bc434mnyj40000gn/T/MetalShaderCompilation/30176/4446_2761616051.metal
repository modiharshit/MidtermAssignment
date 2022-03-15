

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_Globals
{
    uint InstanceOffset;
};

struct PositionOnlyMain_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_0000115e_a49aeab3(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    PositionOnlyMain_out out = {};
    uint _63 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _64 = 3u * _63;
    uint _67 = _64 + 1u;
    uint _69 = _64 + 2u;
    float4 _90 = float4x4(float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_64)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_67)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_69)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_63)).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _140 = float4x4(float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_64)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_67)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_69)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_63)).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _161 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4((((Primitive.Primitive_LocalToWorld[0].xyz * _90.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _90.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _90.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _172;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_161.z < 0.0))
    {
        float4 _170 = _161;
        _170.z = 9.9999999747524270787835121154785e-07;
        float4 _171 = _170;
        _171.w = 1.0;
        _172 = _171;
    }
    else
    {
        _172 = _161;
    }
    float _178 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _140.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _140.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _140.zzz)));
    float4 _203 = _172;
    _203.z = ((_172.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_178) > 0.0) ? (sqrt(fast::clamp(1.0 - (_178 * _178), 0.0, 1.0)) / _178) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _172.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _203;
    return out;
}

