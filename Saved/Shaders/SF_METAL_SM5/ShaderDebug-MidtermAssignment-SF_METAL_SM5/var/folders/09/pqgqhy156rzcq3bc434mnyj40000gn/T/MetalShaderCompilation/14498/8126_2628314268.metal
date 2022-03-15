

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

constant spvUnsafeArray<float2, 1> _71 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _72 = {};
constant float4 _73 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
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

vertex Main_out Main_00001fbe_9ca8e49c(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _91 = float4(in.in_var_ATTRIBUTE4.x);
    int _94 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _108 = float4(in.in_var_ATTRIBUTE4.y);
    int _111 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _127 = float4(in.in_var_ATTRIBUTE4.z);
    int _130 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _146 = float4(in.in_var_ATTRIBUTE4.w);
    int _149 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _161 = (((_91 * BoneMatrices.read(uint(uint(_94)))) + (_108 * BoneMatrices.read(uint(uint(_111))))) + (_127 * BoneMatrices.read(uint(uint(_130))))) + (_146 * BoneMatrices.read(uint(uint(_149))));
    float4 _162 = (((_91 * BoneMatrices.read(uint(uint(_94 + 1)))) + (_108 * BoneMatrices.read(uint(uint(_111 + 1))))) + (_127 * BoneMatrices.read(uint(uint(_130 + 1))))) + (_146 * BoneMatrices.read(uint(uint(_149 + 1))));
    float4 _163 = (((_91 * BoneMatrices.read(uint(uint(_94 + 2)))) + (_108 * BoneMatrices.read(uint(uint(_111 + 2))))) + (_127 * BoneMatrices.read(uint(uint(_130 + 2))))) + (_146 * BoneMatrices.read(uint(uint(_149 + 2))));
    float3x4 _247;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _171 = float4(in.in_var_ATTRIBUTE15.x);
        int _174 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _190 = float4(in.in_var_ATTRIBUTE15.y);
        int _193 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _209 = float4(in.in_var_ATTRIBUTE15.z);
        int _212 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _228 = float4(in.in_var_ATTRIBUTE15.w);
        int _231 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _247 = float3x4((((_161 + (_171 * BoneMatrices.read(uint(uint(_174))))) + (_190 * BoneMatrices.read(uint(uint(_193))))) + (_209 * BoneMatrices.read(uint(uint(_212))))) + (_228 * BoneMatrices.read(uint(uint(_231)))), (((_162 + (_171 * BoneMatrices.read(uint(uint(_174 + 1))))) + (_190 * BoneMatrices.read(uint(uint(_193 + 1))))) + (_209 * BoneMatrices.read(uint(uint(_212 + 1))))) + (_228 * BoneMatrices.read(uint(uint(_231 + 1)))), (((_163 + (_171 * BoneMatrices.read(uint(uint(_174 + 2))))) + (_190 * BoneMatrices.read(uint(uint(_193 + 2))))) + (_209 * BoneMatrices.read(uint(uint(_212 + 2))))) + (_228 * BoneMatrices.read(uint(uint(_231 + 2)))));
    }
    else
    {
        _247 = float3x4(_161, _162, _163);
    }
    float3 _253 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _247);
    float3x3 _254 = _72;
    _254[0] = _253;
    float3 _260 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _247);
    float3x3 _261 = _254;
    _261[2] = _260;
    float3x3 _266 = _261;
    _266[1] = normalize(cross(_260, _253) * in.in_var_ATTRIBUTE2.w);
    float3 _267 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _268 = _267.x;
    float _269 = _267.y;
    float _270 = _267.z;
    float4 _271 = float4(_268, _269, _270, 1.0);
    float3 _272 = _271 * _247;
    float3 _273 = _272 + in.in_var_ATTRIBUTE12;
    float3 _278 = _273.xxx;
    float3 _279 = Primitive.Primitive_LocalToWorld[0u].xyz * _278;
    float3 _283 = _273.yyy;
    float3 _284 = Primitive.Primitive_LocalToWorld[1u].xyz * _283;
    float3 _285 = _279 + _284;
    float3 _289 = _273.zzz;
    float3 _290 = Primitive.Primitive_LocalToWorld[2u].xyz * _289;
    float3 _291 = _285 + _290;
    float3 _295 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _296 = _291 + _295;
    float _297 = _296.x;
    float _298 = _296.y;
    float _299 = _296.z;
    float4 _300 = float4(_297, _298, _299, 1.0);
    spvUnsafeArray<float2, 1> _75;
    _75 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _76 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _302 = 0; _302 < 1; )
    {
        _76[_302] = _75[_302];
        _302++;
        continue;
    }
    float4 _311 = float4(_300.x, _300.y, _300.z, _300.w);
    float4 _314 = View.View_TranslatedWorldToClip * _311;
    float4 _317 = _73;
    _317.w = 0.0;
    float3x3 _330 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _330[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _333 = _330;
    _333[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _336 = _333;
    _336[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _337 = _336 * _266;
    float3 _338 = _337[0];
    spvUnsafeArray<float4, 1> _348 = { float4(_76[0].x, _76[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_338.x, _338.y, _338.z, _317.w);
    out.out_var_TEXCOORD11_centroid = float4(_337[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _348;
    out.out_var_TEXCOORD6 = _311;
    out.gl_Position = _314;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

