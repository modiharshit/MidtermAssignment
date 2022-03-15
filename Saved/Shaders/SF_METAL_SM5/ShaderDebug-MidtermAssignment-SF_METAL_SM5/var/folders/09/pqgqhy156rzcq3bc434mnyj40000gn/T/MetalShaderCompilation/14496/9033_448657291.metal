

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

struct type_Globals
{
    uint NumBoneInfluencesParam;
};

constant spvUnsafeArray<float2, 1> _79 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float _80 = {};
constant float3x3 _81 = {};
constant float4 _82 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float out_var_TEXCOORD8 [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00002349_1abdf78b(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _100 = float4(in.in_var_ATTRIBUTE4.x);
    int _103 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _117 = float4(in.in_var_ATTRIBUTE4.y);
    int _120 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _136 = float4(in.in_var_ATTRIBUTE4.z);
    int _139 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _155 = float4(in.in_var_ATTRIBUTE4.w);
    int _158 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _170 = (((_100 * BoneMatrices.read(uint(uint(_103)))) + (_117 * BoneMatrices.read(uint(uint(_120))))) + (_136 * BoneMatrices.read(uint(uint(_139))))) + (_155 * BoneMatrices.read(uint(uint(_158))));
    float4 _171 = (((_100 * BoneMatrices.read(uint(uint(_103 + 1)))) + (_117 * BoneMatrices.read(uint(uint(_120 + 1))))) + (_136 * BoneMatrices.read(uint(uint(_139 + 1))))) + (_155 * BoneMatrices.read(uint(uint(_158 + 1))));
    float4 _172 = (((_100 * BoneMatrices.read(uint(uint(_103 + 2)))) + (_117 * BoneMatrices.read(uint(uint(_120 + 2))))) + (_136 * BoneMatrices.read(uint(uint(_139 + 2))))) + (_155 * BoneMatrices.read(uint(uint(_158 + 2))));
    float3x4 _256;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _180 = float4(in.in_var_ATTRIBUTE15.x);
        int _183 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _199 = float4(in.in_var_ATTRIBUTE15.y);
        int _202 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _218 = float4(in.in_var_ATTRIBUTE15.z);
        int _221 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _237 = float4(in.in_var_ATTRIBUTE15.w);
        int _240 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _256 = float3x4((((_170 + (_180 * BoneMatrices.read(uint(uint(_183))))) + (_199 * BoneMatrices.read(uint(uint(_202))))) + (_218 * BoneMatrices.read(uint(uint(_221))))) + (_237 * BoneMatrices.read(uint(uint(_240)))), (((_171 + (_180 * BoneMatrices.read(uint(uint(_183 + 1))))) + (_199 * BoneMatrices.read(uint(uint(_202 + 1))))) + (_218 * BoneMatrices.read(uint(uint(_221 + 1))))) + (_237 * BoneMatrices.read(uint(uint(_240 + 1)))), (((_172 + (_180 * BoneMatrices.read(uint(uint(_183 + 2))))) + (_199 * BoneMatrices.read(uint(uint(_202 + 2))))) + (_218 * BoneMatrices.read(uint(uint(_221 + 2))))) + (_237 * BoneMatrices.read(uint(uint(_240 + 2)))));
    }
    else
    {
        _256 = float3x4(_170, _171, _172);
    }
    float3 _262 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _256);
    float3x3 _263 = _81;
    _263[0] = _262;
    float3 _269 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _256);
    float3x3 _270 = _263;
    _270[2] = _269;
    float3x3 _275 = _270;
    _275[1] = normalize(cross(_269, _262) * in.in_var_ATTRIBUTE2.w);
    float3 _282 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _256) + in.in_var_ATTRIBUTE12;
    float4 _309 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _282.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _282.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _282.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    spvUnsafeArray<float2, 1> _84;
    _84 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _85 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _311 = 0; _311 < 1; )
    {
        _85[_311] = _84[_311];
        _311++;
        continue;
    }
    float3x3 _332 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _332[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _335 = _332;
    _335[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _338 = _335;
    _338[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _339 = _338 * _275;
    float3 _340 = _339[2];
    float _341 = _340.x;
    float4 _351 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_309.x, _309.y, _309.z, _309.w);
    float4 _362;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_351.z < 0.0))
    {
        float4 _360 = _351;
        _360.z = 9.9999999747524270787835121154785e-07;
        float4 _361 = _360;
        _361.w = 1.0;
        _362 = _361;
    }
    else
    {
        _362 = _351;
    }
    float _368 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_341, _340.yz, _80).xyz));
    float4 _389 = _82;
    _389.w = 0.0;
    float3 _390 = _339[0];
    spvUnsafeArray<float4, 1> _396 = { float4(_85[0].x, _85[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_390.x, _390.y, _390.z, _389.w);
    out.out_var_TEXCOORD11_centroid = float4(_341, _340.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _396;
    out.out_var_TEXCOORD6 = _362.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_368) > 0.0) ? (sqrt(fast::clamp(1.0 - (_368 * _368), 0.0, 1.0)) / _368) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _309.xyz;
    out.gl_Position = _362;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

