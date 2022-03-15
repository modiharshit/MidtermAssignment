

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

constant float3x3 _59 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001cc7_df5eb647(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    Main_out out = {};
    float _75 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _79 = _75 * _Globals.SplineParams[6].w;
    float _83 = _79 - _Globals.SplineParams[4].w;
    bool _87 = _Globals.SplineParams[3].w != 0.0;
    float _88 = smoothstep(0.0, 1.0, _83);
    float _89 = _87 ? _88 : _83;
    float3 _100 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _101 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _102 = _100 + _101;
    float3 _103 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _104 = _102 + _103;
    float3 _105 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _106 = _104 - _105;
    float3 _107 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _108 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _109 = _107 - _108;
    float3 _110 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _111 = _109 - _110;
    float3 _112 = _111 + _105;
    float _113 = _83 * _83;
    float3 _114 = _106 * _113;
    float3 _115 = _112 * _83;
    float3 _116 = _114 + _115;
    float3 _117 = _116 + _Globals.SplineParams[1].xyz;
    float3 _118 = normalize(_117);
    float3 _121 = cross(_Globals.SplineParams[6].xyz, _118);
    float3 _122 = normalize(_121);
    float3 _123 = cross(_118, _122);
    float3 _124 = normalize(_123);
    float _129 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _89);
    float _130 = sin(_129);
    float _131 = cos(_129);
    float3 _132 = _122 * _131;
    float3 _133 = _124 * _130;
    float3 _134 = _132 - _133;
    float3 _135 = _124 * _131;
    float3 _136 = _122 * _130;
    float3 _137 = _135 + _136;
    float2 _144 = float2(_89);
    float2 _145 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _144);
    float _146 = _145.x;
    float _151 = _145.y;
    float3x3 _162 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _163 = transpose(_162);
    float3x3 _165 = float3x3(_118, _134 * float(int(sign(_146))), _137 * float(int(sign(_151)))) * _163;
    float3 _169 = (_165 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _171 = cross(_169, _165 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _174 = _59;
    _174[0] = cross(_171, _169) * in.in_var_ATTRIBUTE2.w;
    float3x3 _175 = _174;
    _175[1] = _171;
    float3x3 _176 = _175;
    _176[2] = _169;
    float3x3 _190 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _190[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _193 = _190;
    _193[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _196 = _193;
    _196[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _197 = _196 * _176;
    float _201 = _113 * _83;
    float _202 = 2.0 * _201;
    float _203 = 3.0 * _113;
    float _204 = _202 - _203;
    float _205 = _204 + 1.0;
    float3 _206 = _Globals.SplineParams[0].xyz * _205;
    float _207 = 2.0 * _113;
    float _208 = _201 - _207;
    float _209 = _208 + _83;
    float3 _210 = _Globals.SplineParams[1].xyz * _209;
    float3 _211 = _206 + _210;
    float _212 = _201 - _113;
    float3 _213 = _Globals.SplineParams[4].xyz * _212;
    float3 _214 = _211 + _213;
    float _215 = (-2.0) * _201;
    float _216 = _215 + _203;
    float3 _217 = _Globals.SplineParams[3].xyz * _216;
    float3 _218 = _214 + _217;
    float2 _221 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _144);
    float _222 = _221.x;
    float3 _223 = _122 * _222;
    float3 _224 = _218 + _223;
    float _225 = _221.y;
    float3 _226 = _124 * _225;
    float3 _227 = _224 + _226;
    float3 _228 = _134 * _146;
    float3 _229 = _137 * _151;
    float3x3 _230 = float3x3(float3(0.0), _228, _229);
    float3x3 _231 = _230 * _163;
    float3 _232 = _231[0];
    float3 _233 = _231[1];
    float3 _234 = _231[2];
    float4x3 _235 = float4x3(_232, _233, _234, _227);
    float3 _236 = _235 * in.in_var_ATTRIBUTE0;
    float3 _237 = _236.xxx;
    float3 _238 = Primitive.Primitive_LocalToWorld[0].xyz * _237;
    float3 _239 = _236.yyy;
    float3 _240 = Primitive.Primitive_LocalToWorld[1].xyz * _239;
    float3 _241 = _238 + _240;
    float3 _242 = _236.zzz;
    float3 _243 = Primitive.Primitive_LocalToWorld[2].xyz * _242;
    float3 _244 = _241 + _243;
    float3 _247 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _248 = _244 + _247;
    float _249 = _248.x;
    float _250 = _248.y;
    float _251 = _248.z;
    float4 _252 = float4(_249, _250, _251, 1.0);
    float4 _253 = float4(_252.x, _252.y, _252.z, _252.w);
    float4 _254 = View.View_TranslatedWorldToClip * _253;
    out.out_var_TEXCOORD10_centroid = float4(_197[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_197[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _254;
    return out;
}

