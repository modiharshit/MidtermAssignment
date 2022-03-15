

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _172 = {};
constant float4 _174 = {};

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

fragment MainPS_out Main_00004f2a_7e21903e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], texture2d<float> Material_Texture2D_4 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], sampler Material_Texture2D_4Sampler [[sampler(7)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float2 _244 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float2 _253 = (_250.xy * float2(2.0)) - float2(1.0);
    float3 _269 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_253, sqrt(fast::clamp(1.0 - dot(_253, _253), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_244 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _284 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _289 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_284 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _294 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_284 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _321;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _321 = _234.w;
                break;
            }
            else
            {
                float _305 = _234.z;
                _321 = ((_305 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_305 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _329 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _332 = mix(_289.x + 0.5, _294.x + 0.5, fast::min(fast::max((_321 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_329.x + 0.5);
    float4 _337 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float4 _350 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float3 _356 = fast::clamp(fast::min(fast::max(((_337.xyz * mix(0.60000002384185791015625, 1.0, _332)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _281.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _357 = fast::clamp(_350.y, 0.0, 1.0);
    float _362 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _350.x + (_332 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _363 = in.in_var_PRIMITIVE_ID * 36u;
    uint _364 = _363 + 20u;
    float _412;
    float _413;
    float _414;
    float3 _415;
    float3 _416;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _382 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _386 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _392 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float _402 = _392.w;
        _412 = (_362 * _402) + _392.z;
        _413 = (0.5 * _402) + _392.y;
        _414 = _392.x;
        _415 = (_356 * _386.w) + _386.xyz;
        _416 = normalize((_269 * _389.w) + ((_389.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _412 = _362;
        _413 = 0.5;
        _414 = 0.0;
        _415 = _356;
        _416 = _269;
    }
    bool _426 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _432;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363 + 18u)].w > 0.0) && _426)
    {
        _432 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _432 = 1.0;
    }
    float _479;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364)].z > 0.0)
    {
        float3 _447 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _458 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_447.x), int(_447.y), int(_447.z), 0).xyz), 0));
        _479 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_458.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_447 / float3(_458.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _479 = _432;
    }
    float3 _493 = ((_415 - (_415 * _414)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _500 = (mix(float3(0.07999999821186065673828125 * _413), _415, float3(_414)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _503 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _508;
    if (_503)
    {
        _508 = _493 + (_500 * 0.449999988079071044921875);
    }
    else
    {
        _508 = _493;
    }
    float3 _510 = select(_500, float3(0.0), bool3(_503));
    float3 _512 = float3(dot(_510, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _519 = float3(_357);
    float3 _587;
    if (_426)
    {
        float3 _539 = fast::clamp((_243 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _543 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _539);
        float4 _547 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _539);
        float4 _550 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _539);
        float4 _568 = _174;
        _568.y = (-0.48860299587249755859375) * _416.y;
        float4 _571 = _568;
        _571.z = 0.48860299587249755859375 * _416.z;
        float4 _574 = _571;
        _574.w = (-0.48860299587249755859375) * _416.x;
        float4 _575 = _574;
        _575.x = 0.886227548122406005859375;
        float3 _577 = _575.yzw * 2.094395160675048828125;
        float4 _578 = float4(_575.x, _577.x, _577.y, _577.z);
        float3 _580 = float3(0.0);
        _580.x = dot(float4(_543.x, _547.x, _550.x, _543.w), _578);
        float3 _582 = _580;
        _582.y = dot(float4(_543.y, _547.y, _550.y, _547.w), _578);
        float3 _584 = _582;
        _584.z = dot(float4(_543.z, _547.z, _550.zw), _578);
        _587 = fast::max(float3(0.0), _584) * float3(0.3183098733425140380859375);
    }
    else
    {
        _587 = float3(0.0);
    }
    float _613;
    float _614;
    float3 _615;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _603;
        float _604;
        if (_426)
        {
            _603 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _604 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _603 = _416;
            _604 = 1.0;
        }
        float _605 = 1.0 - _604;
        float _607 = 1.0 - (_605 * _605);
        _613 = mix(fast::clamp(dot(_603, _416), 0.0, 1.0), 1.0, _607);
        _614 = _604;
        _615 = mix(_603, _416, float3(_607));
    }
    else
    {
        _613 = 1.0;
        _614 = 1.0;
        _615 = _416;
    }
    float4 _619 = float4(_615, 1.0);
    float3 _623 = _172;
    _623.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _619);
    float3 _627 = _623;
    _627.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _619);
    float3 _631 = _627;
    _631.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _619);
    float4 _634 = _619.xyzz * _619.yzzx;
    float3 _638 = _172;
    _638.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _634);
    float3 _642 = _638;
    _642.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _634);
    float3 _646 = _642;
    _646.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _634);
    float3 _661 = (_587 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_631 + _646) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_615.x * _615.x) - (_615.y * _615.y)))) * View.View_SkyLightColor.xyz) * (_614 * _613));
    float3 _683 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _712;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _711;
        if (any(abs(_243 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363 + 19u)].xyz + float3(1.0))))
        {
            _711 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _711 = _683;
        }
        _712 = _711;
    }
    else
    {
        _712 = _683;
    }
    float4 _719 = float4(((mix(float3(0.0), _508 + (_510 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_661 * _508) * fast::max(_519, ((((((_415 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _357) + ((_415 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _357) + ((_415 * 2.755199909210205078125) + float3(0.69029998779296875))) * _357))) + _712) * 1.0, 0.0);
    float4 _726;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _725 = _719;
        _725.w = 0.0;
        _726 = _725;
    }
    else
    {
        _726 = _719;
    }
    float2 _730 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _738 = (_416 * 0.5) + float3(0.5);
    float4 _740 = float4(_738.x, _738.y, _738.z, float4(0.0).w);
    _740.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _364)].y;
    float4 _741 = float4(0.0);
    _741.x = _414;
    float4 _742 = _741;
    _742.y = _413;
    float4 _743 = _742;
    _743.z = _412;
    float4 _744 = _743;
    _744.w = 0.50588238239288330078125;
    float4 _756 = float4(_415.x, _415.y, _415.z, float4(0.0).w);
    _756.w = ((log2(((dot(_661, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_519, ((((((_512 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _357) + ((_512 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _357) + ((_512 * 2.755199909210205078125) + float3(0.69029998779296875))) * _357).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_730.xyx * _730.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _726 * View.View_PreExposure;
    out.out_var_SV_Target1 = _740;
    out.out_var_SV_Target2 = _744;
    out.out_var_SV_Target3 = _756;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_479, 1.0, 1.0, 1.0);
    return out;
}

