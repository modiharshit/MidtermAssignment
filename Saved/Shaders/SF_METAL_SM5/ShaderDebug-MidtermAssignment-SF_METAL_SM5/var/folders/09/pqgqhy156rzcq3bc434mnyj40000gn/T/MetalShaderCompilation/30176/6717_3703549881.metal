

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

constant float3x3 _75 = {};
constant float _79 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE9 [[attribute(9)]];
    float3 in_var_ATTRIBUTE10 [[attribute(10)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00001a3d_dcbfafb9(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _93 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _96 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _102 = int(_96 + (_Globals.InputWeightIndexSize * uint(_93)));
    float3x4 _104;
    _104 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _105;
    for (int _107 = 0; _107 < _93; _104 = _105, _107++)
    {
        int _115 = int(_96 + (_Globals.InputWeightIndexSize * uint(_107)));
        int _120 = int(InputWeightStream.read(uint(uint(_115))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _139 = float4(float(InputWeightStream.read(uint(uint(_102 + _107))).x) * 0.0039215688593685626983642578125);
            int _140 = int((InputWeightStream.read(uint(uint(_115 + 1))).x << 8u) | uint(_120)) * 3;
            _105 = float3x4(_104[0] + (_139 * BoneMatrices.read(uint(uint(_140)))), _104[1] + (_139 * BoneMatrices.read(uint(uint(_140 + 1)))), _104[2] + (_139 * BoneMatrices.read(uint(uint(_140 + 2)))));
        }
        else
        {
            float4 _166 = float4(float(InputWeightStream.read(uint(uint(_102 + _107))).x) * 0.0039215688593685626983642578125);
            int _167 = _120 * 3;
            _105 = float3x4(_104[0] + (_166 * BoneMatrices.read(uint(uint(_167)))), _104[1] + (_166 * BoneMatrices.read(uint(uint(_167 + 1)))), _104[2] + (_166 * BoneMatrices.read(uint(uint(_167 + 2)))));
        }
    }
    float3 _189 = normalize(in.in_var_ATTRIBUTE2.xyz + in.in_var_ATTRIBUTE10);
    float3 _190 = _189.xyz;
    float3 _200 = normalize(float4(normalize(in.in_var_ATTRIBUTE1 - (_190 * dot(in.in_var_ATTRIBUTE1, _190))), 0.0) * _104);
    float3x3 _201 = _75;
    _201[0] = _200;
    float3 _207 = normalize(float4(_189, 0.0) * _104);
    float3x3 _208 = _201;
    _208[2] = _207;
    float3x3 _213 = _208;
    _213[1] = normalize(cross(_207, _200) * in.in_var_ATTRIBUTE2.w);
    float3 _214 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE9;
    float3 _215 = _214 + in.in_var_ATTRIBUTE11;
    float _216 = _215.x;
    float _217 = _215.y;
    float _218 = _215.z;
    float4 _219 = float4(_216, _217, _218, 1.0);
    float3 _220 = _219 * _104;
    float3 _221 = _220 + in.in_var_ATTRIBUTE12;
    float3 _226 = _221.xxx;
    float3 _227 = Primitive.Primitive_LocalToWorld[0u].xyz * _226;
    float3 _231 = _221.yyy;
    float3 _232 = Primitive.Primitive_LocalToWorld[1u].xyz * _231;
    float3 _233 = _227 + _232;
    float3 _237 = _221.zzz;
    float3 _238 = Primitive.Primitive_LocalToWorld[2u].xyz * _237;
    float3 _239 = _233 + _238;
    float3 _243 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _244 = _239 + _243;
    float _245 = _244.x;
    float _246 = _244.y;
    float _247 = _244.z;
    float4 _248 = float4(_245, _246, _247, 1.0);
    float3x3 _261 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _261[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _264 = _261;
    _264[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _267 = _264;
    _267[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _275 = float4(_248.x, _248.y, _248.z, _248.w);
    float4 _280 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _275;
    out.out_var_TEXCOORD6 = _275;
    out.out_var_TEXCOORD8 = float4((_267 * _213)[2], _79).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _280;
    return out;
}

