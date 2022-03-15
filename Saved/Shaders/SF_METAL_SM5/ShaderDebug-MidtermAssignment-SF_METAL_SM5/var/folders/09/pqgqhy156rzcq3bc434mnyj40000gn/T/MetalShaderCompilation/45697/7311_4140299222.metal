

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

constant float _78 = {};
constant float3x3 _79 = {};
constant float4 _80 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00001c8f_f6c7f3d6(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _94 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _97 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _103 = int(_97 + (_Globals.InputWeightIndexSize * uint(_94)));
    float3x4 _105;
    _105 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _106;
    for (int _108 = 0; _108 < _94; _105 = _106, _108++)
    {
        int _116 = int(_97 + (_Globals.InputWeightIndexSize * uint(_108)));
        int _121 = int(InputWeightStream.read(uint(uint(_116))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _140 = float4(float(InputWeightStream.read(uint(uint(_103 + _108))).x) * 0.0039215688593685626983642578125);
            int _141 = int((InputWeightStream.read(uint(uint(_116 + 1))).x << 8u) | uint(_121)) * 3;
            _106 = float3x4(_105[0] + (_140 * BoneMatrices.read(uint(uint(_141)))), _105[1] + (_140 * BoneMatrices.read(uint(uint(_141 + 1)))), _105[2] + (_140 * BoneMatrices.read(uint(uint(_141 + 2)))));
        }
        else
        {
            float4 _167 = float4(float(InputWeightStream.read(uint(uint(_103 + _108))).x) * 0.0039215688593685626983642578125);
            int _168 = _121 * 3;
            _106 = float3x4(_105[0] + (_167 * BoneMatrices.read(uint(uint(_168)))), _105[1] + (_167 * BoneMatrices.read(uint(uint(_168 + 1)))), _105[2] + (_167 * BoneMatrices.read(uint(uint(_168 + 2)))));
        }
    }
    float3 _190 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _191 = _190.xyz;
    float3 _201 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_191 * dot(in.in_var_ATTRIBUTE1, _191))), 0.0) * _105);
    float3x3 _202 = _79;
    _202[0] = _201;
    float3 _208 = normalize(float4(_190, 0.0) * _105);
    float3x3 _209 = _202;
    _209[2] = _208;
    float3x3 _214 = _209;
    _214[1] = normalize(cross(_208, _201) * in.in_var_ATTRIBUTE2.w);
    float3 _215 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _216 = _215 + in.in_var_ATTRIBUTE11;
    float _217 = _216.x;
    float _218 = _216.y;
    float _219 = _216.z;
    float4 _220 = float4(_217, _218, _219, 1.0);
    float3 _221 = _220 * _105;
    float3 _222 = _221 + in.in_var_ATTRIBUTE12;
    float3 _227 = _222.xxx;
    float3 _228 = Primitive.Primitive_LocalToWorld[0u].xyz * _227;
    float3 _232 = _222.yyy;
    float3 _233 = Primitive.Primitive_LocalToWorld[1u].xyz * _232;
    float3 _234 = _228 + _233;
    float3 _238 = _222.zzz;
    float3 _239 = Primitive.Primitive_LocalToWorld[2u].xyz * _238;
    float3 _240 = _234 + _239;
    float3 _244 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _245 = _240 + _244;
    float _246 = _245.x;
    float _247 = _245.y;
    float _248 = _245.z;
    float4 _249 = float4(_246, _247, _248, 1.0);
    float3x3 _262 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _262[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _265 = _262;
    _265[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _268 = _265;
    _268[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _269 = _268 * _214;
    float3 _270 = _269[2];
    float _271 = _270.x;
    float4 _276 = float4(_249.x, _249.y, _249.z, _249.w);
    float4 _277 = _80;
    _277.w = 0.0;
    float3 _278 = _269[0];
    float4 _289 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _276;
    out.out_var_TEXCOORD10_centroid = float4(_278.x, _278.y, _278.z, _277.w);
    out.out_var_TEXCOORD11_centroid = float4(_271, _270.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _249.xyz;
    out.out_var_TEXCOORD6 = _289;
    out.out_var_TEXCOORD8 = float4(_271, _270.yz, _78).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _289;
    return out;
}

