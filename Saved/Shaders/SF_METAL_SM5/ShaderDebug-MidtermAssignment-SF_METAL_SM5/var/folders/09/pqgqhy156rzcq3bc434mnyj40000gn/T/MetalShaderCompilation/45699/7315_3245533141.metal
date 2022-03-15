

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

constant float3x3 _72 = {};
constant float4 _73 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR0 [[user(locn4)]];
    float4 out_var_COLOR1 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001c93_c172e7d5(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _92 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _102 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _103 = 3u * _102;
    float4 _105 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_103));
    float4 _107 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_103 + 1u)));
    float4 _109 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_103 + 2u)));
    float4 _111 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_102));
    uint _112 = 2u * _92;
    float4 _117 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_112 + 1u)));
    float _118 = _117.w;
    float3 _119 = _117.xyz;
    float3 _121 = cross(_119, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_112)).xyz) * _118;
    float3x3 _124 = _72;
    _124[0] = cross(_121, _119) * _118;
    float3x3 _125 = _124;
    _125[1] = _121;
    float3x3 _126 = _125;
    _126[2] = _119;
    float3x3 _140 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_105.xyz, _107.xyz, _109.xyz);
    float3x3 _143 = _140;
    _143[0] = normalize(_140[0]);
    float3x3 _146 = _143;
    _146[1] = normalize(_140[1]);
    float3x3 _149 = _146;
    _149[2] = normalize(_140[2]);
    float3x3 _150 = _149 * _126;
    float _156 = trunc(_105.w * 0.00390625);
    float _157 = _111.w;
    float4 _158 = _73;
    _158.x = _157;
    float3 _163 = _111.xyz + _Globals.InstancingOffset.xyz;
    float3 _174 = (((Primitive.Primitive_LocalToWorld[0].xyz * _163.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _163.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _163.zzz)) + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _185 = _158;
    _185.y = 1.0 - fast::clamp((length(_174 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _197 = _Globals.InstancingViewZCompareZero.w * _157;
    float _232 = (dot(select(float3(0.0), float3(1.0), float3(length(_174 - _Globals.InstancingWorldViewOriginZero.xyz) + _197) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginZero.w) + (dot(select(float3(0.0), float3(1.0), float3(length(_174 - _Globals.InstancingWorldViewOriginOne.xyz) + _197) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginOne.w);
    float4 _233 = _185;
    _233.w = _232;
    float _237 = ((_Globals.InstancingFadeOutParams.z * _156) + (_Globals.InstancingFadeOutParams.w * (1.0 - _156))) * float(abs(_232) < 0.999000012874603271484375);
    float4 _238 = _233;
    _238.z = _237;
    float4 _256 = float4x4(float4(_105.xyz, 0.0), float4(_107.xyz, 0.0), float4(_109.xyz, 0.0), float4(_111.xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4x4 _287 = Primitive.Primitive_PreviousLocalToWorld;
    _287[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _291 = _287;
    _291[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _295 = _291;
    _295[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _306 = View.View_TranslatedWorldToClip * float4((float4((((Primitive.Primitive_LocalToWorld[0].xyz * _256.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _256.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _256.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * _237).xyz, 1.0);
    float4 _313 = _306;
    _313.z = _306.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _306.w) : 0.0);
    out.gl_Position = _313;
    out.out_var_TEXCOORD6 = _306;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_295 * _256).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_150[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_150[2], _118 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_92 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _238;
    return out;
}

