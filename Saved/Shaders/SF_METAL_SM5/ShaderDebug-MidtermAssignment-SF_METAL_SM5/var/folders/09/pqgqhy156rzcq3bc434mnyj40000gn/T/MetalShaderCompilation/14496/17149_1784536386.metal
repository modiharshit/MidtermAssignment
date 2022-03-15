

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

fragment MainPS_out Main_000042fd_6a5ddd42(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(2)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(3)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
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
    float4 _266 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _270 = float3(_248.x);
    float4 _275 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _279 = float3(_248.z);
    float3 _282 = float3(_248.w);
    float3 _297 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_248.y)), _266.xyz * float3(0.2249999940395355224609375), _270), _275.xyz * float3(0.25), _279), float3(0.0), _282), float3(0.0), float3(1.0));
    float _298 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _279), float3(0.0), _282).x, 0.0, 1.0);
    bool _311 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _317;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _311)
    {
        _317 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _317 = 1.0;
    }
    float _364;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _332 = fast::clamp((_207 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _343 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_332.x), int(_332.y), int(_332.z), 0).xyz), 0));
        _364 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_343.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_332 / float3(_343.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _364 = _317;
    }
    float3 _376 = ((_297 - (_297 * _298)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _383 = (mix(float3(0.039999999105930328369140625), _297, float3(_298)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _386 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _391;
    if (_386)
    {
        _391 = _376 + (_383 * 0.449999988079071044921875);
    }
    else
    {
        _391 = _376;
    }
    float3 _393 = select(_383, float3(0.0), bool3(_386));
    float3 _395 = float3(dot(_393, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _469;
    if (_311)
    {
        float3 _421 = fast::clamp((_207 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _425 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _421);
        float4 _429 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _421);
        float4 _432 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _421);
        float4 _450 = _162;
        _450.y = (-0.48860299587249755859375) * _244.y;
        float4 _453 = _450;
        _453.z = 0.48860299587249755859375 * _244.z;
        float4 _456 = _453;
        _456.w = (-0.48860299587249755859375) * _244.x;
        float4 _457 = _456;
        _457.x = 0.886227548122406005859375;
        float3 _459 = _457.yzw * 2.094395160675048828125;
        float4 _460 = float4(_457.x, _459.x, _459.y, _459.z);
        float3 _462 = float3(0.0);
        _462.x = dot(float4(_425.x, _429.x, _432.x, _425.w), _460);
        float3 _464 = _462;
        _464.y = dot(float4(_425.y, _429.y, _432.y, _429.w), _460);
        float3 _466 = _464;
        _466.z = dot(float4(_425.z, _429.z, _432.zw), _460);
        _469 = fast::max(float3(0.0), _466) * float3(0.3183098733425140380859375);
    }
    else
    {
        _469 = float3(0.0);
    }
    float _495;
    float _496;
    float3 _497;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _485;
        float _486;
        if (_311)
        {
            _485 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _486 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _485 = _244;
            _486 = 1.0;
        }
        float _487 = 1.0 - _486;
        float _489 = 1.0 - (_487 * _487);
        _495 = mix(fast::clamp(dot(_485, _244), 0.0, 1.0), 1.0, _489);
        _496 = _486;
        _497 = mix(_485, _244, float3(_489));
    }
    else
    {
        _495 = 1.0;
        _496 = 1.0;
        _497 = _244;
    }
    float4 _501 = float4(_497, 1.0);
    float3 _505 = _160;
    _505.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _501);
    float3 _509 = _505;
    _509.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _501);
    float3 _513 = _509;
    _513.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _501);
    float4 _516 = _501.xyzz * _501.yzzx;
    float3 _520 = _160;
    _520.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _516);
    float3 _524 = _520;
    _524.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _516);
    float3 _528 = _524;
    _528.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _516);
    float3 _543 = (_469 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_513 + _528) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_497.x * _497.x) - (_497.y * _497.y)))) * View.View_SkyLightColor.xyz) * (_496 * _495));
    float3 _565 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _591;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _590;
        if (any(abs(_207 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _590 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_207, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _590 = _565;
        }
        _591 = _590;
    }
    else
    {
        _591 = _565;
    }
    float4 _598 = float4(((mix(float3(0.0), _391 + (_393 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_543 * _391) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _591) * 1.0, 0.0);
    float4 _605;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _604 = _598;
        _604.w = 0.0;
        _605 = _604;
    }
    else
    {
        _605 = _598;
    }
    float2 _610 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _618 = (_244 * 0.5) + float3(0.5);
    float4 _620 = float4(_618.x, _618.y, _618.z, float4(0.0).w);
    _620.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _621 = float4(0.0);
    _621.x = _298;
    float4 _622 = _621;
    _622.y = 0.5;
    float4 _623 = _622;
    _623.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _266.x)), _270), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _275.x)), _279), float3(0.100000001490116119384765625), _282).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _624 = _623;
    _624.w = 0.50588238239288330078125;
    float4 _636 = float4(_297.x, _297.y, _297.z, float4(0.0).w);
    _636.w = ((log2(((dot(_543, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_395 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_395 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_395 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_610.xyx * _610.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _605 * View.View_PreExposure;
    out.out_var_SV_Target1 = _620;
    out.out_var_SV_Target2 = _624;
    out.out_var_SV_Target3 = _636;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_364, 1.0, 1.0, 1.0);
    return out;
}

