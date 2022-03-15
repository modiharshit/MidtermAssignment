

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
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    float4 LightFunctionParameters;
    float3 LightFunctionParameters2;
    float3 LightWorldPosition;
};

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment Main_out Main_00000b5e_5dd71d56(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]])
{
    Main_out out = {};
    float _48 = (in.in_var_TEXCOORD0.x * 6.283185482025146484375) - 3.1415927410125732421875;
    float _50 = in.in_var_TEXCOORD0.y * 3.1415927410125732421875;
    float _52 = sin(_50);
    out.out_var_SV_Target0 = float4(mix(_Globals.LightFunctionParameters2.y, mix(_Globals.LightFunctionParameters2.y, dot(fast::max(mix(float3(1.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375)), fast::clamp((_Globals.LightFunctionParameters2.x - length(View.View_WorldCameraOrigin - float4(_Globals.LightWorldPosition + float3(cos(_50), sin(_48) * _52, cos(_48) * _52).zyx, 1.0).xyz)) / (_Globals.LightFunctionParameters2.x * 0.20000000298023223876953125), 0.0, 1.0)), _Globals.LightFunctionParameters.y));
    return out;
}

