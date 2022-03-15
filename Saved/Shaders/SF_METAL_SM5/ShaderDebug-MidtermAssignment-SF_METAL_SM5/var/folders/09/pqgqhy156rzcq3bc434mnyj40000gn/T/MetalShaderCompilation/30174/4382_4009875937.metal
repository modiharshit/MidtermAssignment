

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
    char _m0_pad[2112];
    float4 View_BufferSizeAndInvSize;
    char _m1_pad[36];
    float View_PreExposure;
    char _m2_pad[56];
    float2 View_RoughnessOverrideParameter;
    char _m3_pad[60];
    float View_MaterialTextureMipBias;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct type_Globals
{
    float4x4 SvPositionToDecal;
    char _m1_pad[128];
    float2 DecalParams;
};

constant spvUnsafeArray<float2, 1> _64 = spvUnsafeArray<float2, 1>({ float2(0.0) });

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
};

fragment MainPS_out Main_0000111e_ef01d9e1(constant type_View& View [[buffer(0)]], constant type_Material& Material [[buffer(1)]], constant type_Globals& _Globals [[buffer(2)]], texture2d<float> DecalPass_SceneTextures_SceneDepthTexture [[texture(0)]], texture2d<float> Material_Texture2D_0 [[texture(1)]], sampler DecalPass_SceneTextures_PointClampSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _89 = _Globals.SvPositionToDecal * float4(gl_FragCoord.xy, DecalPass_SceneTextures_SceneDepthTexture.sample(DecalPass_SceneTextures_PointClampSampler, (gl_FragCoord.xy * View.View_BufferSizeAndInvSize.zw), level(0.0)).x, 1.0);
    float3 _93 = _89.xyz / float3(_89.w);
    if (any((_93 + float3(1.0)) < float3(0.0)))
    {
        discard_fragment();
    }
    if (any((float3(1.0) - _93) < float3(0.0)))
    {
        discard_fragment();
    }
    float3 _105 = (_93 * 0.5) + float3(0.5);
    spvUnsafeArray<float2, 1> _70 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _108 = 0; _108 < 1; )
    {
        _70[_108] = _105.zy;
        _108++;
        continue;
    }
    float _142 = fast::clamp(4.0 - (4.0 * abs((_105.x * 2.0) - 1.0)), 0.0, 1.0) * _Globals.DecalParams.x;
    float4 _151 = float4(fast::max(mix(float3(Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _70[0], bias(View.View_MaterialTextureMipBias)).yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0)), _142);
    float3 _155 = _151.xyz * View.View_PreExposure;
    float4 _157 = float4(0.0);
    _157.x = 0.0;
    float4 _158 = _157;
    _158.y = 0.5;
    float4 _159 = _158;
    _159.z = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _160 = float4(_155.x, _155.y, _155.z, _151.w);
    _160.w = _142;
    float4 _161 = _159;
    _161.w = _142;
    float4 _162 = float4(0.0);
    _162.w = _142;
    out.out_var_SV_Target0 = _160;
    out.out_var_SV_Target1 = _161;
    out.out_var_SV_Target2 = _162;
    return out;
}

