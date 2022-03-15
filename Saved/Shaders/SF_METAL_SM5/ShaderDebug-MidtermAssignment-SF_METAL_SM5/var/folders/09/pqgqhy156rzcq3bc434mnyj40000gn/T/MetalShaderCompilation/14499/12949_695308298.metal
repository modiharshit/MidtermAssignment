

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _118 = {};
constant float3 _119 = {};

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

fragment MainPS_out Main_00003295_2971900a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> Material_Texture2D_0 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _164 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _169 = (_164.xyz / float3(_164.w)) - View.View_PreViewTranslation;
    uint _170 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _186 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _170 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _197 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _202 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _203 = dfdx(_202);
    float _204 = dot(_203, _203);
    float3 _205 = dfdy(_202);
    float _206 = dot(_205, _205);
    float _214 = 1.0 / sqrt((abs(_204 - _206) > 9.9999997473787516355514526367188e-06) ? ((_204 >= _206) ? _204 : _206) : _206);
    float3 _223 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _224 = fast::clamp((((_197.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _214)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _214), 0.0), 1.0), 0.0, 1.0);
    float3 _231 = (_223 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _238 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _241 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _246;
    if (_241)
    {
        _246 = _231 + (_238 * 0.449999988079071044921875);
    }
    else
    {
        _246 = _231;
    }
    bool _251 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float3 _266;
    if (_251)
    {
        float3 _261 = _119;
        _261.x = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0].x * 0.886227548122406005859375;
        float3 _263 = _261;
        _263.y = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1].x * 0.886227548122406005859375;
        float3 _265 = _263;
        _265.z = IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2].x * 0.886227548122406005859375;
        _266 = _265;
    }
    else
    {
        _266 = float3(0.0);
    }
    float _284;
    float3 _285;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float _282;
        float3 _283;
        if (_251)
        {
            _282 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
            _283 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
        }
        else
        {
            _282 = 1.0;
            _283 = _186;
        }
        _284 = _282;
        _285 = _283;
    }
    else
    {
        _284 = 1.0;
        _285 = _186;
    }
    float4 _289 = float4(_285, 1.0);
    float3 _293 = _119;
    _293.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _289);
    float3 _297 = _293;
    _297.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _289);
    float3 _301 = _297;
    _301.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _289);
    float4 _304 = _289.xyzz * _289.yzzx;
    float3 _308 = _119;
    _308.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _304);
    float3 _312 = _308;
    _312.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _304);
    float3 _316 = _312;
    _316.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _304);
    bool _347 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _396;
    if (_347)
    {
        float4 _354 = View.View_WorldToClip * float4(_169, 1.0);
        float _355 = _354.w;
        float4 _384;
        if (_347)
        {
            _384 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_354.xy / float2(_355)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_355 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _384 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _396 = float4(_384.xyz + (in.in_var_TEXCOORD7.xyz * _384.w), _384.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _396 = in.in_var_TEXCOORD7;
    }
    float3 _404 = (_169 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _417 = fast::clamp((float3(0.5) - abs(_404 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _431 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_169 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _404, level(0.0)), float4((_417.x * _417.y) * _417.z));
    float3 _447 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _477;
    float3 _478;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _465 = any(abs(_169 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _170 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _170 + 19u)].xyz + float3(1.0)));
        float3 _475;
        if (_465)
        {
            _475 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_169, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _475 = _447;
        }
        _477 = _465 ? 1.0 : _224;
        _478 = _475;
    }
    else
    {
        _477 = _224;
        _478 = _447;
    }
    float4 _488 = float4((((mix(_246 * float4(_431.x * 0.886227548122406005859375, _431.y * 0.886227548122406005859375, _431.z * 0.886227548122406005859375, _118).xyz, _246 + (select(_238, float3(0.0), bool3(_241)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((_266 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_301 + _316) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_285.x * _285.x) - (_285.y * _285.y)))) * View.View_SkyLightColor.xyz) * _284)) * _246) * fast::max(float3(1.0), ((((((_223 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_223 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_223 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _478) * _396.w) + _396.xyz, _477);
    float3 _492 = _488.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_492.x, _492.y, _492.z, _488.w);
    return out;
}

