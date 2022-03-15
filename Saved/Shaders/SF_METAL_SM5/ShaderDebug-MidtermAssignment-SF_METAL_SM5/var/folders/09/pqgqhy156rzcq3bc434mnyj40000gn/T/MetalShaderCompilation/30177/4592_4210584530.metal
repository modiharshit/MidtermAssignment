

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m4_pad[68];
    float View_PreExposure;
    char _m5_pad[72];
    float View_OutOfBoundsMask;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
    float4 out_var_SV_Target3 [[color(3)]];
    float4 out_var_SV_Target4 [[color(4)]];
    float4 out_var_SV_Target5 [[color(5)]];
};

fragment MainPS_out Main_000011f0_faf86bd2(constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _82 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _87 = (_82.xyz / float3(_82.w)) - View.View_PreViewTranslation;
    float2 _96 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float2 _98 = View.View_ViewSizeAndInvSize.zw * View.View_ViewSizeAndInvSize.xy;
    float4 _103 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_96 / _98));
    float2 _105 = View.View_ViewSizeAndInvSize.zw * 100.0;
    float2 _108 = fast::min(fast::max((_98 - _96) / _105, float2(0.0)), float2(1.0));
    float2 _114 = fast::min(fast::max(_96 / _105, float2(0.0)), float2(1.0));
    float3 _129 = fast::max(mix(mix(_103.xyz, float3(0.0), float3(fast::min(fast::min(_108.x, _108.y), fast::min(_114.x, _114.y)))), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _155;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _154;
        if (any(abs(_87 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _154 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_87, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _154 = _129;
        }
        _155 = _154;
    }
    else
    {
        _155 = _129;
    }
    float4 _159 = float4(_155, 0.0);
    float4 _160 = float4(0.0);
    _160.w = 0.0;
    float3 _164 = _159.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_164.x, _164.y, _164.z, _159.w);
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _160;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

