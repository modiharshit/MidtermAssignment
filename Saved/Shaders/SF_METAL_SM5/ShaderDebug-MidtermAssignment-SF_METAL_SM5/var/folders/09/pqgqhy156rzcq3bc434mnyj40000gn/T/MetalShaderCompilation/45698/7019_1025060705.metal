

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
    uint InputWeightIndexSize;
    uint LayerId;
};

constant float _76 = {};
constant float3x3 _77 = {};
constant float4 _78 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainForGS_out Main_00001b6b_3d192f61(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    MainForGS_out out = {};
    int _90 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _93 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _99 = int(_93 + (_Globals.InputWeightIndexSize * uint(_90)));
    float3x4 _101;
    _101 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _102;
    for (int _104 = 0; _104 < _90; _101 = _102, _104++)
    {
        int _112 = int(_93 + (_Globals.InputWeightIndexSize * uint(_104)));
        int _117 = int(InputWeightStream.read(uint(uint(_112))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _136 = float4(float(InputWeightStream.read(uint(uint(_99 + _104))).x) * 0.0039215688593685626983642578125);
            int _137 = int((InputWeightStream.read(uint(uint(_112 + 1))).x << 8u) | uint(_117)) * 3;
            _102 = float3x4(_101[0] + (_136 * BoneMatrices.read(uint(uint(_137)))), _101[1] + (_136 * BoneMatrices.read(uint(uint(_137 + 1)))), _101[2] + (_136 * BoneMatrices.read(uint(uint(_137 + 2)))));
        }
        else
        {
            float4 _163 = float4(float(InputWeightStream.read(uint(uint(_99 + _104))).x) * 0.0039215688593685626983642578125);
            int _164 = _117 * 3;
            _102 = float3x4(_101[0] + (_163 * BoneMatrices.read(uint(uint(_164)))), _101[1] + (_163 * BoneMatrices.read(uint(uint(_164 + 1)))), _101[2] + (_163 * BoneMatrices.read(uint(uint(_164 + 2)))));
        }
    }
    float3 _189 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _101);
    float3x3 _190 = _77;
    _190[0] = _189;
    float3 _196 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _101);
    float3x3 _197 = _190;
    _197[2] = _196;
    float3x3 _202 = _197;
    _202[1] = normalize(cross(_196, _189) * in.in_var_ATTRIBUTE2.w);
    float3 _203 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _204 = _203.x;
    float _205 = _203.y;
    float _206 = _203.z;
    float4 _207 = float4(_204, _205, _206, 1.0);
    float3 _208 = _207 * _101;
    float3 _209 = _208 + in.in_var_ATTRIBUTE12;
    float3 _214 = _209.xxx;
    float3 _215 = Primitive.Primitive_LocalToWorld[0u].xyz * _214;
    float3 _219 = _209.yyy;
    float3 _220 = Primitive.Primitive_LocalToWorld[1u].xyz * _219;
    float3 _221 = _215 + _220;
    float3 _225 = _209.zzz;
    float3 _226 = Primitive.Primitive_LocalToWorld[2u].xyz * _225;
    float3 _227 = _221 + _226;
    float3 _231 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _232 = _227 + _231;
    float _233 = _232.x;
    float _234 = _232.y;
    float _235 = _232.z;
    float4 _236 = float4(_233, _234, _235, 1.0);
    float3x3 _249 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _249[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _252 = _249;
    _252[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _255 = _252;
    _255[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _256 = _255 * _202;
    float3 _257 = _256[2];
    float _258 = _257.x;
    float4 _263 = float4(_236.x, _236.y, _236.z, _236.w);
    float4 _264 = _78;
    _264.w = 0.0;
    float3 _265 = _256[0];
    float4 _276 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _263;
    out.out_var_TEXCOORD10_centroid = float4(_265.x, _265.y, _265.z, _264.w);
    out.out_var_TEXCOORD11_centroid = float4(_258, _257.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _236.xyz;
    out.out_var_TEXCOORD6 = _276;
    out.out_var_TEXCOORD8 = float4(_258, _257.yz, _76).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _276;
    return out;
}

