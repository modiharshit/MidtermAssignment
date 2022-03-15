

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
    float4 View_NormalOverrideParameter;
    char _m7_pad[16];
    float View_OutOfBoundsMask;
    char _m8_pad[24];
    float View_CullingSign;
    char _m9_pad[52];
    float View_UnlitViewmodeMask;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m12_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m18_pad[80];
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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    char _m1_pad[16];
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

constant float3 _137 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003ac6_2167a758(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(7)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(5)]], constant type_Material& Material [[buffer(6)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _182 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _187 = (_182.xyz / float3(_182.w)) - View.View_PreViewTranslation;
    uint _188 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _204 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _188 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _215 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _220 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _221 = dfdx(_220);
    float _222 = dot(_221, _221);
    float3 _223 = dfdy(_220);
    float _224 = dot(_223, _223);
    float _232 = 1.0 / sqrt((abs(_222 - _224) > 9.9999997473787516355514526367188e-06) ? ((_222 >= _224) ? _222 : _224) : _224);
    float3 _241 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _242 = fast::clamp((((_215.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _232)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _232), 0.0), 1.0), 0.0, 1.0);
    float3 _249 = (_241 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _256 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _259 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _264;
    if (_259)
    {
        _264 = _249 + (_256 * 0.449999988079071044921875);
    }
    else
    {
        _264 = _249;
    }
    bool _269 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _284;
    if (_269)
    {
        float3 _279 = _137;
        _279.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _281 = _279;
        _281.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _283 = _281;
        _283.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _284 = _283;
    }
    else
    {
        _284 = float3(0.0);
    }
    float _302;
    float3 _303;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _300;
        float3 _301;
        if (_269)
        {
            _300 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _301 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _300 = 1.0;
            _301 = _204;
        }
        _302 = _300;
        _303 = _301;
    }
    else
    {
        _302 = 1.0;
        _303 = _204;
    }
    float4 _307 = float4(_303, 1.0);
    float3 _311 = _137;
    _311.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _307);
    float3 _315 = _311;
    _315.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _307);
    float3 _319 = _315;
    _319.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _307);
    float4 _322 = _307.xyzz * _307.yzzx;
    float3 _326 = _137;
    _326.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _322);
    float3 _330 = _326;
    _330.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _322);
    float3 _334 = _330;
    _334.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _322);
    bool _365 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _414;
    if (_365)
    {
        float4 _372 = View.View_WorldToClip * float4(_187, 1.0);
        float _373 = _372.w;
        float4 _402;
        if (_365)
        {
            _402 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_372.xy / float2(_373)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_373 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _402 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _414 = float4(_402.xyz + (in.in_var_TEXCOORD7.xyz * _402.w), _402.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _414 = in.in_var_TEXCOORD7;
    }
    float3 _422 = (_187 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _435 = fast::clamp((float3(0.5) - abs(_422 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _449 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_187 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _422, level(0.0)), float4((_435.x * _435.y) * _435.z));
    float _456 = _449.w;
    float3 _458 = float4(_449.x * 0.886227548122406005859375, _449.y * 0.886227548122406005859375, _449.z * 0.886227548122406005859375, _456).xyz;
    float3 _524;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _472 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_187, 1.0);
        float2 _476 = _472.xy / float2(_472.w);
        float _477 = _472.z;
        float4 _480 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _476, level(0.0));
        float3 _484 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _477;
        bool2 _509 = _476 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _511 = _476 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _524 = _264 * fast::max(_458 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _456) * (float3(1.0) - select(fast::clamp(exp((float3((((_480.x * _477) * 0.5) + dot((sin(_484) * _480.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_484)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _476, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_509.x || _511.x, _509.y || _511.y)))))), float3(0.0));
    }
    else
    {
        _524 = _264 * _458;
    }
    float3 _531 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _561;
    float3 _562;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _549 = any(abs(_187 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _188 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _188 + 19u)].xyz + float3(1.0)));
        float3 _559;
        if (_549)
        {
            _559 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_187, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _559 = _531;
        }
        _561 = _549 ? 1.0 : _242;
        _562 = _559;
    }
    else
    {
        _561 = _242;
        _562 = _531;
    }
    float4 _572 = float4((((mix(_524, _264 + (select(_256, float3(0.0), bool3(_259)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((_284 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_319 + _334) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_303.x * _303.x) - (_303.y * _303.y)))) * View.View_SkyLightColor.xyz) * _302)) * _264) * fast::max(float3(1.0), ((((((_241 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_241 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_241 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _562) * _414.w) + _414.xyz, _561);
    float3 _576 = _572.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_576.x, _576.y, _576.z, _572.w);
    return out;
}

