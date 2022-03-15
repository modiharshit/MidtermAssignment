

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

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_00001d89_69fbc005(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _98 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _101 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _107 = int(_101 + (_Globals.InputWeightIndexSize * uint(_98)));
    float3x4 _109;
    _109 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _110;
    for (int _112 = 0; _112 < _98; _109 = _110, _112++)
    {
        int _120 = int(_101 + (_Globals.InputWeightIndexSize * uint(_112)));
        int _125 = int(InputWeightStream.read(uint(uint(_120))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _171 = float4(float(InputWeightStream.read(uint(uint(_107 + _112))).x) * 0.0039215688593685626983642578125);
            int _172 = int((InputWeightStream.read(uint(uint(_120 + 1))).x << 8u) | uint(_125)) * 3;
            _110 = float3x4(_109[0] + (_171 * BoneMatrices.read(uint(uint(_172)))), _109[1] + (_171 * BoneMatrices.read(uint(uint(_172 + 1)))), _109[2] + (_171 * BoneMatrices.read(uint(uint(_172 + 2)))));
        }
        else
        {
            float4 _136 = float4(float(InputWeightStream.read(uint(uint(_107 + _112))).x) * 0.0039215688593685626983642578125);
            int _137 = _125 * 3;
            _110 = float3x4(_109[0] + (_136 * BoneMatrices.read(uint(uint(_137)))), _109[1] + (_136 * BoneMatrices.read(uint(uint(_137 + 1)))), _109[2] + (_136 * BoneMatrices.read(uint(uint(_137 + 2)))));
        }
    }
    float3 _194 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _195 = _194.xyz;
    float3 _205 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_195 * dot(in.in_var_ATTRIBUTE1, _195))), 0.0) * _109);
    float3x3 _206 = _78;
    _206[0] = _205;
    float3 _212 = normalize(float4(_194, 0.0) * _109);
    float3x3 _213 = _206;
    _213[2] = _212;
    float3x3 _218 = _213;
    _218[1] = normalize(cross(_212, _205) * in.in_var_ATTRIBUTE2.w);
    float3 _219 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _220 = _219 + in.in_var_ATTRIBUTE11;
    float _221 = _220.x;
    float _222 = _220.y;
    float _223 = _220.z;
    float4 _224 = float4(_221, _222, _223, 1.0);
    float3 _225 = _224 * _109;
    float3 _226 = _225 + in.in_var_ATTRIBUTE12;
    float3 _231 = _226.xxx;
    float3 _232 = Primitive.Primitive_LocalToWorld[0u].xyz * _231;
    float3 _236 = _226.yyy;
    float3 _237 = Primitive.Primitive_LocalToWorld[1u].xyz * _236;
    float3 _238 = _232 + _237;
    float3 _242 = _226.zzz;
    float3 _243 = Primitive.Primitive_LocalToWorld[2u].xyz * _242;
    float3 _244 = _238 + _243;
    float3 _248 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _249 = _244 + _248;
    float _250 = _249.x;
    float _251 = _249.y;
    float _252 = _249.z;
    float4 _253 = float4(_250, _251, _252, 1.0);
    spvUnsafeArray<float2, 1> _81;
    _81 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _82 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _255 = 0; _255 < 1; )
    {
        _82[_255] = _81[_255];
        _255++;
        continue;
    }
    float4 _264 = float4(_253.x, _253.y, _253.z, _253.w);
    float4 _265 = View.View_TranslatedWorldToClip * _264;
    float4 _268 = _79;
    _268.w = 0.0;
    float3x3 _281 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _281[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _284 = _281;
    _284[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _287 = _284;
    _287[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _288 = _287 * _218;
    float3 _289 = _288[0];
    spvUnsafeArray<float4, 1> _299 = { float4(_82[0].x, _82[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_289.x, _289.y, _289.z, _268.w);
    out.out_var_TEXCOORD11_centroid = float4(_288[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _299;
    out.out_var_TEXCOORD6 = _264;
    out.gl_Position = _265;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

