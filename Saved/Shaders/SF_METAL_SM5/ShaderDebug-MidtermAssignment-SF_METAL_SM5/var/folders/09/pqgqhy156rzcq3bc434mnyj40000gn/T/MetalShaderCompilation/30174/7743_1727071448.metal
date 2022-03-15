

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

constant float3x3 _74 = {};
constant float _75 = {};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
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

vertex Main_out Main_00001e3f_66f104d8(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    Main_out out = {};
    float4 _92 = float4(in.in_var_ATTRIBUTE4.x);
    int _95 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _109 = float4(in.in_var_ATTRIBUTE4.y);
    int _112 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _128 = float4(in.in_var_ATTRIBUTE4.z);
    int _131 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _147 = float4(in.in_var_ATTRIBUTE4.w);
    int _150 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _162 = (((_92 * BoneMatrices.read(uint(uint(_95)))) + (_109 * BoneMatrices.read(uint(uint(_112))))) + (_128 * BoneMatrices.read(uint(uint(_131))))) + (_147 * BoneMatrices.read(uint(uint(_150))));
    float4 _163 = (((_92 * BoneMatrices.read(uint(uint(_95 + 1)))) + (_109 * BoneMatrices.read(uint(uint(_112 + 1))))) + (_128 * BoneMatrices.read(uint(uint(_131 + 1))))) + (_147 * BoneMatrices.read(uint(uint(_150 + 1))));
    float4 _164 = (((_92 * BoneMatrices.read(uint(uint(_95 + 2)))) + (_109 * BoneMatrices.read(uint(uint(_112 + 2))))) + (_128 * BoneMatrices.read(uint(uint(_131 + 2))))) + (_147 * BoneMatrices.read(uint(uint(_150 + 2))));
    float3x4 _248;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _172 = float4(in.in_var_ATTRIBUTE15.x);
        int _175 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _191 = float4(in.in_var_ATTRIBUTE15.y);
        int _194 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _210 = float4(in.in_var_ATTRIBUTE15.z);
        int _213 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _229 = float4(in.in_var_ATTRIBUTE15.w);
        int _232 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _248 = float3x4((((_162 + (_172 * BoneMatrices.read(uint(uint(_175))))) + (_191 * BoneMatrices.read(uint(uint(_194))))) + (_210 * BoneMatrices.read(uint(uint(_213))))) + (_229 * BoneMatrices.read(uint(uint(_232)))), (((_163 + (_172 * BoneMatrices.read(uint(uint(_175 + 1))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 1))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 1))))) + (_229 * BoneMatrices.read(uint(uint(_232 + 1)))), (((_164 + (_172 * BoneMatrices.read(uint(uint(_175 + 2))))) + (_191 * BoneMatrices.read(uint(uint(_194 + 2))))) + (_210 * BoneMatrices.read(uint(uint(_213 + 2))))) + (_229 * BoneMatrices.read(uint(uint(_232 + 2)))));
    }
    else
    {
        _248 = float3x4(_162, _163, _164);
    }
    float3 _251 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _252 = _251.xyz;
    float3 _262 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_252 * dot(in.in_var_ATTRIBUTE1, _252))), 0.0) * _248);
    float3x3 _263 = _74;
    _263[0] = _262;
    float3 _269 = normalize(float4(_251, 0.0) * _248);
    float3x3 _270 = _263;
    _270[2] = _269;
    float3x3 _275 = _270;
    _275[1] = normalize(cross(_269, _262) * in.in_var_ATTRIBUTE2.w);
    float3 _276 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _277 = _276 + in.in_var_ATTRIBUTE11;
    float _278 = _277.x;
    float _279 = _277.y;
    float _280 = _277.z;
    float4 _281 = float4(_278, _279, _280, 1.0);
    float3 _282 = _281 * _248;
    float3 _283 = _282 + in.in_var_ATTRIBUTE12;
    float3 _288 = _283.xxx;
    float3 _289 = Primitive.Primitive_LocalToWorld[0u].xyz * _288;
    float3 _293 = _283.yyy;
    float3 _294 = Primitive.Primitive_LocalToWorld[1u].xyz * _293;
    float3 _295 = _289 + _294;
    float3 _299 = _283.zzz;
    float3 _300 = Primitive.Primitive_LocalToWorld[2u].xyz * _299;
    float3 _301 = _295 + _300;
    float3 _305 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _306 = _301 + _305;
    float _307 = _306.x;
    float _308 = _306.y;
    float _309 = _306.z;
    float4 _310 = float4(_307, _308, _309, 1.0);
    float3x3 _323 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _323[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _326 = _323;
    _326[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _329 = _326;
    _329[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _337 = float4(_310.x, _310.y, _310.z, _310.w);
    float4 _342 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _337;
    out.out_var_TEXCOORD6 = _337;
    out.out_var_TEXCOORD8 = float4((_329 * _275)[2], _75).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _342;
    return out;
}

