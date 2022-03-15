

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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
};

constant float3x3 _71 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_000020c8_765c5aa9(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _89 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _93 = _89 * _Globals.SplineParams[6].w;
    float _97 = _93 - _Globals.SplineParams[4].w;
    bool _101 = _Globals.SplineParams[3].w != 0.0;
    float _102 = smoothstep(0.0, 1.0, _97);
    float _103 = _101 ? _102 : _97;
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
    float _127 = _97 * _97;
    float3 _128 = _120 * _127;
    float3 _129 = _126 * _97;
    float3 _130 = _128 + _129;
    float3 _131 = _130 + _Globals.SplineParams[1].xyz;
    float3 _132 = normalize(_131);
    float3 _135 = cross(_Globals.SplineParams[6].xyz, _132);
    float3 _136 = normalize(_135);
    float3 _137 = cross(_132, _136);
    float3 _138 = normalize(_137);
    float _143 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _103);
    float _144 = sin(_143);
    float _145 = cos(_143);
    float3 _146 = _136 * _145;
    float3 _147 = _138 * _144;
    float3 _148 = _146 - _147;
    float3 _149 = _138 * _145;
    float3 _150 = _136 * _144;
    float3 _151 = _149 + _150;
    float2 _158 = float2(_103);
    float2 _159 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _158);
    float _160 = _159.x;
    float _165 = _159.y;
    float3x3 _176 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _177 = transpose(_176);
    float3x3 _179 = float3x3(_132, _148 * float(int(sign(_160))), _151 * float(int(sign(_165)))) * _177;
    float3 _183 = (_179 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _185 = cross(_183, _179 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _188 = _71;
    _188[0] = cross(_185, _183) * in.in_var_ATTRIBUTE2.w;
    float3x3 _189 = _188;
    _189[1] = _185;
    float3x3 _190 = _189;
    _190[2] = _183;
    float3x3 _204 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _204[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _207 = _204;
    _207[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _210 = _207;
    _210[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _211 = _210 * _190;
    float _215 = _127 * _97;
    float _216 = 2.0 * _215;
    float _217 = 3.0 * _127;
    float _218 = _216 - _217;
    float _219 = _218 + 1.0;
    float3 _220 = _Globals.SplineParams[0].xyz * _219;
    float _221 = 2.0 * _127;
    float _222 = _215 - _221;
    float _223 = _222 + _97;
    float3 _224 = _Globals.SplineParams[1].xyz * _223;
    float3 _225 = _220 + _224;
    float _226 = _215 - _127;
    float3 _227 = _Globals.SplineParams[4].xyz * _226;
    float3 _228 = _225 + _227;
    float _229 = (-2.0) * _215;
    float _230 = _229 + _217;
    float3 _231 = _Globals.SplineParams[3].xyz * _230;
    float3 _232 = _228 + _231;
    float2 _235 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _158);
    float _236 = _235.x;
    float3 _237 = _136 * _236;
    float3 _238 = _232 + _237;
    float _239 = _235.y;
    float3 _240 = _138 * _239;
    float3 _241 = _238 + _240;
    float3 _242 = _148 * _160;
    float3 _243 = _151 * _165;
    float3x3 _244 = float3x3(float3(0.0), _242, _243);
    float3x3 _245 = _244 * _177;
    float3 _246 = _245[0];
    float3 _247 = _245[1];
    float3 _248 = _245[2];
    float4x3 _249 = float4x3(_246, _247, _248, _241);
    float3 _250 = _249 * in.in_var_ATTRIBUTE0;
    float3 _251 = _250.xxx;
    float3 _252 = Primitive.Primitive_LocalToWorld[0].xyz * _251;
    float3 _253 = _250.yyy;
    float3 _254 = Primitive.Primitive_LocalToWorld[1].xyz * _253;
    float3 _255 = _252 + _254;
    float3 _256 = _250.zzz;
    float3 _257 = Primitive.Primitive_LocalToWorld[2].xyz * _256;
    float3 _258 = _255 + _257;
    float3 _261 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _262 = _258 + _261;
    float _263 = _262.x;
    float _264 = _262.y;
    float _265 = _262.z;
    float4 _266 = float4(_263, _264, _265, 1.0);
    float4 _267 = float4(_266.x, _266.y, _266.z, _266.w);
    float4 _268 = View.View_TranslatedWorldToClip * _267;
    float2 _275 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    spvUnsafeArray<float4, 1> _287 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_211[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_211[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _287;
    out.out_var_TEXCOORD4 = float4(_275.x, _275.y, float2(0.0).x, float2(0.0).y);
    out.gl_Position = _268;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

