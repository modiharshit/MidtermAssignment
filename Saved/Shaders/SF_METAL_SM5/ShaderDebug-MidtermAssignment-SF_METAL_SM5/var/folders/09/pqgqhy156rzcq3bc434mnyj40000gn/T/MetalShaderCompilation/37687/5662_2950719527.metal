

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
    char _m0_pad[192];
    float4x4 View_TranslatedWorldToView;
    char _m1_pad[784];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m3_pad[992];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[16];
    float4 View_BufferSizeAndInvSize;
    char _m6_pad[80];
    float4 View_NormalOverrideParameter;
    char _m7_pad[56];
    float View_GameTime;
    char _m8_pad[8];
    float View_MaterialTextureMipBias;
};

struct type_DistortionPass
{
    char _m0_pad[112];
    float4 DistortionPass_DistortionParams;
};

struct type_Material
{
    char _m0_pad[32];
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _77 = {};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD1 [[user(locn2), flat]];
    float4 in_var_TEXCOORD3_0 [[user(locn3)]];
};

fragment Main_out Main_0000161e_afe06827(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DistortionPass& DistortionPass [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture2d<float> DistortionPass_SceneTextures_SceneDepthTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler DistortionPass_SceneTextures_PointClampSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _119 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _77, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _130 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(0.0, View.View_GameTime * 0.5) + float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _133 = (_130.xy * float2(2.0)) - float2(1.0);
    float2 _141 = float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) - float2(0.5);
    float _147 = fast::min(fast::max(1.0 - (sqrt(dot(_141, _141)) * 2.0), 0.0), 1.0);
    float _165 = _119.w;
    float2 _190 = ((normalize(float3x3(View.View_TranslatedWorldToView[0].xyz, View.View_TranslatedWorldToView[1].xyz, View.View_TranslatedWorldToView[2].xyz) * (float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * ((mix(float3(0.0, 0.0, 1.0), float4(_133, sqrt(fast::clamp(1.0 - dot(_133, _133), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_147 <= 0.0) ? 0.0 : pow(_147, 2.0), 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz))).xy * (mix(1.0, 1.5, in.in_var_TEXCOORD1.x) - 1.0)) * View.View_ViewSizeAndInvSize.xy) * View.View_BufferSizeAndInvSize.zw;
    if ((dot(_190, _190) - 9.9999997473787516355514526367188e-06) < 0.0)
    {
        discard_fragment();
    }
    float2 _203 = _190 * ((DistortionPass.DistortionPass_DistortionParams.zw * float2(0.000230000005103647708892822265625, -0.000230000005103647708892822265625)) * float2(DistortionPass.DistortionPass_DistortionParams.x, DistortionPass.DistortionPass_DistortionParams.y * DistortionPass.DistortionPass_DistortionParams.x));
    float4 _208 = DistortionPass_SceneTextures_SceneDepthTexture.sample(DistortionPass_SceneTextures_PointClampSampler, ((((_119.xy / float2(_165)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz) + _203), level(0.0));
    float _209 = _208.x;
    float2 _235 = (_203 * fast::clamp((((((_209 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_209 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _165) * (1.0 / fast::max(1.0, fast::clamp(abs(Material.Material_ScalarExpressions[0].y * (-0.5)), 0.0, 50.0)))) + (-Material.Material_ScalarExpressions[0].y), 0.0, 1.0)) * 4.0;
    out.out_var_SV_Target0 = float4(fast::max(_235, float2(0.0)), abs(fast::min(_235, float2(0.0))));
    return out;
}

