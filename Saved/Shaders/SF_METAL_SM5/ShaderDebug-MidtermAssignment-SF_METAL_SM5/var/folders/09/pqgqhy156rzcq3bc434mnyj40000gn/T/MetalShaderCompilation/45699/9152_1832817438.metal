

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
    uint LayerId;
};

constant float3x3 _77 = {};
constant float4 _78 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float3 out_var_TEXCOORD8 [[user(locn5)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainForGS_out Main_000023c0_6d3e931e(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainForGS_out out = {};
    uint _94 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _95 = 3u * _94;
    float4 _97 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_95));
    uint _98 = _95 + 1u;
    float4 _99 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_98));
    uint _100 = _95 + 2u;
    float4 _101 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_100));
    float4 _103 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_94));
    uint _104 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _109 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_104 + 1u)));
    float _110 = _109.w;
    float3 _111 = _109.xyz;
    float3 _113 = cross(_111, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_104)).xyz) * _110;
    float3x3 _116 = _77;
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
    float _146 = _97.w;
    float _147 = _146 * 0.00390625;
    float _148 = trunc(_147);
    float _149 = _103.w;
    float4 _150 = _78;
    _150.x = _149;
    float3 _151 = _103.xyz;
    float3 _155 = _151 + _Globals.InstancingOffset.xyz;
    float3 _156 = _155.xxx;
    float3 _157 = Primitive.Primitive_LocalToWorld[0].xyz * _156;
    float3 _158 = _155.yyy;
    float3 _159 = Primitive.Primitive_LocalToWorld[1].xyz * _158;
    float3 _160 = _157 + _159;
    float3 _161 = _155.zzz;
    float3 _162 = Primitive.Primitive_LocalToWorld[2].xyz * _161;
    float3 _163 = _160 + _162;
    float3 _166 = _163 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _177 = _150;
    _177.y = 1.0 - fast::clamp((length(_166 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _180 = _Globals.InstancingFadeOutParams.z * _148;
    float _183 = 1.0 - _148;
    float _184 = _Globals.InstancingFadeOutParams.w * _183;
    float _185 = _180 + _184;
    float _189 = _Globals.InstancingViewZCompareZero.w * _149;
    float3 _193 = _166 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _194 = length(_193);
    float _195 = _194 + _189;
    float3 _199 = _166 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _200 = length(_199);
    float _201 = _200 + _189;
    float3 _202 = float3(_195);
    bool3 _205 = _202 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _206 = select(float3(0.0), float3(1.0), _205);
    float _210 = dot(_206, _Globals.InstancingViewZConstant.xyz);
    float _213 = _210 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _214 = float3(_201);
    bool3 _218 = _214 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _219 = select(float3(0.0), float3(1.0), _218);
    float _220 = dot(_219, _Globals.InstancingViewZConstant.xyz);
    float _223 = _220 * _Globals.InstancingWorldViewOriginOne.w;
    float _224 = _213 + _223;
    float4 _225 = _177;
    _225.w = _224;
    float _226 = abs(_224);
    bool _227 = _226 < 0.999000012874603271484375;
    float _228 = float(_227);
    float _229 = _185 * _228;
    float4 _230 = _225;
    _230.z = _229;
    float _231 = _97.x;
    float _232 = _97.y;
    float _233 = _97.z;
    float4 _234 = float4(_231, _232, _233, 0.0);
    float _235 = _99.x;
    float _236 = _99.y;
    float _237 = _99.z;
    float4 _238 = float4(_235, _236, _237, 0.0);
    float _239 = _101.x;
    float _240 = _101.y;
    float _241 = _101.z;
    float4 _242 = float4(_239, _240, _241, 0.0);
    float _243 = _103.x;
    float _244 = _103.y;
    float _245 = _103.z;
    float4 _246 = float4(_243, _244, _245, 1.0);
    float4x4 _247 = float4x4(_234, _238, _242, _246);
    float4 _248 = _247 * in.in_var_ATTRIBUTE0;
    float3 _249 = _248.xxx;
    float3 _250 = Primitive.Primitive_LocalToWorld[0].xyz * _249;
    float3 _251 = _248.yyy;
    float3 _252 = Primitive.Primitive_LocalToWorld[1].xyz * _251;
    float3 _253 = _250 + _252;
    float3 _254 = _248.zzz;
    float3 _255 = Primitive.Primitive_LocalToWorld[2].xyz * _254;
    float3 _256 = _253 + _255;
    float3 _257 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _258 = _256 + _257;
    float _259 = _258.x;
    float _260 = _258.y;
    float _261 = _258.z;
    float4 _262 = float4(_259, _260, _261, 1.0);
    float4 _263 = _262 * _229;
    float3 _264 = _142[2];
    float4 _265 = float4(_263.x, _263.y, _263.z, _263.w);
    float4 _280 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _265;
    out.out_var_TEXCOORD10_centroid = float4(_142[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_264, _110 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _230;
    out.out_var_TEXCOORD7 = _263.xyz;
    out.out_var_TEXCOORD6 = _280;
    out.out_var_TEXCOORD8 = _264;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _280;
    return out;
}

