

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
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_MeshParticleVF
{
    char _m0_pad[24];
    uint MeshParticleVF_PrevTransformAvailable;
};

constant spvUnsafeArray<float2, 1> _77 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float _79 = {};
constant float4 _80 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
    float4 in_var_ATTRIBUTE8 [[attribute(8)]];
    float4 in_var_ATTRIBUTE9 [[attribute(9)]];
    float4 in_var_ATTRIBUTE10 [[attribute(10)]];
};

vertex MainVertexShader_out Main_000017ff_70f5b09d(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_MeshParticleVF& MeshParticleVF [[buffer(3)]], texture_buffer<float> PrevTransformBuffer [[texture(0)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _83;
    _83 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _84 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _103 = 0; _103 < 1; )
    {
        _84[_103] = _83[_103];
        _103++;
        continue;
    }
    float4x4 _113 = transpose(float4x4(in.in_var_ATTRIBUTE8, in.in_var_ATTRIBUTE9, in.in_var_ATTRIBUTE10, float4(0.0, 0.0, 0.0, 1.0)));
    float3 _116 = (_113 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation;
    float _117 = _116.x;
    spvUnsafeArray<float2, 1> _82;
    _82 = _84;
    spvUnsafeArray<float2, 1> _85 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _121 = 0; _121 < 1; )
    {
        _85[_121] = _82[_121];
        _121++;
        continue;
    }
    float4 _132 = _80;
    _132.w = 0.0;
    float3x3 _134 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _134[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _137 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _138 = _134;
    _138[1] = _137;
    float3x3 _141 = _138;
    _141[0] = cross(_137, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _149 = float3x3(_113[0].xyz, _113[1].xyz, _113[2].xyz) * _141;
    float3 _151 = normalize(_149[0]);
    spvUnsafeArray<float4, 1> _162 = { float4(_85[0].x, _85[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _188;
    switch (0u)
    {
        default:
        {
            if (MeshParticleVF.MeshParticleVF_PrevTransformAvailable > 0u)
            {
                uint _172 = (gl_InstanceIndex - gl_BaseInstance) * 3u;
                _188 = float4((transpose(float4x4(PrevTransformBuffer.read(uint(_172)), PrevTransformBuffer.read(uint((_172 + 1u))), PrevTransformBuffer.read(uint((_172 + 2u))), float4(0.0, 0.0, 0.0, 1.0))) * in.in_var_ATTRIBUTE0).xyz + View.View_PrevPreViewTranslation, _79);
                break;
            }
            else
            {
                _188 = float4(_117, _116.yz, _79);
                break;
            }
        }
    }
    float4 _195 = View.View_TranslatedWorldToClip * float4(_117, _116.yz, 1.0);
    float4 _204 = _195;
    _204.z = _195.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _195.w) : 0.0);
    out.gl_Position = _204;
    out.out_var_TEXCOORD6 = _195;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_188.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_151.x, _151.y, _151.z, _132.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_149[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _162;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

