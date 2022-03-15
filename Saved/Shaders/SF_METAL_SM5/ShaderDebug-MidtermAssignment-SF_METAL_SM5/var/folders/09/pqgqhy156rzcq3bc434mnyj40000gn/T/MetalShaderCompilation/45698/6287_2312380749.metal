

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

struct type_Globals
{
    uint InputWeightIndexSize;
};

constant float _73 = {};
constant float3x3 _74 = {};
constant float4 _75 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_0000188f_89d4214d(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _87 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _90 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _96 = int(_90 + (_Globals.InputWeightIndexSize * uint(_87)));
    float3x4 _98;
    _98 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _99;
    for (int _101 = 0; _101 < _87; _98 = _99, _101++)
    {
        int _109 = int(_90 + (_Globals.InputWeightIndexSize * uint(_101)));
        int _114 = int(InputWeightStream.read(uint(uint(_109))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _133 = float4(float(InputWeightStream.read(uint(uint(_96 + _101))).x) * 0.0039215688593685626983642578125);
            int _134 = int((InputWeightStream.read(uint(uint(_109 + 1))).x << 8u) | uint(_114)) * 3;
            _99 = float3x4(_98[0] + (_133 * BoneMatrices.read(uint(uint(_134)))), _98[1] + (_133 * BoneMatrices.read(uint(uint(_134 + 1)))), _98[2] + (_133 * BoneMatrices.read(uint(uint(_134 + 2)))));
        }
        else
        {
            float4 _160 = float4(float(InputWeightStream.read(uint(uint(_96 + _101))).x) * 0.0039215688593685626983642578125);
            int _161 = _114 * 3;
            _99 = float3x4(_98[0] + (_160 * BoneMatrices.read(uint(uint(_161)))), _98[1] + (_160 * BoneMatrices.read(uint(uint(_161 + 1)))), _98[2] + (_160 * BoneMatrices.read(uint(uint(_161 + 2)))));
        }
    }
    float3 _186 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _98);
    float3x3 _187 = _74;
    _187[0] = _186;
    float3 _193 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _98);
    float3x3 _194 = _187;
    _194[2] = _193;
    float3x3 _199 = _194;
    _199[1] = normalize(cross(_193, _186) * in.in_var_ATTRIBUTE2.w);
    float3 _206 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _98) + in.in_var_ATTRIBUTE12;
    float4 _233 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _206.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _206.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _206.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _246 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _246[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _249 = _246;
    _249[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _252 = _249;
    _252[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _253 = _252 * _199;
    float3 _254 = _253[2];
    float _255 = _254.x;
    float4 _265 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_233.x, _233.y, _233.z, _233.w);
    float4 _276;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_265.z < 0.0))
    {
        float4 _274 = _265;
        _274.z = 9.9999999747524270787835121154785e-07;
        float4 _275 = _274;
        _275.w = 1.0;
        _276 = _275;
    }
    else
    {
        _276 = _265;
    }
    float _282 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_255, _254.yz, _73).xyz));
    float4 _307 = _276;
    _307.z = ((_276.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_282) > 0.0) ? (sqrt(fast::clamp(1.0 - (_282 * _282), 0.0, 1.0)) / _282) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _276.w;
    float4 _308 = _75;
    _308.w = 0.0;
    float3 _309 = _253[0];
    out.out_var_TEXCOORD10_centroid = float4(_309.x, _309.y, _309.z, _308.w);
    out.out_var_TEXCOORD11_centroid = float4(_255, _254.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _233.xyz;
    out.gl_Position = _307;
    return out;
}

