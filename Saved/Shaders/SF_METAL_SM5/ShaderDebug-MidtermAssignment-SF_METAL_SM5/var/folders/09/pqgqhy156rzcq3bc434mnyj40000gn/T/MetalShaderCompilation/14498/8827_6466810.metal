

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
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_Globals
{
    uint NumBoneInfluencesParam;
    uint LayerId;
};

constant spvUnsafeArray<float2, 1> _81 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float _82 = {};
constant float3x3 _83 = {};
constant float4 _84 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float3 out_var_TEXCOORD8 [[user(locn5)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
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

vertex MainForGS_out Main_0000227b_0062acfa(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    MainForGS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    float4 _102 = float4(in.in_var_ATTRIBUTE4.x);
    int _105 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _119 = float4(in.in_var_ATTRIBUTE4.y);
    int _122 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _138 = float4(in.in_var_ATTRIBUTE4.z);
    int _141 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _157 = float4(in.in_var_ATTRIBUTE4.w);
    int _160 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _172 = (((_102 * BoneMatrices.read(uint(uint(_105)))) + (_119 * BoneMatrices.read(uint(uint(_122))))) + (_138 * BoneMatrices.read(uint(uint(_141))))) + (_157 * BoneMatrices.read(uint(uint(_160))));
    float4 _173 = (((_102 * BoneMatrices.read(uint(uint(_105 + 1)))) + (_119 * BoneMatrices.read(uint(uint(_122 + 1))))) + (_138 * BoneMatrices.read(uint(uint(_141 + 1))))) + (_157 * BoneMatrices.read(uint(uint(_160 + 1))));
    float4 _174 = (((_102 * BoneMatrices.read(uint(uint(_105 + 2)))) + (_119 * BoneMatrices.read(uint(uint(_122 + 2))))) + (_138 * BoneMatrices.read(uint(uint(_141 + 2))))) + (_157 * BoneMatrices.read(uint(uint(_160 + 2))));
    float3x4 _258;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _182 = float4(in.in_var_ATTRIBUTE15.x);
        int _185 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _201 = float4(in.in_var_ATTRIBUTE15.y);
        int _204 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _220 = float4(in.in_var_ATTRIBUTE15.z);
        int _223 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _239 = float4(in.in_var_ATTRIBUTE15.w);
        int _242 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _258 = float3x4((((_172 + (_182 * BoneMatrices.read(uint(uint(_185))))) + (_201 * BoneMatrices.read(uint(uint(_204))))) + (_220 * BoneMatrices.read(uint(uint(_223))))) + (_239 * BoneMatrices.read(uint(uint(_242)))), (((_173 + (_182 * BoneMatrices.read(uint(uint(_185 + 1))))) + (_201 * BoneMatrices.read(uint(uint(_204 + 1))))) + (_220 * BoneMatrices.read(uint(uint(_223 + 1))))) + (_239 * BoneMatrices.read(uint(uint(_242 + 1)))), (((_174 + (_182 * BoneMatrices.read(uint(uint(_185 + 2))))) + (_201 * BoneMatrices.read(uint(uint(_204 + 2))))) + (_220 * BoneMatrices.read(uint(uint(_223 + 2))))) + (_239 * BoneMatrices.read(uint(uint(_242 + 2)))));
    }
    else
    {
        _258 = float3x4(_172, _173, _174);
    }
    float3 _264 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _258);
    float3x3 _265 = _83;
    _265[0] = _264;
    float3 _271 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _258);
    float3x3 _272 = _265;
    _272[2] = _271;
    float3x3 _277 = _272;
    _277[1] = normalize(cross(_271, _264) * in.in_var_ATTRIBUTE2.w);
    float3 _278 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _279 = _278.x;
    float _280 = _278.y;
    float _281 = _278.z;
    float4 _282 = float4(_279, _280, _281, 1.0);
    float3 _283 = _282 * _258;
    float3 _284 = _283 + in.in_var_ATTRIBUTE12;
    float3 _289 = _284.xxx;
    float3 _290 = Primitive.Primitive_LocalToWorld[0u].xyz * _289;
    float3 _294 = _284.yyy;
    float3 _295 = Primitive.Primitive_LocalToWorld[1u].xyz * _294;
    float3 _296 = _290 + _295;
    float3 _300 = _284.zzz;
    float3 _301 = Primitive.Primitive_LocalToWorld[2u].xyz * _300;
    float3 _302 = _296 + _301;
    float3 _306 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _307 = _302 + _306;
    float _308 = _307.x;
    float _309 = _307.y;
    float _310 = _307.z;
    float4 _311 = float4(_308, _309, _310, 1.0);
    spvUnsafeArray<float2, 1> _86;
    _86 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _87 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _313 = 0; _313 < 1; )
    {
        _87[_313] = _86[_313];
        _313++;
        continue;
    }
    float3x3 _334 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _334[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _337 = _334;
    _337[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _340 = _337;
    _340[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _341 = _340 * _277;
    float3 _342 = _341[2];
    float _343 = _342.x;
    float4 _348 = float4(_311.x, _311.y, _311.z, _311.w);
    float4 _351 = _84;
    _351.w = 0.0;
    float3 _352 = _341[0];
    spvUnsafeArray<float4, 1> _358 = { float4(_87[0].x, _87[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _364 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _348;
    out.out_var_TEXCOORD10_centroid = float4(_352.x, _352.y, _352.z, _351.w);
    out.out_var_TEXCOORD11_centroid = float4(_343, _342.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _358;
    out.out_var_TEXCOORD7 = _311.xyz;
    out.out_var_TEXCOORD6 = _364;
    out.out_var_TEXCOORD8 = float4(_343, _342.yz, _82).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _364;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

