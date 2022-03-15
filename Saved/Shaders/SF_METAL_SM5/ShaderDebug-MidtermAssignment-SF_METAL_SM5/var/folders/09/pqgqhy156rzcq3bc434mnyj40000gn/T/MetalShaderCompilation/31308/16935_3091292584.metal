

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

fragment MainPS_out Main_00004227_b84161a8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
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
    float _289;
    float _290;
    float _291;
    float3 _292;
    float3 _293;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _258 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _262 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float _278 = _268.w;
        float _284 = 0.5 * _278;
        _289 = (_238 * _278) + _268.z;
        _290 = _284 + _268.y;
        _291 = _284 + _268.x;
        _292 = (_233 * _262.w) + _262.xyz;
        _293 = normalize((_220 * _265.w) + ((_265.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _289 = _238;
        _290 = 0.5;
        _291 = 0.5;
        _292 = _233;
        _293 = _220;
    }
    bool _303 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _309;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 18u)].w > 0.0) && _303)
    {
        _309 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _309 = 1.0;
    }
    float _356;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].z > 0.0)
    {
        float3 _324 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _335 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_324.x), int(_324.y), int(_324.z), 0).xyz), 0));
        _356 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_335.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_324 / float3(_335.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _356 = _309;
    }
    float3 _370 = ((_292 - (_292 * _291)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _377 = (mix(float3(0.07999999821186065673828125 * _290), _292, float3(_291)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _380 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _385;
    if (_380)
    {
        _385 = _370 + (_377 * 0.449999988079071044921875);
    }
    else
    {
        _385 = _370;
    }
    float3 _387 = select(_377, float3(0.0), bool3(_380));
    float3 _389 = float3(dot(_387, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _463;
    if (_303)
    {
        float3 _415 = fast::clamp((_212 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _419 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _415);
        float4 _423 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _415);
        float4 _426 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _415);
        float4 _444 = _149;
        _444.y = (-0.48860299587249755859375) * _293.y;
        float4 _447 = _444;
        _447.z = 0.48860299587249755859375 * _293.z;
        float4 _450 = _447;
        _450.w = (-0.48860299587249755859375) * _293.x;
        float4 _451 = _450;
        _451.x = 0.886227548122406005859375;
        float3 _453 = _451.yzw * 2.094395160675048828125;
        float4 _454 = float4(_451.x, _453.x, _453.y, _453.z);
        float3 _456 = float3(0.0);
        _456.x = dot(float4(_419.x, _423.x, _426.x, _419.w), _454);
        float3 _458 = _456;
        _458.y = dot(float4(_419.y, _423.y, _426.y, _423.w), _454);
        float3 _460 = _458;
        _460.z = dot(float4(_419.z, _423.z, _426.zw), _454);
        _463 = fast::max(float3(0.0), _460) * float3(0.3183098733425140380859375);
    }
    else
    {
        _463 = float3(0.0);
    }
    float _489;
    float _490;
    float3 _491;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _479;
        float _480;
        if (_303)
        {
            _479 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _480 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _479 = _293;
            _480 = 1.0;
        }
        float _481 = 1.0 - _480;
        float _483 = 1.0 - (_481 * _481);
        _489 = mix(fast::clamp(dot(_479, _293), 0.0, 1.0), 1.0, _483);
        _490 = _480;
        _491 = mix(_479, _293, float3(_483));
    }
    else
    {
        _489 = 1.0;
        _490 = 1.0;
        _491 = _293;
    }
    float4 _495 = float4(_491, 1.0);
    float3 _499 = _146;
    _499.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _495);
    float3 _503 = _499;
    _503.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _495);
    float3 _507 = _503;
    _507.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _495);
    float4 _510 = _495.xyzz * _495.yzzx;
    float3 _514 = _146;
    _514.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _510);
    float3 _518 = _514;
    _518.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _510);
    float3 _522 = _518;
    _522.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _510);
    float3 _537 = (_463 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_507 + _522) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_491.x * _491.x) - (_491.y * _491.y)))) * View.View_SkyLightColor.xyz) * (_490 * _489));
    float3 _559 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _588;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _587;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 19u)].xyz + float3(1.0))))
        {
            _587 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _587 = _559;
        }
        _588 = _587;
    }
    else
    {
        _588 = _559;
    }
    float4 _595 = float4(((mix(float3(0.0), _385 + (_387 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_537 * _385) * fast::max(float3(1.0), ((((((_292 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_292 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_292 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _588) * 1.0, 0.0);
    float4 _602;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _601 = _595;
        _601.w = 0.0;
        _602 = _601;
    }
    else
    {
        _602 = _595;
    }
    float2 _606 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _614 = (_293 * 0.5) + float3(0.5);
    float4 _616 = float4(_614.x, _614.y, _614.z, float4(0.0).w);
    _616.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].y;
    float4 _617 = float4(0.0);
    _617.x = _291;
    float4 _618 = _617;
    _618.y = _290;
    float4 _619 = _618;
    _619.z = _289;
    float4 _620 = _619;
    _620.w = 0.50588238239288330078125;
    float4 _632 = float4(_292.x, _292.y, _292.z, float4(0.0).w);
    _632.w = ((log2(((dot(_537, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_389 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_389 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_389 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_606.xyx * _606.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _602 * View.View_PreExposure;
    out.out_var_SV_Target1 = _616;
    out.out_var_SV_Target2 = _620;
    out.out_var_SV_Target3 = _632;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_356, 1.0, 1.0, 1.0);
    return out;
}

