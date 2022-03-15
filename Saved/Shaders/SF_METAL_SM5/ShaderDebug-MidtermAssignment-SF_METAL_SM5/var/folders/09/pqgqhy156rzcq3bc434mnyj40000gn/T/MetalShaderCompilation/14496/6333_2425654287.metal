

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

constant float3x3 _60 = {};
constant float4 _61 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
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

vertex Main_out Main_000018bd_90948c0f(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _78 = float4(in.in_var_ATTRIBUTE4.x);
    int _81 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _95 = float4(in.in_var_ATTRIBUTE4.y);
    int _98 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _114 = float4(in.in_var_ATTRIBUTE4.z);
    int _117 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _133 = float4(in.in_var_ATTRIBUTE4.w);
    int _136 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _148 = (((_78 * BoneMatrices.read(uint(uint(_81)))) + (_95 * BoneMatrices.read(uint(uint(_98))))) + (_114 * BoneMatrices.read(uint(uint(_117))))) + (_133 * BoneMatrices.read(uint(uint(_136))));
    float4 _149 = (((_78 * BoneMatrices.read(uint(uint(_81 + 1)))) + (_95 * BoneMatrices.read(uint(uint(_98 + 1))))) + (_114 * BoneMatrices.read(uint(uint(_117 + 1))))) + (_133 * BoneMatrices.read(uint(uint(_136 + 1))));
    float4 _150 = (((_78 * BoneMatrices.read(uint(uint(_81 + 2)))) + (_95 * BoneMatrices.read(uint(uint(_98 + 2))))) + (_114 * BoneMatrices.read(uint(uint(_117 + 2))))) + (_133 * BoneMatrices.read(uint(uint(_136 + 2))));
    float3x4 _234;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _158 = float4(in.in_var_ATTRIBUTE15.x);
        int _161 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _177 = float4(in.in_var_ATTRIBUTE15.y);
        int _180 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _196 = float4(in.in_var_ATTRIBUTE15.z);
        int _199 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _215 = float4(in.in_var_ATTRIBUTE15.w);
        int _218 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _234 = float3x4((((_148 + (_158 * BoneMatrices.read(uint(uint(_161))))) + (_177 * BoneMatrices.read(uint(uint(_180))))) + (_196 * BoneMatrices.read(uint(uint(_199))))) + (_215 * BoneMatrices.read(uint(uint(_218)))), (((_149 + (_158 * BoneMatrices.read(uint(uint(_161 + 1))))) + (_177 * BoneMatrices.read(uint(uint(_180 + 1))))) + (_196 * BoneMatrices.read(uint(uint(_199 + 1))))) + (_215 * BoneMatrices.read(uint(uint(_218 + 1)))), (((_150 + (_158 * BoneMatrices.read(uint(uint(_161 + 2))))) + (_177 * BoneMatrices.read(uint(uint(_180 + 2))))) + (_196 * BoneMatrices.read(uint(uint(_199 + 2))))) + (_215 * BoneMatrices.read(uint(uint(_218 + 2)))));
    }
    else
    {
        _234 = float3x4(_148, _149, _150);
    }
    float3 _240 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _234);
    float3x3 _241 = _60;
    _241[0] = _240;
    float3 _247 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _234);
    float3x3 _248 = _241;
    _248[2] = _247;
    float3x3 _253 = _248;
    _253[1] = normalize(cross(_247, _240) * in.in_var_ATTRIBUTE2.w);
    float3 _254 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _255 = _254.x;
    float _256 = _254.y;
    float _257 = _254.z;
    float4 _258 = float4(_255, _256, _257, 1.0);
    float3 _259 = _258 * _234;
    float3 _260 = _259 + in.in_var_ATTRIBUTE12;
    float3 _265 = _260.xxx;
    float3 _266 = Primitive.Primitive_LocalToWorld[0u].xyz * _265;
    float3 _270 = _260.yyy;
    float3 _271 = Primitive.Primitive_LocalToWorld[1u].xyz * _270;
    float3 _272 = _266 + _271;
    float3 _276 = _260.zzz;
    float3 _277 = Primitive.Primitive_LocalToWorld[2u].xyz * _276;
    float3 _278 = _272 + _277;
    float3 _282 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _283 = _278 + _282;
    float _284 = _283.x;
    float _285 = _283.y;
    float _286 = _283.z;
    float4 _287 = float4(_284, _285, _286, 1.0);
    float4 _288 = float4(_287.x, _287.y, _287.z, _287.w);
    float4 _289 = View.View_TranslatedWorldToClip * _288;
    float4 _290 = _61;
    _290.w = 0.0;
    float3x3 _303 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _303[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _306 = _303;
    _306[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _309 = _306;
    _309[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _310 = _309 * _253;
    float3 _311 = _310[0];
    out.out_var_TEXCOORD10_centroid = float4(_311.x, _311.y, _311.z, _290.w);
    out.out_var_TEXCOORD11_centroid = float4(_310[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _289;
    return out;
}

