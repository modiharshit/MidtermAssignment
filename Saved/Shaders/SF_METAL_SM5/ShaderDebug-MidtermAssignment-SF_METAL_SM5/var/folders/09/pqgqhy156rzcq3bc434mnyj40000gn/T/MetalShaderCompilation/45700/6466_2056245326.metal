

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
    float4 out_var_COLOR0 [[user(locn2)]];
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
    float4 in_var_ATTRIBUTE13 [[attribute(13)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00001942_7a8fd04e(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _80 = float4(in.in_var_ATTRIBUTE4.x);
    int _83 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _97 = float4(in.in_var_ATTRIBUTE4.y);
    int _100 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _116 = float4(in.in_var_ATTRIBUTE4.z);
    int _119 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _135 = float4(in.in_var_ATTRIBUTE4.w);
    int _138 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _150 = (((_80 * BoneMatrices.read(uint(uint(_83)))) + (_97 * BoneMatrices.read(uint(uint(_100))))) + (_116 * BoneMatrices.read(uint(uint(_119))))) + (_135 * BoneMatrices.read(uint(uint(_138))));
    float4 _151 = (((_80 * BoneMatrices.read(uint(uint(_83 + 1)))) + (_97 * BoneMatrices.read(uint(uint(_100 + 1))))) + (_116 * BoneMatrices.read(uint(uint(_119 + 1))))) + (_135 * BoneMatrices.read(uint(uint(_138 + 1))));
    float4 _152 = (((_80 * BoneMatrices.read(uint(uint(_83 + 2)))) + (_97 * BoneMatrices.read(uint(uint(_100 + 2))))) + (_116 * BoneMatrices.read(uint(uint(_119 + 2))))) + (_135 * BoneMatrices.read(uint(uint(_138 + 2))));
    float3x4 _236;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _160 = float4(in.in_var_ATTRIBUTE15.x);
        int _163 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _179 = float4(in.in_var_ATTRIBUTE15.y);
        int _182 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _198 = float4(in.in_var_ATTRIBUTE15.z);
        int _201 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _217 = float4(in.in_var_ATTRIBUTE15.w);
        int _220 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _236 = float3x4((((_150 + (_160 * BoneMatrices.read(uint(uint(_163))))) + (_179 * BoneMatrices.read(uint(uint(_182))))) + (_198 * BoneMatrices.read(uint(uint(_201))))) + (_217 * BoneMatrices.read(uint(uint(_220)))), (((_151 + (_160 * BoneMatrices.read(uint(uint(_163 + 1))))) + (_179 * BoneMatrices.read(uint(uint(_182 + 1))))) + (_198 * BoneMatrices.read(uint(uint(_201 + 1))))) + (_217 * BoneMatrices.read(uint(uint(_220 + 1)))), (((_152 + (_160 * BoneMatrices.read(uint(uint(_163 + 2))))) + (_179 * BoneMatrices.read(uint(uint(_182 + 2))))) + (_198 * BoneMatrices.read(uint(uint(_201 + 2))))) + (_217 * BoneMatrices.read(uint(uint(_220 + 2)))));
    }
    else
    {
        _236 = float3x4(_150, _151, _152);
    }
    float3 _242 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _236);
    float3x3 _243 = _61;
    _243[0] = _242;
    float3 _249 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _236);
    float3x3 _250 = _243;
    _250[2] = _249;
    float3x3 _255 = _250;
    _255[1] = normalize(cross(_249, _242) * in.in_var_ATTRIBUTE2.w);
    float3 _256 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _257 = _256.x;
    float _258 = _256.y;
    float _259 = _256.z;
    float4 _260 = float4(_257, _258, _259, 1.0);
    float3 _261 = _260 * _236;
    float3 _262 = _261 + in.in_var_ATTRIBUTE12;
    float3 _267 = _262.xxx;
    float3 _268 = Primitive.Primitive_LocalToWorld[0u].xyz * _267;
    float3 _272 = _262.yyy;
    float3 _273 = Primitive.Primitive_LocalToWorld[1u].xyz * _272;
    float3 _274 = _268 + _273;
    float3 _278 = _262.zzz;
    float3 _279 = Primitive.Primitive_LocalToWorld[2u].xyz * _278;
    float3 _280 = _274 + _279;
    float3 _284 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _285 = _280 + _284;
    float _286 = _285.x;
    float _287 = _285.y;
    float _288 = _285.z;
    float4 _289 = float4(_286, _287, _288, 1.0);
    float4 _290 = float4(_289.x, _289.y, _289.z, _289.w);
    float4 _291 = View.View_TranslatedWorldToClip * _290;
    float4 _292 = _62;
    _292.w = 0.0;
    float3x3 _305 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _305[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _308 = _305;
    _308[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _311 = _308;
    _311[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _312 = _311 * _255;
    float3 _313 = _312[0];
    out.out_var_TEXCOORD10_centroid = float4(_313.x, _313.y, _313.z, _292.w);
    out.out_var_TEXCOORD11_centroid = float4(_312[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR0 = in.in_var_ATTRIBUTE13;
    out.gl_Position = _291;
    return out;
}

