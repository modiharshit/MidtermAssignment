

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

constant float _74 = {};
constant float3x3 _75 = {};
constant float4 _76 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_00001878_ce348855(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _88 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _91 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _97 = int(_91 + (_Globals.InputWeightIndexSize * uint(_88)));
    float3x4 _99;
    _99 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _100;
    for (int _102 = 0; _102 < _88; _99 = _100, _102++)
    {
        int _110 = int(_91 + (_Globals.InputWeightIndexSize * uint(_102)));
        int _115 = int(InputWeightStream.read(uint(uint(_110))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _134 = float4(float(InputWeightStream.read(uint(uint(_97 + _102))).x) * 0.0039215688593685626983642578125);
            int _135 = int((InputWeightStream.read(uint(uint(_110 + 1))).x << 8u) | uint(_115)) * 3;
            _100 = float3x4(_99[0] + (_134 * BoneMatrices.read(uint(uint(_135)))), _99[1] + (_134 * BoneMatrices.read(uint(uint(_135 + 1)))), _99[2] + (_134 * BoneMatrices.read(uint(uint(_135 + 2)))));
        }
        else
        {
            float4 _161 = float4(float(InputWeightStream.read(uint(uint(_97 + _102))).x) * 0.0039215688593685626983642578125);
            int _162 = _115 * 3;
            _100 = float3x4(_99[0] + (_161 * BoneMatrices.read(uint(uint(_162)))), _99[1] + (_161 * BoneMatrices.read(uint(uint(_162 + 1)))), _99[2] + (_161 * BoneMatrices.read(uint(uint(_162 + 2)))));
        }
    }
    float3 _187 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _99);
    float3x3 _188 = _75;
    _188[0] = _187;
    float3 _194 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _99);
    float3x3 _195 = _188;
    _195[2] = _194;
    float3x3 _200 = _195;
    _200[1] = normalize(cross(_194, _187) * in.in_var_ATTRIBUTE2.w);
    float3 _207 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _99) + in.in_var_ATTRIBUTE12;
    float4 _234 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _207.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _207.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _207.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _247 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _247[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _250 = _247;
    _250[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _253 = _250;
    _253[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _254 = _253 * _200;
    float3 _255 = _254[2];
    float _256 = _255.x;
    float4 _266 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_234.x, _234.y, _234.z, _234.w);
    float4 _277;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_266.z < 0.0))
    {
        float4 _275 = _266;
        _275.z = 9.9999999747524270787835121154785e-07;
        float4 _276 = _275;
        _276.w = 1.0;
        _277 = _276;
    }
    else
    {
        _277 = _266;
    }
    float _283 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_256, _255.yz, _74).xyz));
    float4 _302 = _76;
    _302.w = 0.0;
    float3 _303 = _254[0];
    out.out_var_TEXCOORD10_centroid = float4(_303.x, _303.y, _303.z, _302.w);
    out.out_var_TEXCOORD11_centroid = float4(_256, _255.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _277.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_283) > 0.0) ? (sqrt(fast::clamp(1.0 - (_283 * _283), 0.0, 1.0)) / _283) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _234.xyz;
    out.gl_Position = _277;
    return out;
}

