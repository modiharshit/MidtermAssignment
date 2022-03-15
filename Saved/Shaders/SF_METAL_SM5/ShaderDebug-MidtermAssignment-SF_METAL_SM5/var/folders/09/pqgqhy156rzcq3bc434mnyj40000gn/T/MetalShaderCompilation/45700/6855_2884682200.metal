

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
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _65 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex MainVertexShader_out Main_00001ac7_abf0c1d8(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    MainVertexShader_out out = {};
    float _96 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _102 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _96) : _96;
    float3 _118 = _Globals.SplineParams[3].xyz * 6.0;
    float _126 = _96 * _96;
    float3 _131 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _118) * _126) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _118) * _96)) + _Globals.SplineParams[1].xyz);
    float3 _135 = normalize(cross(_Globals.SplineParams[6].xyz, _131));
    float3 _137 = normalize(cross(_131, _135));
    float _142 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _102);
    float _143 = sin(_142);
    float _144 = cos(_142);
    float3 _147 = (_135 * _144) - (_137 * _143);
    float3 _150 = (_137 * _144) + (_135 * _143);
    float2 _157 = float2(_102);
    float2 _158 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _157);
    float _159 = _158.x;
    float _164 = _158.y;
    float3x3 _176 = transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3x3 _178 = float3x3(_131, _147 * float(int(sign(_159))), _150 * float(int(sign(_164)))) * _176;
    float3 _182 = (_178 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _184 = cross(_182, _178 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _187 = _65;
    _187[0] = cross(_184, _182) * in.in_var_ATTRIBUTE2.w;
    float3x3 _188 = _187;
    _188[1] = _184;
    float3x3 _189 = _188;
    _189[2] = _182;
    float3x3 _203 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _203[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _206 = _203;
    _206[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _209 = _206;
    _209[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _210 = _209 * _189;
    float _214 = _126 * _96;
    float _216 = 3.0 * _126;
    float2 _234 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _157);
    float3x3 _244 = float3x3(float3(0.0), _147 * _159, _150 * _164) * _176;
    float3 _249 = float4x3(_244[0], _244[1], _244[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _214) - _216) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_214 - (2.0 * _126)) + _96))) + (_Globals.SplineParams[4].xyz * (_214 - _126))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _214) + _216))) + (_135 * _234.x)) + (_137 * _234.y)) * in.in_var_ATTRIBUTE0;
    float4x4 _280 = Primitive.Primitive_PreviousLocalToWorld;
    _280[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _284 = _280;
    _284[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _288 = _284;
    _288[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _301 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0].xyz * _249.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _249.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _249.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _308 = _301;
    _308.z = _301.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _301.w) : 0.0);
    out.gl_Position = _308;
    out.out_var_TEXCOORD6 = _301;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_288 * float4(_249, in.in_var_ATTRIBUTE0.w)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_210[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_210[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

