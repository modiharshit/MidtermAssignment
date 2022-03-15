

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

constant float3 _165 = {};
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

fragment MainPS_out Main_00004be7_47414d87(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = (_231.xyz / float3(_231.w)) - View.View_PreViewTranslation;
    float2 _237 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _285;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _285 = _227.w;
                break;
            }
            else
            {
                float _269 = _227.z;
                _285 = ((_269 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_269 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _290 = fast::min(fast::max(((mix(-2000.0, 2000.0, _258.x) + _285) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _301 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_290)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _312 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float4 _316 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float3 _322 = fast::clamp(_312.xyz, float3(0.0), float3(1.0));
    float _323 = fast::clamp(_312.x, 0.0, 1.0);
    float _324 = fast::clamp(_316.w, 0.0, 1.0);
    float _329 = (fast::clamp(mix(_316.x, 0.300000011920928955078125, _290), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _330 = in.in_var_PRIMITIVE_ID * 36u;
    uint _331 = _330 + 20u;
    float _379;
    float _380;
    float _381;
    float3 _382;
    float3 _383;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _331)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _349 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _353 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _349, level(0.0));
        float4 _356 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _349, level(0.0));
        float4 _359 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _349, level(0.0));
        float _369 = _359.w;
        _379 = (_329 * _369) + _359.z;
        _380 = (_323 * _369) + _359.y;
        _381 = _359.x;
        _382 = (_322 * _353.w) + _353.xyz;
        _383 = normalize((_301 * _356.w) + ((_356.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _379 = _329;
        _380 = _323;
        _381 = 0.0;
        _382 = _322;
        _383 = _301;
    }
    bool _393 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _399;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _330 + 18u)].w > 0.0) && _393)
    {
        _399 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _399 = 1.0;
    }
    float _446;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _331)].z > 0.0)
    {
        float3 _414 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _425 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_414.x), int(_414.y), int(_414.z), 0).xyz), 0));
        _446 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_425.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_414 / float3(_425.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _446 = _399;
    }
    float3 _460 = ((_382 - (_382 * _381)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _467 = (mix(float3(0.07999999821186065673828125 * _380), _382, float3(_381)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _470 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _475;
    if (_470)
    {
        _475 = _460 + (_467 * 0.449999988079071044921875);
    }
    else
    {
        _475 = _460;
    }
    float3 _477 = select(_467, float3(0.0), bool3(_470));
    float3 _479 = float3(dot(_477, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _486 = float3(_324);
    float3 _554;
    if (_393)
    {
        float3 _506 = fast::clamp((_236 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _510 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _506);
        float4 _514 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _506);
        float4 _517 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _506);
        float4 _535 = _167;
        _535.y = (-0.48860299587249755859375) * _383.y;
        float4 _538 = _535;
        _538.z = 0.48860299587249755859375 * _383.z;
        float4 _541 = _538;
        _541.w = (-0.48860299587249755859375) * _383.x;
        float4 _542 = _541;
        _542.x = 0.886227548122406005859375;
        float3 _544 = _542.yzw * 2.094395160675048828125;
        float4 _545 = float4(_542.x, _544.x, _544.y, _544.z);
        float3 _547 = float3(0.0);
        _547.x = dot(float4(_510.x, _514.x, _517.x, _510.w), _545);
        float3 _549 = _547;
        _549.y = dot(float4(_510.y, _514.y, _517.y, _514.w), _545);
        float3 _551 = _549;
        _551.z = dot(float4(_510.z, _514.z, _517.zw), _545);
        _554 = fast::max(float3(0.0), _551) * float3(0.3183098733425140380859375);
    }
    else
    {
        _554 = float3(0.0);
    }
    float _580;
    float _581;
    float3 _582;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _570;
        float _571;
        if (_393)
        {
            _570 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _571 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _570 = _383;
            _571 = 1.0;
        }
        float _572 = 1.0 - _571;
        float _574 = 1.0 - (_572 * _572);
        _580 = mix(fast::clamp(dot(_570, _383), 0.0, 1.0), 1.0, _574);
        _581 = _571;
        _582 = mix(_570, _383, float3(_574));
    }
    else
    {
        _580 = 1.0;
        _581 = 1.0;
        _582 = _383;
    }
    float4 _586 = float4(_582, 1.0);
    float3 _590 = _165;
    _590.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _586);
    float3 _594 = _590;
    _594.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _586);
    float3 _598 = _594;
    _598.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _586);
    float4 _601 = _586.xyzz * _586.yzzx;
    float3 _605 = _165;
    _605.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _601);
    float3 _609 = _605;
    _609.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _601);
    float3 _613 = _609;
    _613.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _601);
    float3 _628 = (_554 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_598 + _613) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_582.x * _582.x) - (_582.y * _582.y)))) * View.View_SkyLightColor.xyz) * (_581 * _580));
    float3 _650 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _679;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _678;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _330 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _330 + 19u)].xyz + float3(1.0))))
        {
            _678 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _678 = _650;
        }
        _679 = _678;
    }
    else
    {
        _679 = _650;
    }
    float4 _686 = float4(((mix(float3(0.0), _475 + (_477 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_628 * _475) * fast::max(_486, ((((((_382 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _324) + ((_382 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _324) + ((_382 * 2.755199909210205078125) + float3(0.69029998779296875))) * _324))) + _679) * 1.0, 0.0);
    float4 _693;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _692 = _686;
        _692.w = 0.0;
        _693 = _692;
    }
    else
    {
        _693 = _686;
    }
    float2 _697 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _705 = (_383 * 0.5) + float3(0.5);
    float4 _707 = float4(_705.x, _705.y, _705.z, float4(0.0).w);
    _707.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _331)].y;
    float4 _708 = float4(0.0);
    _708.x = _381;
    float4 _709 = _708;
    _709.y = _380;
    float4 _710 = _709;
    _710.z = _379;
    float4 _711 = _710;
    _711.w = 0.50588238239288330078125;
    float4 _723 = float4(_382.x, _382.y, _382.z, float4(0.0).w);
    _723.w = ((log2(((dot(_628, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_486, ((((((_479 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _324) + ((_479 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _324) + ((_479 * 2.755199909210205078125) + float3(0.69029998779296875))) * _324).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_697.xyx * _697.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _693 * View.View_PreExposure;
    out.out_var_SV_Target1 = _707;
    out.out_var_SV_Target2 = _711;
    out.out_var_SV_Target3 = _723;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_446, 1.0, 1.0, 1.0);
    return out;
}

