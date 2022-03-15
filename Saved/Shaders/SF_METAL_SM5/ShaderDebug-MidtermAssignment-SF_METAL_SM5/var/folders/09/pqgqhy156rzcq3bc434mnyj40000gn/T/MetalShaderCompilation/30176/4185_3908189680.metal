

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
    float4x4 LightFunctionWorldToLight;
    float3 LightFunctionParameters2;
    float2 LightFunctionTexelSize;
    float4x4 ShadowToWorld;
};

constant spvUnsafeArray<float2, 1> _67 = spvUnsafeArray<float2, 1>({ float2(0.0) });

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment Main_out Main_00001059_e8f23df0(constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> Material_Texture2D_0 [[texture(0)]], sampler Material_Texture2D_0Sampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    float4 _86 = _Globals.ShadowToWorld * float4(((gl_FragCoord.xy * _Globals.LightFunctionTexelSize) - float2(0.5)) * float2(2.0, -2.0), 9.9999999747524270787835121154785e-07, 1.0);
    float3 _90 = _86.xyz / float3(_86.w);
    float4 _97 = _Globals.LightFunctionWorldToLight * float4(_90, 1.0);
    float3 _101 = _97.xyz / float3(_97.w);
    float2 _103 = _101.zy;
    float2 _134;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _134 = ((_103 / float2(_101.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _133;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _123 = normalize(_101.zyx);
            _133 = float2((atan2(_123.y, _123.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_123.z) * 0.3183098733425140380859375);
        }
        else
        {
            _133 = _103;
        }
        _134 = _133;
    }
    spvUnsafeArray<float2, 1> _73 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _136 = 0; _136 < 1; )
    {
        _73[_136] = _134;
        _136++;
        continue;
    }
    out.out_var_SV_Target0 = float4(mix(_Globals.LightFunctionParameters2.y, mix(_Globals.LightFunctionParameters2.y, dot(fast::max(mix(float4(Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_73[0] * 4.0)).x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375)), fast::clamp((_Globals.LightFunctionParameters2.x - length(View.View_WorldCameraOrigin - _90.xyz)) / (_Globals.LightFunctionParameters2.x * 0.20000000298023223876953125), 0.0, 1.0)), _Globals.LightFunctionParameters.y));
    return out;
}

