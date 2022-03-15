

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

struct type_TranslucentDepthPass
{
    char _m0_pad[112];
    float4x4 TranslucentDepthPass_ProjectionMatrix;
    float TranslucentDepthPass_bClampToNearPlane;
};

struct type_Globals
{
    uint NumBoneInfluencesParam;
};

constant spvUnsafeArray<float2, 1> _77 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _78 = {};
constant float4 _79 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
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

vertex MainVS_out Main_000020da_2bcd1bec(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    MainVS_out out = {};
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
    float3 _259 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _253);
    float3x3 _260 = _78;
    _260[0] = _259;
    float3 _266 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _253);
    float3x3 _267 = _260;
    _267[2] = _266;
    float3x3 _272 = _267;
    _272[1] = normalize(cross(_266, _259) * in.in_var_ATTRIBUTE2.w);
    float3 _279 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _253) + in.in_var_ATTRIBUTE12;
    float4 _306 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _279.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _279.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _279.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    spvUnsafeArray<float2, 1> _81;
    _81 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _82 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _308 = 0; _308 < 1; )
    {
        _82[_308] = _81[_308];
        _308++;
        continue;
    }
    float4 _317 = float4(_306.x, _306.y, _306.z, _306.w);
    float4 _320 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _317;
    float4 _331;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_320.z < 0.0))
    {
        float4 _329 = _320;
        _329.z = 9.9999999747524270787835121154785e-07;
        float4 _330 = _329;
        _330.w = 1.0;
        _331 = _330;
    }
    else
    {
        _331 = _320;
    }
    float4 _335 = _79;
    _335.w = 0.0;
    float3x3 _348 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _348[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _351 = _348;
    _351[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _354 = _351;
    _354[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _355 = _354 * _272;
    float3 _356 = _355[0];
    spvUnsafeArray<float4, 1> _366 = { float4(_82[0].x, _82[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_356.x, _356.y, _356.z, _335.w);
    out.out_var_TEXCOORD11_centroid = float4(_355[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _366;
    out.out_var_TEXCOORD6 = _331.z;
    out.out_var_TEXCOORD7 = _317;
    out.gl_Position = _331;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

