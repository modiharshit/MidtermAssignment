

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

struct PositionOnlyMainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMainForGS_out Main_00001c3a_dae79dbc(PositionOnlyMainForGS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    PositionOnlyMainForGS_out out = {};
    float _80 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _84 = _80 * _Globals.SplineParams[6].w;
    float _88 = _84 - _Globals.SplineParams[4].w;
    bool _92 = _Globals.SplineParams[3].w != 0.0;
    float _93 = smoothstep(0.0, 1.0, _88);
    float _94 = _92 ? _93 : _88;
    float _105 = _88 * _88;
    float _106 = _105 * _88;
    float _107 = 2.0 * _106;
    float _108 = 3.0 * _105;
    float _109 = _107 - _108;
    float _110 = _109 + 1.0;
    float3 _111 = _Globals.SplineParams[0].xyz * _110;
    float _112 = 2.0 * _105;
    float _113 = _106 - _112;
    float _114 = _113 + _88;
    float3 _115 = _Globals.SplineParams[1].xyz * _114;
    float3 _116 = _111 + _115;
    float _117 = _106 - _105;
    float3 _118 = _Globals.SplineParams[4].xyz * _117;
    float3 _119 = _116 + _118;
    float _120 = (-2.0) * _106;
    float _121 = _120 + _108;
    float3 _122 = _Globals.SplineParams[3].xyz * _121;
    float3 _123 = _119 + _122;
    float3 _124 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _125 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _126 = _124 + _125;
    float3 _127 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _128 = _126 + _127;
    float3 _129 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _130 = _128 - _129;
    float3 _131 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _132 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _133 = _131 - _132;
    float3 _134 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _135 = _133 - _134;
    float3 _136 = _135 + _129;
    float3 _137 = _130 * _105;
    float3 _138 = _136 * _88;
    float3 _139 = _137 + _138;
    float3 _140 = _139 + _Globals.SplineParams[1].xyz;
    float3 _141 = normalize(_140);
    float3 _144 = cross(_Globals.SplineParams[6].xyz, _141);
    float3 _145 = normalize(_144);
    float3 _146 = cross(_141, _145);
    float3 _147 = normalize(_146);
    float2 _154 = float2(_94);
    float2 _155 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _154);
    float _156 = _155.x;
    float3 _157 = _145 * _156;
    float3 _158 = _123 + _157;
    float _159 = _155.y;
    float3 _160 = _147 * _159;
    float3 _161 = _158 + _160;
    float _166 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _94);
    float _167 = sin(_166);
    float _168 = cos(_166);
    float3 _169 = _145 * _168;
    float3 _170 = _147 * _167;
    float3 _171 = _169 - _170;
    float3 _172 = _147 * _168;
    float3 _173 = _145 * _167;
    float3 _174 = _172 + _173;
    float2 _177 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _154);
    float _178 = _177.x;
    float3 _179 = _171 * _178;
    float _180 = _177.y;
    float3 _181 = _174 * _180;
    float3x3 _188 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _189 = transpose(_188);
    float3x3 _190 = float3x3(float3(0.0), _179, _181);
    float3x3 _191 = _190 * _189;
    float3 _192 = _191[0];
    float3 _193 = _191[1];
    float3 _194 = _191[2];
    float4x3 _195 = float4x3(_192, _193, _194, _161);
    float3 _196 = _195 * in.in_var_ATTRIBUTE0;
    float3 _201 = _196.xxx;
    float3 _202 = Primitive.Primitive_LocalToWorld[0].xyz * _201;
    float3 _205 = _196.yyy;
    float3 _206 = Primitive.Primitive_LocalToWorld[1].xyz * _205;
    float3 _207 = _202 + _206;
    float3 _210 = _196.zzz;
    float3 _211 = Primitive.Primitive_LocalToWorld[2].xyz * _210;
    float3 _212 = _207 + _211;
    float3 _215 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _216 = _212 + _215;
    float _217 = _216.x;
    float _218 = _216.y;
    float _219 = _216.z;
    float4 _220 = float4(_217, _218, _219, 1.0);
    float4 _241 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _220;
    out.gl_Layer = _Globals.LayerId;
    out.out_var_TEXCOORD10_centroid = float4(0.0);
    out.out_var_TEXCOORD11_centroid = float4(0.0);
    out.out_var_TEXCOORD7 = _220.xyz;
    out.out_var_TEXCOORD6 = _241;
    out.out_var_TEXCOORD8 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE2.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE2.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE2.zzz);
    out.gl_Position = _241;
    return out;
}

