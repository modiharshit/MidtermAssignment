

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
    char _m0_pad[64];
    float4x4 View_WorldToClip;
    char _m1_pad[576];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[352];
    float3 View_PreViewTranslation;
    char _m3_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    char _m6_pad[32];
    float View_OutOfBoundsMask;
    char _m7_pad[80];
    float View_UnlitViewmodeMask;
    char _m8_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m10_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m11_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _98 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000219f_0710554f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _125 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _130 = (_125.xyz / float3(_125.w)) - View.View_PreViewTranslation;
    float4 _141 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _146 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _147 = dfdx(_146);
    float _148 = dot(_147, _147);
    float3 _149 = dfdy(_146);
    float _150 = dot(_149, _149);
    float _158 = 1.0 / sqrt((abs(_148 - _150) > 9.9999997473787516355514526367188e-06) ? ((_148 >= _150) ? _148 : _150) : _150);
    float _168 = fast::clamp((((_141.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _158)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _158), 0.0), 1.0), 0.0, 1.0);
    float3 _175 = (fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _182 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _185 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _190;
    if (_185)
    {
        _190 = _175 + (_182 * 0.449999988079071044921875);
    }
    else
    {
        _190 = _175;
    }
    bool _195 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _244;
    if (_195)
    {
        float4 _202 = View.View_WorldToClip * float4(_130, 1.0);
        float _203 = _202.w;
        float4 _232;
        if (_195)
        {
            _232 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_202.xy / float2(_203)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_203 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _232 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _244 = float4(_232.xyz + (in.in_var_TEXCOORD7.xyz * _232.w), _232.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _244 = in.in_var_TEXCOORD7;
    }
    float3 _252 = (_130 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _265 = fast::clamp((float3(0.5) - abs(_252 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _279 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_130 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _252, level(0.0)), float4((_265.x * _265.y) * _265.z));
    float3 _295 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _326;
    float3 _327;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _301 = in.in_var_PRIMITIVE_ID * 36u;
        bool _314 = any(abs(_130 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301 + 19u)].xyz + float3(1.0)));
        float3 _324;
        if (_314)
        {
            _324 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_130, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _324 = _295;
        }
        _326 = _314 ? 1.0 : _168;
        _327 = _324;
    }
    else
    {
        _326 = _168;
        _327 = _295;
    }
    float4 _336 = float4(((mix(_190 * float4(_279.x * 0.886227548122406005859375, _279.y * 0.886227548122406005859375, _279.z * 0.886227548122406005859375, _98).xyz, _190 + (select(_182, float3(0.0), bool3(_185)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _327) * _244.w) + _244.xyz, _326);
    float3 _340 = _336.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_340.x, _340.y, _340.z, _336.w);
    return out;
}

