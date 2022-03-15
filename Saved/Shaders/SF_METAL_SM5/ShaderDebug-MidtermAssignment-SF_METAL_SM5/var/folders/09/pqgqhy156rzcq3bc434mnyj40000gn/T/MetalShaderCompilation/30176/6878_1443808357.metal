

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

struct PositionOnlyMain_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct PositionOnlyMain_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex PositionOnlyMain_out Main_00001ade_560ec465(PositionOnlyMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]])
{
    PositionOnlyMain_out out = {};
    float _76 = dot(in.in_var_ATTRIBUTE0.xyz, _Globals.SplineParams[7].xyz);
    float _80 = _76 * _Globals.SplineParams[6].w;
    float _84 = _80 - _Globals.SplineParams[4].w;
    bool _88 = _Globals.SplineParams[3].w != 0.0;
    float _89 = smoothstep(0.0, 1.0, _84);
    float _90 = _88 ? _89 : _84;
    float _101 = _84 * _84;
    float _102 = _101 * _84;
    float _103 = 2.0 * _102;
    float _104 = 3.0 * _101;
    float _105 = _103 - _104;
    float _106 = _105 + 1.0;
    float3 _107 = _Globals.SplineParams[0].xyz * _106;
    float _108 = 2.0 * _101;
    float _109 = _102 - _108;
    float _110 = _109 + _84;
    float3 _111 = _Globals.SplineParams[1].xyz * _110;
    float3 _112 = _107 + _111;
    float _113 = _102 - _101;
    float3 _114 = _Globals.SplineParams[4].xyz * _113;
    float3 _115 = _112 + _114;
    float _116 = (-2.0) * _102;
    float _117 = _116 + _104;
    float3 _118 = _Globals.SplineParams[3].xyz * _117;
    float3 _119 = _115 + _118;
    float3 _120 = _Globals.SplineParams[0].xyz * 6.0;
    float3 _121 = _Globals.SplineParams[1].xyz * 3.0;
    float3 _122 = _120 + _121;
    float3 _123 = _Globals.SplineParams[4].xyz * 3.0;
    float3 _124 = _122 + _123;
    float3 _125 = _Globals.SplineParams[3].xyz * 6.0;
    float3 _126 = _124 - _125;
    float3 _127 = _Globals.SplineParams[0].xyz * (-6.0);
    float3 _128 = _Globals.SplineParams[1].xyz * 4.0;
    float3 _129 = _127 - _128;
    float3 _130 = _Globals.SplineParams[4].xyz * 2.0;
    float3 _131 = _129 - _130;
    float3 _132 = _131 + _125;
    float3 _133 = _126 * _101;
    float3 _134 = _132 * _84;
    float3 _135 = _133 + _134;
    float3 _136 = _135 + _Globals.SplineParams[1].xyz;
    float3 _137 = normalize(_136);
    float3 _140 = cross(_Globals.SplineParams[6].xyz, _137);
    float3 _141 = normalize(_140);
    float3 _142 = cross(_137, _141);
    float3 _143 = normalize(_142);
    float2 _150 = float2(_90);
    float2 _151 = mix(_Globals.SplineParams[2].zw, _Globals.SplineParams[5].zw, _150);
    float _152 = _151.x;
    float3 _153 = _141 * _152;
    float3 _154 = _119 + _153;
    float _155 = _151.y;
    float3 _156 = _143 * _155;
    float3 _157 = _154 + _156;
    float _162 = mix(_Globals.SplineParams[0].w, _Globals.SplineParams[1].w, _90);
    float _163 = sin(_162);
    float _164 = cos(_162);
    float3 _165 = _141 * _164;
    float3 _166 = _143 * _163;
    float3 _167 = _165 - _166;
    float3 _168 = _143 * _164;
    float3 _169 = _141 * _163;
    float3 _170 = _168 + _169;
    float2 _173 = mix(_Globals.SplineParams[2].xy, _Globals.SplineParams[5].xy, _150);
    float _174 = _173.x;
    float3 _175 = _167 * _174;
    float _176 = _173.y;
    float3 _177 = _170 * _176;
    float3x3 _184 = float3x3(_Globals.SplineParams[7].xyz, _Globals.SplineParams[8].xyz, _Globals.SplineParams[9].xyz);
    float3x3 _185 = transpose(_184);
    float3x3 _186 = float3x3(float3(0.0), _175, _177);
    float3x3 _187 = _186 * _185;
    float3 _188 = _187[0];
    float3 _189 = _187[1];
    float3 _190 = _187[2];
    float4x3 _191 = float4x3(_188, _189, _190, _157);
    float3 _192 = _191 * in.in_var_ATTRIBUTE0;
    float3 _197 = _192.xxx;
    float3 _198 = Primitive.Primitive_LocalToWorld[0].xyz * _197;
    float3 _201 = _192.yyy;
    float3 _202 = Primitive.Primitive_LocalToWorld[1].xyz * _201;
    float3 _203 = _198 + _202;
    float3 _206 = _192.zzz;
    float3 _207 = Primitive.Primitive_LocalToWorld[2].xyz * _206;
    float3 _208 = _203 + _207;
    float3 _211 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _212 = _208 + _211;
    float _213 = _212.x;
    float _214 = _212.y;
    float _215 = _212.z;
    float4 _216 = float4(_213, _214, _215, 1.0);
    float4 _237 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _216;
    out.gl_Layer = _Globals.LayerId;
    out.out_var_TEXCOORD6 = _216;
    out.out_var_TEXCOORD8 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * in.in_var_ATTRIBUTE2.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * in.in_var_ATTRIBUTE2.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * in.in_var_ATTRIBUTE2.zzz);
    out.gl_Position = _237;
    return out;
}

