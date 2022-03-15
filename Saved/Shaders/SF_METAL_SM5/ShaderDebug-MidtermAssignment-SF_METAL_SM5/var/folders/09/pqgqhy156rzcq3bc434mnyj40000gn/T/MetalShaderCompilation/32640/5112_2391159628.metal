

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

constant float _71 = {};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
};

fragment Main_out Main_000013f8_8e86334c(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_DistortionPass& DistortionPass [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture2d<float> DistortionPass_SceneTextures_SceneDepthTexture [[texture(0)]], sampler DistortionPass_SceneTextures_PointClampSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    float3x3 _99 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _110 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _71, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _115 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _125 = (float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz;
    float _134 = fast::max(abs(1.0 - fast::max(0.0, dot(normalize(_99 * normalize(_125)) * 1.0, normalize(-(_115.xyz / float3(_115.w)))))), 9.9999997473787516355514526367188e-05);
    float _146 = _110.w;
    float2 _171 = ((normalize(float3x3(View.View_TranslatedWorldToView[0].xyz, View.View_TranslatedWorldToView[1].xyz, View.View_TranslatedWorldToView[2].xyz) * (_99 * _125)).xy * (mix(1.0, Material.Material_ScalarExpressions[1].y, (_134 <= 0.0) ? 0.0 : pow(_134, Material.Material_ScalarExpressions[1].x)) - 1.0)) * View.View_ViewSizeAndInvSize.xy) * View.View_BufferSizeAndInvSize.zw;
    if ((dot(_171, _171) - 9.9999997473787516355514526367188e-06) < 0.0)
    {
        discard_fragment();
    }
    float2 _184 = _171 * ((DistortionPass.DistortionPass_DistortionParams.zw * float2(0.000230000005103647708892822265625, -0.000230000005103647708892822265625)) * float2(DistortionPass.DistortionPass_DistortionParams.x, DistortionPass.DistortionPass_DistortionParams.y * DistortionPass.DistortionPass_DistortionParams.x));
    float4 _189 = DistortionPass_SceneTextures_SceneDepthTexture.sample(DistortionPass_SceneTextures_PointClampSampler, ((((_110.xy / float2(_146)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz) + _184), level(0.0));
    float _190 = _189.x;
    float2 _216 = (_184 * fast::clamp((((((_190 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_190 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _146) * (1.0 / fast::max(1.0, fast::clamp(abs(Material.Material_ScalarExpressions[1].z * (-0.5)), 0.0, 50.0)))) + (-Material.Material_ScalarExpressions[1].z), 0.0, 1.0)) * 4.0;
    out.out_var_SV_Target0 = float4(fast::max(_216, float2(0.0)), abs(fast::min(_216, float2(0.0))));
    return out;
}

