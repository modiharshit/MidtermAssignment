

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

constant float _72 = {};
constant float3x3 _73 = {};
constant float4 _74 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainForGS_out Main_00001f61_b25b8931(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    MainForGS_out out = {};
    float4 _89 = float4(in.in_var_ATTRIBUTE4.x);
    int _92 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _106 = float4(in.in_var_ATTRIBUTE4.y);
    int _109 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _125 = float4(in.in_var_ATTRIBUTE4.z);
    int _128 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _144 = float4(in.in_var_ATTRIBUTE4.w);
    int _147 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _159 = (((_89 * BoneMatrices.read(uint(uint(_92)))) + (_106 * BoneMatrices.read(uint(uint(_109))))) + (_125 * BoneMatrices.read(uint(uint(_128))))) + (_144 * BoneMatrices.read(uint(uint(_147))));
    float4 _160 = (((_89 * BoneMatrices.read(uint(uint(_92 + 1)))) + (_106 * BoneMatrices.read(uint(uint(_109 + 1))))) + (_125 * BoneMatrices.read(uint(uint(_128 + 1))))) + (_144 * BoneMatrices.read(uint(uint(_147 + 1))));
    float4 _161 = (((_89 * BoneMatrices.read(uint(uint(_92 + 2)))) + (_106 * BoneMatrices.read(uint(uint(_109 + 2))))) + (_125 * BoneMatrices.read(uint(uint(_128 + 2))))) + (_144 * BoneMatrices.read(uint(uint(_147 + 2))));
    float3x4 _245;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _169 = float4(in.in_var_ATTRIBUTE15.x);
        int _172 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _188 = float4(in.in_var_ATTRIBUTE15.y);
        int _191 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _207 = float4(in.in_var_ATTRIBUTE15.z);
        int _210 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _226 = float4(in.in_var_ATTRIBUTE15.w);
        int _229 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _245 = float3x4((((_159 + (_169 * BoneMatrices.read(uint(uint(_172))))) + (_188 * BoneMatrices.read(uint(uint(_191))))) + (_207 * BoneMatrices.read(uint(uint(_210))))) + (_226 * BoneMatrices.read(uint(uint(_229)))), (((_160 + (_169 * BoneMatrices.read(uint(uint(_172 + 1))))) + (_188 * BoneMatrices.read(uint(uint(_191 + 1))))) + (_207 * BoneMatrices.read(uint(uint(_210 + 1))))) + (_226 * BoneMatrices.read(uint(uint(_229 + 1)))), (((_161 + (_169 * BoneMatrices.read(uint(uint(_172 + 2))))) + (_188 * BoneMatrices.read(uint(uint(_191 + 2))))) + (_207 * BoneMatrices.read(uint(uint(_210 + 2))))) + (_226 * BoneMatrices.read(uint(uint(_229 + 2)))));
    }
    else
    {
        _245 = float3x4(_159, _160, _161);
    }
    float3 _251 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _245);
    float3x3 _252 = _73;
    _252[0] = _251;
    float3 _258 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _245);
    float3x3 _259 = _252;
    _259[2] = _258;
    float3x3 _264 = _259;
    _264[1] = normalize(cross(_258, _251) * in.in_var_ATTRIBUTE2.w);
    float3 _265 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _266 = _265.x;
    float _267 = _265.y;
    float _268 = _265.z;
    float4 _269 = float4(_266, _267, _268, 1.0);
    float3 _270 = _269 * _245;
    float3 _271 = _270 + in.in_var_ATTRIBUTE12;
    float3 _276 = _271.xxx;
    float3 _277 = Primitive.Primitive_LocalToWorld[0u].xyz * _276;
    float3 _281 = _271.yyy;
    float3 _282 = Primitive.Primitive_LocalToWorld[1u].xyz * _281;
    float3 _283 = _277 + _282;
    float3 _287 = _271.zzz;
    float3 _288 = Primitive.Primitive_LocalToWorld[2u].xyz * _287;
    float3 _289 = _283 + _288;
    float3 _293 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _294 = _289 + _293;
    float _295 = _294.x;
    float _296 = _294.y;
    float _297 = _294.z;
    float4 _298 = float4(_295, _296, _297, 1.0);
    float3x3 _311 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _311[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _314 = _311;
    _314[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _317 = _314;
    _317[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _318 = _317 * _264;
    float3 _319 = _318[2];
    float _320 = _319.x;
    float4 _325 = float4(_298.x, _298.y, _298.z, _298.w);
    float4 _326 = _74;
    _326.w = 0.0;
    float3 _327 = _318[0];
    float4 _338 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _325;
    out.out_var_TEXCOORD10_centroid = float4(_327.x, _327.y, _327.z, _326.w);
    out.out_var_TEXCOORD11_centroid = float4(_320, _319.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _298.xyz;
    out.out_var_TEXCOORD6 = _338;
    out.out_var_TEXCOORD8 = float4(_320, _319.yz, _72).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _338;
    return out;
}

