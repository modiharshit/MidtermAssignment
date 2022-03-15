

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[2016];
    float4 View_TemporalAAJitter;
};

constant float4 _41 = {};

struct MainPixelShader_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPixelShader_in
{
    float4 in_var_TEXCOORD6 [[user(locn0)]];
    float4 in_var_TEXCOORD7 [[user(locn1)]];
};

fragment MainPixelShader_out Main_00000629_c31c0a70(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]])
{
    MainPixelShader_out out = {};
    float _64 = (in.in_var_TEXCOORD6.z / in.in_var_TEXCOORD6.w) - (in.in_var_TEXCOORD7.z / in.in_var_TEXCOORD7.w);
    float2 _70 = (float3(((in.in_var_TEXCOORD6.xy / float2(in.in_var_TEXCOORD6.w)) - View.View_TemporalAAJitter.xy) - ((in.in_var_TEXCOORD7.xy / float2(in.in_var_TEXCOORD7.w)) - View.View_TemporalAAJitter.zw), _64).xy * 0.2495000064373016357421875) + float2(0.49999237060546875);
    uint _72 = as_type<uint>(_64);
    float4 _79 = float4(_70.x, _70.y, _41.z, _41.w);
    _79.z = fast::clamp((float((_72 >> 16u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    float4 _86 = _79;
    _86.w = fast::clamp((float((_72 >> 0u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    out.out_var_SV_Target0 = _86;
    return out;
}

