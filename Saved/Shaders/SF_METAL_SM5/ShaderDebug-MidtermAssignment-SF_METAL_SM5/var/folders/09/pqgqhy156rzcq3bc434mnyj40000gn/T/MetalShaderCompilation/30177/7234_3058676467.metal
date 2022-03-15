

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_00001c42_b64fb2f3(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _94 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _97 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _103 = int(_97 + (_Globals.InputWeightIndexSize * uint(_94)));
    float3x4 _105;
    _105 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _106;
    for (int _108 = 0; _108 < _94; _105 = _106, _108++)
    {
        int _116 = int(_97 + (_Globals.InputWeightIndexSize * uint(_108)));
        int _121 = int(InputWeightStream.read(uint(uint(_116))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _167 = float4(float(InputWeightStream.read(uint(uint(_103 + _108))).x) * 0.0039215688593685626983642578125);
            int _168 = int((InputWeightStream.read(uint(uint(_116 + 1))).x << 8u) | uint(_121)) * 3;
            _106 = float3x4(_105[0] + (_167 * BoneMatrices.read(uint(uint(_168)))), _105[1] + (_167 * BoneMatrices.read(uint(uint(_168 + 1)))), _105[2] + (_167 * BoneMatrices.read(uint(uint(_168 + 2)))));
        }
        else
        {
            float4 _132 = float4(float(InputWeightStream.read(uint(uint(_103 + _108))).x) * 0.0039215688593685626983642578125);
            int _133 = _121 * 3;
            _106 = float3x4(_105[0] + (_132 * BoneMatrices.read(uint(uint(_133)))), _105[1] + (_132 * BoneMatrices.read(uint(uint(_133 + 1)))), _105[2] + (_132 * BoneMatrices.read(uint(uint(_133 + 2)))));
        }
    }
    float3 _193 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _105);
    float3x3 _194 = _76;
    _194[0] = _193;
    float3 _200 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _105);
    float3x3 _201 = _194;
    _201[2] = _200;
    float3x3 _206 = _201;
    _206[1] = normalize(cross(_200, _193) * in.in_var_ATTRIBUTE2.w);
    float3 _207 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _208 = _207.x;
    float _209 = _207.y;
    float _210 = _207.z;
    float4 _211 = float4(_208, _209, _210, 1.0);
    float3 _212 = _211 * _105;
    float3 _213 = _212 + in.in_var_ATTRIBUTE12;
    float3 _218 = _213.xxx;
    float3 _219 = Primitive.Primitive_LocalToWorld[0u].xyz * _218;
    float3 _223 = _213.yyy;
    float3 _224 = Primitive.Primitive_LocalToWorld[1u].xyz * _223;
    float3 _225 = _219 + _224;
    float3 _229 = _213.zzz;
    float3 _230 = Primitive.Primitive_LocalToWorld[2u].xyz * _229;
    float3 _231 = _225 + _230;
    float3 _235 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _236 = _231 + _235;
    float _237 = _236.x;
    float _238 = _236.y;
    float _239 = _236.z;
    float4 _240 = float4(_237, _238, _239, 1.0);
    spvUnsafeArray<float2, 1> _79;
    _79 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _80 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _242 = 0; _242 < 1; )
    {
        _80[_242] = _79[_242];
        _242++;
        continue;
    }
    float4 _251 = float4(_240.x, _240.y, _240.z, _240.w);
    float4 _252 = View.View_TranslatedWorldToClip * _251;
    float4 _255 = _77;
    _255.w = 0.0;
    float3x3 _268 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _268[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _271 = _268;
    _271[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _274 = _271;
    _274[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _275 = _274 * _206;
    float3 _276 = _275[0];
    spvUnsafeArray<float4, 1> _286 = { float4(_80[0].x, _80[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_276.x, _276.y, _276.z, _255.w);
    out.out_var_TEXCOORD11_centroid = float4(_275[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _286;
    out.out_var_TEXCOORD6 = _251;
    out.gl_Position = _252;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

