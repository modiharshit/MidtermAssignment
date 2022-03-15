

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

constant float3x3 _73 = {};
constant float4 _74 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002355_7b0a5faf(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _87 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _90 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _91 = 3u * _90;
    float4 _93 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_91));
    uint _94 = _91 + 1u;
    float4 _95 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_94));
    uint _96 = _91 + 2u;
    float4 _97 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_96));
    float4 _99 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_90));
    uint _100 = 2u * _87;
    float4 _105 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_100 + 1u)));
    float _106 = _105.w;
    float3 _107 = _105.xyz;
    float3 _109 = cross(_107, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_100)).xyz) * _106;
    float3x3 _112 = _73;
    _112[0] = cross(_109, _107) * _106;
    float3x3 _113 = _112;
    _113[1] = _109;
    float3x3 _114 = _113;
    _114[2] = _107;
    float3x3 _128 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_93.xyz, _95.xyz, _97.xyz);
    float3x3 _131 = _128;
    _131[0] = normalize(_128[0]);
    float3x3 _134 = _131;
    _134[1] = normalize(_128[1]);
    float3x3 _137 = _134;
    _137[2] = normalize(_128[2]);
    float3x3 _138 = _137 * _114;
    float _142 = _93.w;
    float _143 = _142 * 0.00390625;
    float _144 = trunc(_143);
    float _145 = _99.w;
    float4 _146 = _74;
    _146.x = _145;
    float3 _147 = _99.xyz;
    float3 _151 = _147 + _Globals.InstancingOffset.xyz;
    float3 _152 = _151.xxx;
    float3 _153 = Primitive.Primitive_LocalToWorld[0].xyz * _152;
    float3 _154 = _151.yyy;
    float3 _155 = Primitive.Primitive_LocalToWorld[1].xyz * _154;
    float3 _156 = _153 + _155;
    float3 _157 = _151.zzz;
    float3 _158 = Primitive.Primitive_LocalToWorld[2].xyz * _157;
    float3 _159 = _156 + _158;
    float3 _162 = _159 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _173 = _146;
    _173.y = 1.0 - fast::clamp((length(_162 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _176 = _Globals.InstancingFadeOutParams.z * _144;
    float _179 = 1.0 - _144;
    float _180 = _Globals.InstancingFadeOutParams.w * _179;
    float _181 = _176 + _180;
    float _185 = _Globals.InstancingViewZCompareZero.w * _145;
    float3 _189 = _162 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _190 = length(_189);
    float _191 = _190 + _185;
    float3 _195 = _162 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _196 = length(_195);
    float _197 = _196 + _185;
    float3 _198 = float3(_191);
    bool3 _201 = _198 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _202 = select(float3(0.0), float3(1.0), _201);
    float _206 = dot(_202, _Globals.InstancingViewZConstant.xyz);
    float _209 = _206 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _210 = float3(_197);
    bool3 _214 = _210 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _215 = select(float3(0.0), float3(1.0), _214);
    float _216 = dot(_215, _Globals.InstancingViewZConstant.xyz);
    float _219 = _216 * _Globals.InstancingWorldViewOriginOne.w;
    float _220 = _209 + _219;
    float4 _221 = _173;
    _221.w = _220;
    float _222 = abs(_220);
    bool _223 = _222 < 0.999000012874603271484375;
    float _224 = float(_223);
    float _225 = _181 * _224;
    float4 _226 = _221;
    _226.z = _225;
    float _227 = _93.x;
    float _228 = _93.y;
    float _229 = _93.z;
    float4 _230 = float4(_227, _228, _229, 0.0);
    float _231 = _95.x;
    float _232 = _95.y;
    float _233 = _95.z;
    float4 _234 = float4(_231, _232, _233, 0.0);
    float _235 = _97.x;
    float _236 = _97.y;
    float _237 = _97.z;
    float4 _238 = float4(_235, _236, _237, 0.0);
    float _239 = _99.x;
    float _240 = _99.y;
    float _241 = _99.z;
    float4 _242 = float4(_239, _240, _241, 1.0);
    float4x4 _243 = float4x4(_230, _234, _238, _242);
    float4 _244 = _243 * in.in_var_ATTRIBUTE0;
    float3 _245 = _244.xxx;
    float3 _246 = Primitive.Primitive_LocalToWorld[0].xyz * _245;
    float3 _247 = _244.yyy;
    float3 _248 = Primitive.Primitive_LocalToWorld[1].xyz * _247;
    float3 _249 = _246 + _248;
    float3 _250 = _244.zzz;
    float3 _251 = Primitive.Primitive_LocalToWorld[2].xyz * _250;
    float3 _252 = _249 + _251;
    float3 _253 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _254 = _252 + _253;
    float _255 = _254.x;
    float _256 = _254.y;
    float _257 = _254.z;
    float4 _258 = float4(_255, _256, _257, 1.0);
    float4 _259 = _258 * _225;
    uint _262 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _268 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_262 * _87) + min(0u, (_262 - 1u)))));
    float4 _269 = float4(_259.x, _259.y, _259.z, _259.w);
    float4 _270 = View.View_TranslatedWorldToClip * _269;
    spvUnsafeArray<float4, 1> _282 = { float4(_268.x, _268.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_138[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_138[2], _106 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _226;
    out_var_TEXCOORD0 = _282;
    out.gl_Position = _270;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

