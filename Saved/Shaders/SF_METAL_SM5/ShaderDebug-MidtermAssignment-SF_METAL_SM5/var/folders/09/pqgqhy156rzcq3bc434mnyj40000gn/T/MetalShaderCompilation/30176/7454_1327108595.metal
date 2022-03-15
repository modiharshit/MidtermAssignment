

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

constant float3x3 _71 = {};
constant float _72 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
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

vertex MainForGS_out Main_00001d1e_4f1a11f3(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> BoneMatrices [[texture(0)]])
{
    MainForGS_out out = {};
    float4 _87 = float4(in.in_var_ATTRIBUTE4.x);
    int _90 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _104 = float4(in.in_var_ATTRIBUTE4.y);
    int _107 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _123 = float4(in.in_var_ATTRIBUTE4.z);
    int _126 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _142 = float4(in.in_var_ATTRIBUTE4.w);
    int _145 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _157 = (((_87 * BoneMatrices.read(uint(uint(_90)))) + (_104 * BoneMatrices.read(uint(uint(_107))))) + (_123 * BoneMatrices.read(uint(uint(_126))))) + (_142 * BoneMatrices.read(uint(uint(_145))));
    float4 _158 = (((_87 * BoneMatrices.read(uint(uint(_90 + 1)))) + (_104 * BoneMatrices.read(uint(uint(_107 + 1))))) + (_123 * BoneMatrices.read(uint(uint(_126 + 1))))) + (_142 * BoneMatrices.read(uint(uint(_145 + 1))));
    float4 _159 = (((_87 * BoneMatrices.read(uint(uint(_90 + 2)))) + (_104 * BoneMatrices.read(uint(uint(_107 + 2))))) + (_123 * BoneMatrices.read(uint(uint(_126 + 2))))) + (_142 * BoneMatrices.read(uint(uint(_145 + 2))));
    float3x4 _243;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _167 = float4(in.in_var_ATTRIBUTE15.x);
        int _170 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _186 = float4(in.in_var_ATTRIBUTE15.y);
        int _189 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _205 = float4(in.in_var_ATTRIBUTE15.z);
        int _208 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _224 = float4(in.in_var_ATTRIBUTE15.w);
        int _227 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _243 = float3x4((((_157 + (_167 * BoneMatrices.read(uint(uint(_170))))) + (_186 * BoneMatrices.read(uint(uint(_189))))) + (_205 * BoneMatrices.read(uint(uint(_208))))) + (_224 * BoneMatrices.read(uint(uint(_227)))), (((_158 + (_167 * BoneMatrices.read(uint(uint(_170 + 1))))) + (_186 * BoneMatrices.read(uint(uint(_189 + 1))))) + (_205 * BoneMatrices.read(uint(uint(_208 + 1))))) + (_224 * BoneMatrices.read(uint(uint(_227 + 1)))), (((_159 + (_167 * BoneMatrices.read(uint(uint(_170 + 2))))) + (_186 * BoneMatrices.read(uint(uint(_189 + 2))))) + (_205 * BoneMatrices.read(uint(uint(_208 + 2))))) + (_224 * BoneMatrices.read(uint(uint(_227 + 2)))));
    }
    else
    {
        _243 = float3x4(_157, _158, _159);
    }
    float3 _249 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _243);
    float3x3 _250 = _71;
    _250[0] = _249;
    float3 _256 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _243);
    float3x3 _257 = _250;
    _257[2] = _256;
    float3x3 _262 = _257;
    _262[1] = normalize(cross(_256, _249) * in.in_var_ATTRIBUTE2.w);
    float3 _263 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _264 = _263.x;
    float _265 = _263.y;
    float _266 = _263.z;
    float4 _267 = float4(_264, _265, _266, 1.0);
    float3 _268 = _267 * _243;
    float3 _269 = _268 + in.in_var_ATTRIBUTE12;
    float3 _274 = _269.xxx;
    float3 _275 = Primitive.Primitive_LocalToWorld[0u].xyz * _274;
    float3 _279 = _269.yyy;
    float3 _280 = Primitive.Primitive_LocalToWorld[1u].xyz * _279;
    float3 _281 = _275 + _280;
    float3 _285 = _269.zzz;
    float3 _286 = Primitive.Primitive_LocalToWorld[2u].xyz * _285;
    float3 _287 = _281 + _286;
    float3 _291 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _292 = _287 + _291;
    float _293 = _292.x;
    float _294 = _292.y;
    float _295 = _292.z;
    float4 _296 = float4(_293, _294, _295, 1.0);
    float3x3 _309 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _309[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _312 = _309;
    _312[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _315 = _312;
    _315[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _323 = float4(_296.x, _296.y, _296.z, _296.w);
    float4 _328 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _323;
    out.out_var_TEXCOORD6 = _323;
    out.out_var_TEXCOORD8 = float4((_315 * _262)[2], _72).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _328;
    return out;
}

