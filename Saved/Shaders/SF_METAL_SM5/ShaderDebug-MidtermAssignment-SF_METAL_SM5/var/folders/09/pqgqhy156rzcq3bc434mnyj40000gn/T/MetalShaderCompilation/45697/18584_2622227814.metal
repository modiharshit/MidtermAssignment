

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
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float3 _164 = {};
constant float _166 = {};
constant float4 _167 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004898_9c4c0566(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(2)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _166, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    float4 _237 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _256 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _291 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _291) : (PrimitiveDither.PrimitiveDither_LODFactor < _291)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _302 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _303 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _304 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _305 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _310 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _311 = in.in_var_PRIMITIVE_ID * 36u;
    uint _312 = _311 + 20u;
    float _362;
    float _363;
    float _364;
    float3 _365;
    float3 _366;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _330 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _334 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _330, level(0.0));
        float4 _337 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _330, level(0.0));
        float4 _340 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _330, level(0.0));
        float _350 = _340.w;
        _362 = (_310 * _350) + _340.z;
        _363 = (_304 * _350) + _340.y;
        _364 = (_303 * _350) + _340.x;
        _365 = (_302 * _334.w) + _334.xyz;
        _366 = normalize((_256 * _337.w) + ((_337.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _362 = _310;
        _363 = _304;
        _364 = _303;
        _365 = _302;
        _366 = _256;
    }
    bool _376 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _382;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 18u)].w > 0.0) && _376)
    {
        _382 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _382 = 1.0;
    }
    float _429;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312)].z > 0.0)
    {
        float3 _397 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _408 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_397.x), int(_397.y), int(_397.z), 0).xyz), 0));
        _429 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_408.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_397 / float3(_408.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _429 = _382;
    }
    float3 _443 = ((_365 - (_365 * _364)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _450 = (mix(float3(0.07999999821186065673828125 * _363), _365, float3(_364)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _453 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _458;
    if (_453)
    {
        _458 = _443 + (_450 * 0.449999988079071044921875);
    }
    else
    {
        _458 = _443;
    }
    float3 _460 = select(_450, float3(0.0), bool3(_453));
    float3 _462 = float3(dot(_460, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _469 = float3(_305);
    float3 _537;
    if (_376)
    {
        float3 _489 = fast::clamp((_233 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _493 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _489);
        float4 _497 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _489);
        float4 _500 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _489);
        float4 _518 = _167;
        _518.y = (-0.48860299587249755859375) * _366.y;
        float4 _521 = _518;
        _521.z = 0.48860299587249755859375 * _366.z;
        float4 _524 = _521;
        _524.w = (-0.48860299587249755859375) * _366.x;
        float4 _525 = _524;
        _525.x = 0.886227548122406005859375;
        float3 _527 = _525.yzw * 2.094395160675048828125;
        float4 _528 = float4(_525.x, _527.x, _527.y, _527.z);
        float3 _530 = float3(0.0);
        _530.x = dot(float4(_493.x, _497.x, _500.x, _493.w), _528);
        float3 _532 = _530;
        _532.y = dot(float4(_493.y, _497.y, _500.y, _497.w), _528);
        float3 _534 = _532;
        _534.z = dot(float4(_493.z, _497.z, _500.zw), _528);
        _537 = fast::max(float3(0.0), _534) * float3(0.3183098733425140380859375);
    }
    else
    {
        _537 = float3(0.0);
    }
    float _563;
    float _564;
    float3 _565;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _553;
        float _554;
        if (_376)
        {
            _553 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _554 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _553 = _366;
            _554 = 1.0;
        }
        float _555 = 1.0 - _554;
        float _557 = 1.0 - (_555 * _555);
        _563 = mix(fast::clamp(dot(_553, _366), 0.0, 1.0), 1.0, _557);
        _564 = _554;
        _565 = mix(_553, _366, float3(_557));
    }
    else
    {
        _563 = 1.0;
        _564 = 1.0;
        _565 = _366;
    }
    float4 _569 = float4(_565, 1.0);
    float3 _573 = _164;
    _573.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _569);
    float3 _577 = _573;
    _577.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _569);
    float3 _581 = _577;
    _581.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _569);
    float4 _584 = _569.xyzz * _569.yzzx;
    float3 _588 = _164;
    _588.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _584);
    float3 _592 = _588;
    _592.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _584);
    float3 _596 = _592;
    _596.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _584);
    float3 _611 = (_537 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_581 + _596) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_565.x * _565.x) - (_565.y * _565.y)))) * View.View_SkyLightColor.xyz) * (_564 * _563));
    float3 _633 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _662;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _661;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311 + 19u)].xyz + float3(1.0))))
        {
            _661 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _661 = _633;
        }
        _662 = _661;
    }
    else
    {
        _662 = _633;
    }
    float4 _669 = float4(((mix(float3(0.0), _458 + (_460 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_611 * _458) * fast::max(_469, ((((((_365 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _305) + ((_365 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _305) + ((_365 * 2.755199909210205078125) + float3(0.69029998779296875))) * _305))) + _662) * 1.0, 0.0);
    float4 _676;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _675 = _669;
        _675.w = 0.0;
        _676 = _675;
    }
    else
    {
        _676 = _669;
    }
    float2 _680 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _688 = (_366 * 0.5) + float3(0.5);
    float4 _690 = float4(_688.x, _688.y, _688.z, float4(0.0).w);
    _690.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _312)].y;
    float4 _691 = float4(0.0);
    _691.x = _364;
    float4 _692 = _691;
    _692.y = _363;
    float4 _693 = _692;
    _693.z = _362;
    float4 _694 = _693;
    _694.w = 0.50588238239288330078125;
    float4 _706 = float4(_365.x, _365.y, _365.z, float4(0.0).w);
    _706.w = ((log2(((dot(_611, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_469, ((((((_462 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _305) + ((_462 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _305) + ((_462 * 2.755199909210205078125) + float3(0.69029998779296875))) * _305).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_680.xyx * _680.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _676 * View.View_PreExposure;
    out.out_var_SV_Target1 = _690;
    out.out_var_SV_Target2 = _694;
    out.out_var_SV_Target3 = _706;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_429, 1.0, 1.0, 1.0);
    return out;
}

