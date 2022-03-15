

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

constant float3x3 _65 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex Main_out Main_00001e48_84a21dab(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _81 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _85 = _81 * _Globals.SplineParams[6].w;
    float _89 = _85 - _Globals.SplineParams[4].w;
    bool _93 = _Globals.SplineParams[3].w != 0.0;
    float _94 = smoothstep(0.0, 1.0, _89);
    float _95 = _93 ? _94 : _89;
    float3 _106 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _107 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _108 = _106 + _107;
    float3 _109 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _110 = _108 + _109;
    float3 _111 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _112 = _110 - _111;
    float3 _113 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _114 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _115 = _113 - _114;
    float3 _116 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _117 = _115 - _116;
    float3 _118 = _117 + _111;
    float _119 = _89 * _89;
    float3 _120 = _112 * _119;
    float3 _121 = _118 * _89;
    float3 _122 = _120 + _121;
    float3 _123 = _122 + _Globals.SplineParams[1].xyz;
    float3 _124 = normalize(_123);
    float3 _127 = cross(_Globals.SplineParams[6].xyz, _124);
    float3 _128 = normalize(_127);
    float3 _129 = cross(_124, _128);
    float3 _130 = normalize(_129);
    float _135 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _95);
    float _136 = sin(_135);
    float _137 = cos(_135);
    float3 _138 = _128 * _137;
    float3 _139 = _130 * _136;
    float3 _140 = _138 - _139;
    float3 _141 = _130 * _137;
    float3 _142 = _128 * _136;
    float3 _143 = _141 + _142;
    float2 _150 = float2(_95);
    float2 _151 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _150);
    float _152 = _151.x;
    float _157 = _151.y;
    float3x3 _168 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _169 = transpose(_168);
    float3x3 _171 = float3x3(_124, _140 * float(int(sign(_152))), _143 * float(int(sign(_157)))) * _169;
    float3 _175 = (_171 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _177 = cross(_175, _171 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _180 = _65;
    _180[0] = cross(_177, _175) * in.in_var_ATTRIBUTE2.w;
    float3x3 _181 = _180;
    _181[1] = _177;
    float3x3 _182 = _181;
    _182[2] = _175;
    float3x3 _196 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _196[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _199 = _196;
    _199[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _202 = _199;
    _202[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _203 = _202 * _182;
    float _207 = _119 * _89;
    float _208 = 2.0 * _207;
    float _209 = 3.0 * _119;
    float _210 = _208 - _209;
    float _211 = _210 + 1.0;
    float3 _212 = _Globals.SplineParams[0].xyz * _211;
    float _213 = 2.0 * _119;
    float _214 = _207 - _213;
    float _215 = _214 + _89;
    float3 _216 = _Globals.SplineParams[1].xyz * _215;
    float3 _217 = _212 + _216;
    float _218 = _207 - _119;
    float3 _219 = _Globals.SplineParams[4].xyz * _218;
    float3 _220 = _217 + _219;
    float _221 = (-2.0) * _207;
    float _222 = _221 + _209;
    float3 _223 = _Globals.SplineParams[3].xyz * _222;
    float3 _224 = _220 + _223;
    float2 _227 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _150);
    float _228 = _227.x;
    float3 _229 = _128 * _228;
    float3 _230 = _224 + _229;
    float _231 = _227.y;
    float3 _232 = _130 * _231;
    float3 _233 = _230 + _232;
    float3 _234 = _140 * _152;
    float3 _235 = _143 * _157;
    float3x3 _236 = float3x3(float3(0.0), _234, _235);
    float3x3 _237 = _236 * _169;
    float3 _238 = _237[0];
    float3 _239 = _237[1];
    float3 _240 = _237[2];
    float4x3 _241 = float4x3(_238, _239, _240, _233);
    float3 _242 = _241 * in.in_var_ATTRIBUTE0;
    float3 _243 = _242.xxx;
    float3 _244 = Primitive.Primitive_LocalToWorld[0].xyz * _243;
    float3 _245 = _242.yyy;
    float3 _246 = Primitive.Primitive_LocalToWorld[1].xyz * _245;
    float3 _247 = _244 + _246;
    float3 _248 = _242.zzz;
    float3 _249 = Primitive.Primitive_LocalToWorld[2].xyz * _248;
    float3 _250 = _247 + _249;
    float3 _253 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _254 = _250 + _253;
    float _255 = _254.x;
    float _256 = _254.y;
    float _257 = _254.z;
    float4 _258 = float4(_255, _256, _257, 1.0);
    float4 _259 = float4(_258.x, _258.y, _258.z, _258.w);
    float4 _260 = View.View_TranslatedWorldToClip * _259;
    spvUnsafeArray<float4, 1> _272 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_203[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_203[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _272;
    out.gl_Position = _260;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

