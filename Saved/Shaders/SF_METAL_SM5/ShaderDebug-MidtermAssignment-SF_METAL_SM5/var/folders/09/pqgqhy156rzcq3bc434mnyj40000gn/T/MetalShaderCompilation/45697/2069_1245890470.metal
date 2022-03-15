

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[2016];
    float4 View_TemporalAAJitter;
};

constant float4 _39 = {};

struct MainPixelShader_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPixelShader_in
{
    float4 in_var_TEXCOORD6 [[user(locn0)]];
    float4 in_var_TEXCOORD7 [[user(locn1)]];
    float4 in_var_COLOR1 [[user(locn5)]];
};

fragment MainPixelShader_out Main_00000815_4a42c7a6(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _60 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _60) : (in.in_var_COLOR1.w < _60)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float _88 = (in.in_var_TEXCOORD6.z / in.in_var_TEXCOORD6.w) - (in.in_var_TEXCOORD7.z / in.in_var_TEXCOORD7.w);
    float2 _94 = (float3(((in.in_var_TEXCOORD6.xy / float2(in.in_var_TEXCOORD6.w)) - View.View_TemporalAAJitter.xy) - ((in.in_var_TEXCOORD7.xy / float2(in.in_var_TEXCOORD7.w)) - View.View_TemporalAAJitter.zw), _88).xy * 0.2495000064373016357421875) + float2(0.49999237060546875);
    uint _96 = as_type<uint>(_88);
    float4 _103 = float4(_94.x, _94.y, _39.z, _39.w);
    _103.z = fast::clamp((float((_96 >> 16u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    float4 _110 = _103;
    _110.w = fast::clamp((float((_96 >> 0u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    out.out_var_SV_Target0 = _110;
    return out;
}

