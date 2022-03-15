

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
    char _m8_pad[80];
    float View_UnlitViewmodeMask;
    char _m9_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m11_pad[80];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
    char _m16_pad[16];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float _114 = {};
constant float3 _117 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    float4 in_var_TEXCOORD7 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002ef0_bfadd408(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _159 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _164 = (_159.xyz / float3(_159.w)) - View.View_PreViewTranslation;
    float4 _183 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _185 = fast::clamp(_183.x, 0.0, 1.0);
    float3 _195 = fast::clamp((_164 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _206 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_195.x), int(_195.y), int(_195.z), 0).xyz), 0));
    float3 _221 = (((_206.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_195 / float3(_206.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _237 = ((float3(1.0) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _241 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _221, level(0.0));
    float3 _246 = _117;
    _246.x = _241.x * 0.886227548122406005859375;
    float3 _248 = _246;
    _248.y = _241.y * 0.886227548122406005859375;
    float3 _250 = _248;
    _250.z = _241.z * 0.886227548122406005859375;
    float _271;
    float3 _272;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _266 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _221, level(0.0)).xyz * 2.0) - float3(1.0);
        float _267 = length(_266);
        _271 = _267;
        _272 = _266 / float3(fast::max(_267, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _271 = 1.0;
        _272 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    }
    float4 _276 = float4(_272, 1.0);
    float3 _280 = _117;
    _280.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _276);
    float3 _284 = _280;
    _284.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _276);
    float3 _288 = _284;
    _288.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _276);
    float4 _291 = _276.xyzz * _276.yzzx;
    float3 _295 = _117;
    _295.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _291);
    float3 _299 = _295;
    _299.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _291);
    float3 _303 = _299;
    _303.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _291);
    bool _322 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _370;
    if (_322)
    {
        float4 _329 = View.View_WorldToClip * float4(_164, 1.0);
        float _330 = _329.w;
        float4 _358;
        if (_322)
        {
            _358 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_329.xy / float2(_330)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_330 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _358 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _370 = float4(_358.xyz + (in.in_var_TEXCOORD7.xyz * _358.w), _358.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _370 = in.in_var_TEXCOORD7;
    }
    float3 _378 = (_164 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _391 = fast::clamp((float3(0.5) - abs(_378 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _404 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_164 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _378, level(0.0)), float4((_391.x * _391.y) * _391.z));
    float3 _418 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _449;
    float3 _450;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        uint _424 = in.in_var_PRIMITIVE_ID * 36u;
        bool _437 = any(abs(_164 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _424 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _424 + 19u)].xyz + float3(1.0)));
        float3 _447;
        if (_437)
        {
            _447 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_164, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _447 = _418;
        }
        _449 = _437 ? 1.0 : _185;
        _450 = _447;
    }
    else
    {
        _449 = _185;
        _450 = _418;
    }
    float4 _460 = float4((((mix(_237 * float4(_404.x * 0.886227548122406005859375, _404.y * 0.886227548122406005859375, _404.z * 0.886227548122406005859375, _114).xyz, _237, float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _250) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_288 + _303) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_272.x * _272.x) - (_272.y * _272.y)))) * View.View_SkyLightColor.xyz) * _271)) * _237) * float3(1.000099658966064453125))) + _450) * _370.w) + _370.xyz, _449);
    float3 _464 = _460.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_464.x, _464.y, _464.z, _460.w);
    return out;
}

