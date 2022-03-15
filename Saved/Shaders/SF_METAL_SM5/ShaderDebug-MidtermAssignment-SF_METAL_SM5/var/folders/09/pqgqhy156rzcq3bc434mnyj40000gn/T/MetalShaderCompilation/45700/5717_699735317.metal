

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
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001655_29b51d15(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    Main_out out = {};
    float _64 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _68 = _64 * _Globals.SplineParams[6].w;
    float _72 = _68 - _Globals.SplineParams[4].w;
    bool _76 = _Globals.SplineParams[3].w != 0.0;
    float _77 = smoothstep(0.0, 1.0, _72);
    float _78 = _76 ? _77 : _72;
    float _89 = _72 * _72;
    float _90 = _89 * _72;
    float _91 = 2.0 * _90;
    float _92 = 3.0 * _89;
    float _93 = _91 - _92;
    float _94 = _93 + 1.0;
    float3 _95 = _Globals.SplineParams[0].xyz * _94;
    float _96 = 2.0 * _89;
    float _97 = _90 - _96;
    float _98 = _97 + _72;
    float3 _99 = _Globals.SplineParams[1].xyz * _98;
    float3 _100 = _95 + _99;
    float _101 = _90 - _89;
    float3 _102 = _Globals.SplineParams[4].xyz * _101;
    float3 _103 = _100 + _102;
    float _104 = (-2.0) * _90;
    float _105 = _104 + _92;
    float3 _106 = _Globals.SplineParams[3].xyz * _105;
    float3 _107 = _103 + _106;
    float3 _108 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _109 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _110 = _108 + _109;
    float3 _111 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _112 = _110 + _111;
    float3 _113 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _114 = _112 - _113;
    float3 _115 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _116 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _117 = _115 - _116;
    float3 _118 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _119 = _117 - _118;
    float3 _120 = _119 + _113;
    float3 _121 = _114 * _89;
    float3 _122 = _120 * _72;
    float3 _123 = _121 + _122;
    float3 _124 = _123 + _Globals.SplineParams[1].xyz;
    float3 _125 = normalize(_124);
    float3 _128 = cross(_Globals.SplineParams[6].xyz, _125);
    float3 _129 = normalize(_128);
    float3 _130 = cross(_125, _129);
    float3 _131 = normalize(_130);
    float2 _138 = float2(_78);
    float2 _139 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _138);
    float _140 = _139.x;
    float3 _141 = _129 * _140;
    float3 _142 = _107 + _141;
    float _143 = _139.y;
    float3 _144 = _131 * _143;
    float3 _145 = _142 + _144;
    float _150 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _78);
    float _151 = sin(_150);
    float _152 = cos(_150);
    float3 _153 = _129 * _152;
    float3 _154 = _131 * _151;
    float3 _155 = _153 - _154;
    float3 _156 = _131 * _152;
    float3 _157 = _129 * _151;
    float3 _158 = _156 + _157;
    float2 _161 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _138);
    float _162 = _161.x;
    float3 _163 = _155 * _162;
    float _164 = _161.y;
    float3 _165 = _158 * _164;
    float3x3 _172 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _173 = transpose(_172);
    float3x3 _174 = float3x3(float3(0.0), _163, _165);
    float3x3 _175 = _174 * _173;
    float3 _176 = _175[0];
    float3 _177 = _175[1];
    float3 _178 = _175[2];
    float4x3 _179 = float4x3(_176, _177, _178, _145);
    float3 _180 = _179 * in.in_var_ATTRIBUTE0;
    float3 _185 = _180.xxx;
    float3 _186 = Primitive.Primitive_LocalToWorld[0].xyz * _185;
    float3 _189 = _180.yyy;
    float3 _190 = Primitive.Primitive_LocalToWorld[1].xyz * _189;
    float3 _191 = _186 + _190;
    float3 _194 = _180.zzz;
    float3 _195 = Primitive.Primitive_LocalToWorld[2].xyz * _194;
    float3 _196 = _191 + _195;
    float3 _199 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _200 = _196 + _199;
    float _201 = _200.x;
    float _202 = _200.y;
    float _203 = _200.z;
    float4 _204 = float4(_201, _202, _203, 1.0);
    float4 _205 = View.View_TranslatedWorldToClip * _204;
    out.gl_Position = _205;
    return out;
}

