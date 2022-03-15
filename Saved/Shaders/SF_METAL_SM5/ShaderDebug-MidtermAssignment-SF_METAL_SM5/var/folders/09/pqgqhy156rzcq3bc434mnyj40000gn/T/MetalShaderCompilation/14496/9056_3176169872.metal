

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

constant spvUnsafeArray<float2, 1> _78 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float _79 = {};
constant float3x3 _80 = {};
constant float4 _81 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_00002360_bd508190(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _99 = float4(in.in_var_ATTRIBUTE4.x);
    int _102 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _116 = float4(in.in_var_ATTRIBUTE4.y);
    int _119 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _135 = float4(in.in_var_ATTRIBUTE4.z);
    int _138 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _154 = float4(in.in_var_ATTRIBUTE4.w);
    int _157 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _169 = (((_99 * BoneMatrices.read(uint(uint(_102)))) + (_116 * BoneMatrices.read(uint(uint(_119))))) + (_135 * BoneMatrices.read(uint(uint(_138))))) + (_154 * BoneMatrices.read(uint(uint(_157))));
    float4 _170 = (((_99 * BoneMatrices.read(uint(uint(_102 + 1)))) + (_116 * BoneMatrices.read(uint(uint(_119 + 1))))) + (_135 * BoneMatrices.read(uint(uint(_138 + 1))))) + (_154 * BoneMatrices.read(uint(uint(_157 + 1))));
    float4 _171 = (((_99 * BoneMatrices.read(uint(uint(_102 + 2)))) + (_116 * BoneMatrices.read(uint(uint(_119 + 2))))) + (_135 * BoneMatrices.read(uint(uint(_138 + 2))))) + (_154 * BoneMatrices.read(uint(uint(_157 + 2))));
    float3x4 _255;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _179 = float4(in.in_var_ATTRIBUTE15.x);
        int _182 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _198 = float4(in.in_var_ATTRIBUTE15.y);
        int _201 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _217 = float4(in.in_var_ATTRIBUTE15.z);
        int _220 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _236 = float4(in.in_var_ATTRIBUTE15.w);
        int _239 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _255 = float3x4((((_169 + (_179 * BoneMatrices.read(uint(uint(_182))))) + (_198 * BoneMatrices.read(uint(uint(_201))))) + (_217 * BoneMatrices.read(uint(uint(_220))))) + (_236 * BoneMatrices.read(uint(uint(_239)))), (((_170 + (_179 * BoneMatrices.read(uint(uint(_182 + 1))))) + (_198 * BoneMatrices.read(uint(uint(_201 + 1))))) + (_217 * BoneMatrices.read(uint(uint(_220 + 1))))) + (_236 * BoneMatrices.read(uint(uint(_239 + 1)))), (((_171 + (_179 * BoneMatrices.read(uint(uint(_182 + 2))))) + (_198 * BoneMatrices.read(uint(uint(_201 + 2))))) + (_217 * BoneMatrices.read(uint(uint(_220 + 2))))) + (_236 * BoneMatrices.read(uint(uint(_239 + 2)))));
    }
    else
    {
        _255 = float3x4(_169, _170, _171);
    }
    float3 _261 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _255);
    float3x3 _262 = _80;
    _262[0] = _261;
    float3 _268 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _255);
    float3x3 _269 = _262;
    _269[2] = _268;
    float3x3 _274 = _269;
    _274[1] = normalize(cross(_268, _261) * in.in_var_ATTRIBUTE2.w);
    float3 _281 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _255) + in.in_var_ATTRIBUTE12;
    float4 _308 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _281.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _281.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _281.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    spvUnsafeArray<float2, 1> _83;
    _83 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _84 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _310 = 0; _310 < 1; )
    {
        _84[_310] = _83[_310];
        _310++;
        continue;
    }
    float3x3 _331 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _331[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _334 = _331;
    _334[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _337 = _334;
    _337[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _338 = _337 * _274;
    float3 _339 = _338[2];
    float _340 = _339.x;
    float4 _350 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_308.x, _308.y, _308.z, _308.w);
    float4 _361;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_350.z < 0.0))
    {
        float4 _359 = _350;
        _359.z = 9.9999999747524270787835121154785e-07;
        float4 _360 = _359;
        _360.w = 1.0;
        _361 = _360;
    }
    else
    {
        _361 = _350;
    }
    float _367 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_340, _339.yz, _79).xyz));
    float4 _392 = _361;
    _392.z = ((_361.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_367) > 0.0) ? (sqrt(fast::clamp(1.0 - (_367 * _367), 0.0, 1.0)) / _367) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _361.w;
    float4 _395 = _81;
    _395.w = 0.0;
    float3 _396 = _338[0];
    spvUnsafeArray<float4, 1> _402 = { float4(_84[0].x, _84[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_396.x, _396.y, _396.z, _395.w);
    out.out_var_TEXCOORD11_centroid = float4(_340, _339.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _402;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _308.xyz;
    out.gl_Position = _392;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

