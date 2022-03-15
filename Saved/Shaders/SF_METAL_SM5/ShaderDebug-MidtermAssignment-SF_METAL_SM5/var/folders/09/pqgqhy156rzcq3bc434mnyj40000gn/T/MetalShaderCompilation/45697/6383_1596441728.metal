

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

struct type_Globals
{
    uint NumBoneInfluencesParam;
};

constant float3x3 _61 = {};
constant float4 _62 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000018ef_5f27c480(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _77 = float4(in.in_var_ATTRIBUTE4.x);
    int _80 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _94 = float4(in.in_var_ATTRIBUTE4.y);
    int _97 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _113 = float4(in.in_var_ATTRIBUTE4.z);
    int _116 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _132 = float4(in.in_var_ATTRIBUTE4.w);
    int _135 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _147 = (((_77 * BoneMatrices.read(uint(uint(_80)))) + (_94 * BoneMatrices.read(uint(uint(_97))))) + (_113 * BoneMatrices.read(uint(uint(_116))))) + (_132 * BoneMatrices.read(uint(uint(_135))));
    float4 _148 = (((_77 * BoneMatrices.read(uint(uint(_80 + 1)))) + (_94 * BoneMatrices.read(uint(uint(_97 + 1))))) + (_113 * BoneMatrices.read(uint(uint(_116 + 1))))) + (_132 * BoneMatrices.read(uint(uint(_135 + 1))));
    float4 _149 = (((_77 * BoneMatrices.read(uint(uint(_80 + 2)))) + (_94 * BoneMatrices.read(uint(uint(_97 + 2))))) + (_113 * BoneMatrices.read(uint(uint(_116 + 2))))) + (_132 * BoneMatrices.read(uint(uint(_135 + 2))));
    float3x4 _233;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _157 = float4(in.in_var_ATTRIBUTE15.x);
        int _160 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _176 = float4(in.in_var_ATTRIBUTE15.y);
        int _179 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _195 = float4(in.in_var_ATTRIBUTE15.z);
        int _198 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _214 = float4(in.in_var_ATTRIBUTE15.w);
        int _217 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _233 = float3x4((((_147 + (_157 * BoneMatrices.read(uint(uint(_160))))) + (_176 * BoneMatrices.read(uint(uint(_179))))) + (_195 * BoneMatrices.read(uint(uint(_198))))) + (_214 * BoneMatrices.read(uint(uint(_217)))), (((_148 + (_157 * BoneMatrices.read(uint(uint(_160 + 1))))) + (_176 * BoneMatrices.read(uint(uint(_179 + 1))))) + (_195 * BoneMatrices.read(uint(uint(_198 + 1))))) + (_214 * BoneMatrices.read(uint(uint(_217 + 1)))), (((_149 + (_157 * BoneMatrices.read(uint(uint(_160 + 2))))) + (_176 * BoneMatrices.read(uint(uint(_179 + 2))))) + (_195 * BoneMatrices.read(uint(uint(_198 + 2))))) + (_214 * BoneMatrices.read(uint(uint(_217 + 2)))));
    }
    else
    {
        _233 = float3x4(_147, _148, _149);
    }
    float3 _239 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _233);
    float3x3 _240 = _61;
    _240[0] = _239;
    float3 _246 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _233);
    float3x3 _247 = _240;
    _247[2] = _246;
    float3x3 _252 = _247;
    _252[1] = normalize(cross(_246, _239) * in.in_var_ATTRIBUTE2.w);
    float3 _253 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _254 = _253.x;
    float _255 = _253.y;
    float _256 = _253.z;
    float4 _257 = float4(_254, _255, _256, 1.0);
    float3 _258 = _257 * _233;
    float3 _259 = _258 + in.in_var_ATTRIBUTE12;
    float3 _264 = _259.xxx;
    float3 _265 = Primitive.Primitive_LocalToWorld[0u].xyz * _264;
    float3 _269 = _259.yyy;
    float3 _270 = Primitive.Primitive_LocalToWorld[1u].xyz * _269;
    float3 _271 = _265 + _270;
    float3 _275 = _259.zzz;
    float3 _276 = Primitive.Primitive_LocalToWorld[2u].xyz * _275;
    float3 _277 = _271 + _276;
    float3 _281 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _282 = _277 + _281;
    float _283 = _282.x;
    float _284 = _282.y;
    float _285 = _282.z;
    float4 _286 = float4(_283, _284, _285, 1.0);
    float4 _287 = float4(_286.x, _286.y, _286.z, _286.w);
    float4 _290 = View.View_TranslatedWorldToClip * _287;
    float4 _291 = _62;
    _291.w = 0.0;
    float3x3 _304 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _304[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _307 = _304;
    _307[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _310 = _307;
    _310[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _311 = _310 * _252;
    float3 _312 = _311[0];
    out.out_var_TEXCOORD10_centroid = float4(_312.x, _312.y, _312.z, _291.w);
    out.out_var_TEXCOORD11_centroid = float4(_311[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _287;
    out.gl_Position = _290;
    return out;
}

