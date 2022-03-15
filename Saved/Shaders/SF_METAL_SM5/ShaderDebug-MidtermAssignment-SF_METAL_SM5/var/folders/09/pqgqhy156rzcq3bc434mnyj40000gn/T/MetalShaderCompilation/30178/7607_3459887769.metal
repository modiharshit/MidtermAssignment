

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

constant float3x3 _70 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex MainForGS_out Main_00001db7_ce39b299(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    MainForGS_out out = {};
    float _83 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _87 = _83 * _Globals.SplineParams[6].w;
    float _91 = _87 - _Globals.SplineParams[4].w;
    bool _95 = _Globals.SplineParams[3].w != 0.0;
    float _96 = smoothstep(0.0, 1.0, _91);
    float _97 = _95 ? _96 : _91;
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
    float _121 = _91 * _91;
    float3 _122 = _114 * _121;
    float3 _123 = _120 * _91;
    float3 _124 = _122 + _123;
    float3 _125 = _124 + _Globals.SplineParams[1].xyz;
    float3 _126 = normalize(_125);
    float3 _129 = cross(_Globals.SplineParams[6].xyz, _126);
    float3 _130 = normalize(_129);
    float3 _131 = cross(_126, _130);
    float3 _132 = normalize(_131);
    float _137 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _97);
    float _138 = sin(_137);
    float _139 = cos(_137);
    float3 _140 = _130 * _139;
    float3 _141 = _132 * _138;
    float3 _142 = _140 - _141;
    float3 _143 = _132 * _139;
    float3 _144 = _130 * _138;
    float3 _145 = _143 + _144;
    float2 _152 = float2(_97);
    float2 _153 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _152);
    float _154 = _153.x;
    float _159 = _153.y;
    float3x3 _170 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _171 = transpose(_170);
    float3x3 _173 = float3x3(_126, _142 * float(int(sign(_154))), _145 * float(int(sign(_159)))) * _171;
    float3 _177 = (_173 * in.in_var_ATTRIBUTE2.xyz).xyz;
    float3 _180 = cross(_177, _173 * in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _183 = _70;
    _183[0] = cross(_180, _177) * in.in_var_ATTRIBUTE2.w;
    float3x3 _184 = _183;
    _184[1] = _180;
    float3x3 _185 = _184;
    _185[2] = _177;
    float3x3 _199 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _199[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _202 = _199;
    _202[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _205 = _202;
    _205[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float _207 = _121 * _91;
    float _208 = 2.0 * _207;
    float _209 = 3.0 * _121;
    float _210 = _208 - _209;
    float _211 = _210 + 1.0;
    float3 _212 = _Globals.SplineParams[0].xyz * _211;
    float _213 = 2.0 * _121;
    float _214 = _207 - _213;
    float _215 = _214 + _91;
    float3 _216 = _Globals.SplineParams[1].xyz * _215;
    float3 _217 = _212 + _216;
    float _218 = _207 - _121;
    float3 _219 = _Globals.SplineParams[4].xyz * _218;
    float3 _220 = _217 + _219;
    float _221 = (-2.0) * _207;
    float _222 = _221 + _209;
    float3 _223 = _Globals.SplineParams[3].xyz * _222;
    float3 _224 = _220 + _223;
    float2 _227 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _152);
    float _228 = _227.x;
    float3 _229 = _130 * _228;
    float3 _230 = _224 + _229;
    float _231 = _227.y;
    float3 _232 = _132 * _231;
    float3 _233 = _230 + _232;
    float3 _234 = _142 * _154;
    float3 _235 = _145 * _159;
    float3x3 _236 = float3x3(float3(0.0), _234, _235);
    float3x3 _237 = _236 * _171;
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
    float4 _260 = float4(_258.x, _258.y, _258.z, _258.w);
    float4 _265 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _260;
    out.out_var_TEXCOORD6 = _260;
    out.out_var_TEXCOORD8 = (_205 * _185)[2];
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _265;
    return out;
}

