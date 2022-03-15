

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

constant spvUnsafeArray<float2, 1> _71 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _75 = {};
constant float4 _76 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00001b96_58e3e107(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _93 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _96 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _102 = int(_96 + (_Globals.InputWeightIndexSize * uint(_93)));
    float3x4 _104;
    _104 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _105;
    for (int _107 = 0; _107 < _93; _104 = _105, _107++)
    {
        int _115 = int(_96 + (_Globals.InputWeightIndexSize * uint(_107)));
        int _120 = int(InputWeightStream.read(uint(uint(_115))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _166 = float4(float(InputWeightStream.read(uint(uint(_102 + _107))).x) * 0.0039215688593685626983642578125);
            int _167 = int((InputWeightStream.read(uint(uint(_115 + 1))).x << 8u) | uint(_120)) * 3;
            _105 = float3x4(_104[0] + (_166 * BoneMatrices.read(uint(uint(_167)))), _104[1] + (_166 * BoneMatrices.read(uint(uint(_167 + 1)))), _104[2] + (_166 * BoneMatrices.read(uint(uint(_167 + 2)))));
        }
        else
        {
            float4 _131 = float4(float(InputWeightStream.read(uint(uint(_102 + _107))).x) * 0.0039215688593685626983642578125);
            int _132 = _120 * 3;
            _105 = float3x4(_104[0] + (_131 * BoneMatrices.read(uint(uint(_132)))), _104[1] + (_131 * BoneMatrices.read(uint(uint(_132 + 1)))), _104[2] + (_131 * BoneMatrices.read(uint(uint(_132 + 2)))));
        }
    }
    float3 _192 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _104);
    float3x3 _193 = _75;
    _193[0] = _192;
    float3 _199 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _104);
    float3x3 _200 = _193;
    _200[2] = _199;
    float3x3 _205 = _200;
    _205[1] = normalize(cross(_199, _192) * in.in_var_ATTRIBUTE2.w);
    float3 _206 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _207 = _206.x;
    float _208 = _206.y;
    float _209 = _206.z;
    float4 _210 = float4(_207, _208, _209, 1.0);
    float3 _211 = _210 * _104;
    float3 _212 = _211 + in.in_var_ATTRIBUTE12;
    float3 _217 = _212.xxx;
    float3 _218 = Primitive.Primitive_LocalToWorld[0u].xyz * _217;
    float3 _222 = _212.yyy;
    float3 _223 = Primitive.Primitive_LocalToWorld[1u].xyz * _222;
    float3 _224 = _218 + _223;
    float3 _228 = _212.zzz;
    float3 _229 = Primitive.Primitive_LocalToWorld[2u].xyz * _228;
    float3 _230 = _224 + _229;
    float3 _234 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _235 = _230 + _234;
    float _236 = _235.x;
    float _237 = _235.y;
    float _238 = _235.z;
    float4 _239 = float4(_236, _237, _238, 1.0);
    spvUnsafeArray<float2, 1> _78;
    _78 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _79 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _241 = 0; _241 < 1; )
    {
        _79[_241] = _78[_241];
        _241++;
        continue;
    }
    float4 _250 = float4(_239.x, _239.y, _239.z, _239.w);
    float4 _251 = View.View_TranslatedWorldToClip * _250;
    float4 _254 = _76;
    _254.w = 0.0;
    float3x3 _267 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _267[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _270 = _267;
    _270[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _273 = _270;
    _273[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _274 = _273 * _205;
    float3 _275 = _274[0];
    spvUnsafeArray<float4, 1> _285 = { float4(_79[0].x, _79[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_275.x, _275.y, _275.z, _254.w);
    out.out_var_TEXCOORD11_centroid = float4(_274[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _285;
    out.gl_Position = _251;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

