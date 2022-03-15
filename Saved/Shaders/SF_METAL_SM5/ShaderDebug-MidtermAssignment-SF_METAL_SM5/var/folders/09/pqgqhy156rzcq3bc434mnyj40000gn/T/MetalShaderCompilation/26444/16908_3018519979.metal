

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

constant float3 _146 = {};
constant float _148 = {};
constant float4 _149 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000420c_b3eaf5ab(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _220 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _233 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _238 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _239 = in.in_var_PRIMITIVE_ID * 36u;
    uint _240 = _239 + 20u;
    float _288;
    float _289;
    float _290;
    float3 _291;
    float3 _292;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _258 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _262 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float _278 = _268.w;
        _288 = (_238 * _278) + _268.z;
        _289 = (0.5 * _278) + _268.y;
        _290 = _268.x;
        _291 = (_233 * _262.w) + _262.xyz;
        _292 = normalize((_220 * _265.w) + ((_265.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _288 = _238;
        _289 = 0.5;
        _290 = 0.0;
        _291 = _233;
        _292 = _220;
    }
    bool _302 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _308;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 18u)].w > 0.0) && _302)
    {
        _308 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _308 = 1.0;
    }
    float _355;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].z > 0.0)
    {
        float3 _323 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _334 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_323.x), int(_323.y), int(_323.z), 0).xyz), 0));
        _355 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_334.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_323 / float3(_334.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _355 = _308;
    }
    float3 _369 = ((_291 - (_291 * _290)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _376 = (mix(float3(0.07999999821186065673828125 * _289), _291, float3(_290)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _379 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _384;
    if (_379)
    {
        _384 = _369 + (_376 * 0.449999988079071044921875);
    }
    else
    {
        _384 = _369;
    }
    float3 _386 = select(_376, float3(0.0), bool3(_379));
    float3 _388 = float3(dot(_386, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _462;
    if (_302)
    {
        float3 _414 = fast::clamp((_212 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _418 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _414);
        float4 _422 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _414);
        float4 _425 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _414);
        float4 _443 = _149;
        _443.y = (-0.48860299587249755859375) * _292.y;
        float4 _446 = _443;
        _446.z = 0.48860299587249755859375 * _292.z;
        float4 _449 = _446;
        _449.w = (-0.48860299587249755859375) * _292.x;
        float4 _450 = _449;
        _450.x = 0.886227548122406005859375;
        float3 _452 = _450.yzw * 2.094395160675048828125;
        float4 _453 = float4(_450.x, _452.x, _452.y, _452.z);
        float3 _455 = float3(0.0);
        _455.x = dot(float4(_418.x, _422.x, _425.x, _418.w), _453);
        float3 _457 = _455;
        _457.y = dot(float4(_418.y, _422.y, _425.y, _422.w), _453);
        float3 _459 = _457;
        _459.z = dot(float4(_418.z, _422.z, _425.zw), _453);
        _462 = fast::max(float3(0.0), _459) * float3(0.3183098733425140380859375);
    }
    else
    {
        _462 = float3(0.0);
    }
    float _488;
    float _489;
    float3 _490;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _478;
        float _479;
        if (_302)
        {
            _478 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _479 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _478 = _292;
            _479 = 1.0;
        }
        float _480 = 1.0 - _479;
        float _482 = 1.0 - (_480 * _480);
        _488 = mix(fast::clamp(dot(_478, _292), 0.0, 1.0), 1.0, _482);
        _489 = _479;
        _490 = mix(_478, _292, float3(_482));
    }
    else
    {
        _488 = 1.0;
        _489 = 1.0;
        _490 = _292;
    }
    float4 _494 = float4(_490, 1.0);
    float3 _498 = _146;
    _498.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _494);
    float3 _502 = _498;
    _502.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _494);
    float3 _506 = _502;
    _506.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _494);
    float4 _509 = _494.xyzz * _494.yzzx;
    float3 _513 = _146;
    _513.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _509);
    float3 _517 = _513;
    _517.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _509);
    float3 _521 = _517;
    _521.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _509);
    float3 _536 = (_462 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_506 + _521) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_490.x * _490.x) - (_490.y * _490.y)))) * View.View_SkyLightColor.xyz) * (_489 * _488));
    float3 _558 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _587;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _586;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 19u)].xyz + float3(1.0))))
        {
            _586 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _586 = _558;
        }
        _587 = _586;
    }
    else
    {
        _587 = _558;
    }
    float4 _594 = float4(((mix(float3(0.0), _384 + (_386 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_536 * _384) * fast::max(float3(1.0), ((((((_291 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_291 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_291 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _587) * 1.0, 0.0);
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
    float2 _605 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _613 = (_292 * 0.5) + float3(0.5);
    float4 _615 = float4(_613.x, _613.y, _613.z, float4(0.0).w);
    _615.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].y;
    float4 _616 = float4(0.0);
    _616.x = _290;
    float4 _617 = _616;
    _617.y = _289;
    float4 _618 = _617;
    _618.z = _288;
    float4 _619 = _618;
    _619.w = 0.50588238239288330078125;
    float4 _631 = float4(_291.x, _291.y, _291.z, float4(0.0).w);
    _631.w = ((log2(((dot(_536, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_605.xyx * _605.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _601 * View.View_PreExposure;
    out.out_var_SV_Target1 = _615;
    out.out_var_SV_Target2 = _619;
    out.out_var_SV_Target3 = _631;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_355, 1.0, 1.0, 1.0);
    return out;
}

