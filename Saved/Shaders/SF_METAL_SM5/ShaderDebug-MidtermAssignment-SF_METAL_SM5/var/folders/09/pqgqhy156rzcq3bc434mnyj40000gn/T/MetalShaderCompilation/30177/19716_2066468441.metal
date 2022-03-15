

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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_LandscapeParameters
{
    char _m0_pad[144];
    float4x4 LandscapeParameters_LocalToWorldNoScaling;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _169 = {};
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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
    float4 in_var_TEXCOORD1 [[user(locn1)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004d04_7b2bce59(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> LandscapeParameters_NormalmapTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler LandscapeParameters_NormalmapTextureSampler [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _217 = LandscapeParameters_NormalmapTexture.sample(LandscapeParameters_NormalmapTextureSampler, in.in_var_TEXCOORD1.zw);
    float2 _222 = (float2(_217.zw) * float2(2.0)) - float2(1.0);
    float _226 = sqrt(fast::max(1.0 - dot(_222, _222), 0.0));
    float _227 = _222.x;
    float3 _229 = float3(_227, _222.y, _226);
    float3 _232 = normalize(float3(_226, 0.0, -_227));
    float4 _256 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _260 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _265 = (_260.xyz / float3(_260.w)) - View.View_PreViewTranslation;
    float4 _273 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _276 = (_273.xy * float2(2.0)) - float2(1.0);
    float3 _293 = normalize((float3x3(LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[0].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[1].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[2].xyz) * float3x3(_232, cross(_229, _232), _229)) * normalize(((float4(_276, sqrt(fast::clamp(1.0 - dot(_276, _276), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _305 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _307 = mix(0.4000000059604644775390625, 1.0, _305.x);
    float4 _311 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _336;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _336 = _256.w;
                break;
            }
            else
            {
                float _320 = _256.z;
                _336 = ((_320 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_320 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _340 = fast::min(fast::max((_336 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _341 = _311.y;
    float4 _345 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _347 = _345.y;
    float3 _360 = fast::clamp(float3(mix(_307, 1.0 - _307, mix(_341, 1.0, _340)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_347 + mix(_341, 0.0, _340), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _365 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _347) + mix(mix(0.699999988079071044921875, 1.0, _341), 1.0, _340), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _412;
    float _413;
    float _414;
    float3 _415;
    float3 _416;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _382 = ((_256.xy / float2(_256.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _386 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _392 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float _402 = _392.w;
        _412 = (_365 * _402) + _392.z;
        _413 = (0.5 * _402) + _392.y;
        _414 = _392.x;
        _415 = (_360 * _386.w) + _386.xyz;
        _416 = normalize((_293 * _389.w) + ((_389.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _412 = _365;
        _413 = 0.5;
        _414 = 0.0;
        _415 = _360;
        _416 = _293;
    }
    bool _424 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _430;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _424)
    {
        _430 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _430 = 1.0;
    }
    float _477;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _445 = fast::clamp((_265 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _456 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_445.x), int(_445.y), int(_445.z), 0).xyz), 0));
        _477 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_456.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_445 / float3(_456.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _477 = _430;
    }
    float3 _491 = ((_415 - (_415 * _414)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _498 = (mix(float3(0.07999999821186065673828125 * _413), _415, float3(_414)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _501 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _506;
    if (_501)
    {
        _506 = _491 + (_498 * 0.449999988079071044921875);
    }
    else
    {
        _506 = _491;
    }
    float3 _508 = select(_498, float3(0.0), bool3(_501));
    float3 _510 = float3(dot(_508, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _596;
    if (_424)
    {
        float4 _546 = _172;
        _546.y = (-0.48860299587249755859375) * _416.y;
        float4 _549 = _546;
        _549.z = 0.48860299587249755859375 * _416.z;
        float4 _552 = _549;
        _552.w = (-0.48860299587249755859375) * _416.x;
        float3 _553 = _416 * _416;
        float4 _556 = _169;
        _556.x = (1.09254801273345947265625 * _416.x) * _416.y;
        float4 _559 = _556;
        _559.y = ((-1.09254801273345947265625) * _416.y) * _416.z;
        float4 _564 = _559;
        _564.z = 0.3153919875621795654296875 * ((3.0 * _553.z) - 1.0);
        float4 _567 = _564;
        _567.w = ((-1.09254801273345947265625) * _416.x) * _416.z;
        float4 _571 = _552;
        _571.x = 0.886227548122406005859375;
        float3 _573 = _571.yzw * 2.094395160675048828125;
        float4 _574 = float4(_571.x, _573.x, _573.y, _573.z);
        float4 _575 = _567 * 0.785398185253143310546875;
        float _576 = (_553.x - _553.y) * 0.4290426075458526611328125;
        float3 _582 = float3(0.0);
        _582.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _574) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _575)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _576);
        float3 _588 = _582;
        _588.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _574) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _575)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _576);
        float3 _594 = _588;
        _594.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _574) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _575)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _576);
        _596 = fast::max(float3(0.0), _594);
    }
    else
    {
        _596 = float3(0.0);
    }
    float _622;
    float _623;
    float3 _624;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _612;
        float _613;
        if (_424)
        {
            _612 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _613 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _612 = _416;
            _613 = 1.0;
        }
        float _614 = 1.0 - _613;
        float _616 = 1.0 - (_614 * _614);
        _622 = mix(fast::clamp(dot(_612, _416), 0.0, 1.0), 1.0, _616);
        _623 = _613;
        _624 = mix(_612, _416, float3(_616));
    }
    else
    {
        _622 = 1.0;
        _623 = 1.0;
        _624 = _416;
    }
    float4 _628 = float4(_624, 1.0);
    float3 _632 = _170;
    _632.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _628);
    float3 _636 = _632;
    _636.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _628);
    float3 _640 = _636;
    _640.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _628);
    float4 _643 = _628.xyzz * _628.yzzx;
    float3 _647 = _170;
    _647.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _643);
    float3 _651 = _647;
    _651.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _643);
    float3 _655 = _651;
    _655.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _643);
    float3 _670 = (_596 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_640 + _655) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_624.x * _624.x) - (_624.y * _624.y)))) * View.View_SkyLightColor.xyz) * (_623 * _622));
    float3 _692 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _718;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _717;
        if (any(abs(_265 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _717 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_265, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _717 = _692;
        }
        _718 = _717;
    }
    else
    {
        _718 = _692;
    }
    float4 _725 = float4(((mix(float3(0.0), _506 + (_508 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_670 * _506) * fast::max(float3(1.0), ((((((_415 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_415 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_415 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _718) * 1.0, 0.0);
    float4 _732;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _731 = _725;
        _731.w = 0.0;
        _732 = _731;
    }
    else
    {
        _732 = _725;
    }
    float2 _736 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _744 = (_416 * 0.5) + float3(0.5);
    float4 _746 = float4(_744.x, _744.y, _744.z, float4(0.0).w);
    _746.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _747 = float4(0.0);
    _747.x = _414;
    float4 _748 = _747;
    _748.y = _413;
    float4 _749 = _748;
    _749.z = _412;
    float4 _750 = _749;
    _750.w = 0.50588238239288330078125;
    float4 _762 = float4(_415.x, _415.y, _415.z, float4(0.0).w);
    _762.w = ((log2(((dot(_670, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_510 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_510 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_510 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_736.xyx * _736.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _732 * View.View_PreExposure;
    out.out_var_SV_Target1 = _746;
    out.out_var_SV_Target2 = _750;
    out.out_var_SV_Target3 = _762;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_477, 1.0, 1.0, 1.0);
    return out;
}

