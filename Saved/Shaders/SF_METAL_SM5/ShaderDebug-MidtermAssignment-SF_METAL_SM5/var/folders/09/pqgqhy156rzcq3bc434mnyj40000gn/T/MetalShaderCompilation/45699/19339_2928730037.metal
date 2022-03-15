

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
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

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    char _m1_pad[16];
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
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _163 = {};
constant float4 _164 = {};
constant float _166 = {};
constant float4 _167 = {};
constant float3 _168 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

fragment MainPS_out Main_00004b8b_ae90dfb5(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float3x3 _221 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _166, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float3 _248 = (Primitive.Primitive_LocalToWorld * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _260 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _263 = (float3(-0.5) + _260.xyz) * 2.0;
    float3 _279 = ((((_248 / float3(sqrt(dot(_248, _248)))) * _221) * (-1.0)) * _263.z) + (float3(_263.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _221));
    float3 _291 = normalize(_221 * normalize(((_279 / float3(sqrt(dot(_279, _279)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _302 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _309 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _325 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _325) : (in.in_var_COLOR1.w < _325)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((_302.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _340 = fast::clamp(_302.xyz, float3(0.0), float3(1.0));
    float _345 = (fast::clamp(_260.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _355 = (fast::clamp(float4(_309.xyz, _163).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _403;
    float _404;
    float _405;
    float _406;
    float3 _407;
    float3 _408;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _372 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _376 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float4 _379 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float4 _382 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float _384 = _376.w;
        float _392 = _382.w;
        _403 = _355 * _384;
        _404 = (_345 * _392) + _382.z;
        _405 = (0.5 * _392) + _382.y;
        _406 = _382.x;
        _407 = (_340 * _384) + _376.xyz;
        _408 = normalize((_291 * _379.w) + ((_379.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _403 = _355;
        _404 = _345;
        _405 = 0.5;
        _406 = 0.0;
        _407 = _340;
        _408 = _291;
    }
    bool _416 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _422;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _416)
    {
        _422 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _422 = 1.0;
    }
    float _469;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _437 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _448 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_437.x), int(_437.y), int(_437.z), 0).xyz), 0));
        _469 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_448.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_437 / float3(_448.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _469 = _422;
    }
    float3 _472 = sqrt(fast::clamp(_403, float3(0.0), float3(1.0)));
    float4 _474 = float4(_472.x, _472.y, _472.z, float4(0.0).w);
    _474.w = 1.0;
    float3 _479 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _480 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _498 = ((_407 - (_407 * _406)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _505 = (mix(float3(0.07999999821186065673828125 * _405), _407, float3(_406)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    float3 _656;
    float3 _657;
    if (_416)
    {
        float4 _553 = _167;
        _553.y = (-0.48860299587249755859375) * _408.y;
        float4 _556 = _553;
        _556.z = 0.48860299587249755859375 * _408.z;
        float4 _559 = _556;
        _559.w = (-0.48860299587249755859375) * _408.x;
        float3 _560 = _408 * _408;
        float4 _563 = _164;
        _563.x = (1.09254801273345947265625 * _408.x) * _408.y;
        float4 _566 = _563;
        _566.y = ((-1.09254801273345947265625) * _408.y) * _408.z;
        float4 _571 = _566;
        _571.z = 0.3153919875621795654296875 * ((3.0 * _560.z) - 1.0);
        float4 _574 = _571;
        _574.w = ((-1.09254801273345947265625) * _408.x) * _408.z;
        float4 _578 = _559;
        _578.x = 0.886227548122406005859375;
        float3 _580 = _578.yzw * 2.094395160675048828125;
        float4 _581 = float4(_578.x, _580.x, _580.y, _580.z);
        float4 _582 = _574 * 0.785398185253143310546875;
        float _583 = (_560.x - _560.y) * 0.4290426075458526611328125;
        float3 _589 = float3(0.0);
        _589.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _581) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _582)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _583);
        float3 _595 = _589;
        _595.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _581) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _582)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _583);
        float3 _601 = _595;
        _601.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _581) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _582)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _583);
        float3 _603 = -_408;
        float _604 = _603.y;
        float4 _606 = _167;
        _606.y = (-0.48860299587249755859375) * _604;
        float _607 = _603.z;
        float4 _609 = _606;
        _609.z = 0.48860299587249755859375 * _607;
        float _610 = _603.x;
        float4 _612 = _609;
        _612.w = (-0.48860299587249755859375) * _610;
        float3 _613 = _603 * _603;
        float4 _616 = _164;
        _616.x = (1.09254801273345947265625 * _610) * _604;
        float4 _619 = _616;
        _619.y = ((-1.09254801273345947265625) * _604) * _607;
        float4 _624 = _619;
        _624.z = 0.3153919875621795654296875 * ((3.0 * _613.z) - 1.0);
        float4 _627 = _624;
        _627.w = ((-1.09254801273345947265625) * _610) * _607;
        float4 _631 = _612;
        _631.x = 0.886227548122406005859375;
        float3 _633 = _631.yzw * 2.094395160675048828125;
        float4 _634 = float4(_631.x, _633.x, _633.y, _633.z);
        float4 _635 = _627 * 0.785398185253143310546875;
        float _636 = (_613.x - _613.y) * 0.4290426075458526611328125;
        float3 _642 = _168;
        _642.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _634) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _635)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _636);
        float3 _648 = _642;
        _648.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _634) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _635)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _636);
        float3 _654 = _648;
        _654.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _634) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _635)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _636);
        _656 = fast::max(float3(0.0), _654);
        _657 = fast::max(float3(0.0), _601);
    }
    else
    {
        _656 = float3(0.0);
        _657 = float3(0.0);
    }
    float3 _660 = _657 * View.View_IndirectLightingColorScale;
    float3 _685 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _711;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _710;
        if (any(abs(_243 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _710 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _710 = _685;
        }
        _711 = _710;
    }
    else
    {
        _711 = _685;
    }
    float4 _718 = float4(((mix(float3(0.0), _513 + (_515 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_660 * _513) + ((_656 * View.View_IndirectLightingColorScale) * _403)) * fast::max(float3(1.0), ((((((_407 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_407 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_407 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _711) * 1.0, 0.0);
    float4 _725;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _724 = _718;
        _724.w = 0.0;
        _725 = _724;
    }
    else
    {
        _725 = _718;
    }
    float2 _729 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _737 = (_408 * 0.5) + float3(0.5);
    float4 _739 = float4(_737.x, _737.y, _737.z, float4(0.0).w);
    _739.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _740 = float4(0.0);
    _740.x = _406;
    float4 _741 = _740;
    _741.y = _405;
    float4 _742 = _741;
    _742.z = fast::max(_404, fast::clamp((pow(fast::max(dot(_479, _479), dot(_480, _480)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _743 = _742;
    _743.w = 0.525490224361419677734375;
    float4 _755 = float4(_407.x, _407.y, _407.z, float4(0.0).w);
    _755.w = ((log2(((dot(_660, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_517 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_517 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_517 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_729.xyx * _729.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _725 * View.View_PreExposure;
    out.out_var_SV_Target1 = _739;
    out.out_var_SV_Target2 = _743;
    out.out_var_SV_Target3 = _755;
    out.out_var_SV_Target4 = _474;
    out.out_var_SV_Target5 = float4(_469, 1.0, 1.0, 1.0);
    return out;
}

