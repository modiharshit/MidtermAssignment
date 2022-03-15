

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

constant float3x3 _72 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_00002174_c0b04e40(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _90 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _94 = _90 * _Globals.SplineParams[6].w;
    float _98 = _94 - _Globals.SplineParams[4].w;
    bool _102 = _Globals.SplineParams[3].w != 0.0;
    float _103 = smoothstep(0.0, 1.0, _98);
    float _104 = _102 ? _103 : _98;
    float3 _115 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _116 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _117 = _115 + _116;
    float3 _118 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _119 = _117 + _118;
    float3 _120 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _121 = _119 - _120;
    float3 _122 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _123 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _124 = _122 - _123;
    float3 _125 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _126 = _124 - _125;
    float3 _127 = _126 + _120;
    float _128 = _98 * _98;
    float3 _129 = _121 * _128;
    float3 _130 = _127 * _98;
    float3 _131 = _129 + _130;
    float3 _132 = _131 + _Globals.SplineParams[1].xyz;
    float3 _133 = normalize(_132);
    float3 _136 = cross(_Globals.SplineParams[6].xyz, _133);
    float3 _137 = normalize(_136);
    float3 _138 = cross(_133, _137);
    float3 _139 = normalize(_138);
    float _144 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _104);
    float _145 = sin(_144);
    float _146 = cos(_144);
    float3 _147 = _137 * _146;
    float3 _148 = _139 * _145;
    float3 _149 = _147 - _148;
    float3 _150 = _139 * _146;
    float3 _151 = _137 * _145;
    float3 _152 = _150 + _151;
    float2 _159 = float2(_104);
    float2 _160 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _159);
    float _161 = _160.x;
    float _166 = _160.y;
    float3x3 _177 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _178 = transpose(_177);
    float3x3 _180 = float3x3(_133, _149 * float(int(sign(_161))), _152 * float(int(sign(_166)))) * _178;
    float3 _184 = (_180 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _186 = cross(_184, _180 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _189 = _72;
    _189[0] = cross(_186, _184) * in.in_var_ATTRIBUTE2.w;
    float3x3 _190 = _189;
    _190[1] = _186;
    float3x3 _191 = _190;
    _191[2] = _184;
    float3x3 _205 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _205[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _208 = _205;
    _208[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _211 = _208;
    _211[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _212 = _211 * _191;
    float _216 = _128 * _98;
    float _217 = 2.0 * _216;
    float _218 = 3.0 * _128;
    float _219 = _217 - _218;
    float _220 = _219 + 1.0;
    float3 _221 = _Globals.SplineParams[0].xyz * _220;
    float _222 = 2.0 * _128;
    float _223 = _216 - _222;
    float _224 = _223 + _98;
    float3 _225 = _Globals.SplineParams[1].xyz * _224;
    float3 _226 = _221 + _225;
    float _227 = _216 - _128;
    float3 _228 = _Globals.SplineParams[4].xyz * _227;
    float3 _229 = _226 + _228;
    float _230 = (-2.0) * _216;
    float _231 = _230 + _218;
    float3 _232 = _Globals.SplineParams[3].xyz * _231;
    float3 _233 = _229 + _232;
    float2 _236 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _159);
    float _237 = _236.x;
    float3 _238 = _137 * _237;
    float3 _239 = _233 + _238;
    float _240 = _236.y;
    float3 _241 = _139 * _240;
    float3 _242 = _239 + _241;
    float3 _243 = _149 * _161;
    float3 _244 = _152 * _166;
    float3x3 _245 = float3x3(float3(0.0), _243, _244);
    float3x3 _246 = _245 * _178;
    float3 _247 = _246[0];
    float3 _248 = _246[1];
    float3 _249 = _246[2];
    float4x3 _250 = float4x3(_247, _248, _249, _242);
    float3 _251 = _250 * in.in_var_ATTRIBUTE0;
    float3 _252 = _251.xxx;
    float3 _253 = Primitive.Primitive_LocalToWorld[0].xyz * _252;
    float3 _254 = _251.yyy;
    float3 _255 = Primitive.Primitive_LocalToWorld[1].xyz * _254;
    float3 _256 = _253 + _255;
    float3 _257 = _251.zzz;
    float3 _258 = Primitive.Primitive_LocalToWorld[2].xyz * _257;
    float3 _259 = _256 + _258;
    float3 _262 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _263 = _259 + _262;
    float _264 = _263.x;
    float _265 = _263.y;
    float _266 = _263.z;
    float4 _267 = float4(_264, _265, _266, 1.0);
    float4 _268 = float4(_267.x, _267.y, _267.z, _267.w);
    float4 _269 = View.View_TranslatedWorldToClip * _268;
    float2 _276 = (in.in_var_ATTRIBUTE15 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    spvUnsafeArray<float4, 1> _288 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_212[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_212[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _288;
    out.out_var_TEXCOORD4 = float4(_276.x, _276.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _268;
    out.gl_Position = _269;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

