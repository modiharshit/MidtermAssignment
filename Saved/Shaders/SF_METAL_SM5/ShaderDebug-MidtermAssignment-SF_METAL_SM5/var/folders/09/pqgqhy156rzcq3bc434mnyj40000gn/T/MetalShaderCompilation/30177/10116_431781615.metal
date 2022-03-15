

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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
    float4 PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias;
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
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002784_19bc76ef(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceLightmapBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(4)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _93 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _96 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _97 = 3u * _96;
    float4 _99 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_97));
    uint _100 = _97 + 1u;
    float4 _101 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_100));
    uint _102 = _97 + 2u;
    float4 _103 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_102));
    float4 _105 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_96));
    float4 _107 = InstanceVF_VertexFetch_InstanceLightmapBuffer.read(uint(_96));
    uint _108 = 2u * _93;
    float4 _113 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_108 + 1u)));
    float _114 = _113.w;
    float3 _115 = _113.xyz;
    float3 _117 = cross(_115, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_108)).xyz) * _114;
    float3x3 _120 = _79;
    _120[0] = cross(_117, _115) * _114;
    float3x3 _121 = _120;
    _121[1] = _117;
    float3x3 _122 = _121;
    _122[2] = _115;
    float3x3 _136 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_99.xyz, _101.xyz, _103.xyz);
    float3x3 _139 = _136;
    _139[0] = normalize(_136[0]);
    float3x3 _142 = _139;
    _142[1] = normalize(_136[1]);
    float3x3 _145 = _142;
    _145[2] = normalize(_136[2]);
    float3x3 _146 = _145 * _122;
    float _150 = _99.w;
    float _151 = _150 * 0.00390625;
    float _152 = trunc(_151);
    float _153 = _105.w;
    float4 _154 = _80;
    _154.x = _153;
    float3 _155 = _105.xyz;
    float3 _159 = _155 + _Globals.InstancingOffset.xyz;
    float3 _160 = _159.xxx;
    float3 _161 = Primitive.Primitive_LocalToWorld[0].xyz * _160;
    float3 _162 = _159.yyy;
    float3 _163 = Primitive.Primitive_LocalToWorld[1].xyz * _162;
    float3 _164 = _161 + _163;
    float3 _165 = _159.zzz;
    float3 _166 = Primitive.Primitive_LocalToWorld[2].xyz * _165;
    float3 _167 = _164 + _166;
    float3 _170 = _167 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _181 = _154;
    _181.y = 1.0 - fast::clamp((length(_170 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _184 = _Globals.InstancingFadeOutParams.z * _152;
    float _187 = 1.0 - _152;
    float _188 = _Globals.InstancingFadeOutParams.w * _187;
    float _189 = _184 + _188;
    float _193 = _Globals.InstancingViewZCompareZero.w * _153;
    float3 _197 = _170 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _198 = length(_197);
    float _199 = _198 + _193;
    float3 _203 = _170 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _204 = length(_203);
    float _205 = _204 + _193;
    float3 _206 = float3(_199);
    bool3 _209 = _206 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _210 = select(float3(0.0), float3(1.0), _209);
    float _214 = dot(_210, _Globals.InstancingViewZConstant.xyz);
    float _217 = _214 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _218 = float3(_205);
    bool3 _222 = _218 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _223 = select(float3(0.0), float3(1.0), _222);
    float _224 = dot(_223, _Globals.InstancingViewZConstant.xyz);
    float _227 = _224 * _Globals.InstancingWorldViewOriginOne.w;
    float _228 = _217 + _227;
    float4 _229 = _181;
    _229.w = _228;
    float _230 = abs(_228);
    bool _231 = _230 < 0.999000012874603271484375;
    float _232 = float(_231);
    float _233 = _189 * _232;
    float4 _234 = _229;
    _234.z = _233;
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
    float4 _246 = float4(_243, _244, _245, 0.0);
    float _247 = _105.x;
    float _248 = _105.y;
    float _249 = _105.z;
    float4 _250 = float4(_247, _248, _249, 1.0);
    float4x4 _251 = float4x4(_238, _242, _246, _250);
    float4 _252 = _251 * in.in_var_ATTRIBUTE0;
    float3 _253 = _252.xxx;
    float3 _254 = Primitive.Primitive_LocalToWorld[0].xyz * _253;
    float3 _255 = _252.yyy;
    float3 _256 = Primitive.Primitive_LocalToWorld[1].xyz * _255;
    float3 _257 = _254 + _256;
    float3 _258 = _252.zzz;
    float3 _259 = Primitive.Primitive_LocalToWorld[2].xyz * _258;
    float3 _260 = _257 + _259;
    float3 _261 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _262 = _260 + _261;
    float _263 = _262.x;
    float _264 = _262.y;
    float _265 = _262.z;
    float4 _266 = float4(_263, _264, _265, 1.0);
    float4 _267 = _266 * _233;
    uint _270 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _273 = _270 * _93;
    float4 _276 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_273 + min(0u, (_270 - 1u)))));
    float4 _277 = float4(_267.x, _267.y, _267.z, _267.w);
    float4 _278 = View.View_TranslatedWorldToClip * _277;
    float2 _285 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_273 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    float2 _291 = (_285 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + _107.xy;
    float2 _297 = (_285 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy) + _107.zw;
    spvUnsafeArray<float4, 1> _309 = { float4(_276.x, _276.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_146[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_146[2], _114 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _234;
    out_var_TEXCOORD0 = _309;
    out.out_var_TEXCOORD4 = float4(_291.x, _291.y, _297.x, _297.y);
    out.gl_Position = _278;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

