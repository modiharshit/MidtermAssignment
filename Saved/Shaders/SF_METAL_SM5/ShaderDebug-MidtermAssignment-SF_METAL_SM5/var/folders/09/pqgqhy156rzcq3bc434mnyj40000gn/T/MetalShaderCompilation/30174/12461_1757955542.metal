

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
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
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

constant float _113 = {};
constant float3 _114 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000030ad_68c845d6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _155 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _160 = (_155.xyz / float3(_155.w)) - View.View_PreViewTranslation;
    float3 _168 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _174 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _195 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _198 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _203;
    if (_198)
    {
        _203 = View.View_DiffuseOverrideParameter.xyz + (_195 * 0.449999988079071044921875);
    }
    else
    {
        _203 = View.View_DiffuseOverrideParameter.xyz;
    }
    float2 _207 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _212 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _207);
    float4 _214 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_207 + float2(0.0, 0.5)));
    uint _220 = in.in_var_LIGHTMAP_ID * 15u;
    uint _221 = _220 + 4u;
    uint _226 = _220 + 6u;
    float3 _231 = _212.xyz;
    float _275;
    float3 _276;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _267 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _271 = _267.w;
        _275 = _271 * _271;
        _276 = normalize(((_267.xyz * 2.0) - float3(1.0)).xyz);
    }
    else
    {
        _275 = 1.0;
        _276 = _168;
    }
    float4 _280 = float4(_276, 1.0);
    float3 _284 = _114;
    _284.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _280);
    float3 _288 = _284;
    _288.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _280);
    float3 _292 = _288;
    _292.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _280);
    float4 _295 = _280.xyzz * _280.yzzx;
    float3 _299 = _114;
    _299.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _295);
    float3 _303 = _299;
    _303.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _295);
    float3 _307 = _303;
    _307.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _295);
    bool _325 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _374;
    if (_325)
    {
        float4 _332 = View.View_WorldToClip * float4(_160, 1.0);
        float _333 = _332.w;
        float4 _362;
        if (_325)
        {
            _362 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_332.xy / float2(_333)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_333 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _362 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _374 = float4(_362.xyz + (in.in_var_TEXCOORD7.xyz * _362.w), _362.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _374 = in.in_var_TEXCOORD7;
    }
    float3 _382 = (_160 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _395 = fast::clamp((float3(0.5) - abs(_382 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _409 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_160 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _382, level(0.0)), float4((_395.x * _395.y) * _395.z));
    float3 _425 = fast::max(mix(float3(_174.yxz), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _455;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _431 = in.in_var_PRIMITIVE_ID * 36u;
        float3 _454;
        if (any(abs(_160 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _431 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _431 + 19u)].xyz + float3(1.0))))
        {
            _454 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_160, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _454 = _425;
        }
        _455 = _454;
    }
    else
    {
        _455 = _425;
    }
    float4 _465 = float4((((mix(_203 * float4(_409.x * 0.886227548122406005859375, _409.y * 0.886227548122406005859375, _409.z * 0.886227548122406005859375, _113).xyz, _203 + (select(_195, float3(0.0), bool3(_198)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((((_231 * _231) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _221)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _226)].xyz) * ((exp2(((_212.w + ((_214.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _221)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _226)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_214 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _220 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _220 + 7u)], float4(_168.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_292 + _307) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_276.x * _276.x) - (_276.y * _276.y)))) * View.View_SkyLightColor.xyz) * _275)) * _203)) + _455) * _374.w) + _374.xyz, 1.0);
    float3 _469 = _465.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_469.x, _469.y, _469.z, _465.w);
    return out;
}

