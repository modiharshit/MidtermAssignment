

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[124];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _147 = {};
constant float _149 = {};
constant float4 _150 = {};

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

fragment MainPS_out Main_00003e09_98003e8c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float3 _217 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _225 = in.in_var_PRIMITIVE_ID * 36u;
    uint _226 = _225 + 20u;
    float _273;
    float _274;
    float _275;
    float3 _276;
    float3 _277;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _244 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _248 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float4 _251 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float4 _254 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _244, level(0.0));
        float _264 = _254.w;
        _273 = _264 + _254.z;
        _274 = (0.5 * _264) + _254.y;
        _275 = _254.x;
        _276 = (float3(0.180000007152557373046875) * _248.w) + _248.xyz;
        _277 = normalize((_217 * _251.w) + ((_251.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _273 = 1.0;
        _274 = 0.5;
        _275 = 0.0;
        _276 = float3(0.180000007152557373046875);
        _277 = _217;
    }
    bool _287 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _293;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _225 + 18u)].w > 0.0) && _287)
    {
        _293 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _293 = 1.0;
    }
    float _340;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226)].z > 0.0)
    {
        float3 _308 = fast::clamp((_209 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _319 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_308.x), int(_308.y), int(_308.z), 0).xyz), 0));
        _340 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_319.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_308 / float3(_319.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _340 = _293;
    }
    float3 _363 = (((_276 - (_276 * _275)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _274), _276, float3(_275)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float3 _424;
    if (_287)
    {
        float3 _376 = fast::clamp((_209 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _380 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _376);
        float4 _384 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _376);
        float4 _387 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _376);
        float4 _405 = _150;
        _405.y = (-0.48860299587249755859375) * _277.y;
        float4 _408 = _405;
        _408.z = 0.48860299587249755859375 * _277.z;
        float4 _411 = _408;
        _411.w = (-0.48860299587249755859375) * _277.x;
        float4 _412 = _411;
        _412.x = 0.886227548122406005859375;
        float3 _414 = _412.yzw * 2.094395160675048828125;
        float4 _415 = float4(_412.x, _414.x, _414.y, _414.z);
        float3 _417 = float3(0.0);
        _417.x = dot(float4(_380.x, _384.x, _387.x, _380.w), _415);
        float3 _419 = _417;
        _419.y = dot(float4(_380.y, _384.y, _387.y, _384.w), _415);
        float3 _421 = _419;
        _421.z = dot(float4(_380.z, _384.z, _387.zw), _415);
        _424 = fast::max(float3(0.0), _421) * float3(0.3183098733425140380859375);
    }
    else
    {
        _424 = float3(0.0);
    }
    float _450;
    float _451;
    float3 _452;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _440;
        float _441;
        if (_287)
        {
            _440 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _441 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _440 = _277;
            _441 = 1.0;
        }
        float _442 = 1.0 - _441;
        float _444 = 1.0 - (_442 * _442);
        _450 = mix(fast::clamp(dot(_440, _277), 0.0, 1.0), 1.0, _444);
        _451 = _441;
        _452 = mix(_440, _277, float3(_444));
    }
    else
    {
        _450 = 1.0;
        _451 = 1.0;
        _452 = _277;
    }
    float4 _456 = float4(_452, 1.0);
    float3 _460 = _147;
    _460.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _456);
    float3 _464 = _460;
    _464.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _456);
    float3 _468 = _464;
    _468.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _456);
    float4 _471 = _456.xyzz * _456.yzzx;
    float3 _475 = _147;
    _475.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _471);
    float3 _479 = _475;
    _479.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _471);
    float3 _483 = _479;
    _483.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _471);
    float3 _498 = (_424 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_468 + _483) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_452.x * _452.x) - (_452.y * _452.y)))) * View.View_SkyLightColor.xyz) * (_451 * _450));
    float3 _518 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _547;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _546;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _225 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _225 + 19u)].xyz + float3(1.0))))
        {
            _546 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _546 = _518;
        }
        _547 = _546;
    }
    else
    {
        _547 = _518;
    }
    float4 _554 = float4(((mix(float3(0.0), _363, float3(View.View_UnlitViewmodeMask)) + ((_498 * _363) * fast::max(float3(1.0), ((((((_276 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_276 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_276 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _547) * 1.0, 0.0);
    float4 _561;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _560 = _554;
        _560.w = 0.0;
        _561 = _560;
    }
    else
    {
        _561 = _554;
    }
    float2 _565 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _573 = (_277 * 0.5) + float3(0.5);
    float4 _575 = float4(_573.x, _573.y, _573.z, float4(0.0).w);
    _575.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _226)].y;
    float4 _576 = float4(0.0);
    _576.x = _275;
    float4 _577 = _576;
    _577.y = _274;
    float4 _578 = _577;
    _578.z = _273;
    float4 _579 = _578;
    _579.w = 0.50588238239288330078125;
    float4 _590 = float4(_276.x, _276.y, _276.z, float4(0.0).w);
    _590.w = ((log2((dot(_498, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_565.xyx * _565.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _561 * View.View_PreExposure;
    out.out_var_SV_Target1 = _575;
    out.out_var_SV_Target2 = _579;
    out.out_var_SV_Target3 = _590;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_340, 1.0, 1.0, 1.0);
    return out;
}

