

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
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
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

constant float3x3 _69 = {};
constant float4 _70 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR1 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001b38_5b8a58fa(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _92 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _93 = 3u * _92;
    float4 _95 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_93));
    float4 _97 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_93 + 1u)));
    float4 _99 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_93 + 2u)));
    float4 _101 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_92));
    uint _102 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _107 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_102 + 1u)));
    float _108 = _107.w;
    float3 _109 = _107.xyz;
    float3 _111 = cross(_109, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_102)).xyz) * _108;
    float3x3 _114 = _69;
    _114[0] = cross(_111, _109) * _108;
    float3x3 _115 = _114;
    _115[1] = _111;
    float3x3 _116 = _115;
    _116[2] = _109;
    float3x3 _130 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_95.xyz, _97.xyz, _99.xyz);
    float3x3 _133 = _130;
    _133[0] = normalize(_130[0]);
    float3x3 _136 = _133;
    _136[1] = normalize(_130[1]);
    float3x3 _139 = _136;
    _139[2] = normalize(_130[2]);
    float3x3 _140 = _139 * _116;
    float _146 = trunc(_95.w * 0.00390625);
    float _147 = _101.w;
    float4 _148 = _70;
    _148.x = _147;
    float3 _153 = _101.xyz + _Globals.InstancingOffset.xyz;
    float3 _164 = (((Primitive.Primitive_LocalToWorld[0].xyz * _153.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _153.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _153.zzz)) + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _175 = _148;
    _175.y = 1.0 - fast::clamp((length(_164 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _187 = _Globals.InstancingViewZCompareZero.w * _147;
    float _222 = (dot(select(float3(0.0), float3(1.0), float3(length(_164 - _Globals.InstancingWorldViewOriginZero.xyz) + _187) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginZero.w) + (dot(select(float3(0.0), float3(1.0), float3(length(_164 - _Globals.InstancingWorldViewOriginOne.xyz) + _187) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginOne.w);
    float4 _223 = _175;
    _223.w = _222;
    float _227 = ((_Globals.InstancingFadeOutParams.z * _146) + (_Globals.InstancingFadeOutParams.w * (1.0 - _146))) * float(abs(_222) < 0.999000012874603271484375);
    float4 _228 = _223;
    _228.z = _227;
    float4 _246 = float4x4(float4(_95.xyz, 0.0), float4(_97.xyz, 0.0), float4(_99.xyz, 0.0), float4(_101.xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4x4 _277 = Primitive.Primitive_PreviousLocalToWorld;
    _277[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _281 = _277;
    _281[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _285 = _281;
    _285[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _296 = View.View_TranslatedWorldToClip * float4((float4((((Primitive.Primitive_LocalToWorld[0].xyz * _246.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _246.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _246.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * _227).xyz, 1.0);
    float4 _303 = _296;
    _303.z = _296.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _296.w) : 0.0);
    out.gl_Position = _303;
    out.out_var_TEXCOORD6 = _296;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_285 * _246).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_140[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_140[2], _108 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _228;
    return out;
}

