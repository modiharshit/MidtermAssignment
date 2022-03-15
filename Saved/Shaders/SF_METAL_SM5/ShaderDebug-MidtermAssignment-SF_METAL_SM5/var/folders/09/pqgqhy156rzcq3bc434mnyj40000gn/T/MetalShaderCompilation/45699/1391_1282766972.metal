

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Globals
{
    float4 HitProxyId;
};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment Main_out Main_0000056f_4c75787c(constant type_PrimitiveDither& PrimitiveDither [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _58 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _58) : (PrimitiveDither.PrimitiveDither_LODFactor < _58)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    out.out_var_SV_Target0 = _Globals.HitProxyId;
    return out;
}

