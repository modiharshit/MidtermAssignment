

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

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _66 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001a5e_b81e99a3(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    Main_out out = {};
    float _89 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _95 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _89) : _89;
    float3 _111 = _Globals.SplineParams[3].xyz * 6.0;
    float _119 = _89 * _89;
    float3 _124 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _111) * _119) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _111) * _89)) + _Globals.SplineParams[1].xyz);
    float3 _128 = normalize(cross(_Globals.SplineParams[6].xyz, _124));
    float3 _130 = normalize(cross(_124, _128));
    float _135 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _95);
    float _136 = sin(_135);
    float _137 = cos(_135);
    float3 _140 = (_128 * _137) - (_130 * _136);
    float3 _143 = (_130 * _137) + (_128 * _136);
    float2 _150 = float2(_95);
    float2 _151 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _150);
    float _152 = _151.x;
    float _157 = _151.y;
    float3x3 _169 = transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3x3 _171 = float3x3(_124, _140 * float(int(sign(_152))), _143 * float(int(sign(_157)))) * _169;
    float3 _175 = (_171 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _178 = cross(_175, _171 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _181 = _66;
    _181[0] = cross(_178, _175) * in.in_var_ATTRIBUTE2.w;
    float3x3 _182 = _181;
    _182[1] = _178;
    float3x3 _183 = _182;
    _183[2] = _175;
    float3x3 _197 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _197[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _200 = _197;
    _200[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _203 = _200;
    _203[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float _205 = _119 * _89;
    float _207 = 3.0 * _119;
    float2 _225 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _150);
    float3x3 _235 = float3x3(float3(0.0), _140 * _152, _143 * _157) * _169;
    float3 _240 = float4x3(_235[0], _235[1], _235[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _205) - _207) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_205 - (2.0 * _119)) + _89))) + (_Globals.SplineParams[4].xyz * (_205 - _119))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _205) + _207))) + (_128 * _225.x)) + (_130 * _225.y)) * in.in_var_ATTRIBUTE0;
    float4 _256 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _240.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _240.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _240.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _263 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_256.x, _256.y, _256.z, _256.w);
    float4 _274;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_263.z < 0.0))
    {
        float4 _272 = _263;
        _272.z = 9.9999999747524270787835121154785e-07;
        float4 _273 = _272;
        _273.w = 1.0;
        _274 = _273;
    }
    else
    {
        _274 = _263;
    }
    float _280 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (_203 * _183)[2]));
    float4 _305 = _274;
    _305.z = ((_274.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_280) > 0.0) ? (sqrt(fast::clamp(1.0 - (_280 * _280), 0.0, 1.0)) / _280) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _274.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _305;
    return out;
}

