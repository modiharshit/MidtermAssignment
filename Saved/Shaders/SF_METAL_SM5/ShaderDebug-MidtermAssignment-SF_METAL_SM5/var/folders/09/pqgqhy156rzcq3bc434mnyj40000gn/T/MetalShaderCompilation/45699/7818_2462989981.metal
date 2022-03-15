

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
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_HIT_PROXY_ID [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001e8a_92ce3e9d(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _86 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _87 = 3u * _86;
    float4 _89 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_87));
    uint _90 = _87 + 1u;
    float4 _91 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_90));
    uint _92 = _87 + 2u;
    float4 _93 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_92));
    float4 _95 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_86));
    uint _96 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _101 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_96 + 1u)));
    float _102 = _101.w;
    float3 _103 = _101.xyz;
    float3 _105 = cross(_103, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_96)).xyz) * _102;
    float3x3 _108 = _68;
    _108[0] = cross(_105, _103) * _102;
    float3x3 _109 = _108;
    _109[1] = _105;
    float3x3 _110 = _109;
    _110[2] = _103;
    float3x3 _124 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_89.xyz, _91.xyz, _93.xyz);
    float3x3 _127 = _124;
    _127[0] = normalize(_124[0]);
    float3x3 _130 = _127;
    _130[1] = normalize(_124[1]);
    float3x3 _133 = _130;
    _133[2] = normalize(_124[2]);
    float3x3 _134 = _133 * _110;
    float _138 = _89.w;
    float _139 = _138 * 0.00390625;
    float _140 = trunc(_139);
    float _141 = _95.w;
    float4 _142 = _69;
    _142.x = _141;
    float3 _143 = _95.xyz;
    float3 _147 = _143 + _Globals.InstancingOffset.xyz;
    float3 _148 = _147.xxx;
    float3 _149 = Primitive.Primitive_LocalToWorld[0].xyz * _148;
    float3 _150 = _147.yyy;
    float3 _151 = Primitive.Primitive_LocalToWorld[1].xyz * _150;
    float3 _152 = _149 + _151;
    float3 _153 = _147.zzz;
    float3 _154 = Primitive.Primitive_LocalToWorld[2].xyz * _153;
    float3 _155 = _152 + _154;
    float3 _158 = _155 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _169 = _142;
    _169.y = 1.0 - fast::clamp((length(_158 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _172 = _Globals.InstancingFadeOutParams.z * _140;
    float _175 = 1.0 - _140;
    float _176 = _Globals.InstancingFadeOutParams.w * _175;
    float _177 = _172 + _176;
    float _181 = _Globals.InstancingViewZCompareZero.w * _141;
    float3 _185 = _158 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _186 = length(_185);
    float _187 = _186 + _181;
    float3 _191 = _158 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _192 = length(_191);
    float _193 = _192 + _181;
    float3 _194 = float3(_187);
    bool3 _197 = _194 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _198 = select(float3(0.0), float3(1.0), _197);
    float _202 = dot(_198, _Globals.InstancingViewZConstant.xyz);
    float _205 = _202 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _206 = float3(_193);
    bool3 _210 = _206 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _211 = select(float3(0.0), float3(1.0), _210);
    float _212 = dot(_211, _Globals.InstancingViewZConstant.xyz);
    float _215 = _212 * _Globals.InstancingWorldViewOriginOne.w;
    float _216 = _205 + _215;
    float4 _217 = _169;
    _217.w = _216;
    float _218 = abs(_216);
    bool _219 = _218 < 0.999000012874603271484375;
    float _220 = float(_219);
    float _221 = _177 * _220;
    float4 _222 = _217;
    _222.z = _221;
    float _223 = _89.x;
    float _224 = _89.y;
    float _225 = _89.z;
    float4 _226 = float4(_223, _224, _225, 0.0);
    float _227 = _91.x;
    float _228 = _91.y;
    float _229 = _91.z;
    float4 _230 = float4(_227, _228, _229, 0.0);
    float _231 = _93.x;
    float _232 = _93.y;
    float _233 = _93.z;
    float4 _234 = float4(_231, _232, _233, 0.0);
    float _235 = _95.x;
    float _236 = _95.y;
    float _237 = _95.z;
    float4 _238 = float4(_235, _236, _237, 1.0);
    float4x4 _239 = float4x4(_226, _230, _234, _238);
    float4 _240 = _239 * in.in_var_ATTRIBUTE0;
    float3 _241 = _240.xxx;
    float3 _242 = Primitive.Primitive_LocalToWorld[0].xyz * _241;
    float3 _243 = _240.yyy;
    float3 _244 = Primitive.Primitive_LocalToWorld[1].xyz * _243;
    float3 _245 = _242 + _244;
    float3 _246 = _240.zzz;
    float3 _247 = Primitive.Primitive_LocalToWorld[2].xyz * _246;
    float3 _248 = _245 + _247;
    float3 _249 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _250 = _248 + _249;
    float _251 = _250.x;
    float _252 = _250.y;
    float _253 = _250.z;
    float4 _254 = float4(_251, _252, _253, 1.0);
    float4 _255 = _254 * _221;
    float4 _256 = float4(_255.x, _255.y, _255.z, _255.w);
    float4 _265 = View.View_TranslatedWorldToClip * _256;
    out.out_var_TEXCOORD10_centroid = float4(_134[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_134[2], _102 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _222;
    out.out_var_HIT_PROXY_ID = float4((_138 - (256.0 * _140)) * 0.0039215688593685626983642578125, _91.w * 0.0039215688593685626983642578125, _93.w * 0.0039215688593685626983642578125, 0.0);
    out.out_var_TEXCOORD6 = _256;
    out.gl_Position = _265;
    return out;
}

