

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

constant float3x3 _70 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001beb_724862fa(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    Main_out out = {};
    float _93 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _99 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _93) : _93;
    float3 _115 = _Globals.SplineParams[3].xyz * 6.0;
    float _123 = _93 * _93;
    float3 _128 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _115) * _123) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _115) * _93)) + _Globals.SplineParams[1].xyz);
    float3 _132 = normalize(cross(_Globals.SplineParams[6].xyz, _128));
    float3 _134 = normalize(cross(_128, _132));
    float _139 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _99);
    float _140 = sin(_139);
    float _141 = cos(_139);
    float3 _144 = (_132 * _141) - (_134 * _140);
    float3 _147 = (_134 * _141) + (_132 * _140);
    float2 _154 = float2(_99);
    float2 _155 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _154);
    float _156 = _155.x;
    float _161 = _155.y;
    float3x3 _173 = transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3x3 _175 = float3x3(_128, _144 * float(int(sign(_156))), _147 * float(int(sign(_161)))) * _173;
    float3 _179 = (_175 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _181 = cross(_179, _175 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _184 = _70;
    _184[0] = cross(_181, _179) * in.in_var_ATTRIBUTE2.w;
    float3x3 _185 = _184;
    _185[1] = _181;
    float3x3 _186 = _185;
    _186[2] = _179;
    float3x3 _200 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _200[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _203 = _200;
    _203[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _206 = _203;
    _206[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _207 = _206 * _186;
    float _211 = _123 * _93;
    float _213 = 3.0 * _123;
    float2 _231 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _154);
    float3x3 _241 = float3x3(float3(0.0), _144 * _156, _147 * _161) * _173;
    float3 _246 = float4x3(_241[0], _241[1], _241[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _211) - _213) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_211 - (2.0 * _123)) + _93))) + (_Globals.SplineParams[4].xyz * (_211 - _123))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _211) + _213))) + (_132 * _231.x)) + (_134 * _231.y)) * in.in_var_ATTRIBUTE0;
    float4 _262 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _246.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _246.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _246.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float3 _263 = _207[2];
    float4 _269 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_262.x, _262.y, _262.z, _262.w);
    float4 _280;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_269.z < 0.0))
    {
        float4 _278 = _269;
        _278.z = 9.9999999747524270787835121154785e-07;
        float4 _279 = _278;
        _279.w = 1.0;
        _280 = _279;
    }
    else
    {
        _280 = _269;
    }
    float _286 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _263));
    out.out_var_TEXCOORD10_centroid = float4(_207[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_263, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _280.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_286) > 0.0) ? (sqrt(fast::clamp(1.0 - (_286 * _286), 0.0, 1.0)) / _286) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _262.xyz;
    out.gl_Position = _280;
    return out;
}

