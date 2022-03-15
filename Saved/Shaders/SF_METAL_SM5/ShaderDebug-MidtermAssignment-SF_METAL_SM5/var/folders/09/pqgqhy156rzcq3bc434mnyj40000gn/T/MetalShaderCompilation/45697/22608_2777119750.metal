

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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _167 = {};
constant float4 _168 = {};
constant float3 _169 = {};
constant float _171 = {};
constant float4 _172 = {};
constant float3 _173 = {};

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

fragment MainPS_out Main_00005850_a5877c06(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _171, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _247 = (_242.xyz / float3(_242.w)) - View.View_PreViewTranslation;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _270 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _259.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _304 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _304) : (in.in_var_COLOR1.w < _304)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _281.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _319 = fast::clamp(_281.xyz, float3(0.0), float3(1.0));
    float _324 = (fast::clamp(_259.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _334 = (fast::clamp(float4(_288.xyz, _167).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _382;
    float _383;
    float _384;
    float _385;
    float3 _386;
    float3 _387;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _351 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _355 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float _363 = _355.w;
        float _371 = _361.w;
        _382 = _334 * _363;
        _383 = (_324 * _371) + _361.z;
        _384 = (0.5 * _371) + _361.y;
        _385 = _361.x;
        _386 = (_319 * _363) + _355.xyz;
        _387 = normalize((_270 * _358.w) + ((_358.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = _334;
        _383 = _324;
        _384 = 0.5;
        _385 = 0.0;
        _386 = _319;
        _387 = _270;
    }
    bool _395 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _401;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _395)
    {
        _401 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _401 = 1.0;
    }
    float _448;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _416 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _427 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_416.x), int(_416.y), int(_416.z), 0).xyz), 0));
        _448 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_427.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_416 / float3(_427.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _448 = _401;
    }
    float3 _451 = sqrt(fast::clamp(_382, float3(0.0), float3(1.0)));
    float4 _453 = float4(_451.x, _451.y, _451.z, float4(0.0).w);
    _453.w = 1.0;
    float3 _461 = ((_386 - (_386 * _385)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _468 = (mix(float3(0.07999999821186065673828125 * _384), _386, float3(_385)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _471 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _476;
    if (_471)
    {
        _476 = _461 + (_468 * 0.449999988079071044921875);
    }
    else
    {
        _476 = _461;
    }
    float3 _478 = select(_468, float3(0.0), bool3(_471));
    float3 _480 = float3(dot(_478, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _619;
    float3 _620;
    if (_395)
    {
        float4 _516 = _172;
        _516.y = (-0.48860299587249755859375) * _387.y;
        float4 _519 = _516;
        _519.z = 0.48860299587249755859375 * _387.z;
        float4 _522 = _519;
        _522.w = (-0.48860299587249755859375) * _387.x;
        float3 _523 = _387 * _387;
        float4 _526 = _168;
        _526.x = (1.09254801273345947265625 * _387.x) * _387.y;
        float4 _529 = _526;
        _529.y = ((-1.09254801273345947265625) * _387.y) * _387.z;
        float4 _534 = _529;
        _534.z = 0.3153919875621795654296875 * ((3.0 * _523.z) - 1.0);
        float4 _537 = _534;
        _537.w = ((-1.09254801273345947265625) * _387.x) * _387.z;
        float4 _541 = _522;
        _541.x = 0.886227548122406005859375;
        float3 _543 = _541.yzw * 2.094395160675048828125;
        float4 _544 = float4(_541.x, _543.x, _543.y, _543.z);
        float4 _545 = _537 * 0.785398185253143310546875;
        float _546 = (_523.x - _523.y) * 0.4290426075458526611328125;
        float3 _552 = float3(0.0);
        _552.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _546);
        float3 _558 = _552;
        _558.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _546);
        float3 _564 = _558;
        _564.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _546);
        float3 _566 = -_387;
        float _567 = _566.y;
        float4 _569 = _172;
        _569.y = (-0.48860299587249755859375) * _567;
        float _570 = _566.z;
        float4 _572 = _569;
        _572.z = 0.48860299587249755859375 * _570;
        float _573 = _566.x;
        float4 _575 = _572;
        _575.w = (-0.48860299587249755859375) * _573;
        float3 _576 = _566 * _566;
        float4 _579 = _168;
        _579.x = (1.09254801273345947265625 * _573) * _567;
        float4 _582 = _579;
        _582.y = ((-1.09254801273345947265625) * _567) * _570;
        float4 _587 = _582;
        _587.z = 0.3153919875621795654296875 * ((3.0 * _576.z) - 1.0);
        float4 _590 = _587;
        _590.w = ((-1.09254801273345947265625) * _573) * _570;
        float4 _594 = _575;
        _594.x = 0.886227548122406005859375;
        float3 _596 = _594.yzw * 2.094395160675048828125;
        float4 _597 = float4(_594.x, _596.x, _596.y, _596.z);
        float4 _598 = _590 * 0.785398185253143310546875;
        float _599 = (_576.x - _576.y) * 0.4290426075458526611328125;
        float3 _605 = _173;
        _605.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _597) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _598)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _599);
        float3 _611 = _605;
        _611.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _597) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _598)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _599);
        float3 _617 = _611;
        _617.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _597) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _598)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _599);
        _619 = fast::max(float3(0.0), _617);
        _620 = fast::max(float3(0.0), _564);
    }
    else
    {
        _619 = float3(0.0);
        _620 = float3(0.0);
    }
    float _647;
    float _648;
    float3 _649;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _637;
        float _638;
        if (_395)
        {
            _637 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _638 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _637 = _387;
            _638 = 1.0;
        }
        float _639 = 1.0 - _638;
        float _641 = 1.0 - (_639 * _639);
        _647 = mix(fast::clamp(dot(_637, _387), 0.0, 1.0), 1.0, _641);
        _648 = _638;
        _649 = mix(_637, _387, float3(_641));
    }
    else
    {
        _647 = 1.0;
        _648 = 1.0;
        _649 = _387;
    }
    float4 _653 = float4(_649, 1.0);
    float3 _657 = _169;
    _657.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _653);
    float3 _661 = _657;
    _661.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _653);
    float3 _665 = _661;
    _665.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _653);
    float4 _668 = _653.xyzz * _653.yzzx;
    float3 _672 = _169;
    _672.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _668);
    float3 _676 = _672;
    _676.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _668);
    float3 _680 = _676;
    _680.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _668);
    float3 _695 = -_387;
    float _696 = _695.x;
    float _697 = _695.y;
    float4 _699 = float4(_696, _697, _695.z, 1.0);
    float3 _702 = _173;
    _702.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _699);
    float3 _705 = _702;
    _705.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _699);
    float3 _708 = _705;
    _708.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _699);
    float4 _711 = _699.xyzz * _699.yzzx;
    float3 _714 = _173;
    _714.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _711);
    float3 _717 = _714;
    _717.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _711);
    float3 _720 = _717;
    _720.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _711);
    float3 _733 = (_620 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_665 + _680) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_649.x * _649.x) - (_649.y * _649.y)))) * View.View_SkyLightColor.xyz) * (_648 * _647));
    float3 _757 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _783;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _782;
        if (any(abs(_247 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _782 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _782 = _757;
        }
        _783 = _782;
    }
    else
    {
        _783 = _757;
    }
    float4 _790 = float4(((mix(float3(0.0), _476 + (_478 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_733 * _476) + (((_619 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_708 + _720) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_696 * _696) - (_697 * _697)))) * View.View_SkyLightColor.xyz) * _648)) * _382)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _783) * 1.0, 0.0);
    float4 _797;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _796 = _790;
        _796.w = 0.0;
        _797 = _796;
    }
    else
    {
        _797 = _790;
    }
    float2 _801 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _809 = (_387 * 0.5) + float3(0.5);
    float4 _811 = float4(_809.x, _809.y, _809.z, float4(0.0).w);
    _811.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _812 = float4(0.0);
    _812.x = _385;
    float4 _813 = _812;
    _813.y = _384;
    float4 _814 = _813;
    _814.z = _383;
    float4 _815 = _814;
    _815.w = 0.525490224361419677734375;
    float4 _827 = float4(_386.x, _386.y, _386.z, float4(0.0).w);
    _827.w = ((log2(((dot(_733, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_480 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_480 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_480 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_801.xyx * _801.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _797 * View.View_PreExposure;
    out.out_var_SV_Target1 = _811;
    out.out_var_SV_Target2 = _815;
    out.out_var_SV_Target3 = _827;
    out.out_var_SV_Target4 = _453;
    out.out_var_SV_Target5 = float4(_448, 1.0, 1.0, 1.0);
    return out;
}

