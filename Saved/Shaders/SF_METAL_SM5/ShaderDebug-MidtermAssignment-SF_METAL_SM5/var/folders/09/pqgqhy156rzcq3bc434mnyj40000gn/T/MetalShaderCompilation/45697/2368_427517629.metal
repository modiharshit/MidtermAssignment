

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[2016];
    float4 View_TemporalAAJitter;
};

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

constant float4 _52 = {};

struct MainPixelShader_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPixelShader_in
{
    float4 in_var_TEXCOORD6 [[user(locn0)]];
    float4 in_var_TEXCOORD7 [[user(locn1)]];
};

fragment MainPixelShader_out Main_00000940_197b66bd(MainPixelShader_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(1)]], float4 gl_FragCoord [[position]])
{
    MainPixelShader_out out = {};
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _73 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _73) : (PrimitiveDither.PrimitiveDither_LODFactor < _73)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float _101 = (in.in_var_TEXCOORD6.z / in.in_var_TEXCOORD6.w) - (in.in_var_TEXCOORD7.z / in.in_var_TEXCOORD7.w);
    float2 _107 = (float3(((in.in_var_TEXCOORD6.xy / float2(in.in_var_TEXCOORD6.w)) - View.View_TemporalAAJitter.xy) - ((in.in_var_TEXCOORD7.xy / float2(in.in_var_TEXCOORD7.w)) - View.View_TemporalAAJitter.zw), _101).xy * 0.2495000064373016357421875) + float2(0.49999237060546875);
    uint _109 = as_type<uint>(_101);
    float4 _116 = float4(_107.x, _107.y, _52.z, _52.w);
    _116.z = fast::clamp((float((_109 >> 16u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    float4 _123 = _116;
    _123.w = fast::clamp((float((_109 >> 0u) & 65535u) * 1.525902189314365386962890625e-05) + 1.525902234789100475609302520752e-06, 0.0, 1.0);
    out.out_var_SV_Target0 = _123;
    return out;
}

