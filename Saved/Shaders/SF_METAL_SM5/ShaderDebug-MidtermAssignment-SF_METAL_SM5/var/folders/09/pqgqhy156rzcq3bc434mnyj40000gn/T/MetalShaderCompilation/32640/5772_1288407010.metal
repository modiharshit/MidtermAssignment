

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
    char _m1_pad[448];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[992];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m6_pad[16];
    float4 View_BufferSizeAndInvSize;
    char _m7_pad[80];
    float4 View_NormalOverrideParameter;
    char _m8_pad[68];
    float View_MaterialTextureMipBias;
};

struct type_DistortionPass
{
    char _m0_pad[112];
    float4 DistortionPass_DistortionParams;
};

struct type_Material
{
    char _m0_pad[64];
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float _78 = {};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

fragment Main_out Main_0000168c_4ccb87e2(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DistortionPass& DistortionPass [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture2d<float> DistortionPass_SceneTextures_SceneDepthTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler DistortionPass_SceneTextures_PointClampSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float3x3 _110 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _121 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _78, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _126 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float4 _138 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _141 = (_138.xy * float2(2.0)) - float2(1.0);
    float3 _153 = (float4(_141, sqrt(fast::clamp(1.0 - dot(_141, _141), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz;
    float _162 = fast::max(abs(1.0 - fast::max(0.0, dot(normalize(_110 * normalize(_153)) * 1.0, normalize(-(_126.xyz / float3(_126.w)))))), 9.9999997473787516355514526367188e-05);
    float _174 = _121.w;
    float2 _199 = ((normalize(float3x3(View.View_TranslatedWorldToView[0].xyz, View.View_TranslatedWorldToView[1].xyz, View.View_TranslatedWorldToView[2].xyz) * (_110 * _153)).xy * (mix(1.0, Material.Material_ScalarExpressions[1].z, (_162 <= 0.0) ? 0.0 : pow(_162, Material.Material_ScalarExpressions[1].y)) - 1.0)) * View.View_ViewSizeAndInvSize.xy) * View.View_BufferSizeAndInvSize.zw;
    if ((dot(_199, _199) - 9.9999997473787516355514526367188e-06) < 0.0)
    {
        discard_fragment();
    }
    float2 _212 = _199 * ((DistortionPass.DistortionPass_DistortionParams.zw * float2(0.000230000005103647708892822265625, -0.000230000005103647708892822265625)) * float2(DistortionPass.DistortionPass_DistortionParams.x, DistortionPass.DistortionPass_DistortionParams.y * DistortionPass.DistortionPass_DistortionParams.x));
    float4 _217 = DistortionPass_SceneTextures_SceneDepthTexture.sample(DistortionPass_SceneTextures_PointClampSampler, ((((_121.xy / float2(_174)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz) + _212), level(0.0));
    float _218 = _217.x;
    float2 _244 = (_212 * fast::clamp((((((_218 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_218 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _174) * (1.0 / fast::max(1.0, fast::clamp(abs(Material.Material_ScalarExpressions[1].w * (-0.5)), 0.0, 50.0)))) + (-Material.Material_ScalarExpressions[1].w), 0.0, 1.0)) * 4.0;
    out.out_var_SV_Target0 = float4(fast::max(_244, float2(0.0)), abs(fast::min(_244, float2(0.0))));
    return out;
}

