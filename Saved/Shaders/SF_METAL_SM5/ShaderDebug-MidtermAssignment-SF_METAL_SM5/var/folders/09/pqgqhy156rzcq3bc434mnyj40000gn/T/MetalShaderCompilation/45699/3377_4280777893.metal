

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
    char _m0_pad[2016];
    float4 View_TemporalAAJitter;
};

struct type_Material
{
    char _m0_pad[96];
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _59 = {};

struct MainPixelShader_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPixelShader_in
{
    float4 in_var_TEXCOORD6 [[user(locn0)]];
    float4 in_var_TEXCOORD7 [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

fragment MainPixelShader_out Main_00000d31_ff277ca5(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]])
{
    MainPixelShader_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    if (((mix(1.0, Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)).w, Material.Material_ScalarExpressions[0].y) * Material.Material_ScalarExpressions[0].z) - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float _100 = (in.in_var_TEXCOORD6.z / in.in_var_TEXCOORD6.w) - (in.in_var_TEXCOORD7.z / in.in_var_TEXCOORD7.w);
    float2 _106 = (float3(((in.in_var_TEXCOORD6.xy / float2(in.in_var_TEXCOORD6.w)) - View.View_TemporalAAJitter.xy) - ((in.in_var_TEXCOORD7.xy / float2(in.in_var_TEXCOORD7.w)) - View.View_TemporalAAJitter.zw), _100).xy * 0.2495000064373016357421875) + float2(0.49999237060546875);
    uint _108 = as_type<uint>(_100);
    float4 _115 = float4(_106.x, _106.y, _59.z, _59.w);
    _115.z = fast::clamp((float((_108 >> 16u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    float4 _122 = _115;
    _122.w = fast::clamp((float((_108 >> 0u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    out.out_var_SV_Target0 = _122;
    return out;
}

