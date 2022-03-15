

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

constant float3x3 _64 = {};
constant float4 _65 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_000014ac_b8cbeca4(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _79 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _82 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _88 = int(_82 + (_Globals.InputWeightIndexSize * uint(_79)));
    float3x4 _90;
    _90 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _91;
    for (int _93 = 0; _93 < _79; _90 = _91, _93++)
    {
        int _101 = int(_82 + (_Globals.InputWeightIndexSize * uint(_93)));
        int _106 = int(InputWeightStream.read(uint(uint(_101))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _125 = float4(float(InputWeightStream.read(uint(uint(_88 + _93))).x) * 0.0039215688593685626983642578125);
            int _126 = int((InputWeightStream.read(uint(uint(_101 + 1))).x << 8u) | uint(_106)) * 3;
            _91 = float3x4(_90[0] + (_125 * BoneMatrices.read(uint(uint(_126)))), _90[1] + (_125 * BoneMatrices.read(uint(uint(_126 + 1)))), _90[2] + (_125 * BoneMatrices.read(uint(uint(_126 + 2)))));
        }
        else
        {
            float4 _152 = float4(float(InputWeightStream.read(uint(uint(_88 + _93))).x) * 0.0039215688593685626983642578125);
            int _153 = _106 * 3;
            _91 = float3x4(_90[0] + (_152 * BoneMatrices.read(uint(uint(_153)))), _90[1] + (_152 * BoneMatrices.read(uint(uint(_153 + 1)))), _90[2] + (_152 * BoneMatrices.read(uint(uint(_153 + 2)))));
        }
    }
    float3 _178 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _90);
    float3x3 _179 = _64;
    _179[0] = _178;
    float3 _185 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _90);
    float3x3 _186 = _179;
    _186[2] = _185;
    float3x3 _191 = _186;
    _191[1] = normalize(cross(_185, _178) * in.in_var_ATTRIBUTE2.w);
    float3 _192 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _193 = _192.x;
    float _194 = _192.y;
    float _195 = _192.z;
    float4 _196 = float4(_193, _194, _195, 1.0);
    float3 _197 = _196 * _90;
    float3 _198 = _197 + in.in_var_ATTRIBUTE12;
    float3 _203 = _198.xxx;
    float3 _204 = Primitive.Primitive_LocalToWorld[0u].xyz * _203;
    float3 _208 = _198.yyy;
    float3 _209 = Primitive.Primitive_LocalToWorld[1u].xyz * _208;
    float3 _210 = _204 + _209;
    float3 _214 = _198.zzz;
    float3 _215 = Primitive.Primitive_LocalToWorld[2u].xyz * _214;
    float3 _216 = _210 + _215;
    float3 _220 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _221 = _216 + _220;
    float _222 = _221.x;
    float _223 = _221.y;
    float _224 = _221.z;
    float4 _225 = float4(_222, _223, _224, 1.0);
    float4 _226 = float4(_225.x, _225.y, _225.z, _225.w);
    float4 _227 = View.View_TranslatedWorldToClip * _226;
    float4 _228 = _65;
    _228.w = 0.0;
    float3x3 _241 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _241[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _244 = _241;
    _244[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _247 = _244;
    _247[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _248 = _247 * _191;
    float3 _249 = _248[0];
    out.out_var_TEXCOORD10_centroid = float4(_249.x, _249.y, _249.z, _228.w);
    out.out_var_TEXCOORD11_centroid = float4(_248[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _227;
    return out;
}

