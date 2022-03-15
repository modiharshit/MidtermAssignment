

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
};

struct type_Globals
{
    float4 StencilingGeometryPosAndScale;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000047d_3e0fdda5(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]])
{
    Main_out out = {};
    float3 _31 = in.in_var_ATTRIBUTE0.xyz * _Globals.StencilingGeometryPosAndScale.w;
    float3 _34 = _31 + _Globals.StencilingGeometryPosAndScale.xyz;
    float _35 = _34.x;
    float _36 = _34.y;
    float _37 = _34.z;
    float4 _38 = float4(_35, _36, _37, 1.0);
    float4 _41 = View.View_TranslatedWorldToClip * _38;
    out.gl_Position = _41;
    return out;
}

