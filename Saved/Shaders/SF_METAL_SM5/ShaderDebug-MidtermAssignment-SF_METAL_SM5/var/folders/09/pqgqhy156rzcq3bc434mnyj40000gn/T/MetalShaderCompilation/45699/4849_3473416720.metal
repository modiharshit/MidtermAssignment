

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
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_000012f1_cf082210(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    PositionOnlyMain_out out = {};
    uint _69 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _70 = 3u * _69;
    uint _73 = _70 + 1u;
    uint _75 = _70 + 2u;
    float4 _96 = float4x4(float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_70)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_73)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_75)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_69)).xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _120 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _96.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _96.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _96.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _146 = float4x4(float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_70)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_73)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_75)).xyz, 0.0), float4(InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_69)).xyz, 1.0)) * float4(in.in_var_ATTRIBUTE2.xyz, 0.0);
    float4 _167 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * _120;
    float4 _178;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_167.z < 0.0))
    {
        float4 _176 = _167;
        _176.z = 9.9999999747524270787835121154785e-07;
        float4 _177 = _176;
        _177.w = 1.0;
        _178 = _177;
    }
    else
    {
        _178 = _167;
    }
    float _184 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _146.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _146.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _146.zzz)));
    float4 _209 = _178;
    _209.z = ((_178.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_184) > 0.0) ? (sqrt(fast::clamp(1.0 - (_184 * _184), 0.0, 1.0)) / _184) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _178.w;
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_COLOR1 = float4(0.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _120.xyz;
    out.gl_Position = _209;
    return out;
}

