

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float3 _152 = {};
constant float _154 = {};
constant float4 _155 = {};

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
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004465_d9f6202b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _205 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _211 = float4((_205 - float2(0.5)) * float2(2.0, -2.0), _154, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    float3 _229 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _236 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_205 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _237 = _236.xyz;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _254 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _254) : (in.in_var_COLOR1.w < _254)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _265 = fast::clamp(_237, float3(0.0), float3(1.0));
    float _269 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _316;
    float _317;
    float _318;
    float3 _319;
    float3 _320;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _286 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _290 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float4 _293 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float4 _296 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _286, level(0.0));
        float _306 = _296.w;
        _316 = (_269 * _306) + _296.z;
        _317 = (0.5 * _306) + _296.y;
        _318 = _296.x;
        _319 = (_265 * _290.w) + _290.xyz;
        _320 = normalize((_229 * _293.w) + ((_293.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _316 = _269;
        _317 = 0.5;
        _318 = 0.0;
        _319 = _265;
        _320 = _229;
    }
    bool _328 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _334;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _328)
    {
        _334 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _334 = 1.0;
    }
    float _381;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _349 = fast::clamp((_221 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _360 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_349.x), int(_349.y), int(_349.z), 0).xyz), 0));
        _381 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_360.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_349 / float3(_360.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _381 = _334;
    }
    float3 _395 = ((_319 - (_319 * _318)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _402 = (mix(float3(0.07999999821186065673828125 * _317), _319, float3(_318)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _405 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _410;
    if (_405)
    {
        _410 = _395 + (_402 * 0.449999988079071044921875);
    }
    else
    {
        _410 = _395;
    }
    float3 _412 = select(_402, float3(0.0), bool3(_405));
    float3 _414 = float3(dot(_412, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _488;
    if (_328)
    {
        float3 _440 = fast::clamp((_221 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _444 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _440);
        float4 _448 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _440);
        float4 _451 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _440);
        float4 _469 = _155;
        _469.y = (-0.48860299587249755859375) * _320.y;
        float4 _472 = _469;
        _472.z = 0.48860299587249755859375 * _320.z;
        float4 _475 = _472;
        _475.w = (-0.48860299587249755859375) * _320.x;
        float4 _476 = _475;
        _476.x = 0.886227548122406005859375;
        float3 _478 = _476.yzw * 2.094395160675048828125;
        float4 _479 = float4(_476.x, _478.x, _478.y, _478.z);
        float3 _481 = float3(0.0);
        _481.x = dot(float4(_444.x, _448.x, _451.x, _444.w), _479);
        float3 _483 = _481;
        _483.y = dot(float4(_444.y, _448.y, _451.y, _448.w), _479);
        float3 _485 = _483;
        _485.z = dot(float4(_444.z, _448.z, _451.zw), _479);
        _488 = fast::max(float3(0.0), _485) * float3(0.3183098733425140380859375);
    }
    else
    {
        _488 = float3(0.0);
    }
    float _514;
    float _515;
    float3 _516;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _504;
        float _505;
        if (_328)
        {
            _504 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _505 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _504 = _320;
            _505 = 1.0;
        }
        float _506 = 1.0 - _505;
        float _508 = 1.0 - (_506 * _506);
        _514 = mix(fast::clamp(dot(_504, _320), 0.0, 1.0), 1.0, _508);
        _515 = _505;
        _516 = mix(_504, _320, float3(_508));
    }
    else
    {
        _514 = 1.0;
        _515 = 1.0;
        _516 = _320;
    }
    float4 _520 = float4(_516, 1.0);
    float3 _524 = _152;
    _524.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _520);
    float3 _528 = _524;
    _528.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _520);
    float3 _532 = _528;
    _532.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _520);
    float4 _535 = _520.xyzz * _520.yzzx;
    float3 _539 = _152;
    _539.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _535);
    float3 _543 = _539;
    _543.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _535);
    float3 _547 = _543;
    _547.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _535);
    float3 _562 = (_488 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_532 + _547) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_516.x * _516.x) - (_516.y * _516.y)))) * View.View_SkyLightColor.xyz) * (_515 * _514));
    float3 _584 = fast::max(mix(_237, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _610;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _609;
        if (any(abs(_221 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _609 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _609 = _584;
        }
        _610 = _609;
    }
    else
    {
        _610 = _584;
    }
    float4 _617 = float4(((mix(float3(0.0), _410 + (_412 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_562 * _410) * fast::max(float3(1.0), ((((((_319 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_319 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_319 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _610) * 1.0, 0.0);
    float4 _624;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _623 = _617;
        _623.w = 0.0;
        _624 = _623;
    }
    else
    {
        _624 = _617;
    }
    float2 _628 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _636 = (_320 * 0.5) + float3(0.5);
    float4 _638 = float4(_636.x, _636.y, _636.z, float4(0.0).w);
    _638.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _639 = float4(0.0);
    _639.x = _318;
    float4 _640 = _639;
    _640.y = _317;
    float4 _641 = _640;
    _641.z = _316;
    float4 _642 = _641;
    _642.w = 0.50588238239288330078125;
    float4 _654 = float4(_319.x, _319.y, _319.z, float4(0.0).w);
    _654.w = ((log2(((dot(_562, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_414 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_414 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_414 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_628.xyx * _628.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _624 * View.View_PreExposure;
    out.out_var_SV_Target1 = _638;
    out.out_var_SV_Target2 = _642;
    out.out_var_SV_Target3 = _654;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_381, 1.0, 1.0, 1.0);
    return out;
}

