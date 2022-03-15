

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
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_Globals
{
    spvUnsafeArray<float4, 10> SplineParams;
    uint LayerId;
};

constant float3x3 _71 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00001f3c_a0cc4e51(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    Main_out out = {};
    float _85 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _89 = _85 * _Globals.SplineParams[6].w;
    float _93 = _89 - _Globals.SplineParams[4].w;
    bool _97 = _Globals.SplineParams[3].w != 0.0;
    float _98 = smoothstep(0.0, 1.0, _93);
    float _99 = _97 ? _98 : _93;
    float3 _110 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _111 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _112 = _110 + _111;
    float3 _113 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _114 = _112 + _113;
    float3 _115 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _116 = _114 - _115;
    float3 _117 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _118 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _119 = _117 - _118;
    float3 _120 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _121 = _119 - _120;
    float3 _122 = _121 + _115;
    float _123 = _93 * _93;
    float3 _124 = _116 * _123;
    float3 _125 = _122 * _93;
    float3 _126 = _124 + _125;
    float3 _127 = _126 + _Globals.SplineParams[1].xyz;
    float3 _128 = normalize(_127);
    float3 _131 = cross(_Globals.SplineParams[6].xyz, _128);
    float3 _132 = normalize(_131);
    float3 _133 = cross(_128, _132);
    float3 _134 = normalize(_133);
    float _139 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _99);
    float _140 = sin(_139);
    float _141 = cos(_139);
    float3 _142 = _132 * _141;
    float3 _143 = _134 * _140;
    float3 _144 = _142 - _143;
    float3 _145 = _134 * _141;
    float3 _146 = _132 * _140;
    float3 _147 = _145 + _146;
    float2 _154 = float2(_99);
    float2 _155 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _154);
    float _156 = _155.x;
    float _161 = _155.y;
    float3x3 _172 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _173 = transpose(_172);
    float3x3 _175 = float3x3(_128, _144 * float(int(sign(_156))), _147 * float(int(sign(_161)))) * _173;
    float3 _179 = (_175 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _181 = cross(_179, _175 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _184 = _71;
    _184[0] = cross(_181, _179) * in.in_var_ATTRIBUTE2.w;
    float3x3 _185 = _184;
    _185[1] = _181;
    float3x3 _186 = _185;
    _186[2] = _179;
    float3x3 _200 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _200[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _203 = _200;
    _203[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _206 = _203;
    _206[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _207 = _206 * _186;
    float _211 = _123 * _93;
    float _212 = 2.0 * _211;
    float _213 = 3.0 * _123;
    float _214 = _212 - _213;
    float _215 = _214 + 1.0;
    float3 _216 = _Globals.SplineParams[0].xyz * _215;
    float _217 = 2.0 * _123;
    float _218 = _211 - _217;
    float _219 = _218 + _93;
    float3 _220 = _Globals.SplineParams[1].xyz * _219;
    float3 _221 = _216 + _220;
    float _222 = _211 - _123;
    float3 _223 = _Globals.SplineParams[4].xyz * _222;
    float3 _224 = _221 + _223;
    float _225 = (-2.0) * _211;
    float _226 = _225 + _213;
    float3 _227 = _Globals.SplineParams[3].xyz * _226;
    float3 _228 = _224 + _227;
    float2 _231 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _154);
    float _232 = _231.x;
    float3 _233 = _132 * _232;
    float3 _234 = _228 + _233;
    float _235 = _231.y;
    float3 _236 = _134 * _235;
    float3 _237 = _234 + _236;
    float3 _238 = _144 * _156;
    float3 _239 = _147 * _161;
    float3x3 _240 = float3x3(float3(0.0), _238, _239);
    float3x3 _241 = _240 * _173;
    float3 _242 = _241[0];
    float3 _243 = _241[1];
    float3 _244 = _241[2];
    float4x3 _245 = float4x3(_242, _243, _244, _237);
    float3 _246 = _245 * in.in_var_ATTRIBUTE0;
    float3 _247 = _246.xxx;
    float3 _248 = Primitive.Primitive_LocalToWorld[0].xyz * _247;
    float3 _249 = _246.yyy;
    float3 _250 = Primitive.Primitive_LocalToWorld[1].xyz * _249;
    float3 _251 = _248 + _250;
    float3 _252 = _246.zzz;
    float3 _253 = Primitive.Primitive_LocalToWorld[2].xyz * _252;
    float3 _254 = _251 + _253;
    float3 _257 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _258 = _254 + _257;
    float _259 = _258.x;
    float _260 = _258.y;
    float _261 = _258.z;
    float4 _262 = float4(_259, _260, _261, 1.0);
    float3 _263 = _207[2];
    float4 _264 = float4(_262.x, _262.y, _262.z, _262.w);
    float4 _279 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _264;
    out.out_var_TEXCOORD10_centroid = float4(_207[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_263, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _262.xyz;
    out.out_var_TEXCOORD6 = _279;
    out.out_var_TEXCOORD8 = _263;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _279;
    return out;
}

