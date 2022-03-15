

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

constant float _76 = {};
constant float3x3 _77 = {};
constant float4 _78 = {};

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
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_000019b5_bbf68cc8(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _92 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _95 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _101 = int(_95 + (_Globals.InputWeightIndexSize * uint(_92)));
    float3x4 _103;
    _103 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _104;
    for (int _106 = 0; _106 < _92; _103 = _104, _106++)
    {
        int _114 = int(_95 + (_Globals.InputWeightIndexSize * uint(_106)));
        int _119 = int(InputWeightStream.read(uint(uint(_114))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _138 = float4(float(InputWeightStream.read(uint(uint(_101 + _106))).x) * 0.0039215688593685626983642578125);
            int _139 = int((InputWeightStream.read(uint(uint(_114 + 1))).x << 8u) | uint(_119)) * 3;
            _104 = float3x4(_103[0] + (_138 * BoneMatrices.read(uint(uint(_139)))), _103[1] + (_138 * BoneMatrices.read(uint(uint(_139 + 1)))), _103[2] + (_138 * BoneMatrices.read(uint(uint(_139 + 2)))));
        }
        else
        {
            float4 _165 = float4(float(InputWeightStream.read(uint(uint(_101 + _106))).x) * 0.0039215688593685626983642578125);
            int _166 = _119 * 3;
            _104 = float3x4(_103[0] + (_165 * BoneMatrices.read(uint(uint(_166)))), _103[1] + (_165 * BoneMatrices.read(uint(uint(_166 + 1)))), _103[2] + (_165 * BoneMatrices.read(uint(uint(_166 + 2)))));
        }
    }
    float3 _188 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _189 = _188.xyz;
    float3 _199 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_189 * dot(in.in_var_ATTRIBUTE1, _189))), 0.0) * _103);
    float3x3 _200 = _77;
    _200[0] = _199;
    float3 _206 = normalize(float4(_188, 0.0) * _103);
    float3x3 _207 = _200;
    _207[2] = _206;
    float3x3 _212 = _207;
    _212[1] = normalize(cross(_206, _199) * in.in_var_ATTRIBUTE2.w);
    float3 _220 = (float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0) * _103) + in.in_var_ATTRIBUTE12;
    float4 _247 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _220.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _220.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _220.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _260 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _260[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _263 = _260;
    _263[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _266 = _263;
    _266[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _267 = _266 * _212;
    float3 _268 = _267[2];
    float _269 = _268.x;
    float4 _279 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_247.x, _247.y, _247.z, _247.w);
    float4 _290;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_279.z < 0.0))
    {
        float4 _288 = _279;
        _288.z = 9.9999999747524270787835121154785e-07;
        float4 _289 = _288;
        _289.w = 1.0;
        _290 = _289;
    }
    else
    {
        _290 = _279;
    }
    float _296 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_269, _268.yz, _76).xyz));
    float4 _315 = _78;
    _315.w = 0.0;
    float3 _316 = _267[0];
    out.out_var_TEXCOORD10_centroid = float4(_316.x, _316.y, _316.z, _315.w);
    out.out_var_TEXCOORD11_centroid = float4(_269, _268.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _290.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_296) > 0.0) ? (sqrt(fast::clamp(1.0 - (_296 * _296), 0.0, 1.0)) / _296) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _247.xyz;
    out.gl_Position = _290;
    return out;
}

