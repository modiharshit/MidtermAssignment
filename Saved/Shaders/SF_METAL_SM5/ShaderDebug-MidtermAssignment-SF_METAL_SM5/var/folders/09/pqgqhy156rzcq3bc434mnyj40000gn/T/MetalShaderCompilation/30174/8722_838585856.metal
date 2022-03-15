

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
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

struct type_Globals
{
    float4 InstancingViewZCompareZero;
    float4 InstancingViewZCompareOne;
    float4 InstancingViewZConstant;
    float4 InstancingWorldViewOriginZero;
    float4 InstancingWorldViewOriginOne;
    float4 InstancingOffset;
    float4 InstancingFadeOutParams;
    uint InstanceOffset;
};

constant float3x3 _80 = {};
constant float4 _81 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float out_var_TEXCOORD6 [[user(locn4)]];
    float out_var_TEXCOORD8 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002212_31fbce00(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _91 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _92 = 3u * _91;
    float4 _94 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_92));
    float4 _96 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_92 + 1u)));
    float4 _98 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_92 + 2u)));
    float4 _100 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_91));
    uint _104 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _105 = 2u * _104;
    float4 _110 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_105 + 1u)));
    float _111 = _110.w;
    float3 _112 = _110.xyz;
    float3 _114 = cross(_112, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_105)).xyz) * _111;
    float3x3 _117 = _80;
    _117[0] = cross(_114, _112) * _111;
    float3x3 _118 = _117;
    _118[1] = _114;
    float3x3 _119 = _118;
    _119[2] = _112;
    float3x3 _133 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_94.xyz, _96.xyz, _98.xyz);
    float3x3 _136 = _133;
    _136[0] = normalize(_133[0]);
    float3x3 _139 = _136;
    _139[1] = normalize(_133[1]);
    float3x3 _142 = _139;
    _142[2] = normalize(_133[2]);
    float3x3 _143 = _142 * _119;
    float _149 = trunc(_94.w * 0.00390625);
    float _150 = _100.w;
    float4 _151 = _81;
    _151.x = _150;
    float3 _156 = _100.xyz + _Globals.InstancingOffset.xyz;
    float3 _167 = (((Primitive.Primitive_LocalToWorld[0].xyz * _156.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _156.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _156.zzz)) + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _178 = _151;
    _178.y = 1.0 - fast::clamp((length(_167 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _190 = _Globals.InstancingViewZCompareZero.w * _150;
    float _225 = (dot(select(float3(0.0), float3(1.0), float3(length(_167 - _Globals.InstancingWorldViewOriginZero.xyz) + _190) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginZero.w) + (dot(select(float3(0.0), float3(1.0), float3(length(_167 - _Globals.InstancingWorldViewOriginOne.xyz) + _190) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginOne.w);
    float4 _226 = _178;
    _226.w = _225;
    float _230 = ((_Globals.InstancingFadeOutParams.z * _149) + (_Globals.InstancingFadeOutParams.w * (1.0 - _149))) * float(abs(_225) < 0.999000012874603271484375);
    float4 _231 = _226;
    _231.z = _230;
    float4 _249 = float4x4(float4(_94.xyz, 0.0), float4(_96.xyz, 0.0), float4(_98.xyz, 0.0), float4(_100.xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _264 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _249.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _249.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _249.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * _230;
    uint _267 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _273 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_267 * _104) + min(0u, (_267 - 1u)))));
    float3 _274 = _143[2];
    float4 _280 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_264.x, _264.y, _264.z, _264.w);
    float4 _291;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_280.z < 0.0))
    {
        float4 _289 = _280;
        _289.z = 9.9999999747524270787835121154785e-07;
        float4 _290 = _289;
        _290.w = 1.0;
        _291 = _290;
    }
    else
    {
        _291 = _280;
    }
    float _297 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _274));
    spvUnsafeArray<float4, 1> _326 = { float4(_273.x, _273.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_143[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_274, _111 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _231;
    out_var_TEXCOORD0 = _326;
    out.out_var_TEXCOORD6 = _291.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_297) > 0.0) ? (sqrt(fast::clamp(1.0 - (_297 * _297), 0.0, 1.0)) / _297) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _291;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

