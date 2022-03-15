

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

constant float3x3 _66 = {};
constant float4 _67 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00001e00_0ca1c9f3(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _83 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _84 = 3u * _83;
    float4 _86 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_84));
    uint _87 = _84 + 1u;
    float4 _88 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_87));
    uint _89 = _84 + 2u;
    float4 _90 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_89));
    float4 _92 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_83));
    uint _93 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _98 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_93 + 1u)));
    float _99 = _98.w;
    float3 _100 = _98.xyz;
    float3 _102 = cross(_100, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_93)).xyz) * _99;
    float3x3 _105 = _66;
    _105[0] = cross(_102, _100) * _99;
    float3x3 _106 = _105;
    _106[1] = _102;
    float3x3 _107 = _106;
    _107[2] = _100;
    float3x3 _121 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_86.xyz, _88.xyz, _90.xyz);
    float3x3 _124 = _121;
    _124[0] = normalize(_121[0]);
    float3x3 _127 = _124;
    _127[1] = normalize(_121[1]);
    float3x3 _130 = _127;
    _130[2] = normalize(_121[2]);
    float3x3 _131 = _130 * _107;
    float _135 = _86.w;
    float _136 = _135 * 0.00390625;
    float _137 = trunc(_136);
    float _138 = _92.w;
    float4 _139 = _67;
    _139.x = _138;
    float3 _140 = _92.xyz;
    float3 _144 = _140 + _Globals.InstancingOffset.xyz;
    float3 _145 = _144.xxx;
    float3 _146 = Primitive.Primitive_LocalToWorld[0].xyz * _145;
    float3 _147 = _144.yyy;
    float3 _148 = Primitive.Primitive_LocalToWorld[1].xyz * _147;
    float3 _149 = _146 + _148;
    float3 _150 = _144.zzz;
    float3 _151 = Primitive.Primitive_LocalToWorld[2].xyz * _150;
    float3 _152 = _149 + _151;
    float3 _155 = _152 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _166 = _139;
    _166.y = 1.0 - fast::clamp((length(_155 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _169 = _Globals.InstancingFadeOutParams.z * _137;
    float _172 = 1.0 - _137;
    float _173 = _Globals.InstancingFadeOutParams.w * _172;
    float _174 = _169 + _173;
    float _178 = _Globals.InstancingViewZCompareZero.w * _138;
    float3 _182 = _155 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _183 = length(_182);
    float _184 = _183 + _178;
    float3 _188 = _155 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _189 = length(_188);
    float _190 = _189 + _178;
    float3 _191 = float3(_184);
    bool3 _194 = _191 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _195 = select(float3(0.0), float3(1.0), _194);
    float _199 = dot(_195, _Globals.InstancingViewZConstant.xyz);
    float _202 = _199 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _203 = float3(_190);
    bool3 _207 = _203 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _208 = select(float3(0.0), float3(1.0), _207);
    float _209 = dot(_208, _Globals.InstancingViewZConstant.xyz);
    float _212 = _209 * _Globals.InstancingWorldViewOriginOne.w;
    float _213 = _202 + _212;
    float4 _214 = _166;
    _214.w = _213;
    float _215 = abs(_213);
    bool _216 = _215 < 0.999000012874603271484375;
    float _217 = float(_216);
    float _218 = _174 * _217;
    float4 _219 = _214;
    _219.z = _218;
    float _220 = _86.x;
    float _221 = _86.y;
    float _222 = _86.z;
    float4 _223 = float4(_220, _221, _222, 0.0);
    float _224 = _88.x;
    float _225 = _88.y;
    float _226 = _88.z;
    float4 _227 = float4(_224, _225, _226, 0.0);
    float _228 = _90.x;
    float _229 = _90.y;
    float _230 = _90.z;
    float4 _231 = float4(_228, _229, _230, 0.0);
    float _232 = _92.x;
    float _233 = _92.y;
    float _234 = _92.z;
    float4 _235 = float4(_232, _233, _234, 1.0);
    float4x4 _236 = float4x4(_223, _227, _231, _235);
    float4 _237 = _236 * in.in_var_ATTRIBUTE0;
    float3 _238 = _237.xxx;
    float3 _239 = Primitive.Primitive_LocalToWorld[0].xyz * _238;
    float3 _240 = _237.yyy;
    float3 _241 = Primitive.Primitive_LocalToWorld[1].xyz * _240;
    float3 _242 = _239 + _241;
    float3 _243 = _237.zzz;
    float3 _244 = Primitive.Primitive_LocalToWorld[2].xyz * _243;
    float3 _245 = _242 + _244;
    float3 _246 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _247 = _245 + _246;
    float _248 = _247.x;
    float _249 = _247.y;
    float _250 = _247.z;
    float4 _251 = float4(_248, _249, _250, 1.0);
    float4 _252 = _251 * _218;
    float4 _253 = float4(_252.x, _252.y, _252.z, _252.w);
    float4 _254 = View.View_TranslatedWorldToClip * _253;
    out.out_var_TEXCOORD10_centroid = float4(_131[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_131[2], _99 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _219;
    out.out_var_TEXCOORD6 = _253;
    out.gl_Position = _254;
    return out;
}

