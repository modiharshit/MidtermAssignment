

#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[944];
    float4 View_ViewSizeAndInvSize;
};

struct type_Primitive
{
    char _m0_pad[96];
    float4x4 Primitive_WorldToLocal;
};

constant float4 _46 = {};

struct PSMain_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct PSMain_in
{
    float4 in_var_TEXCOORD9 [[user(locn3)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

fragment PSMain_out Main_00000738_60123d21(PSMain_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]])
{
    PSMain_out out = {};
    float4 _59 = in.in_var_TEXCOORD9 / float4(in.in_var_TEXCOORD9.w);
    float4 _69 = View.View_SVPositionToTranslatedWorld * float4(((_59.xy * float2(0.5, -0.5)) + float2(0.5)) * View.View_ViewSizeAndInvSize.xy, _59.z, 1.0);
    float _86 = fast::clamp(round((Primitive.Primitive_WorldToLocal * float4((_69.xyz / float3(_69.w)) - View.View_PreViewTranslation, 1.0)).z * 128.0) + 32768.0, 0.0, 65535.0);
    float2 _91 = float2(floor(_86 * 0.00390625), mod(_86, 256.0)) * float2(0.0039215688593685626983642578125);
    float4 _93 = float4(_91.x, _91.y, _46.z, _46.w);
    _93.z = 0.0;
    float4 _94 = _93;
    _94.w = 0.0;
    out.out_var_SV_Target0 = _94;
    return out;
}

