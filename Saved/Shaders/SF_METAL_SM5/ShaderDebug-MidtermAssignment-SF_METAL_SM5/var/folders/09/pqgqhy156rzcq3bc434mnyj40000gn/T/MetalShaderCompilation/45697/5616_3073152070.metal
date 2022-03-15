

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

constant float3x3 _67 = {};
constant float4 _68 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_000015f0_b72c9446(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _84 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _87 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _93 = int(_87 + (_Globals.InputWeightIndexSize * uint(_84)));
    float3x4 _95;
    _95 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _96;
    for (int _98 = 0; _98 < _84; _95 = _96, _98++)
    {
        int _106 = int(_87 + (_Globals.InputWeightIndexSize * uint(_98)));
        int _111 = int(InputWeightStream.read(uint(uint(_106))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _130 = float4(float(InputWeightStream.read(uint(uint(_93 + _98))).x) * 0.0039215688593685626983642578125);
            int _131 = int((InputWeightStream.read(uint(uint(_106 + 1))).x << 8u) | uint(_111)) * 3;
            _96 = float3x4(_95[0] + (_130 * BoneMatrices.read(uint(uint(_131)))), _95[1] + (_130 * BoneMatrices.read(uint(uint(_131 + 1)))), _95[2] + (_130 * BoneMatrices.read(uint(uint(_131 + 2)))));
        }
        else
        {
            float4 _157 = float4(float(InputWeightStream.read(uint(uint(_93 + _98))).x) * 0.0039215688593685626983642578125);
            int _158 = _111 * 3;
            _96 = float3x4(_95[0] + (_157 * BoneMatrices.read(uint(uint(_158)))), _95[1] + (_157 * BoneMatrices.read(uint(uint(_158 + 1)))), _95[2] + (_157 * BoneMatrices.read(uint(uint(_158 + 2)))));
        }
    }
    float3 _180 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _181 = _180.xyz;
    float3 _191 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_181 * dot(in.in_var_ATTRIBUTE1, _181))), 0.0) * _95);
    float3x3 _192 = _67;
    _192[0] = _191;
    float3 _198 = normalize(float4(_180, 0.0) * _95);
    float3x3 _199 = _192;
    _199[2] = _198;
    float3x3 _204 = _199;
    _204[1] = normalize(cross(_198, _191) * in.in_var_ATTRIBUTE2.w);
    float3 _205 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _206 = _205 + in.in_var_ATTRIBUTE11;
    float _207 = _206.x;
    float _208 = _206.y;
    float _209 = _206.z;
    float4 _210 = float4(_207, _208, _209, 1.0);
    float3 _211 = _210 * _95;
    float3 _212 = _211 + in.in_var_ATTRIBUTE12;
    float3 _217 = _212.xxx;
    float3 _218 = Primitive.Primitive_LocalToWorld[0u].xyz * _217;
    float3 _222 = _212.yyy;
    float3 _223 = Primitive.Primitive_LocalToWorld[1u].xyz * _222;
    float3 _224 = _218 + _223;
    float3 _228 = _212.zzz;
    float3 _229 = Primitive.Primitive_LocalToWorld[2u].xyz * _228;
    float3 _230 = _224 + _229;
    float3 _234 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _235 = _230 + _234;
    float _236 = _235.x;
    float _237 = _235.y;
    float _238 = _235.z;
    float4 _239 = float4(_236, _237, _238, 1.0);
    float4 _240 = float4(_239.x, _239.y, _239.z, _239.w);
    float4 _241 = View.View_TranslatedWorldToClip * _240;
    float4 _242 = _68;
    _242.w = 0.0;
    float3x3 _255 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _255[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _258 = _255;
    _258[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _261 = _258;
    _261[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _262 = _261 * _204;
    float3 _263 = _262[0];
    out.out_var_TEXCOORD10_centroid = float4(_263.x, _263.y, _263.z, _242.w);
    out.out_var_TEXCOORD11_centroid = float4(_262[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _241;
    return out;
}

