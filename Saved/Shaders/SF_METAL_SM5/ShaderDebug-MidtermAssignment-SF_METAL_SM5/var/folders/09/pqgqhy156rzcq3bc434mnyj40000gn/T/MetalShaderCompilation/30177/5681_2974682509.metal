

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

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
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

vertex Main_out Main_00001631_b14e0d8d(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _86 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _89 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _95 = int(_89 + (_Globals.InputWeightIndexSize * uint(_86)));
    float3x4 _97;
    _97 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _98;
    for (int _100 = 0; _100 < _86; _97 = _98, _100++)
    {
        int _108 = int(_89 + (_Globals.InputWeightIndexSize * uint(_100)));
        int _113 = int(InputWeightStream.read(uint(uint(_108))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _132 = float4(float(InputWeightStream.read(uint(uint(_95 + _100))).x) * 0.0039215688593685626983642578125);
            int _133 = int((InputWeightStream.read(uint(uint(_108 + 1))).x << 8u) | uint(_113)) * 3;
            _98 = float3x4(_97[0] + (_132 * BoneMatrices.read(uint(uint(_133)))), _97[1] + (_132 * BoneMatrices.read(uint(uint(_133 + 1)))), _97[2] + (_132 * BoneMatrices.read(uint(uint(_133 + 2)))));
        }
        else
        {
            float4 _159 = float4(float(InputWeightStream.read(uint(uint(_95 + _100))).x) * 0.0039215688593685626983642578125);
            int _160 = _113 * 3;
            _98 = float3x4(_97[0] + (_159 * BoneMatrices.read(uint(uint(_160)))), _97[1] + (_159 * BoneMatrices.read(uint(uint(_160 + 1)))), _97[2] + (_159 * BoneMatrices.read(uint(uint(_160 + 2)))));
        }
    }
    float3 _185 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _97);
    float3x3 _186 = _74;
    _186[0] = _185;
    float3 _192 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _97);
    float3x3 _193 = _186;
    _193[2] = _192;
    float3x3 _198 = _193;
    _198[1] = normalize(cross(_192, _185) * in.in_var_ATTRIBUTE2.w);
    float3 _205 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _97) + in.in_var_ATTRIBUTE12;
    float4 _232 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _205.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _205.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _205.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float3x3 _245 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _245[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _248 = _245;
    _248[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _251 = _248;
    _251[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _264 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_232.x, _232.y, _232.z, _232.w);
    float4 _275;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_264.z < 0.0))
    {
        float4 _273 = _264;
        _273.z = 9.9999999747524270787835121154785e-07;
        float4 _274 = _273;
        _274.w = 1.0;
        _275 = _274;
    }
    else
    {
        _275 = _264;
    }
    float _281 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_251 * _198)[2], _73).xyz));
    out.out_var_TEXCOORD6 = _275.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_281) > 0.0) ? (sqrt(fast::clamp(1.0 - (_281 * _281), 0.0, 1.0)) / _281) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _275;
    return out;
}

