

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

fragment MainPS_out Main_00004f15_71002bed(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
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
    float2 _259 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float _290;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _290 = _231.w;
                break;
            }
            else
            {
                float _274 = _231.z;
                _290 = ((_274 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_274 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _296 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _263.x) + _290) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _305 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _296) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _317 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _320 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _329 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _330 = _329.x;
    float _334 = _329.y;
    float _338 = _329.z;
    float4 _344 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float _345 = _344.x;
    float _349 = _344.y;
    float _353 = _344.z;
    float3 _361 = fast::min(fast::max(mix(float3((_330 <= 0.0) ? 0.0 : pow(_330, 2.0), (_334 <= 0.0) ? 0.0 : pow(_334, 2.0), (_338 <= 0.0) ? 0.0 : pow(_338, 2.0)), float3((_345 <= 0.0) ? 0.0 : pow(_345, 2.0), (_349 <= 0.0) ? 0.0 : pow(_349, 2.0), (_353 <= 0.0) ? 0.0 : pow(_353, 2.0)), _296) * fast::min(fast::max(1.0 - (_317.x * _320.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _366 = fast::clamp(mix(_361, float3(dot(_361, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _368 = in.in_var_PRIMITIVE_ID * 36u;
    uint _369 = _368 + 20u;
    float _417;
    float _418;
    float _419;
    float3 _420;
    float3 _421;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _387 = ((_231.xy / float2(_231.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _391 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _387, level(0.0));
        float4 _394 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _387, level(0.0));
        float4 _397 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _387, level(0.0));
        float _407 = _397.w;
        _417 = (View.View_RoughnessOverrideParameter.x * _407) + _397.z;
        _418 = (0.5 * _407) + _397.y;
        _419 = _397.x;
        _420 = (_366 * _391.w) + _391.xyz;
        _421 = normalize((_305 * _394.w) + ((_394.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _417 = View.View_RoughnessOverrideParameter.x;
        _418 = 0.5;
        _419 = 0.0;
        _420 = _366;
        _421 = _305;
    }
    bool _431 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _437;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368 + 18u)].w > 0.0) && _431)
    {
        _437 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _437 = 1.0;
    }
    float _484;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369)].z > 0.0)
    {
        float3 _452 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _463 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_452.x), int(_452.y), int(_452.z), 0).xyz), 0));
        _484 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_463.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_452 / float3(_463.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _484 = _437;
    }
    float3 _498 = ((_420 - (_420 * _419)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _505 = (mix(float3(0.07999999821186065673828125 * _418), _420, float3(_419)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _508 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _513;
    if (_508)
    {
        _513 = _498 + (_505 * 0.449999988079071044921875);
    }
    else
    {
        _513 = _498;
    }
    float3 _515 = select(_505, float3(0.0), bool3(_508));
    float3 _517 = float3(dot(_515, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _591;
    if (_431)
    {
        float3 _543 = fast::clamp((_240 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _547 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _543);
        float4 _551 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _543);
        float4 _554 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _543);
        float4 _572 = _171;
        _572.y = (-0.48860299587249755859375) * _421.y;
        float4 _575 = _572;
        _575.z = 0.48860299587249755859375 * _421.z;
        float4 _578 = _575;
        _578.w = (-0.48860299587249755859375) * _421.x;
        float4 _579 = _578;
        _579.x = 0.886227548122406005859375;
        float3 _581 = _579.yzw * 2.094395160675048828125;
        float4 _582 = float4(_579.x, _581.x, _581.y, _581.z);
        float3 _584 = float3(0.0);
        _584.x = dot(float4(_547.x, _551.x, _554.x, _547.w), _582);
        float3 _586 = _584;
        _586.y = dot(float4(_547.y, _551.y, _554.y, _551.w), _582);
        float3 _588 = _586;
        _588.z = dot(float4(_547.z, _551.z, _554.zw), _582);
        _591 = fast::max(float3(0.0), _588) * float3(0.3183098733425140380859375);
    }
    else
    {
        _591 = float3(0.0);
    }
    float _617;
    float _618;
    float3 _619;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _607;
        float _608;
        if (_431)
        {
            _607 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _608 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _607 = _421;
            _608 = 1.0;
        }
        float _609 = 1.0 - _608;
        float _611 = 1.0 - (_609 * _609);
        _617 = mix(fast::clamp(dot(_607, _421), 0.0, 1.0), 1.0, _611);
        _618 = _608;
        _619 = mix(_607, _421, float3(_611));
    }
    else
    {
        _617 = 1.0;
        _618 = 1.0;
        _619 = _421;
    }
    float4 _623 = float4(_619, 1.0);
    float3 _627 = _169;
    _627.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _623);
    float3 _631 = _627;
    _631.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _623);
    float3 _635 = _631;
    _635.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _623);
    float4 _638 = _623.xyzz * _623.yzzx;
    float3 _642 = _169;
    _642.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _638);
    float3 _646 = _642;
    _646.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _638);
    float3 _650 = _646;
    _650.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _638);
    float3 _665 = (_591 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_635 + _650) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_619.x * _619.x) - (_619.y * _619.y)))) * View.View_SkyLightColor.xyz) * (_618 * _617));
    float3 _687 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _716;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _715;
        if (any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368 + 19u)].xyz + float3(1.0))))
        {
            _715 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _715 = _687;
        }
        _716 = _715;
    }
    else
    {
        _716 = _687;
    }
    float4 _723 = float4(((mix(float3(0.0), _513 + (_515 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_665 * _513) * fast::max(float3(1.0), ((((((_420 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_420 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_420 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _716) * 1.0, 0.0);
    float4 _730;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _729 = _723;
        _729.w = 0.0;
        _730 = _729;
    }
    else
    {
        _730 = _723;
    }
    float2 _734 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _742 = (_421 * 0.5) + float3(0.5);
    float4 _744 = float4(_742.x, _742.y, _742.z, float4(0.0).w);
    _744.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369)].y;
    float4 _745 = float4(0.0);
    _745.x = _419;
    float4 _746 = _745;
    _746.y = _418;
    float4 _747 = _746;
    _747.z = _417;
    float4 _748 = _747;
    _748.w = 0.50588238239288330078125;
    float4 _760 = float4(_420.x, _420.y, _420.z, float4(0.0).w);
    _760.w = ((log2(((dot(_665, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_517 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_517 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_517 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_734.xyx * _734.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _730 * View.View_PreExposure;
    out.out_var_SV_Target1 = _744;
    out.out_var_SV_Target2 = _748;
    out.out_var_SV_Target3 = _760;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_484, 1.0, 1.0, 1.0);
    return out;
}

