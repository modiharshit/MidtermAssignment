

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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001a43_6de0660b(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    Main_out out = {};
    float _90 = (dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz) * _Globals.SplineParams[6].w) - _Globals.SplineParams[4].w;
    float _96 = (_Globals.SplineParams[3].w != 0.0) ? smoothstep(0.0, 1.0, _90) : _90;
    float3 _112 = _Globals.SplineParams[3].xyz * 6.0;
    float _120 = _90 * _90;
    float3 _125 = normalize(((((((_Globals.SplineParams[0].xyz * 6.0) + (_Globals.SplineParams[1].xyz * 3.0)) + (_Globals.SplineParams[4].xyz * 3.0)) - _112) * _120) + (((((_Globals.SplineParams[0].xyz * (-6.0)) - (_Globals.SplineParams[1].xyz * 4.0)) - (_Globals.SplineParams[4].xyz * 2.0)) + _112) * _90)) + _Globals.SplineParams[1].xyz);
    float3 _129 = normalize(cross(_Globals.SplineParams[6].xyz, _125));
    float3 _131 = normalize(cross(_125, _129));
    float _136 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _96);
    float _137 = sin(_136);
    float _138 = cos(_136);
    float3 _141 = (_129 * _138) - (_131 * _137);
    float3 _144 = (_131 * _138) + (_129 * _137);
    float2 _151 = float2(_96);
    float2 _152 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _151);
    float _153 = _152.x;
    float _158 = _152.y;
    float3x3 _170 = transpose(float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz));
    float3x3 _172 = float3x3(_125, _141 * float(int(sign(_153))), _144 * float(int(sign(_158)))) * _170;
    float3 _176 = (_172 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _179 = cross(_176, _172 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _182 = _68;
    _182[0] = cross(_179, _176) * in.in_var_ATTRIBUTE2.w;
    float3x3 _183 = _182;
    _183[1] = _179;
    float3x3 _184 = _183;
    _184[2] = _176;
    float3x3 _198 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _198[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _201 = _198;
    _201[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _204 = _201;
    _204[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float _206 = _120 * _90;
    float _208 = 3.0 * _120;
    float2 _226 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _151);
    float3x3 _236 = float3x3(float3(0.0), _141 * _153, _144 * _158) * _170;
    float3 _241 = float4x3(_236[0], _236[1], _236[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _206) - _208) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_206 - (2.0 * _120)) + _90))) + (_Globals.SplineParams[4].xyz * (_206 - _120))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _206) + _208))) + (_129 * _226.x)) + (_131 * _226.y)) * in.in_var_ATTRIBUTE0;
    float4 _257 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _241.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _241.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _241.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _264 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_257.x, _257.y, _257.z, _257.w);
    float4 _275;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_264.z < 0.0))
    {
        float4 _273 = _264;
        _273.z = 9.9999999747524270787835121154785e-07;
        float4 _274 = _273;
        _274.w = 1.0;
        _275 = _274;
    }
    else
    {
        _275 = _264;
    }
    float _281 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), (_204 * _184)[2]));
    out.out_var_TEXCOORD6 = _275.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_281) > 0.0) ? (sqrt(fast::clamp(1.0 - (_281 * _281), 0.0, 1.0)) / _281) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _275;
    return out;
}

