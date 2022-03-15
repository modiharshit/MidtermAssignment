

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
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_Globals
{
    uint PerBoneMotionBlur;
    uint InputWeightIndexSize;
};

constant spvUnsafeArray<float2, 1> _79 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _83 = {};
constant float4 _84 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
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

vertex MainVertexShader_out Main_00002583_e802005f(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]], texture_buffer<float> PreviousBoneMatrices [[texture(2)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    int _107 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _110 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _116 = int(_110 + (_Globals.InputWeightIndexSize * uint(_107)));
    float3x4 _118;
    _118 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _119;
    for (int _121 = 0; _121 < _107; _118 = _119, _121++)
    {
        int _129 = int(_110 + (_Globals.InputWeightIndexSize * uint(_121)));
        int _134 = int(InputWeightStream.read(uint(uint(_129))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _180 = float4(float(InputWeightStream.read(uint(uint(_116 + _121))).x) * 0.0039215688593685626983642578125);
            int _181 = int((InputWeightStream.read(uint(uint(_129 + 1))).x << 8u) | uint(_134)) * 3;
            _119 = float3x4(_118[0] + (_180 * BoneMatrices.read(uint(uint(_181)))), _118[1] + (_180 * BoneMatrices.read(uint(uint(_181 + 1)))), _118[2] + (_180 * BoneMatrices.read(uint(uint(_181 + 2)))));
        }
        else
        {
            float4 _145 = float4(float(InputWeightStream.read(uint(uint(_116 + _121))).x) * 0.0039215688593685626983642578125);
            int _146 = _134 * 3;
            _119 = float3x4(_118[0] + (_145 * BoneMatrices.read(uint(uint(_146)))), _118[1] + (_145 * BoneMatrices.read(uint(uint(_146 + 1)))), _118[2] + (_145 * BoneMatrices.read(uint(uint(_146 + 2)))));
        }
    }
    float3 _203 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _204 = _203.xyz;
    float3 _214 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_204 * dot(in.in_var_ATTRIBUTE1, _204))), 0.0) * _118);
    float3x3 _215 = _83;
    _215[0] = _214;
    float3 _221 = normalize(float4(_203, 0.0) * _118);
    float3x3 _222 = _215;
    _222[2] = _221;
    float3x3 _227 = _222;
    _227[1] = normalize(cross(_221, _214) * in.in_var_ATTRIBUTE2.w);
    float4 _233 = float4((in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9) + in.in_var_ATTRIBUTE11, 1.0);
    float3 _235 = (_233 * _118) + in.in_var_ATTRIBUTE12;
    spvUnsafeArray<float2, 1> _86;
    _86 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _87 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _263 = 0; _263 < 1; )
    {
        _87[_263] = _86[_263];
        _263++;
        continue;
    }
    float4 _274 = _84;
    _274.w = 0.0;
    float3x3 _287 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _287[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _290 = _287;
    _290[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _293 = _290;
    _293[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _294 = _293 * _227;
    float3 _295 = _294[0];
    spvUnsafeArray<float4, 1> _305 = { float4(_87[0].x, _87[0].y, float4(0.0).z, float4(0.0).w) };
    float4x4 _311 = Primitive.Primitive_PreviousLocalToWorld;
    _311[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _315 = _311;
    _315[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _319 = _315;
    _319[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float3x4 _409;
    if (_Globals.PerBoneMotionBlur != 0u)
    {
        float3x4 _326;
        _326 = float3x4(float4(0.0), float4(0.0), float4(0.0));
        float3x4 _327;
        for (int _329 = 0; _329 < _107; _326 = _327, _329++)
        {
            int _337 = int(_110 + (_Globals.InputWeightIndexSize * uint(_329)));
            int _342 = int(InputWeightStream.read(uint(uint(_337))).x);
            if (_Globals.InputWeightIndexSize > 1u)
            {
                float4 _388 = float4(float(InputWeightStream.read(uint(uint(_116 + _329))).x) * 0.0039215688593685626983642578125);
                int _389 = int((InputWeightStream.read(uint(uint(_337 + 1))).x << 8u) | uint(_342)) * 3;
                _327 = float3x4(_326[0] + (_388 * PreviousBoneMatrices.read(uint(uint(_389)))), _326[1] + (_388 * PreviousBoneMatrices.read(uint(uint(_389 + 1)))), _326[2] + (_388 * PreviousBoneMatrices.read(uint(uint(_389 + 2)))));
            }
            else
            {
                float4 _353 = float4(float(InputWeightStream.read(uint(uint(_116 + _329))).x) * 0.0039215688593685626983642578125);
                int _354 = _342 * 3;
                _327 = float3x4(_326[0] + (_353 * PreviousBoneMatrices.read(uint(uint(_354)))), _326[1] + (_353 * PreviousBoneMatrices.read(uint(uint(_354 + 1)))), _326[2] + (_353 * PreviousBoneMatrices.read(uint(uint(_354 + 2)))));
            }
        }
        _409 = _326;
    }
    else
    {
        _409 = _118;
    }
    float4 _423 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _235.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _235.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _235.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _432 = _423;
    _432.z = _423.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _423.w) : 0.0);
    out.gl_Position = _432;
    out.out_var_TEXCOORD6 = _423;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_319 * float4((_233 * _409) + in.in_var_ATTRIBUTE12, 1.0)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_295.x, _295.y, _295.z, _274.w);
    out.out_var_TEXCOORD11_centroid = float4(_294[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _305;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

