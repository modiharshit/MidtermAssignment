

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

constant float3x3 _74 = {};
constant float4 _75 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00002407_cc018b01(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _88 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _91 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _92 = 3u * _91;
    float4 _94 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_92));
    uint _95 = _92 + 1u;
    float4 _96 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_95));
    uint _97 = _92 + 2u;
    float4 _98 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_97));
    float4 _100 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_91));
    uint _101 = 2u * _88;
    float4 _106 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_101 + 1u)));
    float _107 = _106.w;
    float3 _108 = _106.xyz;
    float3 _110 = cross(_108, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_101)).xyz) * _107;
    float3x3 _113 = _74;
    _113[0] = cross(_110, _108) * _107;
    float3x3 _114 = _113;
    _114[1] = _110;
    float3x3 _115 = _114;
    _115[2] = _108;
    float3x3 _129 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_94.xyz, _96.xyz, _98.xyz);
    float3x3 _132 = _129;
    _132[0] = normalize(_129[0]);
    float3x3 _135 = _132;
    _135[1] = normalize(_129[1]);
    float3x3 _138 = _135;
    _138[2] = normalize(_129[2]);
    float3x3 _139 = _138 * _115;
    float _143 = _94.w;
    float _144 = _143 * 0.00390625;
    float _145 = trunc(_144);
    float _146 = _100.w;
    float4 _147 = _75;
    _147.x = _146;
    float3 _148 = _100.xyz;
    float3 _152 = _148 + _Globals.InstancingOffset.xyz;
    float3 _153 = _152.xxx;
    float3 _154 = Primitive.Primitive_LocalToWorld[0].xyz * _153;
    float3 _155 = _152.yyy;
    float3 _156 = Primitive.Primitive_LocalToWorld[1].xyz * _155;
    float3 _157 = _154 + _156;
    float3 _158 = _152.zzz;
    float3 _159 = Primitive.Primitive_LocalToWorld[2].xyz * _158;
    float3 _160 = _157 + _159;
    float3 _163 = _160 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _174 = _147;
    _174.y = 1.0 - fast::clamp((length(_163 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _177 = _Globals.InstancingFadeOutParams.z * _145;
    float _180 = 1.0 - _145;
    float _181 = _Globals.InstancingFadeOutParams.w * _180;
    float _182 = _177 + _181;
    float _186 = _Globals.InstancingViewZCompareZero.w * _146;
    float3 _190 = _163 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _191 = length(_190);
    float _192 = _191 + _186;
    float3 _196 = _163 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _197 = length(_196);
    float _198 = _197 + _186;
    float3 _199 = float3(_192);
    bool3 _202 = _199 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _203 = select(float3(0.0), float3(1.0), _202);
    float _207 = dot(_203, _Globals.InstancingViewZConstant.xyz);
    float _210 = _207 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _211 = float3(_198);
    bool3 _215 = _211 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _216 = select(float3(0.0), float3(1.0), _215);
    float _217 = dot(_216, _Globals.InstancingViewZConstant.xyz);
    float _220 = _217 * _Globals.InstancingWorldViewOriginOne.w;
    float _221 = _210 + _220;
    float4 _222 = _174;
    _222.w = _221;
    float _223 = abs(_221);
    bool _224 = _223 < 0.999000012874603271484375;
    float _225 = float(_224);
    float _226 = _182 * _225;
    float4 _227 = _222;
    _227.z = _226;
    float _228 = _94.x;
    float _229 = _94.y;
    float _230 = _94.z;
    float4 _231 = float4(_228, _229, _230, 0.0);
    float _232 = _96.x;
    float _233 = _96.y;
    float _234 = _96.z;
    float4 _235 = float4(_232, _233, _234, 0.0);
    float _236 = _98.x;
    float _237 = _98.y;
    float _238 = _98.z;
    float4 _239 = float4(_236, _237, _238, 0.0);
    float _240 = _100.x;
    float _241 = _100.y;
    float _242 = _100.z;
    float4 _243 = float4(_240, _241, _242, 1.0);
    float4x4 _244 = float4x4(_231, _235, _239, _243);
    float4 _245 = _244 * in.in_var_ATTRIBUTE0;
    float3 _246 = _245.xxx;
    float3 _247 = Primitive.Primitive_LocalToWorld[0].xyz * _246;
    float3 _248 = _245.yyy;
    float3 _249 = Primitive.Primitive_LocalToWorld[1].xyz * _248;
    float3 _250 = _247 + _249;
    float3 _251 = _245.zzz;
    float3 _252 = Primitive.Primitive_LocalToWorld[2].xyz * _251;
    float3 _253 = _250 + _252;
    float3 _254 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _255 = _253 + _254;
    float _256 = _255.x;
    float _257 = _255.y;
    float _258 = _255.z;
    float4 _259 = float4(_256, _257, _258, 1.0);
    float4 _260 = _259 * _226;
    uint _263 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _269 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_263 * _88) + min(0u, (_263 - 1u)))));
    float4 _270 = float4(_260.x, _260.y, _260.z, _260.w);
    float4 _271 = View.View_TranslatedWorldToClip * _270;
    spvUnsafeArray<float4, 1> _283 = { float4(_269.x, _269.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_139[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_139[2], _107 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _227;
    out_var_TEXCOORD0 = _283;
    out.out_var_TEXCOORD6 = _270;
    out.gl_Position = _271;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

