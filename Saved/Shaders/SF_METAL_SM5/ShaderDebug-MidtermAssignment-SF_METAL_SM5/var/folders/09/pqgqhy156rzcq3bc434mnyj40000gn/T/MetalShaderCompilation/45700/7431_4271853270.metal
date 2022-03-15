

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

constant float3x3 _60 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001d07_fe9f4ed6(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    Main_out out = {};
    float _76 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _80 = _76 * _Globals.SplineParams[6].w;
    float _84 = _80 - _Globals.SplineParams[4].w;
    bool _88 = _Globals.SplineParams[3].w != 0.0;
    float _89 = smoothstep(0.0, 1.0, _84);
    float _90 = _88 ? _89 : _84;
    float3 _101 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _102 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _103 = _101 + _102;
    float3 _104 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _105 = _103 + _104;
    float3 _106 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _107 = _105 - _106;
    float3 _108 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _109 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _110 = _108 - _109;
    float3 _111 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _112 = _110 - _111;
    float3 _113 = _112 + _106;
    float _114 = _84 * _84;
    float3 _115 = _107 * _114;
    float3 _116 = _113 * _84;
    float3 _117 = _115 + _116;
    float3 _118 = _117 + _Globals.SplineParams[1].xyz;
    float3 _119 = normalize(_118);
    float3 _122 = cross(_Globals.SplineParams[6].xyz, _119);
    float3 _123 = normalize(_122);
    float3 _124 = cross(_119, _123);
    float3 _125 = normalize(_124);
    float _130 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _90);
    float _131 = sin(_130);
    float _132 = cos(_130);
    float3 _133 = _123 * _132;
    float3 _134 = _125 * _131;
    float3 _135 = _133 - _134;
    float3 _136 = _125 * _132;
    float3 _137 = _123 * _131;
    float3 _138 = _136 + _137;
    float2 _145 = float2(_90);
    float2 _146 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _145);
    float _147 = _146.x;
    float _152 = _146.y;
    float3x3 _163 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _164 = transpose(_163);
    float3x3 _166 = float3x3(_119, _135 * float(int(sign(_147))), _138 * float(int(sign(_152)))) * _164;
    float3 _170 = (_166 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _172 = cross(_170, _166 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _175 = _60;
    _175[0] = cross(_172, _170) * in.in_var_ATTRIBUTE2.w;
    float3x3 _176 = _175;
    _176[1] = _172;
    float3x3 _177 = _176;
    _177[2] = _170;
    float3x3 _191 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _191[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _194 = _191;
    _194[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _197 = _194;
    _197[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _198 = _197 * _177;
    float _202 = _114 * _84;
    float _203 = 2.0 * _202;
    float _204 = 3.0 * _114;
    float _205 = _203 - _204;
    float _206 = _205 + 1.0;
    float3 _207 = _Globals.SplineParams[0].xyz * _206;
    float _208 = 2.0 * _114;
    float _209 = _202 - _208;
    float _210 = _209 + _84;
    float3 _211 = _Globals.SplineParams[1].xyz * _210;
    float3 _212 = _207 + _211;
    float _213 = _202 - _114;
    float3 _214 = _Globals.SplineParams[4].xyz * _213;
    float3 _215 = _212 + _214;
    float _216 = (-2.0) * _202;
    float _217 = _216 + _204;
    float3 _218 = _Globals.SplineParams[3].xyz * _217;
    float3 _219 = _215 + _218;
    float2 _222 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _145);
    float _223 = _222.x;
    float3 _224 = _123 * _223;
    float3 _225 = _219 + _224;
    float _226 = _222.y;
    float3 _227 = _125 * _226;
    float3 _228 = _225 + _227;
    float3 _229 = _135 * _147;
    float3 _230 = _138 * _152;
    float3x3 _231 = float3x3(float3(0.0), _229, _230);
    float3x3 _232 = _231 * _164;
    float3 _233 = _232[0];
    float3 _234 = _232[1];
    float3 _235 = _232[2];
    float4x3 _236 = float4x3(_233, _234, _235, _228);
    float3 _237 = _236 * in.in_var_ATTRIBUTE0;
    float3 _238 = _237.xxx;
    float3 _239 = Primitive.Primitive_LocalToWorld[0].xyz * _238;
    float3 _240 = _237.yyy;
    float3 _241 = Primitive.Primitive_LocalToWorld[1].xyz * _240;
    float3 _242 = _239 + _241;
    float3 _243 = _237.zzz;
    float3 _244 = Primitive.Primitive_LocalToWorld[2].xyz * _243;
    float3 _245 = _242 + _244;
    float3 _248 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _249 = _245 + _248;
    float _250 = _249.x;
    float _251 = _249.y;
    float _252 = _249.z;
    float4 _253 = float4(_250, _251, _252, 1.0);
    float4 _254 = float4(_253.x, _253.y, _253.z, _253.w);
    float4 _255 = View.View_TranslatedWorldToClip * _254;
    out.gl_Position = _255;
    out.out_var_TEXCOORD10_centroid = float4(_198[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_198[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _254;
    return out;
}

