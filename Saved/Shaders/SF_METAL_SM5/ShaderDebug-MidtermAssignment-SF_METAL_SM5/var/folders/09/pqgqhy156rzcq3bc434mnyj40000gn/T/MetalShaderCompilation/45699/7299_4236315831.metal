

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

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct type_Globals
{
    float4 InstancingViewZCompareZero;
    float4 InstancingViewZCompareOne;
    float4 InstancingViewZConstant;
    float4 InstancingWorldViewOriginZero;
    float4 InstancingWorldViewOriginOne;
    float4 InstancingOffset;
    float4 InstancingFadeOutParams;
    uint InstanceOffset;
};

constant float3x3 _73 = {};
constant float4 _74 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001c83_fc810cb7(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _90 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _91 = 3u * _90;
    float4 _93 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_91));
    float4 _95 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_91 + 1u)));
    float4 _97 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_91 + 2u)));
    float4 _99 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_90));
    uint _100 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _105 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_100 + 1u)));
    float _106 = _105.w;
    float3 _107 = _105.xyz;
    float3 _109 = cross(_107, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_100)).xyz) * _106;
    float3x3 _112 = _73;
    _112[0] = cross(_109, _107) * _106;
    float3x3 _113 = _112;
    _113[1] = _109;
    float3x3 _114 = _113;
    _114[2] = _107;
    float3x3 _128 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_93.xyz, _95.xyz, _97.xyz);
    float3x3 _131 = _128;
    _131[0] = normalize(_128[0]);
    float3x3 _134 = _131;
    _134[1] = normalize(_128[1]);
    float3x3 _137 = _134;
    _137[2] = normalize(_128[2]);
    float3x3 _138 = _137 * _114;
    float _144 = trunc(_93.w * 0.00390625);
    float _145 = _99.w;
    float4 _146 = _74;
    _146.x = _145;
    float3 _151 = _99.xyz + _Globals.InstancingOffset.xyz;
    float3 _162 = (((Primitive.Primitive_LocalToWorld[0].xyz * _151.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _151.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _151.zzz)) + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _173 = _146;
    _173.y = 1.0 - fast::clamp((length(_162 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _185 = _Globals.InstancingViewZCompareZero.w * _145;
    float _220 = (dot(select(float3(0.0), float3(1.0), float3(length(_162 - _Globals.InstancingWorldViewOriginZero.xyz) + _185) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginZero.w) + (dot(select(float3(0.0), float3(1.0), float3(length(_162 - _Globals.InstancingWorldViewOriginOne.xyz) + _185) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginOne.w);
    float4 _221 = _173;
    _221.w = _220;
    float _225 = ((_Globals.InstancingFadeOutParams.z * _144) + (_Globals.InstancingFadeOutParams.w * (1.0 - _144))) * float(abs(_220) < 0.999000012874603271484375);
    float4 _226 = _221;
    _226.z = _225;
    float4 _244 = float4x4(float4(_93.xyz, 0.0), float4(_95.xyz, 0.0), float4(_97.xyz, 0.0), float4(_99.xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _259 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _244.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _244.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _244.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * _225;
    float3 _260 = _138[2];
    float4 _266 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_259.x, _259.y, _259.z, _259.w);
    float4 _277;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_266.z < 0.0))
    {
        float4 _275 = _266;
        _275.z = 9.9999999747524270787835121154785e-07;
        float4 _276 = _275;
        _276.w = 1.0;
        _277 = _276;
    }
    else
    {
        _277 = _266;
    }
    float _283 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _260));
    float4 _308 = _277;
    _308.z = ((_277.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_283) > 0.0) ? (sqrt(fast::clamp(1.0 - (_283 * _283), 0.0, 1.0)) / _283) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _277.w;
    out.out_var_TEXCOORD10_centroid = float4(_138[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_260, _106 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _226;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _259.xyz;
    out.gl_Position = _308;
    return out;
}

