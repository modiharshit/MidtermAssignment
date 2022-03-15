

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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _171 = {};
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

fragment MainPS_out Main_00004ea7_b2ff4fce(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _238 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = (_238.xyz / float3(_238.w)) - View.View_PreViewTranslation;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float2 _262 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float _293;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _293 = _234.w;
                break;
            }
            else
            {
                float _277 = _234.z;
                _293 = ((_277 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_277 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _299 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _266.x) + _293) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _308 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _299) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _320 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _323 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _332 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _333 = _332.x;
    float _337 = _332.y;
    float _341 = _332.z;
    float4 _347 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float _348 = _347.x;
    float _352 = _347.y;
    float _356 = _347.z;
    float3 _364 = fast::min(fast::max(mix(float3((_333 <= 0.0) ? 0.0 : pow(_333, 2.0), (_337 <= 0.0) ? 0.0 : pow(_337, 2.0), (_341 <= 0.0) ? 0.0 : pow(_341, 2.0)), float3((_348 <= 0.0) ? 0.0 : pow(_348, 2.0), (_352 <= 0.0) ? 0.0 : pow(_352, 2.0), (_356 <= 0.0) ? 0.0 : pow(_356, 2.0)), _299) * fast::min(fast::max(1.0 - (_320.x * _323.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _369 = fast::clamp(mix(_364, float3(dot(_364, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _371 = in.in_var_PRIMITIVE_ID * 36u;
    uint _372 = _371 + 20u;
    float _420;
    float _421;
    float _422;
    float3 _423;
    float3 _424;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _372)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _390 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _394 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _390, level(0.0));
        float4 _397 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _390, level(0.0));
        float4 _400 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _390, level(0.0));
        float _410 = _400.w;
        _420 = (View.View_RoughnessOverrideParameter.x * _410) + _400.z;
        _421 = (0.5 * _410) + _400.y;
        _422 = _400.x;
        _423 = (_369 * _394.w) + _394.xyz;
        _424 = normalize((_308 * _397.w) + ((_397.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _420 = View.View_RoughnessOverrideParameter.x;
        _421 = 0.5;
        _422 = 0.0;
        _423 = _369;
        _424 = _308;
    }
    bool _434 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _440;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371 + 18u)].w > 0.0) && _434)
    {
        _440 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _440 = 1.0;
    }
    float _487;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _372)].z > 0.0)
    {
        float3 _455 = fast::clamp((_243 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _466 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_455.x), int(_455.y), int(_455.z), 0).xyz), 0));
        _487 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_466.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_455 / float3(_466.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _487 = _440;
    }
    float3 _501 = ((_423 - (_423 * _422)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _508 = (mix(float3(0.07999999821186065673828125 * _421), _423, float3(_422)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _511 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _516;
    if (_511)
    {
        _516 = _501 + (_508 * 0.449999988079071044921875);
    }
    else
    {
        _516 = _501;
    }
    float3 _518 = select(_508, float3(0.0), bool3(_511));
    float3 _520 = float3(dot(_518, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _606;
    if (_434)
    {
        float4 _556 = _174;
        _556.y = (-0.48860299587249755859375) * _424.y;
        float4 _559 = _556;
        _559.z = 0.48860299587249755859375 * _424.z;
        float4 _562 = _559;
        _562.w = (-0.48860299587249755859375) * _424.x;
        float3 _563 = _424 * _424;
        float4 _566 = _171;
        _566.x = (1.09254801273345947265625 * _424.x) * _424.y;
        float4 _569 = _566;
        _569.y = ((-1.09254801273345947265625) * _424.y) * _424.z;
        float4 _574 = _569;
        _574.z = 0.3153919875621795654296875 * ((3.0 * _563.z) - 1.0);
        float4 _577 = _574;
        _577.w = ((-1.09254801273345947265625) * _424.x) * _424.z;
        float4 _581 = _562;
        _581.x = 0.886227548122406005859375;
        float3 _583 = _581.yzw * 2.094395160675048828125;
        float4 _584 = float4(_581.x, _583.x, _583.y, _583.z);
        float4 _585 = _577 * 0.785398185253143310546875;
        float _586 = (_563.x - _563.y) * 0.4290426075458526611328125;
        float3 _592 = float3(0.0);
        _592.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _584) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _585)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _586);
        float3 _598 = _592;
        _598.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _584) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _585)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _586);
        float3 _604 = _598;
        _604.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _584) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _585)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _586);
        _606 = fast::max(float3(0.0), _604);
    }
    else
    {
        _606 = float3(0.0);
    }
    float _632;
    float _633;
    float3 _634;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _622;
        float _623;
        if (_434)
        {
            _622 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _623 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _622 = _424;
            _623 = 1.0;
        }
        float _624 = 1.0 - _623;
        float _626 = 1.0 - (_624 * _624);
        _632 = mix(fast::clamp(dot(_622, _424), 0.0, 1.0), 1.0, _626);
        _633 = _623;
        _634 = mix(_622, _424, float3(_626));
    }
    else
    {
        _632 = 1.0;
        _633 = 1.0;
        _634 = _424;
    }
    float4 _638 = float4(_634, 1.0);
    float3 _642 = _172;
    _642.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _638);
    float3 _646 = _642;
    _646.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _638);
    float3 _650 = _646;
    _650.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _638);
    float4 _653 = _638.xyzz * _638.yzzx;
    float3 _657 = _172;
    _657.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _653);
    float3 _661 = _657;
    _661.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _653);
    float3 _665 = _661;
    _665.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _653);
    float3 _680 = (_606 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_650 + _665) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_634.x * _634.x) - (_634.y * _634.y)))) * View.View_SkyLightColor.xyz) * (_633 * _632));
    float3 _702 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _731;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _730;
        if (any(abs(_243 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371 + 19u)].xyz + float3(1.0))))
        {
            _730 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_243, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _730 = _702;
        }
        _731 = _730;
    }
    else
    {
        _731 = _702;
    }
    float4 _738 = float4(((mix(float3(0.0), _516 + (_518 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_680 * _516) * fast::max(float3(1.0), ((((((_423 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_423 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_423 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _731) * 1.0, 0.0);
    float4 _745;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _744 = _738;
        _744.w = 0.0;
        _745 = _744;
    }
    else
    {
        _745 = _738;
    }
    float2 _749 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _757 = (_424 * 0.5) + float3(0.5);
    float4 _759 = float4(_757.x, _757.y, _757.z, float4(0.0).w);
    _759.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _372)].y;
    float4 _760 = float4(0.0);
    _760.x = _422;
    float4 _761 = _760;
    _761.y = _421;
    float4 _762 = _761;
    _762.z = _420;
    float4 _763 = _762;
    _763.w = 0.50588238239288330078125;
    float4 _775 = float4(_423.x, _423.y, _423.z, float4(0.0).w);
    _775.w = ((log2(((dot(_680, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_520 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_520 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_520 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_749.xyx * _749.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _745 * View.View_PreExposure;
    out.out_var_SV_Target1 = _759;
    out.out_var_SV_Target2 = _763;
    out.out_var_SV_Target3 = _775;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_487, 1.0, 1.0, 1.0);
    return out;
}

