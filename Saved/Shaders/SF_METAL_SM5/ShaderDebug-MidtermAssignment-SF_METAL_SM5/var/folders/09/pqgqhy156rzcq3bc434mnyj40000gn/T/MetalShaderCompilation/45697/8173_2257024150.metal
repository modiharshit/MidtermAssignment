

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
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

constant float3x3 _71 = {};
constant float4 _72 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 out_var_HIT_PROXY_ID [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001fed_86877496(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _86 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _96 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _97 = 3u * _96;
    float4 _99 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_97));
    uint _100 = _97 + 1u;
    float4 _101 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_100));
    uint _102 = _97 + 2u;
    float4 _103 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_102));
    float4 _105 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_96));
    uint _106 = 2u * _86;
    float4 _111 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_106 + 1u)));
    float _112 = _111.w;
    float3 _113 = _111.xyz;
    float3 _115 = cross(_113, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_106)).xyz) * _112;
    float3x3 _118 = _71;
    _118[0] = cross(_115, _113) * _112;
    float3x3 _119 = _118;
    _119[1] = _115;
    float3x3 _120 = _119;
    _120[2] = _113;
    float3x3 _134 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_99.xyz, _101.xyz, _103.xyz);
    float3x3 _137 = _134;
    _137[0] = normalize(_134[0]);
    float3x3 _140 = _137;
    _140[1] = normalize(_134[1]);
    float3x3 _143 = _140;
    _143[2] = normalize(_134[2]);
    float3x3 _144 = _143 * _120;
    float _148 = _99.w;
    float _149 = _148 * 0.00390625;
    float _150 = trunc(_149);
    float _151 = _105.w;
    float4 _152 = _72;
    _152.x = _151;
    float3 _153 = _105.xyz;
    float3 _157 = _153 + _Globals.InstancingOffset.xyz;
    float3 _158 = _157.xxx;
    float3 _159 = Primitive.Primitive_LocalToWorld[0].xyz * _158;
    float3 _160 = _157.yyy;
    float3 _161 = Primitive.Primitive_LocalToWorld[1].xyz * _160;
    float3 _162 = _159 + _161;
    float3 _163 = _157.zzz;
    float3 _164 = Primitive.Primitive_LocalToWorld[2].xyz * _163;
    float3 _165 = _162 + _164;
    float3 _168 = _165 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _179 = _152;
    _179.y = 1.0 - fast::clamp((length(_168 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _182 = _Globals.InstancingFadeOutParams.z * _150;
    float _185 = 1.0 - _150;
    float _186 = _Globals.InstancingFadeOutParams.w * _185;
    float _187 = _182 + _186;
    float _191 = _Globals.InstancingViewZCompareZero.w * _151;
    float3 _195 = _168 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _196 = length(_195);
    float _197 = _196 + _191;
    float3 _201 = _168 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _202 = length(_201);
    float _203 = _202 + _191;
    float3 _204 = float3(_197);
    bool3 _207 = _204 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _208 = select(float3(0.0), float3(1.0), _207);
    float _212 = dot(_208, _Globals.InstancingViewZConstant.xyz);
    float _215 = _212 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _216 = float3(_203);
    bool3 _220 = _216 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _221 = select(float3(0.0), float3(1.0), _220);
    float _222 = dot(_221, _Globals.InstancingViewZConstant.xyz);
    float _225 = _222 * _Globals.InstancingWorldViewOriginOne.w;
    float _226 = _215 + _225;
    float4 _227 = _179;
    _227.w = _226;
    float _228 = abs(_226);
    bool _229 = _228 < 0.999000012874603271484375;
    float _230 = float(_229);
    float _231 = _187 * _230;
    float4 _232 = _227;
    _232.z = _231;
    float _233 = _99.x;
    float _234 = _99.y;
    float _235 = _99.z;
    float4 _236 = float4(_233, _234, _235, 0.0);
    float _237 = _101.x;
    float _238 = _101.y;
    float _239 = _101.z;
    float4 _240 = float4(_237, _238, _239, 0.0);
    float _241 = _103.x;
    float _242 = _103.y;
    float _243 = _103.z;
    float4 _244 = float4(_241, _242, _243, 0.0);
    float _245 = _105.x;
    float _246 = _105.y;
    float _247 = _105.z;
    float4 _248 = float4(_245, _246, _247, 1.0);
    float4x4 _249 = float4x4(_236, _240, _244, _248);
    float4 _250 = _249 * in.in_var_ATTRIBUTE0;
    float3 _251 = _250.xxx;
    float3 _252 = Primitive.Primitive_LocalToWorld[0].xyz * _251;
    float3 _253 = _250.yyy;
    float3 _254 = Primitive.Primitive_LocalToWorld[1].xyz * _253;
    float3 _255 = _252 + _254;
    float3 _256 = _250.zzz;
    float3 _257 = Primitive.Primitive_LocalToWorld[2].xyz * _256;
    float3 _258 = _255 + _257;
    float3 _259 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _260 = _258 + _259;
    float _261 = _260.x;
    float _262 = _260.y;
    float _263 = _260.z;
    float4 _264 = float4(_261, _262, _263, 1.0);
    float4 _265 = _264 * _231;
    float4 _266 = float4(_265.x, _265.y, _265.z, _265.w);
    float4 _275 = View.View_TranslatedWorldToClip * _266;
    out.out_var_TEXCOORD10_centroid = float4(_144[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_144[2], _112 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_86 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _232;
    out.out_var_HIT_PROXY_ID = float4((_148 - (256.0 * _150)) * 0.0039215688593685626983642578125, _101.w * 0.0039215688593685626983642578125, _103.w * 0.0039215688593685626983642578125, 0.0);
    out.out_var_TEXCOORD6 = _266;
    out.gl_Position = _275;
    return out;
}

