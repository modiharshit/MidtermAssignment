

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

constant float3x3 _72 = {};
constant float _76 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
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

vertex Main_out Main_0000178a_1da227aa(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _90 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _93 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _99 = int(_93 + (_Globals.InputWeightIndexSize * uint(_90)));
    float3x4 _101;
    _101 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _102;
    for (int _104 = 0; _104 < _90; _101 = _102, _104++)
    {
        int _112 = int(_93 + (_Globals.InputWeightIndexSize * uint(_104)));
        int _117 = int(InputWeightStream.read(uint(uint(_112))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _136 = float4(float(InputWeightStream.read(uint(uint(_99 + _104))).x) * 0.0039215688593685626983642578125);
            int _137 = int((InputWeightStream.read(uint(uint(_112 + 1))).x << 8u) | uint(_117)) * 3;
            _102 = float3x4(_101[0] + (_136 * BoneMatrices.read(uint(uint(_137)))), _101[1] + (_136 * BoneMatrices.read(uint(uint(_137 + 1)))), _101[2] + (_136 * BoneMatrices.read(uint(uint(_137 + 2)))));
        }
        else
        {
            float4 _163 = float4(float(InputWeightStream.read(uint(uint(_99 + _104))).x) * 0.0039215688593685626983642578125);
            int _164 = _117 * 3;
            _102 = float3x4(_101[0] + (_163 * BoneMatrices.read(uint(uint(_164)))), _101[1] + (_163 * BoneMatrices.read(uint(uint(_164 + 1)))), _101[2] + (_163 * BoneMatrices.read(uint(uint(_164 + 2)))));
        }
    }
    float3 _186 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _187 = _186.xyz;
    float3 _197 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_187 * dot(in.in_var_ATTRIBUTE1, _187))), 0.0) * _101);
    float3x3 _198 = _72;
    _198[0] = _197;
    float3 _204 = normalize(float4(_186, 0.0) * _101);
    float3x3 _205 = _198;
    _205[2] = _204;
    float3x3 _210 = _205;
    _210[1] = normalize(cross(_204, _197) * in.in_var_ATTRIBUTE2.w);
    float3 _218 = (float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0) * _101) + in.in_var_ATTRIBUTE12;
    float4 _245 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _218.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _218.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _218.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _258 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _258[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _261 = _258;
    _261[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _264 = _261;
    _264[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _277 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_245.x, _245.y, _245.z, _245.w);
    float4 _288;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_277.z < 0.0))
    {
        float4 _286 = _277;
        _286.z = 9.9999999747524270787835121154785e-07;
        float4 _287 = _286;
        _287.w = 1.0;
        _288 = _287;
    }
    else
    {
        _288 = _277;
    }
    float _294 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_264 * _210)[2], _76).xyz));
    float4 _319 = _288;
    _319.z = ((_288.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_294) > 0.0) ? (sqrt(fast::clamp(1.0 - (_294 * _294), 0.0, 1.0)) / _294) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _288.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _319;
    return out;
}

