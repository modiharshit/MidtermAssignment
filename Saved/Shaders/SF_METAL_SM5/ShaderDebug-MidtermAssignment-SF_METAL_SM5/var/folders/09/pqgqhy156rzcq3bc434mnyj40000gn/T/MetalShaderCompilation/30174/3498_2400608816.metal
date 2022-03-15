

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
    char _m0_pad[2080];
    float4 View_ViewSizeAndInvSize;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    float2 PostProcessInput_0_UVViewportMin;
    float2 PostProcessInput_0_UVViewportSize;
    char _m2_pad[64];
    uint2 PostProcessOutput_ViewportMin;
    float2 PostProcessOutput_ViewportSizeInverse;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment MainPS_out Main_00000daa_8f166230(constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], texture2d<float> PostProcessInput_0_Texture [[texture(1)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], sampler PostProcessInput_0_Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float2 _64 = (gl_FragCoord.xy - float2(_Globals.PostProcessOutput_ViewportMin)) * _Globals.PostProcessOutput_ViewportSizeInverse;
    float2 _66 = View.View_ViewSizeAndInvSize.zw * View.View_ViewSizeAndInvSize.xy;
    float2 _83 = View.View_ViewSizeAndInvSize.zw * 100.0;
    float2 _86 = fast::min(fast::max((_66 - _64) / _83, float2(0.0)), float2(1.0));
    float2 _92 = fast::min(fast::max(_64 / _83, float2(0.0)), float2(1.0));
    out.out_var_SV_Target0 = float4(fast::max(mix(mix(Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_64 / _66)).xyz, PostProcessInput_0_Texture.sample(PostProcessInput_0_Sampler, ((_64 * _Globals.PostProcessInput_0_UVViewportSize) + _Globals.PostProcessInput_0_UVViewportMin)).xyz, float3(fast::min(fast::min(_86.x, _86.y), fast::min(_92.x, _92.y)))), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), 1.0);
    return out;
}

