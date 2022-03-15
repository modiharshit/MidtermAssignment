

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[1440];
    float4 View_NormalOverrideParameter;
};

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
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float in_var_TEXCOORD6 [[user(locn3)]];
};

fragment MainOpacityPS_out Main_00000945_4d9c354d(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Globals& _Globals [[buffer(1)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    float4 _72 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float _91 = fast::max(abs(1.0 - fast::max(0.0, dot(normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0, normalize(-(_72.xyz / float3(_72.w)))))), 9.9999997473787516355514526367188e-05);
    float _98 = fast::clamp(mix(0.25, 1.0, (((_91 <= 0.0) ? 0.0 : pow(_91, 2.0)) * 0.800000011920928955078125) + 0.20000000298023223876953125), 0.0, 1.0);
    if ((_98 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _107 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _113 = (-2.0) * log(fast::max(1.0 - (_98 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_113, cos(_107) * _113);
    out.out_var_SV_Target1 = float4(0.0, sin(_107) * _113);
    return out;
}

