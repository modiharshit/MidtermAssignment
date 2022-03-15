

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

constant spvUnsafeArray<float2, 1> _72 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _76 = {};
constant float4 _77 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00001bd5_bb6673f0(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _92 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _95 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _101 = int(_95 + (_Globals.InputWeightIndexSize * uint(_92)));
    float3x4 _103;
    _103 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _104;
    for (int _106 = 0; _106 < _92; _103 = _104, _106++)
    {
        int _114 = int(_95 + (_Globals.InputWeightIndexSize * uint(_106)));
        int _119 = int(InputWeightStream.read(uint(uint(_114))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _165 = float4(float(InputWeightStream.read(uint(uint(_101 + _106))).x) * 0.0039215688593685626983642578125);
            int _166 = int((InputWeightStream.read(uint(uint(_114 + 1))).x << 8u) | uint(_119)) * 3;
            _104 = float3x4(_103[0] + (_165 * BoneMatrices.read(uint(uint(_166)))), _103[1] + (_165 * BoneMatrices.read(uint(uint(_166 + 1)))), _103[2] + (_165 * BoneMatrices.read(uint(uint(_166 + 2)))));
        }
        else
        {
            float4 _130 = float4(float(InputWeightStream.read(uint(uint(_101 + _106))).x) * 0.0039215688593685626983642578125);
            int _131 = _119 * 3;
            _104 = float3x4(_103[0] + (_130 * BoneMatrices.read(uint(uint(_131)))), _103[1] + (_130 * BoneMatrices.read(uint(uint(_131 + 1)))), _103[2] + (_130 * BoneMatrices.read(uint(uint(_131 + 2)))));
        }
    }
    float3 _191 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _103);
    float3x3 _192 = _76;
    _192[0] = _191;
    float3 _198 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _103);
    float3x3 _199 = _192;
    _199[2] = _198;
    float3x3 _204 = _199;
    _204[1] = normalize(cross(_198, _191) * in.in_var_ATTRIBUTE2.w);
    float3 _205 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _206 = _205.x;
    float _207 = _205.y;
    float _208 = _205.z;
    float4 _209 = float4(_206, _207, _208, 1.0);
    float3 _210 = _209 * _103;
    float3 _211 = _210 + in.in_var_ATTRIBUTE12;
    float3 _216 = _211.xxx;
    float3 _217 = Primitive.Primitive_LocalToWorld[0u].xyz * _216;
    float3 _221 = _211.yyy;
    float3 _222 = Primitive.Primitive_LocalToWorld[1u].xyz * _221;
    float3 _223 = _217 + _222;
    float3 _227 = _211.zzz;
    float3 _228 = Primitive.Primitive_LocalToWorld[2u].xyz * _227;
    float3 _229 = _223 + _228;
    float3 _233 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _234 = _229 + _233;
    float _235 = _234.x;
    float _236 = _234.y;
    float _237 = _234.z;
    float4 _238 = float4(_235, _236, _237, 1.0);
    spvUnsafeArray<float2, 1> _79;
    _79 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _80 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _240 = 0; _240 < 1; )
    {
        _80[_240] = _79[_240];
        _240++;
        continue;
    }
    float4 _249 = float4(_238.x, _238.y, _238.z, _238.w);
    float4 _252 = View.View_TranslatedWorldToClip * _249;
    float4 _255 = _77;
    _255.w = 0.0;
    float3x3 _268 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _268[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _271 = _268;
    _271[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _274 = _271;
    _274[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _275 = _274 * _204;
    float3 _276 = _275[0];
    spvUnsafeArray<float4, 1> _286 = { float4(_80[0].x, _80[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_276.x, _276.y, _276.z, _255.w);
    out.out_var_TEXCOORD11_centroid = float4(_275[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _286;
    out.out_var_TEXCOORD6 = _249;
    out.gl_Position = _252;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

