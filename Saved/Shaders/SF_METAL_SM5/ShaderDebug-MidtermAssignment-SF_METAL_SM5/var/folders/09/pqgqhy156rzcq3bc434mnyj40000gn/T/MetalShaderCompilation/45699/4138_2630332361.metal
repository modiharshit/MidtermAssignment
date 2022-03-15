

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_MeshParticleVF
{
    char _m0_pad[24];
    uint MeshParticleVF_PrevTransformAvailable;
};

constant float _69 = {};
constant float4 _70 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex MainVertexShader_out Main_0000102a_9cc7afc9(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_MeshParticleVF& MeshParticleVF [[buffer(3)]], texture_buffer<float> PrevTransformBuffer [[texture(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    float4x4 _88 = transpose(float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0)));
    float3 _91 = (_88 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation;
    float _92 = _91.x;
    float4 _95 = _70;
    _95.w = 0.0;
    float3x3 _97 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _97[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _100 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _101 = _97;
    _101[1] = _100;
    float3x3 _104 = _101;
    _104[0] = cross(_100, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _112 = float3x3(_88[0].xyz, _88[1].xyz, _88[2].xyz) * _104;
    float3 _114 = normalize(_112[0]);
    float4 _150;
    switch (0u)
    {
        default:
        {
            if (MeshParticleVF.MeshParticleVF_PrevTransformAvailable > 0u)
            {
                uint _134 = (gl_InstanceIndex - gl_BaseInstance) * 3u;
                _150 = float4((transpose(float4x4(PrevTransformBuffer.read(uint(_134)), PrevTransformBuffer.read(uint((_134 + 1u))), PrevTransformBuffer.read(uint((_134 + 2u))), float4(0.0, 0.0, 0.0, 1.0))) * in.in_var_ATTRIBUTE0).xyz + View.View_PrevPreViewTranslation, _69);
                break;
            }
            else
            {
                _150 = float4(_92, _91.yz, _69);
                break;
            }
        }
    }
    float4 _157 = View.View_TranslatedWorldToClip * float4(_92, _91.yz, 1.0);
    float4 _166 = _157;
    _166.z = _157.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _157.w) : 0.0);
    out.gl_Position = _166;
    out.out_var_TEXCOORD6 = _157;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_150.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_114.x, _114.y, _114.z, _95.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_112[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

