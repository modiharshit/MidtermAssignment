

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

constant float3x3 _76 = {};
constant float4 _77 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float out_var_TEXCOORD8 [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001c68_59155dcd(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _87 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _88 = 3u * _87;
    float4 _90 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_88));
    float4 _92 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_88 + 1u)));
    float4 _94 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_88 + 2u)));
    float4 _96 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_87));
    uint _101 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _106 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_101 + 1u)));
    float _107 = _106.w;
    float3 _108 = _106.xyz;
    float3 _110 = cross(_108, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_101)).xyz) * _107;
    float3x3 _113 = _76;
    _113[0] = cross(_110, _108) * _107;
    float3x3 _114 = _113;
    _114[1] = _110;
    float3x3 _115 = _114;
    _115[2] = _108;
    float3x3 _129 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_90.xyz, _92.xyz, _94.xyz);
    float3x3 _132 = _129;
    _132[0] = normalize(_129[0]);
    float3x3 _135 = _132;
    _135[1] = normalize(_129[1]);
    float3x3 _138 = _135;
    _138[2] = normalize(_129[2]);
    float3x3 _139 = _138 * _115;
    float _145 = trunc(_90.w * 0.00390625);
    float _146 = _96.w;
    float4 _147 = _77;
    _147.x = _146;
    float3 _152 = _96.xyz + _Globals.InstancingOffset.xyz;
    float3 _163 = (((Primitive.Primitive_LocalToWorld[0].xyz * _152.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _152.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _152.zzz)) + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _174 = _147;
    _174.y = 1.0 - fast::clamp((length(_163 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _186 = _Globals.InstancingViewZCompareZero.w * _146;
    float _221 = (dot(select(float3(0.0), float3(1.0), float3(length(_163 - _Globals.InstancingWorldViewOriginZero.xyz) + _186) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginZero.w) + (dot(select(float3(0.0), float3(1.0), float3(length(_163 - _Globals.InstancingWorldViewOriginOne.xyz) + _186) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginOne.w);
    float4 _222 = _174;
    _222.w = _221;
    float _226 = ((_Globals.InstancingFadeOutParams.z * _145) + (_Globals.InstancingFadeOutParams.w * (1.0 - _145))) * float(abs(_221) < 0.999000012874603271484375);
    float4 _227 = _222;
    _227.z = _226;
    float4 _245 = float4x4(float4(_90.xyz, 0.0), float4(_92.xyz, 0.0), float4(_94.xyz, 0.0), float4(_96.xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _260 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _245.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _245.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _245.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * _226;
    float3 _261 = _139[2];
    float4 _267 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_260.x, _260.y, _260.z, _260.w);
    float4 _278;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_267.z < 0.0))
    {
        float4 _276 = _267;
        _276.z = 9.9999999747524270787835121154785e-07;
        float4 _277 = _276;
        _277.w = 1.0;
        _278 = _277;
    }
    else
    {
        _278 = _267;
    }
    float _284 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _261));
    out.out_var_TEXCOORD10_centroid = float4(_139[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_261, _107 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _227;
    out.out_var_TEXCOORD6 = _278.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_284) > 0.0) ? (sqrt(fast::clamp(1.0 - (_284 * _284), 0.0, 1.0)) / _284) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _260.xyz;
    out.gl_Position = _278;
    return out;
}

