

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

constant spvUnsafeArray<float2, 1> _70 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _71 = {};
constant float4 _72 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00001f9a_632e6eb7(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _92 = float4(in.in_var_ATTRIBUTE4.x);
    int _95 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _109 = float4(in.in_var_ATTRIBUTE4.y);
    int _112 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _128 = float4(in.in_var_ATTRIBUTE4.z);
    int _131 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _147 = float4(in.in_var_ATTRIBUTE4.w);
    int _150 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _162 = (((_92 * BoneMatrices.read(uint(uint(_95)))) + (_109 * BoneMatrices.read(uint(uint(_112))))) + (_128 * BoneMatrices.read(uint(uint(_131))))) + (_147 * BoneMatrices.read(uint(uint(_150))));
    float4 _163 = (((_92 * BoneMatrices.read(uint(uint(_95 + 1)))) + (_109 * BoneMatrices.read(uint(uint(_112 + 1))))) + (_128 * BoneMatrices.read(uint(uint(_131 + 1))))) + (_147 * BoneMatrices.read(uint(uint(_150 + 1))));
    float4 _164 = (((_92 * BoneMatrices.read(uint(uint(_95 + 2)))) + (_109 * BoneMatrices.read(uint(uint(_112 + 2))))) + (_128 * BoneMatrices.read(uint(uint(_131 + 2))))) + (_147 * BoneMatrices.read(uint(uint(_150 + 2))));
    float3x4 _248;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _172 = float4(in.in_var_ATTRIBUTE15.x);
        int _175 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _191 = float4(in.in_var_ATTRIBUTE15.y);
        int _194 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _210 = float4(in.in_var_ATTRIBUTE15.z);
        int _213 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _229 = float4(in.in_var_ATTRIBUTE15.w);
        int _232 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _248 = float3x4((((_162 + (_172 * BoneMatrices.read(uint(uint(_175))))) + (_191 * BoneMatrices.read(uint(uint(_194))))) + (_210 * BoneMatrices.read(uint(uint(_213))))) + (_229 * BoneMatrices.read(uint(uint(_232)))), (((_163 + (_172 * BoneMatrices.read(uint(uint(_175 + 1))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 1))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 1))))) + (_229 * BoneMatrices.read(uint(uint(_232 + 1)))), (((_164 + (_172 * BoneMatrices.read(uint(uint(_175 + 2))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 2))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 2))))) + (_229 * BoneMatrices.read(uint(uint(_232 + 2)))));
    }
    else
    {
        _248 = float3x4(_162, _163, _164);
    }
    float3 _254 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _248);
    float3x3 _255 = _71;
    _255[0] = _254;
    float3 _261 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _248);
    float3x3 _262 = _255;
    _262[2] = _261;
    float3x3 _267 = _262;
    _267[1] = normalize(cross(_261, _254) * in.in_var_ATTRIBUTE2.w);
    float3 _268 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _269 = _268.x;
    float _270 = _268.y;
    float _271 = _268.z;
    float4 _272 = float4(_269, _270, _271, 1.0);
    float3 _273 = _272 * _248;
    float3 _274 = _273 + in.in_var_ATTRIBUTE12;
    float3 _279 = _274.xxx;
    float3 _280 = Primitive.Primitive_LocalToWorld[0u].xyz * _279;
    float3 _284 = _274.yyy;
    float3 _285 = Primitive.Primitive_LocalToWorld[1u].xyz * _284;
    float3 _286 = _280 + _285;
    float3 _290 = _274.zzz;
    float3 _291 = Primitive.Primitive_LocalToWorld[2u].xyz * _290;
    float3 _292 = _286 + _291;
    float3 _296 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _297 = _292 + _296;
    float _298 = _297.x;
    float _299 = _297.y;
    float _300 = _297.z;
    float4 _301 = float4(_298, _299, _300, 1.0);
    spvUnsafeArray<float2, 1> _74;
    _74 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _75 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _303 = 0; _303 < 1; )
    {
        _75[_303] = _74[_303];
        _303++;
        continue;
    }
    float4 _312 = float4(_301.x, _301.y, _301.z, _301.w);
    float4 _313 = View.View_TranslatedWorldToClip * _312;
    float4 _316 = _72;
    _316.w = 0.0;
    float3x3 _329 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _329[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _332 = _329;
    _332[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _335 = _332;
    _335[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _336 = _335 * _267;
    float3 _337 = _336[0];
    spvUnsafeArray<float4, 1> _347 = { float4(_75[0].x, _75[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_337.x, _337.y, _337.z, _316.w);
    out.out_var_TEXCOORD11_centroid = float4(_336[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _347;
    out.gl_Position = _313;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

