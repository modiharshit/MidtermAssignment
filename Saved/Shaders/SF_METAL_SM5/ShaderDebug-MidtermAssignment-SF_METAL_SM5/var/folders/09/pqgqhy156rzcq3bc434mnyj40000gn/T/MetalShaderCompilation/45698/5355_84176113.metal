

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_000014eb_05046cf1(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _78 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _81 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _87 = int(_81 + (_Globals.InputWeightIndexSize * uint(_78)));
    float3x4 _89;
    _89 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _90;
    for (int _92 = 0; _92 < _78; _89 = _90, _92++)
    {
        int _100 = int(_81 + (_Globals.InputWeightIndexSize * uint(_92)));
        int _105 = int(InputWeightStream.read(uint(uint(_100))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _124 = float4(float(InputWeightStream.read(uint(uint(_87 + _92))).x) * 0.0039215688593685626983642578125);
            int _125 = int((InputWeightStream.read(uint(uint(_100 + 1))).x << 8u) | uint(_105)) * 3;
            _90 = float3x4(_89[0] + (_124 * BoneMatrices.read(uint(uint(_125)))), _89[1] + (_124 * BoneMatrices.read(uint(uint(_125 + 1)))), _89[2] + (_124 * BoneMatrices.read(uint(uint(_125 + 2)))));
        }
        else
        {
            float4 _151 = float4(float(InputWeightStream.read(uint(uint(_87 + _92))).x) * 0.0039215688593685626983642578125);
            int _152 = _105 * 3;
            _90 = float3x4(_89[0] + (_151 * BoneMatrices.read(uint(uint(_152)))), _89[1] + (_151 * BoneMatrices.read(uint(uint(_152 + 1)))), _89[2] + (_151 * BoneMatrices.read(uint(uint(_152 + 2)))));
        }
    }
    float3 _177 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _89);
    float3x3 _178 = _65;
    _178[0] = _177;
    float3 _184 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _89);
    float3x3 _185 = _178;
    _185[2] = _184;
    float3x3 _190 = _185;
    _190[1] = normalize(cross(_184, _177) * in.in_var_ATTRIBUTE2.w);
    float3 _191 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _192 = _191.x;
    float _193 = _191.y;
    float _194 = _191.z;
    float4 _195 = float4(_192, _193, _194, 1.0);
    float3 _196 = _195 * _89;
    float3 _197 = _196 + in.in_var_ATTRIBUTE12;
    float3 _202 = _197.xxx;
    float3 _203 = Primitive.Primitive_LocalToWorld[0u].xyz * _202;
    float3 _207 = _197.yyy;
    float3 _208 = Primitive.Primitive_LocalToWorld[1u].xyz * _207;
    float3 _209 = _203 + _208;
    float3 _213 = _197.zzz;
    float3 _214 = Primitive.Primitive_LocalToWorld[2u].xyz * _213;
    float3 _215 = _209 + _214;
    float3 _219 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _220 = _215 + _219;
    float _221 = _220.x;
    float _222 = _220.y;
    float _223 = _220.z;
    float4 _224 = float4(_221, _222, _223, 1.0);
    float4 _225 = float4(_224.x, _224.y, _224.z, _224.w);
    float4 _228 = View.View_TranslatedWorldToClip * _225;
    float4 _229 = _66;
    _229.w = 0.0;
    float3x3 _242 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _242[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _245 = _242;
    _245[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _248 = _245;
    _248[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _249 = _248 * _190;
    float3 _250 = _249[0];
    out.out_var_TEXCOORD10_centroid = float4(_250.x, _250.y, _250.z, _229.w);
    out.out_var_TEXCOORD11_centroid = float4(_249[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _225;
    out.gl_Position = _228;
    return out;
}

