

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
    uint NumBoneInfluencesParam;
};

constant spvUnsafeArray<float2, 1> _72 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _73 = {};
constant float4 _74 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000020de_7dde7ea8(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _96 = float4(in.in_var_ATTRIBUTE4.x);
    int _99 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _113 = float4(in.in_var_ATTRIBUTE4.y);
    int _116 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _132 = float4(in.in_var_ATTRIBUTE4.z);
    int _135 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _151 = float4(in.in_var_ATTRIBUTE4.w);
    int _154 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _166 = (((_96 * BoneMatrices.read(uint(uint(_99)))) + (_113 * BoneMatrices.read(uint(uint(_116))))) + (_132 * BoneMatrices.read(uint(uint(_135))))) + (_151 * BoneMatrices.read(uint(uint(_154))));
    float4 _167 = (((_96 * BoneMatrices.read(uint(uint(_99 + 1)))) + (_113 * BoneMatrices.read(uint(uint(_116 + 1))))) + (_132 * BoneMatrices.read(uint(uint(_135 + 1))))) + (_151 * BoneMatrices.read(uint(uint(_154 + 1))));
    float4 _168 = (((_96 * BoneMatrices.read(uint(uint(_99 + 2)))) + (_113 * BoneMatrices.read(uint(uint(_116 + 2))))) + (_132 * BoneMatrices.read(uint(uint(_135 + 2))))) + (_151 * BoneMatrices.read(uint(uint(_154 + 2))));
    float3x4 _252;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _176 = float4(in.in_var_ATTRIBUTE15.x);
        int _179 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _195 = float4(in.in_var_ATTRIBUTE15.y);
        int _198 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _214 = float4(in.in_var_ATTRIBUTE15.z);
        int _217 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _233 = float4(in.in_var_ATTRIBUTE15.w);
        int _236 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _252 = float3x4((((_166 + (_176 * BoneMatrices.read(uint(uint(_179))))) + (_195 * BoneMatrices.read(uint(uint(_198))))) + (_214 * BoneMatrices.read(uint(uint(_217))))) + (_233 * BoneMatrices.read(uint(uint(_236)))), (((_167 + (_176 * BoneMatrices.read(uint(uint(_179 + 1))))) + (_195 * BoneMatrices.read(uint(uint(_198 + 1))))) + (_214 * BoneMatrices.read(uint(uint(_217 + 1))))) + (_233 * BoneMatrices.read(uint(uint(_236 + 1)))), (((_168 + (_176 * BoneMatrices.read(uint(uint(_179 + 2))))) + (_195 * BoneMatrices.read(uint(uint(_198 + 2))))) + (_214 * BoneMatrices.read(uint(uint(_217 + 2))))) + (_233 * BoneMatrices.read(uint(uint(_236 + 2)))));
    }
    else
    {
        _252 = float3x4(_166, _167, _168);
    }
    float3 _255 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _256 = _255.xyz;
    float3 _266 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_256 * dot(in.in_var_ATTRIBUTE1, _256))), 0.0) * _252);
    float3x3 _267 = _73;
    _267[0] = _266;
    float3 _273 = normalize(float4(_255, 0.0) * _252);
    float3x3 _274 = _267;
    _274[2] = _273;
    float3x3 _279 = _274;
    _279[1] = normalize(cross(_273, _266) * in.in_var_ATTRIBUTE2.w);
    float3 _280 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _281 = _280 + in.in_var_ATTRIBUTE11;
    float _282 = _281.x;
    float _283 = _281.y;
    float _284 = _281.z;
    float4 _285 = float4(_282, _283, _284, 1.0);
    float3 _286 = _285 * _252;
    float3 _287 = _286 + in.in_var_ATTRIBUTE12;
    float3 _292 = _287.xxx;
    float3 _293 = Primitive.Primitive_LocalToWorld[0u].xyz * _292;
    float3 _297 = _287.yyy;
    float3 _298 = Primitive.Primitive_LocalToWorld[1u].xyz * _297;
    float3 _299 = _293 + _298;
    float3 _303 = _287.zzz;
    float3 _304 = Primitive.Primitive_LocalToWorld[2u].xyz * _303;
    float3 _305 = _299 + _304;
    float3 _309 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _310 = _305 + _309;
    float _311 = _310.x;
    float _312 = _310.y;
    float _313 = _310.z;
    float4 _314 = float4(_311, _312, _313, 1.0);
    spvUnsafeArray<float2, 1> _76;
    _76 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _77 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _316 = 0; _316 < 1; )
    {
        _77[_316] = _76[_316];
        _316++;
        continue;
    }
    float4 _325 = float4(_314.x, _314.y, _314.z, _314.w);
    float4 _326 = View.View_TranslatedWorldToClip * _325;
    float4 _329 = _74;
    _329.w = 0.0;
    float3x3 _342 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _342[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _345 = _342;
    _345[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _348 = _345;
    _348[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _349 = _348 * _279;
    float3 _350 = _349[0];
    spvUnsafeArray<float4, 1> _360 = { float4(_77[0].x, _77[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_350.x, _350.y, _350.z, _329.w);
    out.out_var_TEXCOORD11_centroid = float4(_349[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _360;
    out.gl_Position = _326;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

