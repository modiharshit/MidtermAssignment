

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
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
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

constant float3x3 _77 = {};
constant float4 _78 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_COLOR1 [[user(locn4)]];
    float4 out_var_TEXCOORD0_0 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00002140_784d9f73(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_LocalVF& LocalVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(2)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(3)]], uint gl_InstanceIndex [[instance_id]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _97 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _100 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _101 = 3u * _100;
    float4 _103 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_101));
    float4 _105 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_101 + 1u)));
    float4 _107 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint((_101 + 2u)));
    float4 _109 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_100));
    uint _110 = 2u * _97;
    float4 _115 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_110 + 1u)));
    float _116 = _115.w;
    float3 _117 = _115.xyz;
    float3 _119 = cross(_117, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_110)).xyz) * _116;
    float3x3 _122 = _77;
    _122[0] = cross(_119, _117) * _116;
    float3x3 _123 = _122;
    _123[1] = _119;
    float3x3 _124 = _123;
    _124[2] = _117;
    float3x3 _138 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * float3x3(_103.xyz, _105.xyz, _107.xyz);
    float3x3 _141 = _138;
    _141[0] = normalize(_138[0]);
    float3x3 _144 = _141;
    _144[1] = normalize(_138[1]);
    float3x3 _147 = _144;
    _147[2] = normalize(_138[2]);
    float3x3 _148 = _147 * _124;
    float _154 = trunc(_103.w * 0.00390625);
    float _155 = _109.w;
    float4 _156 = _78;
    _156.x = _155;
    float3 _161 = _109.xyz + _Globals.InstancingOffset.xyz;
    float3 _172 = (((Primitive.Primitive_LocalToWorld[0].xyz * _161.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _161.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _161.zzz)) + Primitive.Primitive_LocalToWorld[3].xyz;
    float4 _183 = _156;
    _183.y = 1.0 - fast::clamp((length(_172 + View.View_PreViewTranslation) - _Globals.InstancingFadeOutParams.x) * _Globals.InstancingFadeOutParams.y, 0.0, 1.0);
    float _195 = _Globals.InstancingViewZCompareZero.w * _155;
    float _230 = (dot(select(float3(0.0), float3(1.0), float3(length(_172 - _Globals.InstancingWorldViewOriginZero.xyz) + _195) > _Globals.InstancingViewZCompareZero.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginZero.w) + (dot(select(float3(0.0), float3(1.0), float3(length(_172 - _Globals.InstancingWorldViewOriginOne.xyz) + _195) > _Globals.InstancingViewZCompareOne.xyz), _Globals.InstancingViewZConstant.xyz) * _Globals.InstancingWorldViewOriginOne.w);
    float4 _231 = _183;
    _231.w = _230;
    float _235 = ((_Globals.InstancingFadeOutParams.z * _154) + (_Globals.InstancingFadeOutParams.w * (1.0 - _154))) * float(abs(_230) < 0.999000012874603271484375);
    float4 _236 = _231;
    _236.z = _235;
    float4 _254 = float4x4(float4(_103.xyz, 0.0), float4(_105.xyz, 0.0), float4(_107.xyz, 0.0), float4(_109.xyz, 1.0)) * in.in_var_ATTRIBUTE0;
    uint _274 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _280 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_274 * _97) + min(0u, (_274 - 1u)))));
    spvUnsafeArray<float4, 1> _292 = { float4(_280.x, _280.y, float4(0.0).z, float4(0.0).w) };
    float4x4 _296 = Primitive.Primitive_PreviousLocalToWorld;
    _296[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
    float4x4 _300 = _296;
    _300[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
    float4x4 _304 = _300;
    _304[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
    float4 _315 = View.View_TranslatedWorldToClip * float4((float4((((Primitive.Primitive_LocalToWorld[0].xyz * _254.xxx) + (Primitive.Primitive_LocalToWorld[1].xyz * _254.yyy)) + (Primitive.Primitive_LocalToWorld[2].xyz * _254.zzz)) + (Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation), 1.0) * _235).xyz, 1.0);
    float4 _322 = _315;
    _322.z = _315.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _315.w) : 0.0);
    out.gl_Position = _322;
    out.out_var_TEXCOORD6 = _315;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_304 * _254).xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_148[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_148[2], _116 * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_COLOR1 = _236;
    out_var_TEXCOORD0 = _292;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

