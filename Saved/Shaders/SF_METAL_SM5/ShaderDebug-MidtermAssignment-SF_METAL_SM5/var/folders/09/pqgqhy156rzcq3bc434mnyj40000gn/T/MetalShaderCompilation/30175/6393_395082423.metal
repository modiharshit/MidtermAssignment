

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

constant float3x3 _72 = {};
constant float _76 = {};

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
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_000018f9_178c7ab7(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<uint> InputWeightStream [[texture(0)]], texture_buffer<float> BoneMatrices [[texture(1)]])
{
    Main_out out = {};
    int _88 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _91 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _97 = int(_91 + (_Globals.InputWeightIndexSize * uint(_88)));
    float3x4 _99;
    _99 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _100;
    for (int _102 = 0; _102 < _88; _99 = _100, _102++)
    {
        int _110 = int(_91 + (_Globals.InputWeightIndexSize * uint(_102)));
        int _115 = int(InputWeightStream.read(uint(uint(_110))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _134 = float4(float(InputWeightStream.read(uint(uint(_97 + _102))).x) * 0.0039215688593685626983642578125);
            int _135 = int((InputWeightStream.read(uint(uint(_110 + 1))).x << 8u) | uint(_115)) * 3;
            _100 = float3x4(_99[0] + (_134 * BoneMatrices.read(uint(uint(_135)))), _99[1] + (_134 * BoneMatrices.read(uint(uint(_135 + 1)))), _99[2] + (_134 * BoneMatrices.read(uint(uint(_135 + 2)))));
        }
        else
        {
            float4 _161 = float4(float(InputWeightStream.read(uint(uint(_97 + _102))).x) * 0.0039215688593685626983642578125);
            int _162 = _115 * 3;
            _100 = float3x4(_99[0] + (_161 * BoneMatrices.read(uint(uint(_162)))), _99[1] + (_161 * BoneMatrices.read(uint(uint(_162 + 1)))), _99[2] + (_161 * BoneMatrices.read(uint(uint(_162 + 2)))));
        }
    }
    float3 _187 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _99);
    float3x3 _188 = _72;
    _188[0] = _187;
    float3 _194 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _99);
    float3x3 _195 = _188;
    _195[2] = _194;
    float3x3 _200 = _195;
    _200[1] = normalize(cross(_194, _187) * in.in_var_ATTRIBUTE2.w);
    float3 _201 = in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11;
    float _202 = _201.x;
    float _203 = _201.y;
    float _204 = _201.z;
    float4 _205 = float4(_202, _203, _204, 1.0);
    float3 _206 = _205 * _99;
    float3 _207 = _206 + in.in_var_ATTRIBUTE12;
    float3 _212 = _207.xxx;
    float3 _213 = Primitive.Primitive_LocalToWorld[0u].xyz * _212;
    float3 _217 = _207.yyy;
    float3 _218 = Primitive.Primitive_LocalToWorld[1u].xyz * _217;
    float3 _219 = _213 + _218;
    float3 _223 = _207.zzz;
    float3 _224 = Primitive.Primitive_LocalToWorld[2u].xyz * _223;
    float3 _225 = _219 + _224;
    float3 _229 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _230 = _225 + _229;
    float _231 = _230.x;
    float _232 = _230.y;
    float _233 = _230.z;
    float4 _234 = float4(_231, _232, _233, 1.0);
    float3x3 _247 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _247[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _250 = _247;
    _250[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _253 = _250;
    _253[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _261 = float4(_234.x, _234.y, _234.z, _234.w);
    float4 _266 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _261;
    out.out_var_TEXCOORD6 = _261;
    out.out_var_TEXCOORD8 = float4((_253 * _200)[2], _76).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _266;
    return out;
}

