

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

constant float3x3 _68 = {};
constant float4 _69 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_COLOR1 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001ebf_0c6de29b(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _82 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _92 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _93 = 3u * _92;
    float4 _95 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_93));
    uint _96 = _93 + 1u;
    float4 _97 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_96));
    uint _98 = _93 + 2u;
    float4 _99 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_98));
    float4 _101 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_92));
    uint _102 = 2u * _82;
    float4 _107 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_102 + 1u)));
    float _108 = _107.w;
    float3 _109 = _107.xyz;
    float3 _111 = cross(_109, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_102)).xyz) * _108;
    float3x3 _114 = _68;
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
    float _144 = _95.w;
    float _145 = _144 * 0.00390625;
    float _146 = trunc(_145);
    float _147 = _101.w;
    float4 _148 = _69;
    _148.x = _147;
    float3 _149 = _101.xyz;
    float3 _153 = _149 + _Globals.InstancingOffset.xyz;
    float3 _154 = _153.xxx;
    float3 _155 = Primitive.Primitive_LocalToWorld[0].xyz * _154;
    float3 _156 = _153.yyy;
    float3 _157 = Primitive.Primitive_LocalToWorld[1].xyz * _156;
    float3 _158 = _155 + _157;
    float3 _159 = _153.zzz;
    float3 _160 = Primitive.Primitive_LocalToWorld[2].xyz * _159;
    float3 _161 = _158 + _160;
    float3 _164 = _161 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _175 = _148;
    _175.y = 1.0 - fast::clamp((length(_164 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _178 = _Globals.InstancingFadeOutParams.z * _146;
    float _181 = 1.0 - _146;
    float _182 = _Globals.InstancingFadeOutParams.w * _181;
    float _183 = _178 + _182;
    float _187 = _Globals.InstancingViewZCompareZero.w * _147;
    float3 _191 = _164 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _192 = length(_191);
    float _193 = _192 + _187;
    float3 _197 = _164 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _198 = length(_197);
    float _199 = _198 + _187;
    float3 _200 = float3(_193);
    bool3 _203 = _200 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _204 = select(float3(0.0), float3(1.0), _203);
    float _208 = dot(_204, _Globals.InstancingViewZConstant.xyz);
    float _211 = _208 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _212 = float3(_199);
    bool3 _216 = _212 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _217 = select(float3(0.0), float3(1.0), _216);
    float _218 = dot(_217, _Globals.InstancingViewZConstant.xyz);
    float _221 = _218 * _Globals.InstancingWorldViewOriginOne.w;
    float _222 = _211 + _221;
    float4 _223 = _175;
    _223.w = _222;
    float _224 = abs(_222);
    bool _225 = _224 < 0.999000012874603271484375;
    float _226 = float(_225);
    float _227 = _183 * _226;
    float4 _228 = _223;
    _228.z = _227;
    float _229 = _95.x;
    float _230 = _95.y;
    float _231 = _95.z;
    float4 _232 = float4(_229, _230, _231, 0.0);
    float _233 = _97.x;
    float _234 = _97.y;
    float _235 = _97.z;
    float4 _236 = float4(_233, _234, _235, 0.0);
    float _237 = _99.x;
    float _238 = _99.y;
    float _239 = _99.z;
    float4 _240 = float4(_237, _238, _239, 0.0);
    float _241 = _101.x;
    float _242 = _101.y;
    float _243 = _101.z;
    float4 _244 = float4(_241, _242, _243, 1.0);
    float4x4 _245 = float4x4(_232, _236, _240, _244);
    float4 _246 = _245 * in.in_var_ATTRIBUTE0;
    float3 _247 = _246.xxx;
    float3 _248 = Primitive.Primitive_LocalToWorld[0].xyz * _247;
    float3 _249 = _246.yyy;
    float3 _250 = Primitive.Primitive_LocalToWorld[1].xyz * _249;
    float3 _251 = _248 + _250;
    float3 _252 = _246.zzz;
    float3 _253 = Primitive.Primitive_LocalToWorld[2].xyz * _252;
    float3 _254 = _251 + _253;
    float3 _255 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _256 = _254 + _255;
    float _257 = _256.x;
    float _258 = _256.y;
    float _259 = _256.z;
    float4 _260 = float4(_257, _258, _259, 1.0);
    float4 _261 = _260 * _227;
    float4 _262 = float4(_261.x, _261.y, _261.z, _261.w);
    float4 _263 = View.View_TranslatedWorldToClip * _262;
    out.out_var_TEXCOORD10_centroid = float4(_140[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_140[2], _108 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_82 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out.out_var_COLOR1 = _228;
    out.gl_Position = _263;
    return out;
}

