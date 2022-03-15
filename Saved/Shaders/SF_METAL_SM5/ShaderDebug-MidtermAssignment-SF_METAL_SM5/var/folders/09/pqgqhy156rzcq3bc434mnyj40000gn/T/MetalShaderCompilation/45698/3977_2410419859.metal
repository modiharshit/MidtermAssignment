

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
    char _m2_pad[1028];
    float View_PreExposure;
    char _m3_pad[72];
    float View_OutOfBoundsMask;
    char _m4_pad[1076];
    float View_bCheckerboardSubsurfaceProfileRendering;
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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

fragment MainPS_out Main_00000f89_8fac1693(constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _73 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _78 = (_73.xyz / float3(_73.w)) - View.View_PreViewTranslation;
    float3 _89 = fast::max(mix(Material.Material_VectorExpressions[2].xyz, Material.Material_VectorExpressions[3].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _115;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _114;
        if (any(abs(_78 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _114 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_78, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _114 = _89;
        }
        _115 = _114;
    }
    else
    {
        _115 = _89;
    }
    float4 _120 = float4(_115 * 1.0, 0.0);
    float4 _127;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _126 = _120;
        _126.w = 0.0;
        _127 = _126;
    }
    else
    {
        _127 = _120;
    }
    float4 _128 = float4(0.0);
    _128.w = 0.0;
    out.out_var_SV_Target0 = _127 * View.View_PreExposure;
    out.out_var_SV_Target1 = float4(0.0);
    out.out_var_SV_Target2 = _128;
    out.out_var_SV_Target3 = float4(0.0);
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

