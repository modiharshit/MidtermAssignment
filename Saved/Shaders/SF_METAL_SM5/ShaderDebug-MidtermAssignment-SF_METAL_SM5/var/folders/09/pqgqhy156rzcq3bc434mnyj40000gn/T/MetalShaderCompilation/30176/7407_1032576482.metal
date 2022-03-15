

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

constant spvUnsafeArray<float2, 1> _73 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _77 = {};
constant float4 _78 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
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

vertex Main_out Main_00001cef_3d8bdde2(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _97 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _100 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _106 = int(_100 + (_Globals.InputWeightIndexSize * uint(_97)));
    float3x4 _108;
    _108 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _109;
    for (int _111 = 0; _111 < _97; _108 = _109, _111++)
    {
        int _119 = int(_100 + (_Globals.InputWeightIndexSize * uint(_111)));
        int _124 = int(InputWeightStream.read(uint(uint(_119))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _170 = float4(float(InputWeightStream.read(uint(uint(_106 + _111))).x) * 0.0039215688593685626983642578125);
            int _171 = int((InputWeightStream.read(uint(uint(_119 + 1))).x << 8u) | uint(_124)) * 3;
            _109 = float3x4(_108[0] + (_170 * BoneMatrices.read(uint(uint(_171)))), _108[1] + (_170 * BoneMatrices.read(uint(uint(_171 + 1)))), _108[2] + (_170 * BoneMatrices.read(uint(uint(_171 + 2)))));
        }
        else
        {
            float4 _135 = float4(float(InputWeightStream.read(uint(uint(_106 + _111))).x) * 0.0039215688593685626983642578125);
            int _136 = _124 * 3;
            _109 = float3x4(_108[0] + (_135 * BoneMatrices.read(uint(uint(_136)))), _108[1] + (_135 * BoneMatrices.read(uint(uint(_136 + 1)))), _108[2] + (_135 * BoneMatrices.read(uint(uint(_136 + 2)))));
        }
    }
    float3 _193 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _194 = _193.xyz;
    float3 _204 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_194 * dot(in.in_var_ATTRIBUTE1, _194))), 0.0) * _108);
    float3x3 _205 = _77;
    _205[0] = _204;
    float3 _211 = normalize(float4(_193, 0.0) * _108);
    float3x3 _212 = _205;
    _212[2] = _211;
    float3x3 _217 = _212;
    _217[1] = normalize(cross(_211, _204) * in.in_var_ATTRIBUTE2.w);
    float3 _218 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _219 = _218 + in.in_var_ATTRIBUTE11;
    float _220 = _219.x;
    float _221 = _219.y;
    float _222 = _219.z;
    float4 _223 = float4(_220, _221, _222, 1.0);
    float3 _224 = _223 * _108;
    float3 _225 = _224 + in.in_var_ATTRIBUTE12;
    float3 _230 = _225.xxx;
    float3 _231 = Primitive.Primitive_LocalToWorld[0u].xyz * _230;
    float3 _235 = _225.yyy;
    float3 _236 = Primitive.Primitive_LocalToWorld[1u].xyz * _235;
    float3 _237 = _231 + _236;
    float3 _241 = _225.zzz;
    float3 _242 = Primitive.Primitive_LocalToWorld[2u].xyz * _241;
    float3 _243 = _237 + _242;
    float3 _247 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _248 = _243 + _247;
    float _249 = _248.x;
    float _250 = _248.y;
    float _251 = _248.z;
    float4 _252 = float4(_249, _250, _251, 1.0);
    spvUnsafeArray<float2, 1> _80;
    _80 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _81 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _254 = 0; _254 < 1; )
    {
        _81[_254] = _80[_254];
        _254++;
        continue;
    }
    float4 _263 = float4(_252.x, _252.y, _252.z, _252.w);
    float4 _264 = View.View_TranslatedWorldToClip * _263;
    float4 _267 = _78;
    _267.w = 0.0;
    float3x3 _280 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _280[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _283 = _280;
    _283[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _286 = _283;
    _286[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _287 = _286 * _217;
    float3 _288 = _287[0];
    spvUnsafeArray<float4, 1> _298 = { float4(_81[0].x, _81[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_288.x, _288.y, _288.z, _267.w);
    out.out_var_TEXCOORD11_centroid = float4(_287[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _298;
    out.gl_Position = _264;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

