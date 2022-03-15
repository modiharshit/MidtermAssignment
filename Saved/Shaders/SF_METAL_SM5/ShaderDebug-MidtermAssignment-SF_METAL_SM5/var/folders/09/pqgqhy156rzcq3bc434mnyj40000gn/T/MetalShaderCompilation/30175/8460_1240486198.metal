

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

constant spvUnsafeArray<float2, 1> _73 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _74 = {};
constant float4 _75 = {};

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

vertex Main_out Main_0000210c_49f05136(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _95 = float4(in.in_var_ATTRIBUTE4.x);
    int _98 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _112 = float4(in.in_var_ATTRIBUTE4.y);
    int _115 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _131 = float4(in.in_var_ATTRIBUTE4.z);
    int _134 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _150 = float4(in.in_var_ATTRIBUTE4.w);
    int _153 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _165 = (((_95 * BoneMatrices.read(uint(uint(_98)))) + (_112 * BoneMatrices.read(uint(uint(_115))))) + (_131 * BoneMatrices.read(uint(uint(_134))))) + (_150 * BoneMatrices.read(uint(uint(_153))));
    float4 _166 = (((_95 * BoneMatrices.read(uint(uint(_98 + 1)))) + (_112 * BoneMatrices.read(uint(uint(_115 + 1))))) + (_131 * BoneMatrices.read(uint(uint(_134 + 1))))) + (_150 * BoneMatrices.read(uint(uint(_153 + 1))));
    float4 _167 = (((_95 * BoneMatrices.read(uint(uint(_98 + 2)))) + (_112 * BoneMatrices.read(uint(uint(_115 + 2))))) + (_131 * BoneMatrices.read(uint(uint(_134 + 2))))) + (_150 * BoneMatrices.read(uint(uint(_153 + 2))));
    float3x4 _251;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _175 = float4(in.in_var_ATTRIBUTE15.x);
        int _178 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _194 = float4(in.in_var_ATTRIBUTE15.y);
        int _197 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _213 = float4(in.in_var_ATTRIBUTE15.z);
        int _216 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _232 = float4(in.in_var_ATTRIBUTE15.w);
        int _235 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _251 = float3x4((((_165 + (_175 * BoneMatrices.read(uint(uint(_178))))) + (_194 * BoneMatrices.read(uint(uint(_197))))) + (_213 * BoneMatrices.read(uint(uint(_216))))) + (_232 * BoneMatrices.read(uint(uint(_235)))), (((_166 + (_175 * BoneMatrices.read(uint(uint(_178 + 1))))) + (_194 * BoneMatrices.read(uint(uint(_197 + 1))))) + (_213 * BoneMatrices.read(uint(uint(_216 + 1))))) + (_232 * BoneMatrices.read(uint(uint(_235 + 1)))), (((_167 + (_175 * BoneMatrices.read(uint(uint(_178 + 2))))) + (_194 * BoneMatrices.read(uint(uint(_197 + 2))))) + (_213 * BoneMatrices.read(uint(uint(_216 + 2))))) + (_232 * BoneMatrices.read(uint(uint(_235 + 2)))));
    }
    else
    {
        _251 = float3x4(_165, _166, _167);
    }
    float3 _254 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _255 = _254.xyz;
    float3 _265 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_255 * dot(in.in_var_ATTRIBUTE1, _255))), 0.0) * _251);
    float3x3 _266 = _74;
    _266[0] = _265;
    float3 _272 = normalize(float4(_254, 0.0) * _251);
    float3x3 _273 = _266;
    _273[2] = _272;
    float3x3 _278 = _273;
    _278[1] = normalize(cross(_272, _265) * in.in_var_ATTRIBUTE2.w);
    float3 _279 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _280 = _279 + in.in_var_ATTRIBUTE11;
    float _281 = _280.x;
    float _282 = _280.y;
    float _283 = _280.z;
    float4 _284 = float4(_281, _282, _283, 1.0);
    float3 _285 = _284 * _251;
    float3 _286 = _285 + in.in_var_ATTRIBUTE12;
    float3 _291 = _286.xxx;
    float3 _292 = Primitive.Primitive_LocalToWorld[0u].xyz * _291;
    float3 _296 = _286.yyy;
    float3 _297 = Primitive.Primitive_LocalToWorld[1u].xyz * _296;
    float3 _298 = _292 + _297;
    float3 _302 = _286.zzz;
    float3 _303 = Primitive.Primitive_LocalToWorld[2u].xyz * _302;
    float3 _304 = _298 + _303;
    float3 _308 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _309 = _304 + _308;
    float _310 = _309.x;
    float _311 = _309.y;
    float _312 = _309.z;
    float4 _313 = float4(_310, _311, _312, 1.0);
    spvUnsafeArray<float2, 1> _77;
    _77 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _78 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _315 = 0; _315 < 1; )
    {
        _78[_315] = _77[_315];
        _315++;
        continue;
    }
    float4 _324 = float4(_313.x, _313.y, _313.z, _313.w);
    float4 _327 = View.View_TranslatedWorldToClip * _324;
    float4 _330 = _75;
    _330.w = 0.0;
    float3x3 _343 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _343[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _346 = _343;
    _346[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _349 = _346;
    _349[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _350 = _349 * _278;
    float3 _351 = _350[0];
    spvUnsafeArray<float4, 1> _361 = { float4(_78[0].x, _78[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_351.x, _351.y, _351.z, _330.w);
    out.out_var_TEXCOORD11_centroid = float4(_350[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _361;
    out.out_var_TEXCOORD6 = _324;
    out.gl_Position = _327;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

