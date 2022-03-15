

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

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

constant spvUnsafeArray<float2, 1> _74 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _78 = {};
constant float4 _79 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00001d19_2cb480d5(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _96 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _99 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _105 = int(_99 + (_Globals.InputWeightIndexSize * uint(_96)));
    float3x4 _107;
    _107 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _108;
    for (int _110 = 0; _110 < _96; _107 = _108, _110++)
    {
        int _118 = int(_99 + (_Globals.InputWeightIndexSize * uint(_110)));
        int _123 = int(InputWeightStream.read(uint(uint(_118))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _169 = float4(float(InputWeightStream.read(uint(uint(_105 + _110))).x) * 0.0039215688593685626983642578125);
            int _170 = int((InputWeightStream.read(uint(uint(_118 + 1))).x << 8u) | uint(_123)) * 3;
            _108 = float3x4(_107[0] + (_169 * BoneMatrices.read(uint(uint(_170)))), _107[1] + (_169 * BoneMatrices.read(uint(uint(_170 + 1)))), _107[2] + (_169 * BoneMatrices.read(uint(uint(_170 + 2)))));
        }
        else
        {
            float4 _134 = float4(float(InputWeightStream.read(uint(uint(_105 + _110))).x) * 0.0039215688593685626983642578125);
            int _135 = _123 * 3;
            _108 = float3x4(_107[0] + (_134 * BoneMatrices.read(uint(uint(_135)))), _107[1] + (_134 * BoneMatrices.read(uint(uint(_135 + 1)))), _107[2] + (_134 * BoneMatrices.read(uint(uint(_135 + 2)))));
        }
    }
    float3 _192 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _193 = _192.xyz;
    float3 _203 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_193 * dot(in.in_var_ATTRIBUTE1, _193))), 0.0) * _107);
    float3x3 _204 = _78;
    _204[0] = _203;
    float3 _210 = normalize(float4(_192, 0.0) * _107);
    float3x3 _211 = _204;
    _211[2] = _210;
    float3x3 _216 = _211;
    _216[1] = normalize(cross(_210, _203) * in.in_var_ATTRIBUTE2.w);
    float3 _217 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _218 = _217 + in.in_var_ATTRIBUTE11;
    float _219 = _218.x;
    float _220 = _218.y;
    float _221 = _218.z;
    float4 _222 = float4(_219, _220, _221, 1.0);
    float3 _223 = _222 * _107;
    float3 _224 = _223 + in.in_var_ATTRIBUTE12;
    float3 _229 = _224.xxx;
    float3 _230 = Primitive.Primitive_LocalToWorld[0u].xyz * _229;
    float3 _234 = _224.yyy;
    float3 _235 = Primitive.Primitive_LocalToWorld[1u].xyz * _234;
    float3 _236 = _230 + _235;
    float3 _240 = _224.zzz;
    float3 _241 = Primitive.Primitive_LocalToWorld[2u].xyz * _240;
    float3 _242 = _236 + _241;
    float3 _246 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _247 = _242 + _246;
    float _248 = _247.x;
    float _249 = _247.y;
    float _250 = _247.z;
    float4 _251 = float4(_248, _249, _250, 1.0);
    spvUnsafeArray<float2, 1> _81;
    _81 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _82 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _253 = 0; _253 < 1; )
    {
        _82[_253] = _81[_253];
        _253++;
        continue;
    }
    float4 _262 = float4(_251.x, _251.y, _251.z, _251.w);
    float4 _265 = View.View_TranslatedWorldToClip * _262;
    float4 _268 = _79;
    _268.w = 0.0;
    float3x3 _281 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _281[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _284 = _281;
    _284[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _287 = _284;
    _287[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _288 = _287 * _216;
    float3 _289 = _288[0];
    spvUnsafeArray<float4, 1> _299 = { float4(_82[0].x, _82[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_289.x, _289.y, _289.z, _268.w);
    out.out_var_TEXCOORD11_centroid = float4(_288[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _299;
    out.out_var_TEXCOORD6 = _262;
    out.gl_Position = _265;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

