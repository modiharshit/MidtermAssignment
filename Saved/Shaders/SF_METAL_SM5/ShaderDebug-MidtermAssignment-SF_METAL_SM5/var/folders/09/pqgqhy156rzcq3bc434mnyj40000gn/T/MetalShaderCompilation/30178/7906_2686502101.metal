

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

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

vertex MainVertexShader_out Main_00001ee2_a020c4d5(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float _82 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _86 = _82 * _Globals.SplineParams[6].w;
    float _90 = _86 - _Globals.SplineParams[4].w;
    bool _94 = _Globals.SplineParams[3].w != 0.0;
    float _95 = smoothstep(0.0, 1.0, _90);
    float _96 = _94 ? _95 : _90;
    float3 _107 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _108 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _109 = _107 + _108;
    float3 _110 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _111 = _109 + _110;
    float3 _112 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _113 = _111 - _112;
    float3 _114 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _115 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _116 = _114 - _115;
    float3 _117 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _118 = _116 - _117;
    float3 _119 = _118 + _112;
    float _120 = _90 * _90;
    float3 _121 = _113 * _120;
    float3 _122 = _119 * _90;
    float3 _123 = _121 + _122;
    float3 _124 = _123 + _Globals.SplineParams[1].xyz;
    float3 _125 = normalize(_124);
    float3 _128 = cross(_Globals.SplineParams[6].xyz, _125);
    float3 _129 = normalize(_128);
    float3 _130 = cross(_125, _129);
    float3 _131 = normalize(_130);
    float _136 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _96);
    float _137 = sin(_136);
    float _138 = cos(_136);
    float3 _139 = _129 * _138;
    float3 _140 = _131 * _137;
    float3 _141 = _139 - _140;
    float3 _142 = _131 * _138;
    float3 _143 = _129 * _137;
    float3 _144 = _142 + _143;
    float2 _151 = float2(_96);
    float2 _152 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _151);
    float _153 = _152.x;
    float _158 = _152.y;
    float3x3 _169 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _170 = transpose(_169);
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
    float _209 = 2.0 * _208;
    float _210 = 3.0 * _120;
    float _211 = _209 - _210;
    float _212 = _211 + 1.0;
    float3 _213 = _Globals.SplineParams[0].xyz * _212;
    float _214 = 2.0 * _120;
    float _215 = _208 - _214;
    float _216 = _215 + _90;
    float3 _217 = _Globals.SplineParams[1].xyz * _216;
    float3 _218 = _213 + _217;
    float _219 = _208 - _120;
    float3 _220 = _Globals.SplineParams[4].xyz * _219;
    float3 _221 = _218 + _220;
    float _222 = (-2.0) * _208;
    float _223 = _222 + _210;
    float3 _224 = _Globals.SplineParams[3].xyz * _223;
    float3 _225 = _221 + _224;
    float2 _228 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _151);
    float _229 = _228.x;
    float3 _230 = _129 * _229;
    float3 _231 = _225 + _230;
    float _232 = _228.y;
    float3 _233 = _131 * _232;
    float3 _234 = _231 + _233;
    float3 _235 = _141 * _153;
    float3 _236 = _144 * _158;
    float3x3 _237 = float3x3(float3(0.0), _235, _236);
    float3x3 _238 = _237 * _170;
    float3 _239 = _238[0];
    float3 _240 = _238[1];
    float3 _241 = _238[2];
    float4x3 _242 = float4x3(_239, _240, _241, _234);
    float3 _243 = _242 * in.in_var_ATTRIBUTE0;
    float3 _244 = _243.xxx;
    float3 _245 = Primitive.Primitive_LocalToWorld[0].xyz * _244;
    float3 _246 = _243.yyy;
    float3 _247 = Primitive.Primitive_LocalToWorld[1].xyz * _246;
    float3 _248 = _245 + _247;
    float3 _249 = _243.zzz;
    float3 _250 = Primitive.Primitive_LocalToWorld[2].xyz * _249;
    float3 _251 = _248 + _250;
    float3 _254 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _255 = _251 + _254;
    float _256 = _255.x;
    float _257 = _255.y;
    float _258 = _255.z;
    float4 _259 = float4(_256, _257, _258, 1.0);
    float4 _260 = float4(_259.x, _259.y, _259.z, _259.w);
    float4 _261 = View.View_TranslatedWorldToClip * _260;
    spvUnsafeArray<float4, 1> _273 = { float4(in.in_var_ATTRIBUTE4.x, in.in_var_ATTRIBUTE4.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_204[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_204[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _273;
    out.out_var_TEXCOORD6 = _260;
    out.gl_Position = _261;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

