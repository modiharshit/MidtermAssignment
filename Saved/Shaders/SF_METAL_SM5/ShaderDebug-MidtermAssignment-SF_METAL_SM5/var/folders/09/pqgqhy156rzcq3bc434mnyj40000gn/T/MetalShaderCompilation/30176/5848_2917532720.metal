

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

vertex Main_out Main_000016d8_ade60430(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    Main_out out = {};
    float _70 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _74 = _70 * _Globals.SplineParams[6].w;
    float _78 = _74 - _Globals.SplineParams[4].w;
    bool _82 = _Globals.SplineParams[3].w != 0.0;
    float _83 = smoothstep(0.0, 1.0, _78);
    float _84 = _82 ? _83 : _78;
    float _95 = _78 * _78;
    float _96 = _95 * _78;
    float _97 = 2.0 * _96;
    float _98 = 3.0 * _95;
    float _99 = _97 - _98;
    float _100 = _99 + 1.0;
    float3 _101 = _Globals.SplineParams[0].xyz * _100;
    float _102 = 2.0 * _95;
    float _103 = _96 - _102;
    float _104 = _103 + _78;
    float3 _105 = _Globals.SplineParams[1].xyz * _104;
    float3 _106 = _101 + _105;
    float _107 = _96 - _95;
    float3 _108 = _Globals.SplineParams[4].xyz * _107;
    float3 _109 = _106 + _108;
    float _110 = (-2.0) * _96;
    float _111 = _110 + _98;
    float3 _112 = _Globals.SplineParams[3].xyz * _111;
    float3 _113 = _109 + _112;
    float3 _114 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _115 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _116 = _114 + _115;
    float3 _117 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _118 = _116 + _117;
    float3 _119 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _120 = _118 - _119;
    float3 _121 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _122 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _123 = _121 - _122;
    float3 _124 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _125 = _123 - _124;
    float3 _126 = _125 + _119;
    float3 _127 = _120 * _95;
    float3 _128 = _126 * _78;
    float3 _129 = _127 + _128;
    float3 _130 = _129 + _Globals.SplineParams[1].xyz;
    float3 _131 = normalize(_130);
    float3 _134 = cross(_Globals.SplineParams[6].xyz, _131);
    float3 _135 = normalize(_134);
    float3 _136 = cross(_131, _135);
    float3 _137 = normalize(_136);
    float2 _144 = float2(_84);
    float2 _145 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _144);
    float _146 = _145.x;
    float3 _147 = _135 * _146;
    float3 _148 = _113 + _147;
    float _149 = _145.y;
    float3 _150 = _137 * _149;
    float3 _151 = _148 + _150;
    float _156 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _84);
    float _157 = sin(_156);
    float _158 = cos(_156);
    float3 _159 = _135 * _158;
    float3 _160 = _137 * _157;
    float3 _161 = _159 - _160;
    float3 _162 = _137 * _158;
    float3 _163 = _135 * _157;
    float3 _164 = _162 + _163;
    float2 _167 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _144);
    float _168 = _167.x;
    float3 _169 = _161 * _168;
    float _170 = _167.y;
    float3 _171 = _164 * _170;
    float3x3 _178 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _179 = transpose(_178);
    float3x3 _180 = float3x3(float3(0.0), _169, _171);
    float3x3 _181 = _180 * _179;
    float3 _182 = _181[0];
    float3 _183 = _181[1];
    float3 _184 = _181[2];
    float4x3 _185 = float4x3(_182, _183, _184, _151);
    float3 _186 = _185 * in.in_var_ATTRIBUTE0;
    float3 _191 = _186.xxx;
    float3 _192 = Primitive.Primitive_LocalToWorld[0].xyz * _191;
    float3 _195 = _186.yyy;
    float3 _196 = Primitive.Primitive_LocalToWorld[1].xyz * _195;
    float3 _197 = _192 + _196;
    float3 _200 = _186.zzz;
    float3 _201 = Primitive.Primitive_LocalToWorld[2].xyz * _200;
    float3 _202 = _197 + _201;
    float3 _205 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _206 = _202 + _205;
    float _207 = _206.x;
    float _208 = _206.y;
    float _209 = _206.z;
    float4 _210 = float4(_207, _208, _209, 1.0);
    float4 _211 = float4(_210.x, _210.y, _210.z, _210.w);
    float4 _212 = View.View_TranslatedWorldToClip * _211;
    out.gl_Position = _212;
    return out;
}

