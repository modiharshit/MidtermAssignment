

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

constant float3x3 _72 = {};

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
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex MainVertexShader_out Main_00001c46_101b6b40(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _102 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _108 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _102) : _102;
    float3 _124 = _Globals.SplineParams[3].xyz * 6.0;
    float _132 = _102 * _102;
    float3 _137 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _124) * _132) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _124) * _102)) + _Globals.SplineParams[1].xyz);
    float3 _141 = normalize(cross(_Globals.SplineParams[6].xyz, _137));
    float3 _143 = normalize(cross(_137, _141));
    float _148 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _108);
    float _149 = sin(_148);
    float _150 = cos(_148);
    float3 _153 = (_141 * _150) - (_143 * _149);
    float3 _156 = (_143 * _150) + (_141 * _149);
    float2 _163 = float2(_108);
    float2 _164 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _163);
    float _165 = _164.x;
    float _170 = _164.y;
    float3x3 _182 = transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3x3 _184 = float3x3(_137, _153 * float(int(sign(_165))), _156 * float(int(sign(_170)))) * _182;
    float3 _188 = (_184 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _190 = cross(_188, _184 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _193 = _72;
    _193[0] = cross(_190, _188) * in.in_var_ATTRIBUTE2.w;
    float3x3 _194 = _193;
    _194[1] = _190;
    float3x3 _195 = _194;
    _195[2] = _188;
    float3x3 _209 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _209[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _212 = _209;
    _212[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _215 = _212;
    _215[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _216 = _215 * _195;
    float _220 = _132 * _102;
    float _222 = 3.0 * _132;
    float2 _240 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _163);
    float3x3 _250 = float3x3(float3(0.0), _153 * _165, _156 * _170) * _182;
    float3 _255 = float4x3(_250[0], _250[1], _250[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _220) - _222) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_220 - (2.0 * _132)) + _102))) + (_Globals.SplineParams[4].xyz * (_220 - _132))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _220) + _222))) + (_141 * _240.x)) + (_143 * _240.y)) * in.in_var_ATTRIBUTE0;
    spvUnsafeArray<float4, 1> _284 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float4x4 _288 = Primitive.Primitive_PreviousLocalToWorld;
    _288[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _292 = _288;
    _292[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _296 = _292;
    _296[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _309 = View.View_TranslatedWorldToClip * float4((((Primitive.Primitive_LocalToWorld[0].xyz * _255.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _255.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _255.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _316 = _309;
    _316.z = _309.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _309.w) : 0.0);
    out.gl_Position = _316;
    out.out_var_TEXCOORD6 = _309;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_296 * float4(_255, in.in_var_ATTRIBUTE0.w)).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_216[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_216[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _284;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

