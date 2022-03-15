

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

struct type_Globals
{
    uint NumBoneInfluencesParam;
};

constant spvUnsafeArray<float2, 1> _73 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _74 = {};
constant float4 _75 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_0000217d_a2f306eb(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _97 = float4(in.in_var_ATTRIBUTE4.x);
    int _100 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _114 = float4(in.in_var_ATTRIBUTE4.y);
    int _117 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _133 = float4(in.in_var_ATTRIBUTE4.z);
    int _136 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _152 = float4(in.in_var_ATTRIBUTE4.w);
    int _155 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _167 = (((_97 * BoneMatrices.read(uint(uint(_100)))) + (_114 * BoneMatrices.read(uint(uint(_117))))) + (_133 * BoneMatrices.read(uint(uint(_136))))) + (_152 * BoneMatrices.read(uint(uint(_155))));
    float4 _168 = (((_97 * BoneMatrices.read(uint(uint(_100 + 1)))) + (_114 * BoneMatrices.read(uint(uint(_117 + 1))))) + (_133 * BoneMatrices.read(uint(uint(_136 + 1))))) + (_152 * BoneMatrices.read(uint(uint(_155 + 1))));
    float4 _169 = (((_97 * BoneMatrices.read(uint(uint(_100 + 2)))) + (_114 * BoneMatrices.read(uint(uint(_117 + 2))))) + (_133 * BoneMatrices.read(uint(uint(_136 + 2))))) + (_152 * BoneMatrices.read(uint(uint(_155 + 2))));
    float3x4 _253;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _177 = float4(in.in_var_ATTRIBUTE15.x);
        int _180 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _196 = float4(in.in_var_ATTRIBUTE15.y);
        int _199 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _215 = float4(in.in_var_ATTRIBUTE15.z);
        int _218 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _234 = float4(in.in_var_ATTRIBUTE15.w);
        int _237 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _253 = float3x4((((_167 + (_177 * BoneMatrices.read(uint(uint(_180))))) + (_196 * BoneMatrices.read(uint(uint(_199))))) + (_215 * BoneMatrices.read(uint(uint(_218))))) + (_234 * BoneMatrices.read(uint(uint(_237)))), (((_168 + (_177 * BoneMatrices.read(uint(uint(_180 + 1))))) + (_196 * BoneMatrices.read(uint(uint(_199 + 1))))) + (_215 * BoneMatrices.read(uint(uint(_218 + 1))))) + (_234 * BoneMatrices.read(uint(uint(_237 + 1)))), (((_169 + (_177 * BoneMatrices.read(uint(uint(_180 + 2))))) + (_196 * BoneMatrices.read(uint(uint(_199 + 2))))) + (_215 * BoneMatrices.read(uint(uint(_218 + 2))))) + (_234 * BoneMatrices.read(uint(uint(_237 + 2)))));
    }
    else
    {
        _253 = float3x4(_167, _168, _169);
    }
    float3 _256 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _257 = _256.xyz;
    float3 _267 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_257 * dot(in.in_var_ATTRIBUTE1, _257))), 0.0) * _253);
    float3x3 _268 = _74;
    _268[0] = _267;
    float3 _274 = normalize(float4(_256, 0.0) * _253);
    float3x3 _275 = _268;
    _275[2] = _274;
    float3x3 _280 = _275;
    _280[1] = normalize(cross(_274, _267) * in.in_var_ATTRIBUTE2.w);
    float3 _281 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _282 = _281 + in.in_var_ATTRIBUTE11;
    float _283 = _282.x;
    float _284 = _282.y;
    float _285 = _282.z;
    float4 _286 = float4(_283, _284, _285, 1.0);
    float3 _287 = _286 * _253;
    float3 _288 = _287 + in.in_var_ATTRIBUTE12;
    float3 _293 = _288.xxx;
    float3 _294 = Primitive.Primitive_LocalToWorld[0u].xyz * _293;
    float3 _298 = _288.yyy;
    float3 _299 = Primitive.Primitive_LocalToWorld[1u].xyz * _298;
    float3 _300 = _294 + _299;
    float3 _304 = _288.zzz;
    float3 _305 = Primitive.Primitive_LocalToWorld[2u].xyz * _304;
    float3 _306 = _300 + _305;
    float3 _310 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _311 = _306 + _310;
    float _312 = _311.x;
    float _313 = _311.y;
    float _314 = _311.z;
    float4 _315 = float4(_312, _313, _314, 1.0);
    spvUnsafeArray<float2, 1> _77;
    _77 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _78 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _317 = 0; _317 < 1; )
    {
        _78[_317] = _77[_317];
        _317++;
        continue;
    }
    float4 _326 = float4(_315.x, _315.y, _315.z, _315.w);
    float4 _327 = View.View_TranslatedWorldToClip * _326;
    float4 _330 = _75;
    _330.w = 0.0;
    float3x3 _343 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _343[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _346 = _343;
    _346[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _349 = _346;
    _349[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _350 = _349 * _280;
    float3 _351 = _350[0];
    spvUnsafeArray<float4, 1> _361 = { float4(_78[0].x, _78[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_351.x, _351.y, _351.z, _330.w);
    out.out_var_TEXCOORD11_centroid = float4(_350[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _361;
    out.out_var_TEXCOORD6 = _326;
    out.gl_Position = _327;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

