

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
    char _m1_pad[304];
    float3 View_WorldCameraOrigin;
    char _m2_pad[32];
    float3 View_PreViewTranslation;
    char _m3_pad[976];
    float4 View_BufferSizeAndInvSize;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    float4 LightFunctionParameters;
    float4x4 SvPositionToLight;
    float3 LightFunctionParameters2;
};

constant spvUnsafeArray<float2, 1> _62 = spvUnsafeArray<float2, 1>({ float2(0.0) });

struct Main_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

fragment Main_out Main_000011f1_75df0b75(constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> SceneTexturesStruct_SceneDepthTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler SceneTexturesStruct_PointClampSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    Main_out out = {};
    float4 _82 = float4(gl_FragCoord.xy, SceneTexturesStruct_SceneDepthTexture.sample(SceneTexturesStruct_PointClampSampler, (gl_FragCoord.xy * View.View_BufferSizeAndInvSize.zw), level(0.0)).x, 1.0);
    float4 _85 = _Globals.SvPositionToLight * _82;
    float3 _89 = _85.xyz / float3(_85.w);
    float4 _92 = View.View_SVPositionToTranslatedWorld * _82;
    float2 _105 = _89.zy;
    float2 _136;
    if (_Globals.LightFunctionParameters.z > 0.0)
    {
        _136 = ((_105 / float2(_89.x * _Globals.LightFunctionParameters.x)) * 0.5) + float2(0.5);
    }
    else
    {
        float2 _135;
        if (_Globals.LightFunctionParameters.w > 0.0)
        {
            float3 _125 = normalize(_89.zyx);
            _135 = float2((atan2(_125.y, _125.x) + 3.1415927410125732421875) * 0.15915493667125701904296875, acos(_125.z) * 0.3183098733425140380859375);
        }
        else
        {
            _135 = _105;
        }
        _136 = _135;
    }
    spvUnsafeArray<float2, 1> _68 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _138 = 0; _138 < 1; )
    {
        _68[_138] = _136;
        _138++;
        continue;
    }
    float _175 = sqrt(mix(_Globals.LightFunctionParameters2.y, mix(_Globals.LightFunctionParameters2.y, dot(fast::max(mix(float4(Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_68[0] * 4.0)).x).xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), float3(0.33329999446868896484375)), fast::clamp((_Globals.LightFunctionParameters2.x - length(View.View_WorldCameraOrigin - ((_92.xyz / float3(_92.w)) - View.View_PreViewTranslation))) / (_Globals.LightFunctionParameters2.x * 0.20000000298023223876953125), 0.0, 1.0)), _Globals.LightFunctionParameters.y));
    out.out_var_SV_Target0 = mix(float4(1.0, 1.0, _175, _175), float4(_175), float4(_Globals.LightFunctionParameters2.z));
    return out;
}

