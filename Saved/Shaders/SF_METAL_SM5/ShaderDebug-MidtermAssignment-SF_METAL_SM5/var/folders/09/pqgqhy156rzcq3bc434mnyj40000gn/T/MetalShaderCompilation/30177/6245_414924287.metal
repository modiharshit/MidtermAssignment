

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
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _66 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex MainVS_out Main_00001865_18bb3dff(MainVS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
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
    float3 _178 = cross(_176, _172 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _181 = _66;
    _181[0] = cross(_178, _176) * in.in_var_ATTRIBUTE2.w;
    float3x3 _182 = _181;
    _182[1] = _178;
    float3x3 _183 = _182;
    _183[2] = _176;
    float3x3 _197 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _197[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _200 = _197;
    _200[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _203 = _200;
    _203[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _204 = _203 * _183;
    float _208 = _120 * _90;
    float _210 = 3.0 * _120;
    float2 _228 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _151);
    float3x3 _238 = float3x3(float3(0.0), _141 * _153, _144 * _158) * _170;
    float3 _243 = float4x3(_238[0], _238[1], _238[2], (((((_Globals.SplineParams[0].xyz * (((2.0 * _208) - _210) + 1.0)) + (_Globals.SplineParams[1].xyz * ((_208 - (2.0 * _120)) + _90))) + (_Globals.SplineParams[4].xyz * (_208 - _120))) + (_Globals.SplineParams[3].xyz * (((-2.0) * _208) + _210))) + (_129 * _228.x)) + (_131 * _228.y)) * in.in_var_ATTRIBUTE0;
    float4 _259 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _243.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _243.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _243.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0);
    float4 _261 = View.View_TranslatedWorldToClip * float4(_259.x, _259.y, _259.z, _259.w);
    spvUnsafeArray<float4, 1> _273 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    float4 _278 = _261;
    _278.z = _261.z + (9.9999997473787516355514526367188e-05 * _261.w);
    out.out_var_TEXCOORD10_centroid = float4(_204[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_204[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _273;
    out.gl_Position = _278;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

