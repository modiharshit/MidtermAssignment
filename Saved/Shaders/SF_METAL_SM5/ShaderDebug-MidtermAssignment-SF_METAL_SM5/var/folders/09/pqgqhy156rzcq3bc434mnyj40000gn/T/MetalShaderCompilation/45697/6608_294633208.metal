

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

constant float _75 = {};
constant float3x3 _76 = {};
constant float4 _77 = {};

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
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_000019d0_118fbef8(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _91 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _94 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _100 = int(_94 + (_Globals.InputWeightIndexSize * uint(_91)));
    float3x4 _102;
    _102 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _103;
    for (int _105 = 0; _105 < _91; _102 = _103, _105++)
    {
        int _113 = int(_94 + (_Globals.InputWeightIndexSize * uint(_105)));
        int _118 = int(InputWeightStream.read(uint(uint(_113))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _137 = float4(float(InputWeightStream.read(uint(uint(_100 + _105))).x) * 0.0039215688593685626983642578125);
            int _138 = int((InputWeightStream.read(uint(uint(_113 + 1))).x << 8u) | uint(_118)) * 3;
            _103 = float3x4(_102[0] + (_137 * BoneMatrices.read(uint(uint(_138)))), _102[1] + (_137 * BoneMatrices.read(uint(uint(_138 + 1)))), _102[2] + (_137 * BoneMatrices.read(uint(uint(_138 + 2)))));
        }
        else
        {
            float4 _164 = float4(float(InputWeightStream.read(uint(uint(_100 + _105))).x) * 0.0039215688593685626983642578125);
            int _165 = _118 * 3;
            _103 = float3x4(_102[0] + (_164 * BoneMatrices.read(uint(uint(_165)))), _102[1] + (_164 * BoneMatrices.read(uint(uint(_165 + 1)))), _102[2] + (_164 * BoneMatrices.read(uint(uint(_165 + 2)))));
        }
    }
    float3 _187 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _188 = _187.xyz;
    float3 _198 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_188 * dot(in.in_var_ATTRIBUTE1, _188))), 0.0) * _102);
    float3x3 _199 = _76;
    _199[0] = _198;
    float3 _205 = normalize(float4(_187, 0.0) * _102);
    float3x3 _206 = _199;
    _206[2] = _205;
    float3x3 _211 = _206;
    _211[1] = normalize(cross(_205, _198) * in.in_var_ATTRIBUTE2.w);
    float3 _219 = (float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0) * _102) + in.in_var_ATTRIBUTE12;
    float4 _246 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _219.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _219.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _219.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _259 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _259[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _262 = _259;
    _262[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _265 = _262;
    _265[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _266 = _265 * _211;
    float3 _267 = _266[2];
    float _268 = _267.x;
    float4 _278 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_246.x, _246.y, _246.z, _246.w);
    float4 _289;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_278.z < 0.0))
    {
        float4 _287 = _278;
        _287.z = 9.9999999747524270787835121154785e-07;
        float4 _288 = _287;
        _288.w = 1.0;
        _289 = _288;
    }
    else
    {
        _289 = _278;
    }
    float _295 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_268, _267.yz, _75).xyz));
    float4 _320 = _289;
    _320.z = ((_289.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_295) > 0.0) ? (sqrt(fast::clamp(1.0 - (_295 * _295), 0.0, 1.0)) / _295) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _289.w;
    float4 _321 = _77;
    _321.w = 0.0;
    float3 _322 = _266[0];
    out.out_var_TEXCOORD10_centroid = float4(_322.x, _322.y, _322.z, _321.w);
    out.out_var_TEXCOORD11_centroid = float4(_268, _267.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _246.xyz;
    out.gl_Position = _320;
    return out;
}

