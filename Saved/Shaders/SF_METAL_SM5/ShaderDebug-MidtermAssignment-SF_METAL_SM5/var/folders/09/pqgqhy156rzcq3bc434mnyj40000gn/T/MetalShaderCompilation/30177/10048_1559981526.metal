

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

constant float3x3 _81 = {};
constant float4 _82 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR1 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    float4 out_var_TEXCOORD4 [[user(locn4)]];
    float4 out_var_TEXCOORD6 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00002740_5cfb6dd6(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_LocalVF& LocalVF [[buffer(7)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceLightmapBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(4)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _95 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _98 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _99 = 3u * _98;
    float4 _101 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_99));
    uint _102 = _99 + 1u;
    float4 _103 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_102));
    uint _104 = _99 + 2u;
    float4 _105 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_104));
    float4 _107 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_98));
    uint _110 = 2u * _95;
    float4 _115 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_110 + 1u)));
    float _116 = _115.w;
    float3 _117 = _115.xyz;
    float3 _119 = cross(_117, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_110)).xyz) * _116;
    float3x3 _122 = _81;
    _122[0] = cross(_119, _117) * _116;
    float3x3 _123 = _122;
    _123[1] = _119;
    float3x3 _124 = _123;
    _124[2] = _117;
    float3x3 _138 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_101.xyz, _103.xyz, _105.xyz);
    float3x3 _141 = _138;
    _141[0] = normalize(_138[0]);
    float3x3 _144 = _141;
    _144[1] = normalize(_138[1]);
    float3x3 _147 = _144;
    _147[2] = normalize(_138[2]);
    float3x3 _148 = _147 * _124;
    float _152 = _101.w;
    float _153 = _152 * 0.00390625;
    float _154 = trunc(_153);
    float _155 = _107.w;
    float4 _156 = _82;
    _156.x = _155;
    float3 _157 = _107.xyz;
    float3 _161 = _157 + _Globals.InstancingOffset.xyz;
    float3 _162 = _161.xxx;
    float3 _163 = Primitive.Primitive_LocalToWorld[0].xyz * _162;
    float3 _164 = _161.yyy;
    float3 _165 = Primitive.Primitive_LocalToWorld[1].xyz * _164;
    float3 _166 = _163 + _165;
    float3 _167 = _161.zzz;
    float3 _168 = Primitive.Primitive_LocalToWorld[2].xyz * _167;
    float3 _169 = _166 + _168;
    float3 _172 = _169 + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _183 = _156;
    _183.y = 1.0 - fast::clamp((length(_172 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _186 = _Globals.InstancingFadeOutParams.z * _154;
    float _189 = 1.0 - _154;
    float _190 = _Globals.InstancingFadeOutParams.w * _189;
    float _191 = _186 + _190;
    float _195 = _Globals.InstancingViewZCompareZero.w * _155;
    float3 _199 = _172 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _200 = length(_199);
    float _201 = _200 + _195;
    float3 _205 = _172 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _206 = length(_205);
    float _207 = _206 + _195;
    float3 _208 = float3(_201);
    bool3 _211 = _208 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _212 = select(float3(0.0), float3(1.0), _211);
    float _216 = dot(_212, _Globals.InstancingViewZConstant.xyz);
    float _219 = _216 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _220 = float3(_207);
    bool3 _224 = _220 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _225 = select(float3(0.0), float3(1.0), _224);
    float _226 = dot(_225, _Globals.InstancingViewZConstant.xyz);
    float _229 = _226 * _Globals.InstancingWorldViewOriginOne.w;
    float _230 = _219 + _229;
    float4 _231 = _183;
    _231.w = _230;
    float _232 = abs(_230);
    bool _233 = _232 < 0.999000012874603271484375;
    float _234 = float(_233);
    float _235 = _191 * _234;
    float4 _236 = _231;
    _236.z = _235;
    float _237 = _101.x;
    float _238 = _101.y;
    float _239 = _101.z;
    float4 _240 = float4(_237, _238, _239, 0.0);
    float _241 = _103.x;
    float _242 = _103.y;
    float _243 = _103.z;
    float4 _244 = float4(_241, _242, _243, 0.0);
    float _245 = _105.x;
    float _246 = _105.y;
    float _247 = _105.z;
    float4 _248 = float4(_245, _246, _247, 0.0);
    float _249 = _107.x;
    float _250 = _107.y;
    float _251 = _107.z;
    float4 _252 = float4(_249, _250, _251, 1.0);
    float4x4 _253 = float4x4(_240, _244, _248, _252);
    float4 _254 = _253 * in.in_var_ATTRIBUTE0;
    float3 _255 = _254.xxx;
    float3 _256 = Primitive.Primitive_LocalToWorld[0].xyz * _255;
    float3 _257 = _254.yyy;
    float3 _258 = Primitive.Primitive_LocalToWorld[1].xyz * _257;
    float3 _259 = _256 + _258;
    float3 _260 = _254.zzz;
    float3 _261 = Primitive.Primitive_LocalToWorld[2].xyz * _260;
    float3 _262 = _259 + _261;
    float3 _263 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _264 = _262 + _263;
    float _265 = _264.x;
    float _266 = _264.y;
    float _267 = _264.z;
    float4 _268 = float4(_265, _266, _267, 1.0);
    float4 _269 = _268 * _235;
    uint _272 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _275 = _272 * _95;
    float4 _278 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_275 + min(0u, (_272 - 1u)))));
    float4 _279 = float4(_269.x, _269.y, _269.z, _269.w);
    float4 _280 = View.View_TranslatedWorldToClip * _279;
    float2 _293 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint((_275 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + InstanceVF_VertexFetch_InstanceLightmapBuffer.read(uint(_98)).xy;
    spvUnsafeArray<float4, 1> _305 = { float4(_278.x, _278.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_148[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_148[2], _116 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _236;
    out_var_TEXCOORD0 = _305;
    out.out_var_TEXCOORD4 = float4(_293.x, _293.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _279;
    out.gl_Position = _280;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

