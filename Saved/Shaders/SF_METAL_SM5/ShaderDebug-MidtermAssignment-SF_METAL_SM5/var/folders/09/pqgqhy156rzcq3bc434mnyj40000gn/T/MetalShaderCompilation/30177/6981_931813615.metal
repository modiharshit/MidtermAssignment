

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_TranslucentDepthPass
{
    char _m0_pad[112];
    float4x4 TranslucentDepthPass_ProjectionMatrix;
    float TranslucentDepthPass_bClampToNearPlane;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _73 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex MainVS_out Main_00001b45_378a58ef(MainVS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _95 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _101 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _95) : _95;
    float3 _117 = _Globals.SplineParams[3].xyz * 6.0;
    float _125 = _95 * _95;
    float3 _130 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _117) * _125) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _117) * _95)) + _Globals.SplineParams[1].xyz);
    float3 _134 = normalize(cross(_Globals.SplineParams[6].xyz, _130));
    float3 _136 = normalize(cross(_130, _134));
    float _141 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _101);
    float _142 = sin(_141);
    float _143 = cos(_141);
    float3 _146 = (_134 * _143) - (_136 * _142);
    float3 _149 = (_136 * _143) + (_134 * _142);
    float2 _156 = float2(_101);
    float2 _157 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _156);
    float _158 = _157.x;
    float _163 = _157.y;
    float3x3 _175 = transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3x3 _177 = float3x3(_130, _146 * float(int(sign(_158))), _149 * float(int(sign(_163)))) * _175;
    float3 _181 = (_177 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _183 = cross(_181, _177 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _186 = _73;
    _186[0] = cross(_183, _181) * in.in_var_ATTRIBUTE2.w;
    float3x3 _187 = _186;
    _187[1] = _183;
    float3x3 _188 = _187;
    _188[2] = _181;
    float3x3 _202 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _202[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _205 = _202;
    _205[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _208 = _205;
    _208[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _209 = _208 * _188;
    float _213 = _125 * _95;
    float _215 = 3.0 * _125;
    float2 _233 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _156);
    float3x3 _243 = float3x3(float3(0.0), _146 * _158, _149 * _163) * _175;
    float3 _248 = float4x3(_243[0], _243[1], _243[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _213) - _215) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_213 - (2.0 * _125)) + _95))) + (_Globals.SplineParams[4].xyz * (_213 - _125))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _213) + _215))) + (_134 * _233.x)) + (_136 * _233.y)) * in.in_var_ATTRIBUTE0;
    float4 _264 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _248.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _248.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _248.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _265 = float4(_264.x, _264.y, _264.z, _264.w);
    float4 _268 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _265;
    float4 _279;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_268.z < 0.0))
    {
        float4 _277 = _268;
        _277.z = 9.9999999747524270787835121154785e-07;
        float4 _278 = _277;
        _278.w = 1.0;
        _279 = _278;
    }
    else
    {
        _279 = _268;
    }
    spvUnsafeArray<float4, 1> _292 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_209[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_209[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _292;
    out.out_var_TEXCOORD6 = _279.z;
    out.out_var_TEXCOORD7 = _265;
    out.gl_Position = _279;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

