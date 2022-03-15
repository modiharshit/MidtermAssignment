

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[204];
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _165 = {};
constant float3 _166 = {};
constant float _168 = {};
constant float4 _169 = {};
constant float3 _170 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000053d1_640691da(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _168, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = (_239.xyz / float3(_239.w)) - View.View_PreViewTranslation;
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _256.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _285 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _301 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _301) : (in.in_var_COLOR1.w < _301)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _278.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _316 = fast::clamp(_278.xyz, float3(0.0), float3(1.0));
    float _321 = (fast::clamp(_256.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _331 = (fast::clamp(float4(_285.xyz, _165).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _379;
    float _380;
    float _381;
    float _382;
    float3 _383;
    float3 _384;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _348 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _352 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float4 _355 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float _360 = _352.w;
        float _368 = _358.w;
        _379 = _331 * _360;
        _380 = (_321 * _368) + _358.z;
        _381 = (0.5 * _368) + _358.y;
        _382 = _358.x;
        _383 = (_316 * _360) + _352.xyz;
        _384 = normalize((_267 * _355.w) + ((_355.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _379 = _331;
        _380 = _321;
        _381 = 0.5;
        _382 = 0.0;
        _383 = _316;
        _384 = _267;
    }
    bool _392 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _398;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _392)
    {
        _398 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _398 = 1.0;
    }
    float _445;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _413 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _424 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_413.x), int(_413.y), int(_413.z), 0).xyz), 0));
        _445 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_424.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_413 / float3(_424.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _445 = _398;
    }
    float3 _448 = sqrt(fast::clamp(_379, float3(0.0), float3(1.0)));
    float4 _450 = float4(_448.x, _448.y, _448.z, float4(0.0).w);
    _450.w = 1.0;
    float3 _458 = ((_383 - (_383 * _382)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _465 = (mix(float3(0.07999999821186065673828125 * _381), _383, float3(_382)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _468 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _473;
    if (_468)
    {
        _473 = _458 + (_465 * 0.449999988079071044921875);
    }
    else
    {
        _473 = _458;
    }
    float3 _475 = select(_465, float3(0.0), bool3(_468));
    float3 _477 = float3(dot(_475, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _573;
    float3 _574;
    if (_392)
    {
        float3 _503 = fast::clamp((_244 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _507 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _503);
        float4 _511 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _503);
        float4 _514 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _503);
        float4 _519 = float4(_507.x, _511.x, _514.x, _507.w);
        float4 _524 = float4(_507.y, _511.y, _514.y, _511.w);
        float4 _529 = float4(_507.z, _511.z, _514.zw);
        float4 _532 = _169;
        _532.y = (-0.48860299587249755859375) * _384.y;
        float4 _535 = _532;
        _535.z = 0.48860299587249755859375 * _384.z;
        float4 _538 = _535;
        _538.w = (-0.48860299587249755859375) * _384.x;
        float4 _539 = _538;
        _539.x = 0.886227548122406005859375;
        float3 _541 = _539.yzw * 2.094395160675048828125;
        float4 _542 = float4(_539.x, _541.x, _541.y, _541.z);
        float3 _544 = float3(0.0);
        _544.x = dot(_519, _542);
        float3 _546 = _544;
        _546.y = dot(_524, _542);
        float3 _548 = _546;
        _548.z = dot(_529, _542);
        float3 _551 = -_384;
        float4 _554 = _169;
        _554.y = (-0.48860299587249755859375) * _551.y;
        float4 _557 = _554;
        _557.z = 0.48860299587249755859375 * _551.z;
        float4 _560 = _557;
        _560.w = (-0.48860299587249755859375) * _551.x;
        float4 _561 = _560;
        _561.x = 0.886227548122406005859375;
        float3 _563 = _561.yzw * 2.094395160675048828125;
        float4 _564 = float4(_561.x, _563.x, _563.y, _563.z);
        float3 _566 = _170;
        _566.x = dot(_519, _564);
        float3 _568 = _566;
        _568.y = dot(_524, _564);
        float3 _570 = _568;
        _570.z = dot(_529, _564);
        _573 = fast::max(float3(0.0), _570) * float3(0.3183098733425140380859375);
        _574 = fast::max(float3(0.0), _548) * float3(0.3183098733425140380859375);
    }
    else
    {
        _573 = float3(0.0);
        _574 = float3(0.0);
    }
    float _601;
    float _602;
    float3 _603;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _591;
        float _592;
        if (_392)
        {
            _591 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _592 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _591 = _384;
            _592 = 1.0;
        }
        float _593 = 1.0 - _592;
        float _595 = 1.0 - (_593 * _593);
        _601 = mix(fast::clamp(dot(_591, _384), 0.0, 1.0), 1.0, _595);
        _602 = _592;
        _603 = mix(_591, _384, float3(_595));
    }
    else
    {
        _601 = 1.0;
        _602 = 1.0;
        _603 = _384;
    }
    float4 _607 = float4(_603, 1.0);
    float3 _611 = _166;
    _611.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _607);
    float3 _615 = _611;
    _615.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _607);
    float3 _619 = _615;
    _619.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _607);
    float4 _622 = _607.xyzz * _607.yzzx;
    float3 _626 = _166;
    _626.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _622);
    float3 _630 = _626;
    _630.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _622);
    float3 _634 = _630;
    _634.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _622);
    float3 _649 = -_384;
    float _650 = _649.x;
    float _651 = _649.y;
    float4 _653 = float4(_650, _651, _649.z, 1.0);
    float3 _656 = _170;
    _656.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _653);
    float3 _659 = _656;
    _659.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _653);
    float3 _662 = _659;
    _662.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _653);
    float4 _665 = _653.xyzz * _653.yzzx;
    float3 _668 = _170;
    _668.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _665);
    float3 _671 = _668;
    _671.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _665);
    float3 _674 = _671;
    _674.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _665);
    float3 _687 = (_574 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_619 + _634) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_603.x * _603.x) - (_603.y * _603.y)))) * View.View_SkyLightColor.xyz) * (_602 * _601));
    float3 _711 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _737;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _736;
        if (any(abs(_244 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _736 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _736 = _711;
        }
        _737 = _736;
    }
    else
    {
        _737 = _711;
    }
    float4 _744 = float4(((mix(float3(0.0), _473 + (_475 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_687 * _473) + (((_573 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_662 + _674) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_650 * _650) - (_651 * _651)))) * View.View_SkyLightColor.xyz) * _602)) * _379)) * fast::max(float3(1.0), ((((((_383 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_383 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_383 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _737) * 1.0, 0.0);
    float4 _751;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _750 = _744;
        _750.w = 0.0;
        _751 = _750;
    }
    else
    {
        _751 = _744;
    }
    float2 _755 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _763 = (_384 * 0.5) + float3(0.5);
    float4 _765 = float4(_763.x, _763.y, _763.z, float4(0.0).w);
    _765.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _766 = float4(0.0);
    _766.x = _382;
    float4 _767 = _766;
    _767.y = _381;
    float4 _768 = _767;
    _768.z = _380;
    float4 _769 = _768;
    _769.w = 0.525490224361419677734375;
    float4 _781 = float4(_383.x, _383.y, _383.z, float4(0.0).w);
    _781.w = ((log2(((dot(_687, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_477 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_477 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_477 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_755.xyx * _755.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _751 * View.View_PreExposure;
    out.out_var_SV_Target1 = _765;
    out.out_var_SV_Target2 = _769;
    out.out_var_SV_Target3 = _781;
    out.out_var_SV_Target4 = _450;
    out.out_var_SV_Target5 = float4(_445, 1.0, 1.0, 1.0);
    return out;
}

