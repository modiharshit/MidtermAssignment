

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment Main_out Main_000004e6_592f598c(constant type_PrimitiveDither& PrimitiveDither [[buffer(0)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _55 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _55) : (PrimitiveDither.PrimitiveDither_LODFactor < _55)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    out.out_var_SV_Target0 = float4(0.0);
    return out;
}

