

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_Globals
{
    float TranslucentShadowStartOffset;
};

struct MainOpacityPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
};

struct MainOpacityPS_in
{
    float4 in_var_TEXCOORD2 [[user(locn2)]];
    float4 in_var_TEXCOORD3 [[user(locn3)]];
    float in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainOpacityPS_out Main_0000066c_730aabb1(MainOpacityPS_in in [[stage_in]], constant type_Globals& _Globals [[buffer(0)]])
{
    MainOpacityPS_out out = {};
    float2 _46 = in.in_var_TEXCOORD2.xy - float2(0.5);
    float _52 = fast::min(fast::max(1.0 - (sqrt(dot(_46, _46)) * 2.0), 0.0), 1.0);
    float _58 = fast::clamp(in.in_var_TEXCOORD3.w * ((_52 <= 0.0) ? 0.0 : pow(_52, 4.0)), 0.0, 1.0);
    if ((_58 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _67 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _73 = (-2.0) * log(fast::max(1.0 - (_58 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_73, cos(_67) * _73);
    out.out_var_SV_Target1 = float4(0.0, sin(_67) * _73);
    return out;
}

