

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _170 = {};
constant float4 _172 = {};

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
    float4 in_var_COLOR1 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004ce8_1d5f9f7a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float3 _271 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _283 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _285 = mix(0.4000000059604644775390625, 1.0, _283.x);
    float4 _289 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _314;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _314 = _234.w;
                break;
            }
            else
            {
                float _298 = _234.z;
                _314 = ((_298 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_298 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _318 = fast::min(fast::max((_314 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _319 = _289.y;
    float4 _323 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _325 = _323.y;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _347 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _347) : (in.in_var_COLOR1.w < _347)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _358 = fast::clamp(float3(mix(_285, 1.0 - _285, mix(_319, 1.0, _318)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_325 + mix(_319, 0.0, _318), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _363 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _325) + mix(mix(0.699999988079071044921875, 1.0, _319), 1.0, _318), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _410;
    float _411;
    float _412;
    float3 _413;
    float3 _414;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _380 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _384 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _380, level(0.0));
        float4 _387 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _380, level(0.0));
        float4 _390 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _380, level(0.0));
        float _400 = _390.w;
        _410 = (_363 * _400) + _390.z;
        _411 = (0.5 * _400) + _390.y;
        _412 = _390.x;
        _413 = (_358 * _384.w) + _384.xyz;
        _414 = normalize((_271 * _387.w) + ((_387.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _410 = _363;
        _411 = 0.5;
        _412 = 0.0;
        _413 = _358;
        _414 = _271;
    }
    bool _422 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _428;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _422)
    {
        _428 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _428 = 1.0;
    }
    float _475;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _443 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _454 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_443.x), int(_443.y), int(_443.z), 0).xyz), 0));
        _475 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_454.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_443 / float3(_454.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _475 = _428;
    }
    float3 _489 = ((_413 - (_413 * _412)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _496 = (mix(float3(0.07999999821186065673828125 * _411), _413, float3(_412)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _499 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _504;
    if (_499)
    {
        _504 = _489 + (_496 * 0.449999988079071044921875);
    }
    else
    {
        _504 = _489;
    }
    float3 _506 = select(_496, float3(0.0), bool3(_499));
    float3 _508 = float3(dot(_506, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _582;
    if (_422)
    {
        float3 _534 = fast::clamp((_243 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _538 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _534);
        float4 _542 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _534);
        float4 _545 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _534);
        float4 _563 = _172;
        _563.y = (-0.48860299587249755859375) * _414.y;
        float4 _566 = _563;
        _566.z = 0.48860299587249755859375 * _414.z;
        float4 _569 = _566;
        _569.w = (-0.48860299587249755859375) * _414.x;
        float4 _570 = _569;
        _570.x = 0.886227548122406005859375;
        float3 _572 = _570.yzw * 2.094395160675048828125;
        float4 _573 = float4(_570.x, _572.x, _572.y, _572.z);
        float3 _575 = float3(0.0);
        _575.x = dot(float4(_538.x, _542.x, _545.x, _538.w), _573);
        float3 _577 = _575;
        _577.y = dot(float4(_538.y, _542.y, _545.y, _542.w), _573);
        float3 _579 = _577;
        _579.z = dot(float4(_538.z, _542.z, _545.zw), _573);
        _582 = fast::max(float3(0.0), _579) * float3(0.3183098733425140380859375);
    }
    else
    {
        _582 = float3(0.0);
    }
    float _608;
    float _609;
    float3 _610;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _598;
        float _599;
        if (_422)
        {
            _598 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _599 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _598 = _414;
            _599 = 1.0;
        }
        float _600 = 1.0 - _599;
        float _602 = 1.0 - (_600 * _600);
        _608 = mix(fast::clamp(dot(_598, _414), 0.0, 1.0), 1.0, _602);
        _609 = _599;
        _610 = mix(_598, _414, float3(_602));
    }
    else
    {
        _608 = 1.0;
        _609 = 1.0;
        _610 = _414;
    }
    float4 _614 = float4(_610, 1.0);
    float3 _618 = _170;
    _618.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _614);
    float3 _622 = _618;
    _622.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _614);
    float3 _626 = _622;
    _626.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _614);
    float4 _629 = _614.xyzz * _614.yzzx;
    float3 _633 = _170;
    _633.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _629);
    float3 _637 = _633;
    _637.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _629);
    float3 _641 = _637;
    _641.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _629);
    float3 _656 = (_582 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_626 + _641) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_610.x * _610.x) - (_610.y * _610.y)))) * View.View_SkyLightColor.xyz) * (_609 * _608));
    float3 _678 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _704;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _703;
        if (any(abs(_243 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _703 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _703 = _678;
        }
        _704 = _703;
    }
    else
    {
        _704 = _678;
    }
    float4 _711 = float4(((mix(float3(0.0), _504 + (_506 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_656 * _504) * fast::max(float3(1.0), ((((((_413 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_413 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_413 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _704) * 1.0, 0.0);
    float4 _718;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _717 = _711;
        _717.w = 0.0;
        _718 = _717;
    }
    else
    {
        _718 = _711;
    }
    float2 _722 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _730 = (_414 * 0.5) + float3(0.5);
    float4 _732 = float4(_730.x, _730.y, _730.z, float4(0.0).w);
    _732.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _733 = float4(0.0);
    _733.x = _412;
    float4 _734 = _733;
    _734.y = _411;
    float4 _735 = _734;
    _735.z = _410;
    float4 _736 = _735;
    _736.w = 0.50588238239288330078125;
    float4 _748 = float4(_413.x, _413.y, _413.z, float4(0.0).w);
    _748.w = ((log2(((dot(_656, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_508 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_508 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_508 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_722.xyx * _722.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _718 * View.View_PreExposure;
    out.out_var_SV_Target1 = _732;
    out.out_var_SV_Target2 = _736;
    out.out_var_SV_Target3 = _748;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_475, 1.0, 1.0, 1.0);
    return out;
}

