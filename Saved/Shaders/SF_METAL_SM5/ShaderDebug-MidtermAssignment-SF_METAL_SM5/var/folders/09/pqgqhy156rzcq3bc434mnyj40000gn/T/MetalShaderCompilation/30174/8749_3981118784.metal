

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

constant float3x3 _79 = {};
constant float4 _80 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000222d_ed4b0d40(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _91 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _94 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _95 = 3u * _94;
    float4 _97 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_95));
    float4 _99 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_95 + 1u)));
    float4 _101 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_95 + 2u)));
    float4 _103 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_94));
    uint _104 = 2u * _91;
    float4 _109 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_104 + 1u)));
    float _110 = _109.w;
    float3 _111 = _109.xyz;
    float3 _113 = cross(_111, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_104)).xyz) * _110;
    float3x3 _116 = _79;
    _116[0] = cross(_113, _111) * _110;
    float3x3 _117 = _116;
    _117[1] = _113;
    float3x3 _118 = _117;
    _118[2] = _111;
    float3x3 _132 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_97.xyz, _99.xyz, _101.xyz);
    float3x3 _135 = _132;
    _135[0] = normalize(_132[0]);
    float3x3 _138 = _135;
    _138[1] = normalize(_132[1]);
    float3x3 _141 = _138;
    _141[2] = normalize(_132[2]);
    float3x3 _142 = _141 * _118;
    float _148 = trunc(_97.w * 0.00390625);
    float _149 = _103.w;
    float4 _150 = _80;
    _150.x = _149;
    float3 _155 = _103.xyz + _Globals.InstancingOffset.xyz;
    float3 _166 = (((Primitive.Primitive_LocalToWorld[0].xyz * _155.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _155.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _155.zzz)) + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _177 = _150;
    _177.y = 1.0 - fast::clamp((length(_166 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _189 = _Globals.InstancingViewZCompareZero.w * _149;
    float _224 = (dot(select(float3(0.0), float3(1.0), float3(length(_166 - _Globals.InstancingWorldViewOriginZero.xyz) + _189) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginZero.w) + (dot(select(float3(0.0), float3(1.0), float3(length(_166 - _Globals.InstancingWorldViewOriginOne.xyz) + _189) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginOne.w);
    float4 _225 = _177;
    _225.w = _224;
    float _229 = ((_Globals.InstancingFadeOutParams.z * _148) + (_Globals.InstancingFadeOutParams.w * (1.0 - _148))) * float(abs(_224) < 0.999000012874603271484375);
    float4 _230 = _225;
    _230.z = _229;
    float4 _248 = float4x4(float4(_97.xyz, 0.0), float4(_99.xyz, 0.0), float4(_101.xyz, 0.0), float4(_103.xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    float4 _263 = float4((((Primitive.Primitive_LocalToWorld[0].xyz * _248.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _248.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _248.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * _229;
    uint _266 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _272 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_266 * _91) + min(0u, (_266 - 1u)))));
    float3 _273 = _142[2];
    float4 _279 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_263.x, _263.y, _263.z, _263.w);
    float4 _290;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_279.z < 0.0))
    {
        float4 _288 = _279;
        _288.z = 9.9999999747524270787835121154785e-07;
        float4 _289 = _288;
        _289.w = 1.0;
        _290 = _289;
    }
    else
    {
        _290 = _279;
    }
    float _296 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _273));
    float4 _321 = _290;
    _321.z = ((_290.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_296) > 0.0) ? (sqrt(fast::clamp(1.0 - (_296 * _296), 0.0, 1.0)) / _296) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _290.w;
    spvUnsafeArray<float4, 1> _332 = { float4(_272.x, _272.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_142[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_273, _110 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _230;
    out_var_TEXCOORD0 = _332;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _321;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

