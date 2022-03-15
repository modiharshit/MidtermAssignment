

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

constant spvUnsafeArray<float2, 1> _60 = spvUnsafeArray<float2, 1>({ float2(0.0) });

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct Main_in
{
    float4 in_var_TEXCOORD0 [[user(locn0), center_no_perspective]];
};

fragment Main_out Main_0000100d_322e35ce(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]])
{
    Main_out out = {};
    float _69 = (in.in_var_TEXCOORD0.x * 6.283185482025146484375) - 3.1415927410125732421875;
    float _71 = in.in_var_TEXCOORD0.y * 3.1415927410125732421875;
    float _73 = sin(_71);
    float _77 = cos(_71);
    float3 _78 = float3(_77, sin(_69) * _73, cos(_69) * _73);
    float3 _81 = _78.zyx;
    float2 _87 = _78.zy;
    float2 _117;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _117 = ((_87 / float2(_77 * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _116;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _106 = normalize(_81);
            _116 = float2((atan2(_106.y, _106.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_106.z) * 0.3183098733425140380859375);
        }
        else
        {
            _116 = _87;
        }
        _117 = _116;
    }
    spvUnsafeArray<float2, 1> _65 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _119 = 0; _119 < 1; )
    {
        _65[_119] = _117;
        _119++;
        continue;
    }
    out.out_var_SV_Target0 = float4(mix(_Globals.LightFunctionParameters2.y, mix(_Globals.LightFunctionParameters2.y, dot(fast::max(mix(float4(Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_65[0] * 4.0)).x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375)), fast::clamp((_Globals.LightFunctionParameters2.x - length(View.View_WorldCameraOrigin - float4(_Globals.LightWorldPosition + _81, 1.0).xyz)) / (_Globals.LightFunctionParameters2.x * 0.20000000298023223876953125), 0.0, 1.0)), _Globals.LightFunctionParameters.y));
    return out;
}

