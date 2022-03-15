

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_View
{
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[1440];
    float4 View_NormalOverrideParameter;
    char _m2_pad[68];
    float View_MaterialTextureMipBias;
};

struct type_Material
{
    char _m0_pad[64];
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float in_var_TEXCOORD6 [[user(locn4)]];
};

fragment MainOpacityPS_out Main_000010a6_1cb5d1d7(MainOpacityPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainOpacityPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _95 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float4 _107 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _110 = (_107.xy * float2(2.0)) - float2(1.0);
    float _131 = fast::max(abs(1.0 - fast::max(0.0, dot(normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_110, sqrt(fast::clamp(1.0 - dot(_110, _110), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0, normalize(-(_95.xyz / float3(_95.w)))))), 9.9999997473787516355514526367188e-05);
    float _142 = fast::clamp(mix(Material.Material_ScalarExpressions[0].w, Material.Material_ScalarExpressions[1].x, (((_131 <= 0.0) ? 0.0 : pow(_131, 4.0)) * 0.959999978542327880859375) + 0.039999999105930328369140625), 0.0, 1.0);
    if ((_142 - 0.0039215688593685626983642578125) < 0.0)
    {
        discard_fragment();
    }
    float3 _151 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * (in.in_var_TEXCOORD6 + _Globals.TranslucentShadowStartOffset);
    float _157 = (-2.0) * log(fast::max(1.0 - (_142 * 0.5), 9.9999997473787516355514526367188e-06));
    out.out_var_SV_Target0 = float4(_157, cos(_151) * _157);
    out.out_var_SV_Target1 = float4(0.0, sin(_151) * _157);
    return out;
}

