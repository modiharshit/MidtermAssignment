

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
    char _m4_pad[72];
    float View_OutOfBoundsMask;
    char _m5_pad[1072];
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

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000016f3_f2fad0cf(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _102 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _107 = (_102.xyz / float3(_102.w)) - View.View_PreViewTranslation;
    float2 _115 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) - float2(0.5);
    float _121 = fast::min(fast::max(1.0 - (sqrt(dot(_115, _115)) * 2.0), 0.0), 1.0);
    float _125 = fast::clamp((_121 <= 0.0) ? 0.0 : pow(_121, 4.0), 0.0, 1.0);
    bool _128 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _177;
    if (_128)
    {
        float4 _135 = View.View_WorldToClip * float4(_107, 1.0);
        float _136 = _135.w;
        float4 _165;
        if (_128)
        {
            _165 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_135.xy / float2(_136)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_136 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _165 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _177 = float4(_165.xyz + (in.in_var_TEXCOORD7.xyz * _165.w), _165.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _177 = in.in_var_TEXCOORD7;
    }
    float3 _178 = fast::max(mix(float3(1.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _209;
    float3 _210;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _184 = in.in_var_PRIMITIVE_ID * 36u;
        bool _197 = any(abs(_107 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _184 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _184 + 19u)].xyz + float3(1.0)));
        float3 _207;
        if (_197)
        {
            _207 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_107, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _207 = _178;
        }
        _209 = _197 ? 1.0 : _125;
        _210 = _207;
    }
    else
    {
        _209 = _125;
        _210 = _178;
    }
    float4 _218 = float4((_210 * _177.w) + _177.xyz, _209);
    float3 _222 = _218.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_222.x, _222.y, _222.z, _218.w);
    return out;
}

