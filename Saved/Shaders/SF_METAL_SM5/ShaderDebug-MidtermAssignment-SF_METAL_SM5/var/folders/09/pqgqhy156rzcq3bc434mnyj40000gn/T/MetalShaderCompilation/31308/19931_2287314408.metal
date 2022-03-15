

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

constant float3 _169 = {};
constant float4 _171 = {};

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

fragment MainPS_out Main_00004ddb_8855a5e8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _288;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _288 = _231.w;
                break;
            }
            else
            {
                float _272 = _231.z;
                _288 = ((_272 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_272 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _304 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _261.x) + _288) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _316 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _321 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _326 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _330 = (_316.x + 0.5) * ((_321.x + 0.5) * (_326.x + 0.5));
    float4 _336 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _342 = fast::clamp(mix(float3(0.300000011920928955078125), float3(1.0), float3(_330)) * _336.xyz, float3(0.0), float3(1.0));
    float _347 = (fast::clamp(mix(0.5, 0.20000000298023223876953125, _330 * _336.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _348 = in.in_var_PRIMITIVE_ID * 36u;
    uint _349 = _348 + 20u;
    float _397;
    float _398;
    float _399;
    float3 _400;
    float3 _401;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _367 = ((_231.xy / float2(_231.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _371 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float4 _374 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float4 _377 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float _387 = _377.w;
        _397 = (_347 * _387) + _377.z;
        _398 = (0.5 * _387) + _377.y;
        _399 = _377.x;
        _400 = (_342 * _371.w) + _371.xyz;
        _401 = normalize((_304 * _374.w) + ((_374.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _397 = _347;
        _398 = 0.5;
        _399 = 0.0;
        _400 = _342;
        _401 = _304;
    }
    bool _411 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _417;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348 + 18u)].w > 0.0) && _411)
    {
        _417 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _417 = 1.0;
    }
    float _464;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349)].z > 0.0)
    {
        float3 _432 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _443 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_432.x), int(_432.y), int(_432.z), 0).xyz), 0));
        _464 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_443.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_432 / float3(_443.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _464 = _417;
    }
    float3 _478 = ((_400 - (_400 * _399)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _485 = (mix(float3(0.07999999821186065673828125 * _398), _400, float3(_399)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _488 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _493;
    if (_488)
    {
        _493 = _478 + (_485 * 0.449999988079071044921875);
    }
    else
    {
        _493 = _478;
    }
    float3 _495 = select(_485, float3(0.0), bool3(_488));
    float3 _497 = float3(dot(_495, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _571;
    if (_411)
    {
        float3 _523 = fast::clamp((_240 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _527 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _523);
        float4 _531 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _523);
        float4 _534 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _523);
        float4 _552 = _171;
        _552.y = (-0.48860299587249755859375) * _401.y;
        float4 _555 = _552;
        _555.z = 0.48860299587249755859375 * _401.z;
        float4 _558 = _555;
        _558.w = (-0.48860299587249755859375) * _401.x;
        float4 _559 = _558;
        _559.x = 0.886227548122406005859375;
        float3 _561 = _559.yzw * 2.094395160675048828125;
        float4 _562 = float4(_559.x, _561.x, _561.y, _561.z);
        float3 _564 = float3(0.0);
        _564.x = dot(float4(_527.x, _531.x, _534.x, _527.w), _562);
        float3 _566 = _564;
        _566.y = dot(float4(_527.y, _531.y, _534.y, _531.w), _562);
        float3 _568 = _566;
        _568.z = dot(float4(_527.z, _531.z, _534.zw), _562);
        _571 = fast::max(float3(0.0), _568) * float3(0.3183098733425140380859375);
    }
    else
    {
        _571 = float3(0.0);
    }
    float _597;
    float _598;
    float3 _599;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _587;
        float _588;
        if (_411)
        {
            _587 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _588 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _587 = _401;
            _588 = 1.0;
        }
        float _589 = 1.0 - _588;
        float _591 = 1.0 - (_589 * _589);
        _597 = mix(fast::clamp(dot(_587, _401), 0.0, 1.0), 1.0, _591);
        _598 = _588;
        _599 = mix(_587, _401, float3(_591));
    }
    else
    {
        _597 = 1.0;
        _598 = 1.0;
        _599 = _401;
    }
    float4 _603 = float4(_599, 1.0);
    float3 _607 = _169;
    _607.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _603);
    float3 _611 = _607;
    _611.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _603);
    float3 _615 = _611;
    _615.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _603);
    float4 _618 = _603.xyzz * _603.yzzx;
    float3 _622 = _169;
    _622.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _618);
    float3 _626 = _622;
    _626.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _618);
    float3 _630 = _626;
    _630.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _618);
    float3 _645 = (_571 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_615 + _630) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_599.x * _599.x) - (_599.y * _599.y)))) * View.View_SkyLightColor.xyz) * (_598 * _597));
    float3 _667 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _696;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _695;
        if (any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348 + 19u)].xyz + float3(1.0))))
        {
            _695 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _695 = _667;
        }
        _696 = _695;
    }
    else
    {
        _696 = _667;
    }
    float4 _703 = float4(((mix(float3(0.0), _493 + (_495 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_645 * _493) * fast::max(float3(1.0), ((((((_400 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_400 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_400 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _696) * 1.0, 0.0);
    float4 _710;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _709 = _703;
        _709.w = 0.0;
        _710 = _709;
    }
    else
    {
        _710 = _703;
    }
    float2 _714 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _722 = (_401 * 0.5) + float3(0.5);
    float4 _724 = float4(_722.x, _722.y, _722.z, float4(0.0).w);
    _724.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349)].y;
    float4 _725 = float4(0.0);
    _725.x = _399;
    float4 _726 = _725;
    _726.y = _398;
    float4 _727 = _726;
    _727.z = _397;
    float4 _728 = _727;
    _728.w = 0.50588238239288330078125;
    float4 _740 = float4(_400.x, _400.y, _400.z, float4(0.0).w);
    _740.w = ((log2(((dot(_645, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_497 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_497 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_497 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_714.xyx * _714.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _710 * View.View_PreExposure;
    out.out_var_SV_Target1 = _724;
    out.out_var_SV_Target2 = _728;
    out.out_var_SV_Target3 = _740;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_464, 1.0, 1.0, 1.0);
    return out;
}

