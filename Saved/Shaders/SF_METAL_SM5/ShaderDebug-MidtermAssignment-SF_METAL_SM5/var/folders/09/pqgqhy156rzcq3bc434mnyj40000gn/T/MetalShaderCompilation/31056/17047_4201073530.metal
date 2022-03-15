

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[312];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m15_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    char _m3_pad[4];
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_IndirectLightingCache
{
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _160 = {};
constant float4 _162 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
    float4 out_var_SV_Target3 [[color(3)]];
    float4 out_var_SV_Target4 [[color(4)]];
    float4 out_var_SV_Target5 [[color(5)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004297_fa674b7a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(2)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(3)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _202 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _207 = (_202.xyz / float3(_202.w)) - View.View_PreViewTranslation;
    float4 _213 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _216 = (_213.xy * float2(2.0)) - float2(1.0);
    float _220 = sqrt(fast::clamp(1.0 - dot(_216, _216), 0.0, 1.0));
    float3 _228 = float3(float4(_216, _220, 1.0).xy * (-1.0), _220);
    float3 _232 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _228)) - (_228 * 2.0);
    float3 _244 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_232 / float3(sqrt(dot(_232, _232)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _266 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _270 = float3(_248.x);
    float4 _275 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _279 = float3(_248.z);
    float3 _293 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_248.y)), _266.xyz * float3(0.25), _270), _275.xyz * float3(0.2249999940395355224609375), _279), float3(0.0), float3(1.0));
    float _294 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _270), float3(0.0), _279).x, 0.0, 1.0);
    bool _307 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _313;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _307)
    {
        _313 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _313 = 1.0;
    }
    float _360;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _328 = fast::clamp((_207 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _339 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_328.x), int(_328.y), int(_328.z), 0).xyz), 0));
        _360 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_339.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_328 / float3(_339.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _360 = _313;
    }
    float3 _372 = ((_293 - (_293 * _294)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _379 = (mix(float3(0.039999999105930328369140625), _293, float3(_294)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _382 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _387;
    if (_382)
    {
        _387 = _372 + (_379 * 0.449999988079071044921875);
    }
    else
    {
        _387 = _372;
    }
    float3 _389 = select(_379, float3(0.0), bool3(_382));
    float3 _391 = float3(dot(_389, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _465;
    if (_307)
    {
        float3 _417 = fast::clamp((_207 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _421 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _417);
        float4 _425 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _417);
        float4 _428 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _417);
        float4 _446 = _162;
        _446.y = (-0.48860299587249755859375) * _244.y;
        float4 _449 = _446;
        _449.z = 0.48860299587249755859375 * _244.z;
        float4 _452 = _449;
        _452.w = (-0.48860299587249755859375) * _244.x;
        float4 _453 = _452;
        _453.x = 0.886227548122406005859375;
        float3 _455 = _453.yzw * 2.094395160675048828125;
        float4 _456 = float4(_453.x, _455.x, _455.y, _455.z);
        float3 _458 = float3(0.0);
        _458.x = dot(float4(_421.x, _425.x, _428.x, _421.w), _456);
        float3 _460 = _458;
        _460.y = dot(float4(_421.y, _425.y, _428.y, _425.w), _456);
        float3 _462 = _460;
        _462.z = dot(float4(_421.z, _425.z, _428.zw), _456);
        _465 = fast::max(float3(0.0), _462) * float3(0.3183098733425140380859375);
    }
    else
    {
        _465 = float3(0.0);
    }
    float _491;
    float _492;
    float3 _493;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _481;
        float _482;
        if (_307)
        {
            _481 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _482 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _481 = _244;
            _482 = 1.0;
        }
        float _483 = 1.0 - _482;
        float _485 = 1.0 - (_483 * _483);
        _491 = mix(fast::clamp(dot(_481, _244), 0.0, 1.0), 1.0, _485);
        _492 = _482;
        _493 = mix(_481, _244, float3(_485));
    }
    else
    {
        _491 = 1.0;
        _492 = 1.0;
        _493 = _244;
    }
    float4 _497 = float4(_493, 1.0);
    float3 _501 = _160;
    _501.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _497);
    float3 _505 = _501;
    _505.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _497);
    float3 _509 = _505;
    _509.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _497);
    float4 _512 = _497.xyzz * _497.yzzx;
    float3 _516 = _160;
    _516.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _512);
    float3 _520 = _516;
    _520.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _512);
    float3 _524 = _520;
    _524.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _512);
    float3 _539 = (_465 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_509 + _524) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_493.x * _493.x) - (_493.y * _493.y)))) * View.View_SkyLightColor.xyz) * (_492 * _491));
    float3 _561 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _587;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _586;
        if (any(abs(_207 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _586 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _586 = _561;
        }
        _587 = _586;
    }
    else
    {
        _587 = _561;
    }
    float4 _594 = float4(((mix(float3(0.0), _387 + (_389 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_539 * _387) * fast::max(float3(1.0), ((((((_293 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_293 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_293 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _587) * 1.0, 0.0);
    float4 _601;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _600 = _594;
        _600.w = 0.0;
        _601 = _600;
    }
    else
    {
        _601 = _594;
    }
    float2 _606 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _614 = (_244 * 0.5) + float3(0.5);
    float4 _616 = float4(_614.x, _614.y, _614.z, float4(0.0).w);
    _616.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _617 = float4(0.0);
    _617.x = _294;
    float4 _618 = _617;
    _618.y = 0.5;
    float4 _619 = _618;
    _619.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _266.x)), _270), float3(mix(0.550000011920928955078125, 0.75, _275.x)), _279).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _620 = _619;
    _620.w = 0.50588238239288330078125;
    float4 _632 = float4(_293.x, _293.y, _293.z, float4(0.0).w);
    _632.w = ((log2(((dot(_539, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_391 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_391 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_391 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_606.xyx * _606.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _601 * View.View_PreExposure;
    out.out_var_SV_Target1 = _616;
    out.out_var_SV_Target2 = _620;
    out.out_var_SV_Target3 = _632;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_360, 1.0, 1.0, 1.0);
    return out;
}

