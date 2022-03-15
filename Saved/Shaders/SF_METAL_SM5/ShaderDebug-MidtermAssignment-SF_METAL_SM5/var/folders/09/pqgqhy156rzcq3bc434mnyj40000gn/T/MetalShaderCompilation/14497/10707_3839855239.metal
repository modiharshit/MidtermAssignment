

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

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000029d3_e4df8a87(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _143 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _148 = (_143.xyz / float3(_143.w)) - View.View_PreViewTranslation;
    float4 _159 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _164 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _165 = dfdx(_164);
    float _166 = dot(_165, _165);
    float3 _167 = dfdy(_164);
    float _168 = dot(_167, _167);
    float _176 = 1.0 / sqrt((abs(_166 - _168) > 9.9999997473787516355514526367188e-06) ? ((_166 >= _168) ? _166 : _168) : _168);
    float _186 = fast::clamp((((_159.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _176)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _176), 0.0), 1.0), 0.0, 1.0);
    float3 _193 = (fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _200 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _203 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _208;
    if (_203)
    {
        _208 = _193 + (_200 * 0.449999988079071044921875);
    }
    else
    {
        _208 = _193;
    }
    bool _213 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _262;
    if (_213)
    {
        float4 _220 = View.View_WorldToClip * float4(_148, 1.0);
        float _221 = _220.w;
        float4 _250;
        if (_213)
        {
            _250 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_220.xy / float2(_221)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_221 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _250 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _262 = float4(_250.xyz + (in.in_var_TEXCOORD7.xyz * _250.w), _250.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _262 = in.in_var_TEXCOORD7;
    }
    float3 _270 = (_148 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _283 = fast::clamp((float3(0.5) - abs(_270 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _297 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_148 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _270, level(0.0)), float4((_283.x * _283.y) * _283.z));
    float _304 = _297.w;
    float3 _306 = float4(_297.x * 0.886227548122406005859375, _297.y * 0.886227548122406005859375, _297.z * 0.886227548122406005859375, _304).xyz;
    float3 _372;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _320 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_148, 1.0);
        float2 _324 = _320.xy / float2(_320.w);
        float _325 = _320.z;
        float4 _328 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _324, level(0.0));
        float3 _332 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _325;
        bool2 _357 = _324 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _359 = _324 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _372 = _208 * fast::max(_306 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _304) * (float3(1.0) - select(fast::clamp(exp((float3((((_328.x * _325) * 0.5) + dot((sin(_332) * _328.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_332)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _324, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_357.x || _359.x, _357.y || _359.y)))))), float3(0.0));
    }
    else
    {
        _372 = _208 * _306;
    }
    float3 _379 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _410;
    float3 _411;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _385 = in.in_var_PRIMITIVE_ID * 36u;
        bool _398 = any(abs(_148 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _385 + 19u)].xyz + float3(1.0)));
        float3 _408;
        if (_398)
        {
            _408 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_148, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _408 = _379;
        }
        _410 = _398 ? 1.0 : _186;
        _411 = _408;
    }
    else
    {
        _410 = _186;
        _411 = _379;
    }
    float4 _420 = float4(((mix(_372, _208 + (select(_200, float3(0.0), bool3(_203)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _411) * _262.w) + _262.xyz, _410);
    float3 _424 = _420.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_424.x, _424.y, _424.z, _420.w);
    return out;
}

