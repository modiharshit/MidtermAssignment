

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

constant float3x3 _68 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001c06_e195d92a(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    Main_out out = {};
    float _92 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _98 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _92) : _92;
    float3 _114 = _Globals.SplineParams[3].xyz * 6.0;
    float _122 = _92 * _92;
    float3 _127 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _114) * _122) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _114) * _92)) + _Globals.SplineParams[1].xyz);
    float3 _131 = normalize(cross(_Globals.SplineParams[6].xyz, _127));
    float3 _133 = normalize(cross(_127, _131));
    float _138 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _98);
    float _139 = sin(_138);
    float _140 = cos(_138);
    float3 _143 = (_131 * _140) - (_133 * _139);
    float3 _146 = (_133 * _140) + (_131 * _139);
    float2 _153 = float2(_98);
    float2 _154 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _153);
    float _155 = _154.x;
    float _160 = _154.y;
    float3x3 _172 = transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3x3 _174 = float3x3(_127, _143 * float(int(sign(_155))), _146 * float(int(sign(_160)))) * _172;
    float3 _178 = (_174 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _180 = cross(_178, _174 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _183 = _68;
    _183[0] = cross(_180, _178) * in.in_var_ATTRIBUTE2.w;
    float3x3 _184 = _183;
    _184[1] = _180;
    float3x3 _185 = _184;
    _185[2] = _178;
    float3x3 _199 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _199[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _202 = _199;
    _202[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _205 = _202;
    _205[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _206 = _205 * _185;
    float _210 = _122 * _92;
    float _212 = 3.0 * _122;
    float2 _230 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _153);
    float3x3 _240 = float3x3(float3(0.0), _143 * _155, _146 * _160) * _172;
    float3 _245 = float4x3(_240[0], _240[1], _240[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _210) - _212) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_210 - (2.0 * _122)) + _92))) + (_Globals.SplineParams[4].xyz * (_210 - _122))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _210) + _212))) + (_131 * _230.x)) + (_133 * _230.y)) * in.in_var_ATTRIBUTE0;
    float4 _261 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _245.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _245.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _245.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float3 _262 = _206[2];
    float4 _268 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_261.x, _261.y, _261.z, _261.w);
    float4 _279;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_268.z < 0.0))
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
    float _285 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _262));
    float4 _310 = _279;
    _310.z = ((_279.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_285) > 0.0) ? (sqrt(fast::clamp(1.0 - (_285 * _285), 0.0, 1.0)) / _285) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _279.w;
    out.out_var_TEXCOORD10_centroid = float4(_206[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_262, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _261.xyz;
    out.gl_Position = _310;
    return out;
}

