

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
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002694_f11f25c6(Main_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceLightmapBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(4)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _94 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _97 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _98 = 3u * _97;
    float4 _100 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_98));
    uint _101 = _98 + 1u;
    float4 _102 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_101));
    uint _103 = _98 + 2u;
    float4 _104 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_103));
    float4 _106 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_97));
    uint _109 = 2u * _94;
    float4 _114 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_109 + 1u)));
    float _115 = _114.w;
    float3 _116 = _114.xyz;
    float3 _118 = cross(_116, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_109)).xyz) * _115;
    float3x3 _121 = _80;
    _121[0] = cross(_118, _116) * _115;
    float3x3 _122 = _121;
    _122[1] = _118;
    float3x3 _123 = _122;
    _123[2] = _116;
    float3x3 _137 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_100.xyz, _102.xyz, _104.xyz);
    float3x3 _140 = _137;
    _140[0] = normalize(_137[0]);
    float3x3 _143 = _140;
    _143[1] = normalize(_137[1]);
    float3x3 _146 = _143;
    _146[2] = normalize(_137[2]);
    float3x3 _147 = _146 * _123;
    float _151 = _100.w;
    float _152 = _151 * 0.00390625;
    float _153 = trunc(_152);
    float _154 = _106.w;
    float4 _155 = _81;
    _155.x = _154;
    float3 _156 = _106.xyz;
    float3 _160 = _156 + _Globals.InstancingOffset.xyz;
    float3 _161 = _160.xxx;
    float3 _162 = Primitive.Primitive_LocalToWorld[0].xyz * _161;
    float3 _163 = _160.yyy;
    float3 _164 = Primitive.Primitive_LocalToWorld[1].xyz * _163;
    float3 _165 = _162 + _164;
    float3 _166 = _160.zzz;
    float3 _167 = Primitive.Primitive_LocalToWorld[2].xyz * _166;
    float3 _168 = _165 + _167;
    float3 _171 = _168 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _182 = _155;
    _182.y = 1.0 - fast::clamp((length(_171 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _185 = _Globals.InstancingFadeOutParams.z * _153;
    float _188 = 1.0 - _153;
    float _189 = _Globals.InstancingFadeOutParams.w * _188;
    float _190 = _185 + _189;
    float _194 = _Globals.InstancingViewZCompareZero.w * _154;
    float3 _198 = _171 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _199 = length(_198);
    float _200 = _199 + _194;
    float3 _204 = _171 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _205 = length(_204);
    float _206 = _205 + _194;
    float3 _207 = float3(_200);
    bool3 _210 = _207 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _211 = select(float3(0.0), float3(1.0), _210);
    float _215 = dot(_211, _Globals.InstancingViewZConstant.xyz);
    float _218 = _215 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _219 = float3(_206);
    bool3 _223 = _219 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _224 = select(float3(0.0), float3(1.0), _223);
    float _225 = dot(_224, _Globals.InstancingViewZConstant.xyz);
    float _228 = _225 * _Globals.InstancingWorldViewOriginOne.w;
    float _229 = _218 + _228;
    float4 _230 = _182;
    _230.w = _229;
    float _231 = abs(_229);
    bool _232 = _231 < 0.999000012874603271484375;
    float _233 = float(_232);
    float _234 = _190 * _233;
    float4 _235 = _230;
    _235.z = _234;
    float _236 = _100.x;
    float _237 = _100.y;
    float _238 = _100.z;
    float4 _239 = float4(_236, _237, _238, 0.0);
    float _240 = _102.x;
    float _241 = _102.y;
    float _242 = _102.z;
    float4 _243 = float4(_240, _241, _242, 0.0);
    float _244 = _104.x;
    float _245 = _104.y;
    float _246 = _104.z;
    float4 _247 = float4(_244, _245, _246, 0.0);
    float _248 = _106.x;
    float _249 = _106.y;
    float _250 = _106.z;
    float4 _251 = float4(_248, _249, _250, 1.0);
    float4x4 _252 = float4x4(_239, _243, _247, _251);
    float4 _253 = _252 * in.in_var_ATTRIBUTE0;
    float3 _254 = _253.xxx;
    float3 _255 = Primitive.Primitive_LocalToWorld[0].xyz * _254;
    float3 _256 = _253.yyy;
    float3 _257 = Primitive.Primitive_LocalToWorld[1].xyz * _256;
    float3 _258 = _255 + _257;
    float3 _259 = _253.zzz;
    float3 _260 = Primitive.Primitive_LocalToWorld[2].xyz * _259;
    float3 _261 = _258 + _260;
    float3 _262 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _263 = _261 + _262;
    float _264 = _263.x;
    float _265 = _263.y;
    float _266 = _263.z;
    float4 _267 = float4(_264, _265, _266, 1.0);
    float4 _268 = _267 * _234;
    uint _271 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _274 = _271 * _94;
    float4 _277 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_274 + min(0u, (_271 - 1u)))));
    float4 _278 = float4(_268.x, _268.y, _268.z, _268.w);
    float4 _279 = View.View_TranslatedWorldToClip * _278;
    float2 _292 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint((_274 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + InstanceVF_VertexFetch_InstanceLightmapBuffer.read(uint(_97)).xy;
    spvUnsafeArray<float4, 1> _304 = { float4(_277.x, _277.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_147[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_147[2], _115 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _235;
    out_var_TEXCOORD0 = _304;
    out.out_var_TEXCOORD4 = float4(_292.x, _292.y, float2(0.0).x, float2(0.0).y);
    out.gl_Position = _279;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

