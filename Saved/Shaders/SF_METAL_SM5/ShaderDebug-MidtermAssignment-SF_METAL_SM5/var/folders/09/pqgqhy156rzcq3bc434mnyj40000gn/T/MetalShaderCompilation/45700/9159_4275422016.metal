

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

constant float _102 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
    float4 in_var_TEXCOORD7 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000023c7_fed5c340(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _126 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _131 = (_126.xyz / float3(_126.w)) - View.View_PreViewTranslation;
    float3 _141 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _144 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _149;
    if (_144)
    {
        _149 = View.View_DiffuseOverrideParameter.xyz + (_141 * 0.449999988079071044921875);
    }
    else
    {
        _149 = View.View_DiffuseOverrideParameter.xyz;
    }
    bool _154 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _196;
    if (_154)
    {
        float4 _161 = View.View_WorldToClip * float4(_131, 1.0);
        float _162 = _161.w;
        float4 _191;
        if (_154)
        {
            _191 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_161.xy / float2(_162)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_162 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _191 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _196 = float4(_102, _102, _102, _191.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _196 = in.in_var_TEXCOORD7;
    }
    float3 _204 = (_131 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _217 = fast::clamp((float3(0.5) - abs(_204 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _231 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_131 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _204, level(0.0)), float4((_217.x * _217.y) * _217.z));
    float _238 = _231.w;
    float3 _240 = float4(_231.x * 0.886227548122406005859375, _231.y * 0.886227548122406005859375, _231.z * 0.886227548122406005859375, _238).xyz;
    float3 _306;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _254 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_131, 1.0);
        float2 _258 = _254.xy / float2(_254.w);
        float _259 = _254.z;
        float4 _262 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _258, level(0.0));
        float3 _266 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _259;
        bool2 _291 = _258 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _293 = _258 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _306 = _149 * fast::max(_240 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _238) * (float3(1.0) - select(fast::clamp(exp((float3((((_262.x * _259) * 0.5) + dot((sin(_266) * _262.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_266)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _258, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_291.x || _293.x, _291.y || _293.y)))))), float3(0.0));
    }
    else
    {
        _306 = _149 * _240;
    }
    float3 _342;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _318 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _341;
        if (any(abs(_131 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 19u)].xyz + float3(1.0))))
        {
            _341 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_131, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _341 = float3(0.0);
        }
        _342 = _341;
    }
    else
    {
        _342 = float3(0.0);
    }
    float4 _350 = float4(((mix(_306, _149 + (select(_141, float3(0.0), bool3(_144)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _342) * _196.w) * 1.0, 0.0);
    float3 _354 = _350.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_354.x, _354.y, _354.z, _350.w);
    return out;
}

