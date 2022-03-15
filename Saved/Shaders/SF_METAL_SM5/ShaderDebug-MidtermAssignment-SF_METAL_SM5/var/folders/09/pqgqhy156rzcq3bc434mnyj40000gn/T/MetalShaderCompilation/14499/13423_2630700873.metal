

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
    char _m18_pad[16];
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

constant float _128 = {};
constant float3 _129 = {};

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

fragment MainPS_out Main_0000346f_9ccd4f49(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(2)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(3)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(4)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _177 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _182 = (_177.xyz / float3(_177.w)) - View.View_PreViewTranslation;
    uint _183 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _210 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _215 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _216 = dfdx(_215);
    float _217 = dot(_216, _216);
    float3 _218 = dfdy(_215);
    float _219 = dot(_218, _218);
    float _227 = 1.0 / sqrt((abs(_217 - _219) > 9.9999997473787516355514526367188e-06) ? ((_217 >= _219) ? _217 : _219) : _219);
    float3 _236 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _237 = fast::clamp((((_210.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _227)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _227), 0.0), 1.0), 0.0, 1.0);
    float3 _247 = fast::clamp((_182 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _258 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_247.x), int(_247.y), int(_247.z), 0).xyz), 0));
    float3 _273 = (((_258.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_247 / float3(_258.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float3 _280 = (_236 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _287 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _290 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _295;
    if (_290)
    {
        _295 = _280 + (_287 * 0.449999988079071044921875);
    }
    else
    {
        _295 = _280;
    }
    float4 _301 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _273, level(0.0));
    float3 _306 = _129;
    _306.x = _301.x * 0.886227548122406005859375;
    float3 _308 = _306;
    _308.y = _301.y * 0.886227548122406005859375;
    float3 _310 = _308;
    _310.z = _301.z * 0.886227548122406005859375;
    float _331;
    float3 _332;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _326 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _273, level(0.0)).xyz * 2.0) - float3(1.0);
        float _327 = length(_326);
        _331 = _327;
        _332 = _326 / float3(fast::max(_327, 9.9999997473787516355514526367188e-05));
    }
    else
    {
        _331 = 1.0;
        _332 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _183 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    }
    float4 _336 = float4(_332, 1.0);
    float3 _340 = _129;
    _340.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _336);
    float3 _344 = _340;
    _344.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _336);
    float3 _348 = _344;
    _348.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _336);
    float4 _351 = _336.xyzz * _336.yzzx;
    float3 _355 = _129;
    _355.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _351);
    float3 _359 = _355;
    _359.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _351);
    float3 _363 = _359;
    _363.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _351);
    bool _394 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _442;
    if (_394)
    {
        float4 _401 = View.View_WorldToClip * float4(_182, 1.0);
        float _402 = _401.w;
        float4 _430;
        if (_394)
        {
            _430 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_401.xy / float2(_402)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_402 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _430 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _442 = float4(_430.xyz + (in.in_var_TEXCOORD7.xyz * _430.w), _430.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _442 = in.in_var_TEXCOORD7;
    }
    float3 _450 = (_182 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _463 = fast::clamp((float3(0.5) - abs(_450 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _476 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_182 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _450, level(0.0)), float4((_463.x * _463.y) * _463.z));
    float3 _492 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _522;
    float3 _523;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _510 = any(abs(_182 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _183 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _183 + 19u)].xyz + float3(1.0)));
        float3 _520;
        if (_510)
        {
            _520 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_182, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _520 = _492;
        }
        _522 = _510 ? 1.0 : _237;
        _523 = _520;
    }
    else
    {
        _522 = _237;
        _523 = _492;
    }
    float4 _533 = float4((((mix(_295 * float4(_476.x * 0.886227548122406005859375, _476.y * 0.886227548122406005859375, _476.z * 0.886227548122406005859375, _128).xyz, _295 + (select(_287, float3(0.0), bool3(_290)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((((fast::max(float3(0.0), _310) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_348 + _363) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_332.x * _332.x) - (_332.y * _332.y)))) * View.View_SkyLightColor.xyz) * _331)) * _295) * fast::max(float3(1.0), ((((((_236 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_236 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_236 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _523) * _442.w) + _442.xyz, _522);
    float3 _537 = _533.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_537.x, _537.y, _537.z, _533.w);
    return out;
}

