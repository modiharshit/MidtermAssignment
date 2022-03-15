

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

constant float3x3 _65 = {};
constant float4 _66 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_00001558_03a45d2d(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    int _80 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _83 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _89 = int(_83 + (_Globals.InputWeightIndexSize * uint(_80)));
    float3x4 _91;
    _91 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _92;
    for (int _94 = 0; _94 < _80; _91 = _92, _94++)
    {
        int _102 = int(_83 + (_Globals.InputWeightIndexSize * uint(_94)));
        int _107 = int(InputWeightStream.read(uint(uint(_102))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _126 = float4(float(InputWeightStream.read(uint(uint(_89 + _94))).x) * 0.0039215688593685626983642578125);
            int _127 = int((InputWeightStream.read(uint(uint(_102 + 1))).x << 8u) | uint(_107)) * 3;
            _92 = float3x4(_91[0] + (_126 * BoneMatrices.read(uint(uint(_127)))), _91[1] + (_126 * BoneMatrices.read(uint(uint(_127 + 1)))), _91[2] + (_126 * BoneMatrices.read(uint(uint(_127 + 2)))));
        }
        else
        {
            float4 _153 = float4(float(InputWeightStream.read(uint(uint(_89 + _94))).x) * 0.0039215688593685626983642578125);
            int _154 = _107 * 3;
            _92 = float3x4(_91[0] + (_153 * BoneMatrices.read(uint(uint(_154)))), _91[1] + (_153 * BoneMatrices.read(uint(uint(_154 + 1)))), _91[2] + (_153 * BoneMatrices.read(uint(uint(_154 + 2)))));
        }
    }
    float3 _179 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _91);
    float3x3 _180 = _65;
    _180[0] = _179;
    float3 _186 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _91);
    float3x3 _187 = _180;
    _187[2] = _186;
    float3x3 _192 = _187;
    _192[1] = normalize(cross(_186, _179) * in.in_var_ATTRIBUTE2.w);
    float3 _193 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _194 = _193.x;
    float _195 = _193.y;
    float _196 = _193.z;
    float4 _197 = float4(_194, _195, _196, 1.0);
    float3 _198 = _197 * _91;
    float3 _199 = _198 + in.in_var_ATTRIBUTE12;
    float3 _204 = _199.xxx;
    float3 _205 = Primitive.Primitive_LocalToWorld[0u].xyz * _204;
    float3 _209 = _199.yyy;
    float3 _210 = Primitive.Primitive_LocalToWorld[1u].xyz * _209;
    float3 _211 = _205 + _210;
    float3 _215 = _199.zzz;
    float3 _216 = Primitive.Primitive_LocalToWorld[2u].xyz * _215;
    float3 _217 = _211 + _216;
    float3 _221 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _222 = _217 + _221;
    float _223 = _222.x;
    float _224 = _222.y;
    float _225 = _222.z;
    float4 _226 = float4(_223, _224, _225, 1.0);
    float4 _227 = float4(_226.x, _226.y, _226.z, _226.w);
    float4 _228 = View.View_TranslatedWorldToClip * _227;
    float4 _229 = _66;
    _229.w = 0.0;
    float3x3 _242 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _242[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _245 = _242;
    _245[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _248 = _245;
    _248[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _249 = _248 * _192;
    float3 _250 = _249[0];
    out.out_var_TEXCOORD10_centroid = float4(_250.x, _250.y, _250.z, _229.w);
    out.out_var_TEXCOORD11_centroid = float4(_249[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _227;
    out.gl_Position = _228;
    return out;
}

