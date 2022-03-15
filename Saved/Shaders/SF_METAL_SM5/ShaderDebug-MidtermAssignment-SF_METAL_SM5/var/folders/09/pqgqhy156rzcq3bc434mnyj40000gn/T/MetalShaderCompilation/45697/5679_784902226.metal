

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
    uint InputWeightIndexSize;
};

constant float3x3 _68 = {};
constant float4 _69 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_0000162f_2ec8a852(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _83 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _86 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _92 = int(_86 + (_Globals.InputWeightIndexSize * uint(_83)));
    float3x4 _94;
    _94 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _95;
    for (int _97 = 0; _97 < _83; _94 = _95, _97++)
    {
        int _105 = int(_86 + (_Globals.InputWeightIndexSize * uint(_97)));
        int _110 = int(InputWeightStream.read(uint(uint(_105))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _129 = float4(float(InputWeightStream.read(uint(uint(_92 + _97))).x) * 0.0039215688593685626983642578125);
            int _130 = int((InputWeightStream.read(uint(uint(_105 + 1))).x << 8u) | uint(_110)) * 3;
            _95 = float3x4(_94[0] + (_129 * BoneMatrices.read(uint(uint(_130)))), _94[1] + (_129 * BoneMatrices.read(uint(uint(_130 + 1)))), _94[2] + (_129 * BoneMatrices.read(uint(uint(_130 + 2)))));
        }
        else
        {
            float4 _156 = float4(float(InputWeightStream.read(uint(uint(_92 + _97))).x) * 0.0039215688593685626983642578125);
            int _157 = _110 * 3;
            _95 = float3x4(_94[0] + (_156 * BoneMatrices.read(uint(uint(_157)))), _94[1] + (_156 * BoneMatrices.read(uint(uint(_157 + 1)))), _94[2] + (_156 * BoneMatrices.read(uint(uint(_157 + 2)))));
        }
    }
    float3 _179 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _180 = _179.xyz;
    float3 _190 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_180 * dot(in.in_var_ATTRIBUTE1, _180))), 0.0) * _94);
    float3x3 _191 = _68;
    _191[0] = _190;
    float3 _197 = normalize(float4(_179, 0.0) * _94);
    float3x3 _198 = _191;
    _198[2] = _197;
    float3x3 _203 = _198;
    _203[1] = normalize(cross(_197, _190) * in.in_var_ATTRIBUTE2.w);
    float3 _204 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _205 = _204 + in.in_var_ATTRIBUTE11;
    float _206 = _205.x;
    float _207 = _205.y;
    float _208 = _205.z;
    float4 _209 = float4(_206, _207, _208, 1.0);
    float3 _210 = _209 * _94;
    float3 _211 = _210 + in.in_var_ATTRIBUTE12;
    float3 _216 = _211.xxx;
    float3 _217 = Primitive.Primitive_LocalToWorld[0u].xyz * _216;
    float3 _221 = _211.yyy;
    float3 _222 = Primitive.Primitive_LocalToWorld[1u].xyz * _221;
    float3 _223 = _217 + _222;
    float3 _227 = _211.zzz;
    float3 _228 = Primitive.Primitive_LocalToWorld[2u].xyz * _227;
    float3 _229 = _223 + _228;
    float3 _233 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _234 = _229 + _233;
    float _235 = _234.x;
    float _236 = _234.y;
    float _237 = _234.z;
    float4 _238 = float4(_235, _236, _237, 1.0);
    float4 _239 = float4(_238.x, _238.y, _238.z, _238.w);
    float4 _242 = View.View_TranslatedWorldToClip * _239;
    float4 _243 = _69;
    _243.w = 0.0;
    float3x3 _256 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _256[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _259 = _256;
    _259[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _262 = _259;
    _262[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _263 = _262 * _203;
    float3 _264 = _263[0];
    out.out_var_TEXCOORD10_centroid = float4(_264.x, _264.y, _264.z, _243.w);
    out.out_var_TEXCOORD11_centroid = float4(_263[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _239;
    out.gl_Position = _242;
    return out;
}

