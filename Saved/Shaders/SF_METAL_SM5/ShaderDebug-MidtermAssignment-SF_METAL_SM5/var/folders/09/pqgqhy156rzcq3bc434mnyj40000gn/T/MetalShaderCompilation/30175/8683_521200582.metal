

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
    float4 PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias;
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

vertex Main_out Main_000021eb_1f10e3c6(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _88 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _92 = _88 * _Globals.SplineParams[6].w;
    float _96 = _92 - _Globals.SplineParams[4].w;
    bool _100 = _Globals.SplineParams[3].w != 0.0;
    float _101 = smoothstep(0.0, 1.0, _96);
    float _102 = _100 ? _101 : _96;
    float3 _113 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _114 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _115 = _113 + _114;
    float3 _116 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _117 = _115 + _116;
    float3 _118 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _119 = _117 - _118;
    float3 _120 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _121 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _122 = _120 - _121;
    float3 _123 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _124 = _122 - _123;
    float3 _125 = _124 + _118;
    float _126 = _96 * _96;
    float3 _127 = _119 * _126;
    float3 _128 = _125 * _96;
    float3 _129 = _127 + _128;
    float3 _130 = _129 + _Globals.SplineParams[1].xyz;
    float3 _131 = normalize(_130);
    float3 _134 = cross(_Globals.SplineParams[6].xyz, _131);
    float3 _135 = normalize(_134);
    float3 _136 = cross(_131, _135);
    float3 _137 = normalize(_136);
    float _142 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _102);
    float _143 = sin(_142);
    float _144 = cos(_142);
    float3 _145 = _135 * _144;
    float3 _146 = _137 * _143;
    float3 _147 = _145 - _146;
    float3 _148 = _137 * _144;
    float3 _149 = _135 * _143;
    float3 _150 = _148 + _149;
    float2 _157 = float2(_102);
    float2 _158 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _157);
    float _159 = _158.x;
    float _164 = _158.y;
    float3x3 _175 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _176 = transpose(_175);
    float3x3 _178 = float3x3(_131, _147 * float(int(sign(_159))), _150 * float(int(sign(_164)))) * _176;
    float3 _182 = (_178 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _184 = cross(_182, _178 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _187 = _70;
    _187[0] = cross(_184, _182) * in.in_var_ATTRIBUTE2.w;
    float3x3 _188 = _187;
    _188[1] = _184;
    float3x3 _189 = _188;
    _189[2] = _182;
    float3x3 _203 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _203[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _206 = _203;
    _206[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _209 = _206;
    _209[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _210 = _209 * _189;
    float _214 = _126 * _96;
    float _215 = 2.0 * _214;
    float _216 = 3.0 * _126;
    float _217 = _215 - _216;
    float _218 = _217 + 1.0;
    float3 _219 = _Globals.SplineParams[0].xyz * _218;
    float _220 = 2.0 * _126;
    float _221 = _214 - _220;
    float _222 = _221 + _96;
    float3 _223 = _Globals.SplineParams[1].xyz * _222;
    float3 _224 = _219 + _223;
    float _225 = _214 - _126;
    float3 _226 = _Globals.SplineParams[4].xyz * _225;
    float3 _227 = _224 + _226;
    float _228 = (-2.0) * _214;
    float _229 = _228 + _216;
    float3 _230 = _Globals.SplineParams[3].xyz * _229;
    float3 _231 = _227 + _230;
    float2 _234 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _157);
    float _235 = _234.x;
    float3 _236 = _135 * _235;
    float3 _237 = _231 + _236;
    float _238 = _234.y;
    float3 _239 = _137 * _238;
    float3 _240 = _237 + _239;
    float3 _241 = _147 * _159;
    float3 _242 = _150 * _164;
    float3x3 _243 = float3x3(float3(0.0), _241, _242);
    float3x3 _244 = _243 * _176;
    float3 _245 = _244[0];
    float3 _246 = _244[1];
    float3 _247 = _244[2];
    float4x3 _248 = float4x3(_245, _246, _247, _240);
    float3 _249 = _248 * in.in_var_ATTRIBUTE0;
    float3 _250 = _249.xxx;
    float3 _251 = Primitive.Primitive_LocalToWorld[0].xyz * _250;
    float3 _252 = _249.yyy;
    float3 _253 = Primitive.Primitive_LocalToWorld[1].xyz * _252;
    float3 _254 = _251 + _253;
    float3 _255 = _249.zzz;
    float3 _256 = Primitive.Primitive_LocalToWorld[2].xyz * _255;
    float3 _257 = _254 + _256;
    float3 _260 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _261 = _257 + _260;
    float _262 = _261.x;
    float _263 = _261.y;
    float _264 = _261.z;
    float4 _265 = float4(_262, _263, _264, 1.0);
    float4 _266 = float4(_265.x, _265.y, _265.z, _265.w);
    float4 _267 = View.View_TranslatedWorldToClip * _266;
    float2 _274 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    float2 _280 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.zw;
    spvUnsafeArray<float4, 1> _292 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_210[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_210[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _292;
    out.out_var_TEXCOORD4 = float4(_274.x, _274.y, _280.x, _280.y);
    out.gl_Position = _267;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

