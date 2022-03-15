

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_00002035_b4133495(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Globals& _Globals [[buffer(3)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _93 = float4(in.in_var_ATTRIBUTE4.x);
    int _96 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _110 = float4(in.in_var_ATTRIBUTE4.y);
    int _113 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _129 = float4(in.in_var_ATTRIBUTE4.z);
    int _132 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _148 = float4(in.in_var_ATTRIBUTE4.w);
    int _151 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _163 = (((_93 * BoneMatrices.read(uint(uint(_96)))) + (_110 * BoneMatrices.read(uint(uint(_113))))) + (_129 * BoneMatrices.read(uint(uint(_132))))) + (_148 * BoneMatrices.read(uint(uint(_151))));
    float4 _164 = (((_93 * BoneMatrices.read(uint(uint(_96 + 1)))) + (_110 * BoneMatrices.read(uint(uint(_113 + 1))))) + (_129 * BoneMatrices.read(uint(uint(_132 + 1))))) + (_148 * BoneMatrices.read(uint(uint(_151 + 1))));
    float4 _165 = (((_93 * BoneMatrices.read(uint(uint(_96 + 2)))) + (_110 * BoneMatrices.read(uint(uint(_113 + 2))))) + (_129 * BoneMatrices.read(uint(uint(_132 + 2))))) + (_148 * BoneMatrices.read(uint(uint(_151 + 2))));
    float3x4 _249;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _173 = float4(in.in_var_ATTRIBUTE15.x);
        int _176 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _192 = float4(in.in_var_ATTRIBUTE15.y);
        int _195 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _211 = float4(in.in_var_ATTRIBUTE15.z);
        int _214 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _230 = float4(in.in_var_ATTRIBUTE15.w);
        int _233 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _249 = float3x4((((_163 + (_173 * BoneMatrices.read(uint(uint(_176))))) + (_192 * BoneMatrices.read(uint(uint(_195))))) + (_211 * BoneMatrices.read(uint(uint(_214))))) + (_230 * BoneMatrices.read(uint(uint(_233)))), (((_164 + (_173 * BoneMatrices.read(uint(uint(_176 + 1))))) + (_192 * BoneMatrices.read(uint(uint(_195 + 1))))) + (_211 * BoneMatrices.read(uint(uint(_214 + 1))))) + (_230 * BoneMatrices.read(uint(uint(_233 + 1)))), (((_165 + (_173 * BoneMatrices.read(uint(uint(_176 + 2))))) + (_192 * BoneMatrices.read(uint(uint(_195 + 2))))) + (_211 * BoneMatrices.read(uint(uint(_214 + 2))))) + (_230 * BoneMatrices.read(uint(uint(_233 + 2)))));
    }
    else
    {
        _249 = float3x4(_163, _164, _165);
    }
    float3 _255 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _249);
    float3x3 _256 = _72;
    _256[0] = _255;
    float3 _262 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _249);
    float3x3 _263 = _256;
    _263[2] = _262;
    float3x3 _268 = _263;
    _268[1] = normalize(cross(_262, _255) * in.in_var_ATTRIBUTE2.w);
    float3 _269 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _270 = _269.x;
    float _271 = _269.y;
    float _272 = _269.z;
    float4 _273 = float4(_270, _271, _272, 1.0);
    float3 _274 = _273 * _249;
    float3 _275 = _274 + in.in_var_ATTRIBUTE12;
    float3 _280 = _275.xxx;
    float3 _281 = Primitive.Primitive_LocalToWorld[0u].xyz * _280;
    float3 _285 = _275.yyy;
    float3 _286 = Primitive.Primitive_LocalToWorld[1u].xyz * _285;
    float3 _287 = _281 + _286;
    float3 _291 = _275.zzz;
    float3 _292 = Primitive.Primitive_LocalToWorld[2u].xyz * _291;
    float3 _293 = _287 + _292;
    float3 _297 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _298 = _293 + _297;
    float _299 = _298.x;
    float _300 = _298.y;
    float _301 = _298.z;
    float4 _302 = float4(_299, _300, _301, 1.0);
    spvUnsafeArray<float2, 1> _75;
    _75 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _76 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _304 = 0; _304 < 1; )
    {
        _76[_304] = _75[_304];
        _304++;
        continue;
    }
    float4 _313 = float4(_302.x, _302.y, _302.z, _302.w);
    float4 _314 = View.View_TranslatedWorldToClip * _313;
    float4 _317 = _73;
    _317.w = 0.0;
    float3x3 _330 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _330[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _333 = _330;
    _333[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _336 = _333;
    _336[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _337 = _336 * _268;
    float3 _338 = _337[0];
    spvUnsafeArray<float4, 1> _348 = { float4(_76[0].x, _76[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_338.x, _338.y, _338.z, _317.w);
    out.out_var_TEXCOORD11_centroid = float4(_337[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _348;
    out.out_var_TEXCOORD6 = _313;
    out.gl_Position = _314;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

