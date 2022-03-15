

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
    char _m10_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[384];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m14_pad[80];
    float View_IndirectLightingCacheShowFlag;
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

struct type_IndirectLightingCache
{
    char _m0_pad[96];
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
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

constant float3 _131 = {};

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

fragment MainPS_out Main_00002f49_4b3015f7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _159 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _164 = (_159.xyz / float3(_159.w)) - View.View_PreViewTranslation;
    float4 _175 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _180 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _181 = dfdx(_180);
    float _182 = dot(_181, _181);
    float3 _183 = dfdy(_180);
    float _184 = dot(_183, _183);
    float _192 = 1.0 / sqrt((abs(_182 - _184) > 9.9999997473787516355514526367188e-06) ? ((_182 >= _184) ? _182 : _184) : _184);
    float3 _201 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _202 = fast::clamp((((_175.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _192)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _192), 0.0), 1.0), 0.0, 1.0);
    float3 _209 = (_201 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _216 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _219 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _224;
    if (_219)
    {
        _224 = _209 + (_216 * 0.449999988079071044921875);
    }
    else
    {
        _224 = _209;
    }
    float3 _244;
    if (View.View_IndirectLightingCacheShowFlag > 0.0)
    {
        float3 _239 = _131;
        _239.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _241 = _239;
        _241.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _243 = _241;
        _243.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _244 = _243;
    }
    else
    {
        _244 = float3(0.0);
    }
    bool _264 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _313;
    if (_264)
    {
        float4 _271 = View.View_WorldToClip * float4(_164, 1.0);
        float _272 = _271.w;
        float4 _301;
        if (_264)
        {
            _301 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_271.xy / float2(_272)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_272 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _301 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _313 = float4(_301.xyz + (in.in_var_TEXCOORD7.xyz * _301.w), _301.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _313 = in.in_var_TEXCOORD7;
    }
    float3 _321 = (_164 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _334 = fast::clamp((float3(0.5) - abs(_321 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _348 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_164 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _321, level(0.0)), float4((_334.x * _334.y) * _334.z));
    float _355 = _348.w;
    float3 _357 = float4(_348.x * 0.886227548122406005859375, _348.y * 0.886227548122406005859375, _348.z * 0.886227548122406005859375, _355).xyz;
    float3 _423;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _371 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_164, 1.0);
        float2 _375 = _371.xy / float2(_371.w);
        float _376 = _371.z;
        float4 _379 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _375, level(0.0));
        float3 _383 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _376;
        bool2 _408 = _375 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _410 = _375 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _423 = _224 * fast::max(_357 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _355) * (float3(1.0) - select(fast::clamp(exp((float3((((_379.x * _376) * 0.5) + dot((sin(_383) * _379.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_383)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _375, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_408.x || _410.x, _408.y || _410.y)))))), float3(0.0));
    }
    else
    {
        _423 = _224 * _357;
    }
    float3 _430 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _461;
    float3 _462;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _436 = in.in_var_PRIMITIVE_ID * 36u;
        bool _449 = any(abs(_164 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _436 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _436 + 19u)].xyz + float3(1.0)));
        float3 _459;
        if (_449)
        {
            _459 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_164, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _459 = _430;
        }
        _461 = _449 ? 1.0 : _202;
        _462 = _459;
    }
    else
    {
        _461 = _202;
        _462 = _430;
    }
    float4 _472 = float4((((mix(_423, _224 + (select(_216, float3(0.0), bool3(_219)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_244 * View.View_IndirectLightingColorScale) * _224) * fast::max(float3(1.0), ((((((_201 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_201 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_201 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _462) * _313.w) + _313.xyz, _461);
    float3 _476 = _472.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_476.x, _476.y, _476.z, _472.w);
    return out;
}

