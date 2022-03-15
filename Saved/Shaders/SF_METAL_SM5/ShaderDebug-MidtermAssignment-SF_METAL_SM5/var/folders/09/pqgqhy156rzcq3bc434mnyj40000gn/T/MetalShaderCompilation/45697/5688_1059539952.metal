

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

vertex Main_out Main_00001638_3f274bf0(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _85 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _88 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _94 = int(_88 + (_Globals.InputWeightIndexSize * uint(_85)));
    float3x4 _96;
    _96 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _97;
    for (int _99 = 0; _99 < _85; _96 = _97, _99++)
    {
        int _107 = int(_88 + (_Globals.InputWeightIndexSize * uint(_99)));
        int _112 = int(InputWeightStream.read(uint(uint(_107))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _131 = float4(float(InputWeightStream.read(uint(uint(_94 + _99))).x) * 0.0039215688593685626983642578125);
            int _132 = int((InputWeightStream.read(uint(uint(_107 + 1))).x << 8u) | uint(_112)) * 3;
            _97 = float3x4(_96[0] + (_131 * BoneMatrices.read(uint(uint(_132)))), _96[1] + (_131 * BoneMatrices.read(uint(uint(_132 + 1)))), _96[2] + (_131 * BoneMatrices.read(uint(uint(_132 + 2)))));
        }
        else
        {
            float4 _158 = float4(float(InputWeightStream.read(uint(uint(_94 + _99))).x) * 0.0039215688593685626983642578125);
            int _159 = _112 * 3;
            _97 = float3x4(_96[0] + (_158 * BoneMatrices.read(uint(uint(_159)))), _96[1] + (_158 * BoneMatrices.read(uint(uint(_159 + 1)))), _96[2] + (_158 * BoneMatrices.read(uint(uint(_159 + 2)))));
        }
    }
    float3 _181 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _182 = _181.xyz;
    float3 _192 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_182 * dot(in.in_var_ATTRIBUTE1, _182))), 0.0) * _96);
    float3x3 _193 = _68;
    _193[0] = _192;
    float3 _199 = normalize(float4(_181, 0.0) * _96);
    float3x3 _200 = _193;
    _200[2] = _199;
    float3x3 _205 = _200;
    _205[1] = normalize(cross(_199, _192) * in.in_var_ATTRIBUTE2.w);
    float3 _206 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _207 = _206 + in.in_var_ATTRIBUTE11;
    float _208 = _207.x;
    float _209 = _207.y;
    float _210 = _207.z;
    float4 _211 = float4(_208, _209, _210, 1.0);
    float3 _212 = _211 * _96;
    float3 _213 = _212 + in.in_var_ATTRIBUTE12;
    float3 _218 = _213.xxx;
    float3 _219 = Primitive.Primitive_LocalToWorld[0u].xyz * _218;
    float3 _223 = _213.yyy;
    float3 _224 = Primitive.Primitive_LocalToWorld[1u].xyz * _223;
    float3 _225 = _219 + _224;
    float3 _229 = _213.zzz;
    float3 _230 = Primitive.Primitive_LocalToWorld[2u].xyz * _229;
    float3 _231 = _225 + _230;
    float3 _235 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _236 = _231 + _235;
    float _237 = _236.x;
    float _238 = _236.y;
    float _239 = _236.z;
    float4 _240 = float4(_237, _238, _239, 1.0);
    float4 _241 = float4(_240.x, _240.y, _240.z, _240.w);
    float4 _242 = View.View_TranslatedWorldToClip * _241;
    float4 _243 = _69;
    _243.w = 0.0;
    float3x3 _256 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _256[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _259 = _256;
    _259[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _262 = _259;
    _262[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _263 = _262 * _205;
    float3 _264 = _263[0];
    out.gl_Position = _242;
    out.out_var_TEXCOORD10_centroid = float4(_264.x, _264.y, _264.z, _243.w);
    out.out_var_TEXCOORD11_centroid = float4(_263[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _241;
    return out;
}

