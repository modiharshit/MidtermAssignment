

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[2016];
    float4 View_TemporalAAJitter;
};

constant float4 _38 = {};

struct MainPixelShader_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPixelShader_in
{
    float4 in_var_TEXCOORD6 [[user(locn0)]];
    float4 in_var_TEXCOORD7 [[user(locn1)]];
    float4 in_var_COLOR1 [[user(locn4)]];
};

fragment MainPixelShader_out Main_00000813_d4eb49f8(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _59 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _59) : (in.in_var_COLOR1.w < _59)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float _87 = (in.in_var_TEXCOORD6.z / in.in_var_TEXCOORD6.w) - (in.in_var_TEXCOORD7.z / in.in_var_TEXCOORD7.w);
    float2 _93 = (float3(((in.in_var_TEXCOORD6.xy / float2(in.in_var_TEXCOORD6.w)) - View.View_TemporalAAJitter.xy) - ((in.in_var_TEXCOORD7.xy / float2(in.in_var_TEXCOORD7.w)) - View.View_TemporalAAJitter.zw), _87).xy * 0.2495000064373016357421875) + float2(0.49999237060546875);
    uint _95 = as_type<uint>(_87);
    float4 _102 = float4(_93.x, _93.y, _38.z, _38.w);
    _102.z = fast::clamp((float((_95 >> 16u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    float4 _109 = _102;
    _109.w = fast::clamp((float((_95 >> 0u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    out.out_var_SV_Target0 = _109;
    return out;
}

