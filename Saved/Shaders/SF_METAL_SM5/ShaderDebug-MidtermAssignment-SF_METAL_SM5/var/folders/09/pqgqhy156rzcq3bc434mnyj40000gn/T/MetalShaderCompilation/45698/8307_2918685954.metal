

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

constant float _74 = {};
constant float3x3 _75 = {};
constant float4 _76 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00002073_adf79d02(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
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
    float3 _252 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _253 = _252.xyz;
    float3 _263 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_253 * dot(in.in_var_ATTRIBUTE1, _253))), 0.0) * _249);
    float3x3 _264 = _75;
    _264[0] = _263;
    float3 _270 = normalize(float4(_252, 0.0) * _249);
    float3x3 _271 = _264;
    _271[2] = _270;
    float3x3 _276 = _271;
    _276[1] = normalize(cross(_270, _263) * in.in_var_ATTRIBUTE2.w);
    float3 _277 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _278 = _277 + in.in_var_ATTRIBUTE11;
    float _279 = _278.x;
    float _280 = _278.y;
    float _281 = _278.z;
    float4 _282 = float4(_279, _280, _281, 1.0);
    float3 _283 = _282 * _249;
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
    float3x3 _324 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _324[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _327 = _324;
    _327[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _330 = _327;
    _330[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _331 = _330 * _276;
    float3 _332 = _331[2];
    float _333 = _332.x;
    float4 _338 = float4(_311.x, _311.y, _311.z, _311.w);
    float4 _339 = _76;
    _339.w = 0.0;
    float3 _340 = _331[0];
    float4 _351 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _338;
    out.out_var_TEXCOORD10_centroid = float4(_340.x, _340.y, _340.z, _339.w);
    out.out_var_TEXCOORD11_centroid = float4(_333, _332.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _311.xyz;
    out.out_var_TEXCOORD6 = _351;
    out.out_var_TEXCOORD8 = float4(_333, _332.yz, _74).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _351;
    return out;
}

