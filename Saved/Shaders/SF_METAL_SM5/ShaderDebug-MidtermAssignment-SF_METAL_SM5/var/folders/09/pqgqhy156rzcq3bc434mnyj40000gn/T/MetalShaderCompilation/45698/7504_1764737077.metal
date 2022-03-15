

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

constant float3x3 _65 = {};
constant float4 _66 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001d50_692fc035(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _82 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _83 = 3u * _82;
    float4 _85 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_83));
    uint _86 = _83 + 1u;
    float4 _87 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_86));
    uint _88 = _83 + 2u;
    float4 _89 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_88));
    float4 _91 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_82));
    uint _92 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _97 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_92 + 1u)));
    float _98 = _97.w;
    float3 _99 = _97.xyz;
    float3 _101 = cross(_99, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_92)).xyz) * _98;
    float3x3 _104 = _65;
    _104[0] = cross(_101, _99) * _98;
    float3x3 _105 = _104;
    _105[1] = _101;
    float3x3 _106 = _105;
    _106[2] = _99;
    float3x3 _120 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_85.xyz, _87.xyz, _89.xyz);
    float3x3 _123 = _120;
    _123[0] = normalize(_120[0]);
    float3x3 _126 = _123;
    _126[1] = normalize(_120[1]);
    float3x3 _129 = _126;
    _129[2] = normalize(_120[2]);
    float3x3 _130 = _129 * _106;
    float _134 = _85.w;
    float _135 = _134 * 0.00390625;
    float _136 = trunc(_135);
    float _137 = _91.w;
    float4 _138 = _66;
    _138.x = _137;
    float3 _139 = _91.xyz;
    float3 _143 = _139 + _Globals.InstancingOffset.xyz;
    float3 _144 = _143.xxx;
    float3 _145 = Primitive.Primitive_LocalToWorld[0].xyz * _144;
    float3 _146 = _143.yyy;
    float3 _147 = Primitive.Primitive_LocalToWorld[1].xyz * _146;
    float3 _148 = _145 + _147;
    float3 _149 = _143.zzz;
    float3 _150 = Primitive.Primitive_LocalToWorld[2].xyz * _149;
    float3 _151 = _148 + _150;
    float3 _154 = _151 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _165 = _138;
    _165.y = 1.0 - fast::clamp((length(_154 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _168 = _Globals.InstancingFadeOutParams.z * _136;
    float _171 = 1.0 - _136;
    float _172 = _Globals.InstancingFadeOutParams.w * _171;
    float _173 = _168 + _172;
    float _177 = _Globals.InstancingViewZCompareZero.w * _137;
    float3 _181 = _154 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _182 = length(_181);
    float _183 = _182 + _177;
    float3 _187 = _154 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _188 = length(_187);
    float _189 = _188 + _177;
    float3 _190 = float3(_183);
    bool3 _193 = _190 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _194 = select(float3(0.0), float3(1.0), _193);
    float _198 = dot(_194, _Globals.InstancingViewZConstant.xyz);
    float _201 = _198 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _202 = float3(_189);
    bool3 _206 = _202 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _207 = select(float3(0.0), float3(1.0), _206);
    float _208 = dot(_207, _Globals.InstancingViewZConstant.xyz);
    float _211 = _208 * _Globals.InstancingWorldViewOriginOne.w;
    float _212 = _201 + _211;
    float4 _213 = _165;
    _213.w = _212;
    float _214 = abs(_212);
    bool _215 = _214 < 0.999000012874603271484375;
    float _216 = float(_215);
    float _217 = _173 * _216;
    float4 _218 = _213;
    _218.z = _217;
    float _219 = _85.x;
    float _220 = _85.y;
    float _221 = _85.z;
    float4 _222 = float4(_219, _220, _221, 0.0);
    float _223 = _87.x;
    float _224 = _87.y;
    float _225 = _87.z;
    float4 _226 = float4(_223, _224, _225, 0.0);
    float _227 = _89.x;
    float _228 = _89.y;
    float _229 = _89.z;
    float4 _230 = float4(_227, _228, _229, 0.0);
    float _231 = _91.x;
    float _232 = _91.y;
    float _233 = _91.z;
    float4 _234 = float4(_231, _232, _233, 1.0);
    float4x4 _235 = float4x4(_222, _226, _230, _234);
    float4 _236 = _235 * in.in_var_ATTRIBUTE0;
    float3 _237 = _236.xxx;
    float3 _238 = Primitive.Primitive_LocalToWorld[0].xyz * _237;
    float3 _239 = _236.yyy;
    float3 _240 = Primitive.Primitive_LocalToWorld[1].xyz * _239;
    float3 _241 = _238 + _240;
    float3 _242 = _236.zzz;
    float3 _243 = Primitive.Primitive_LocalToWorld[2].xyz * _242;
    float3 _244 = _241 + _243;
    float3 _245 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _246 = _244 + _245;
    float _247 = _246.x;
    float _248 = _246.y;
    float _249 = _246.z;
    float4 _250 = float4(_247, _248, _249, 1.0);
    float4 _251 = _250 * _217;
    float4 _252 = float4(_251.x, _251.y, _251.z, _251.w);
    float4 _253 = View.View_TranslatedWorldToClip * _252;
    out.out_var_TEXCOORD10_centroid = float4(_130[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_130[2], _98 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _218;
    out.gl_Position = _253;
    return out;
}

