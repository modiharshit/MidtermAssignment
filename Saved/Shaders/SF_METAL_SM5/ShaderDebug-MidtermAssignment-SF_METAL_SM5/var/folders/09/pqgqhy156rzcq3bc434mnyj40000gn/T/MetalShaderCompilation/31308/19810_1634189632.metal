

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
constant float _171 = {};
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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004d62_6167c140(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], texture2d<float> Material_Texture2D_4 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], sampler Material_Texture2D_4Sampler [[sampler(7)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _218 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _229 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _171, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = _234.xyz / float3(_234.w);
    float3 _239 = _238 - View.View_PreViewTranslation;
    float2 _243 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float2 _255 = ((normalize(-_238) * _218).xy * ((0.004999999888241291046142578125 * _249.w) + (-0.00449999980628490447998046875))) + _243;
    float4 _259 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _255, bias(View.View_MaterialTextureMipBias));
    float2 _262 = (_259.xy * float2(2.0)) - float2(1.0);
    float4 _275 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _278 = (_275.xy * float2(2.0)) - float2(1.0);
    float3 _297 = normalize(_218 * normalize(((float4(_262, sqrt(fast::clamp(1.0 - dot(_262, _262), 0.0, 1.0)), 1.0).xyz + (float4(_278, sqrt(fast::clamp(1.0 - dot(_278, _278), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _309 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _314 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _317 = (_309.x + 0.5) * (_314.x + 0.5);
    float4 _320 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _255, bias(View.View_MaterialTextureMipBias));
    float4 _326 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _255, bias(View.View_MaterialTextureMipBias));
    float3 _332 = fast::clamp(_320.xyz * mix(0.5, 1.0, _317), float3(0.0), float3(1.0));
    float _333 = fast::clamp(_326.y, 0.0, 1.0);
    float _338 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _326.x + (_317 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _339 = in.in_var_PRIMITIVE_ID * 36u;
    uint _340 = _339 + 20u;
    float _388;
    float _389;
    float _390;
    float3 _391;
    float3 _392;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _340)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _358 = ((_229.xy / float2(_229.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _362 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float4 _365 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float4 _368 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float _378 = _368.w;
        _388 = (_338 * _378) + _368.z;
        _389 = (0.5 * _378) + _368.y;
        _390 = _368.x;
        _391 = (_332 * _362.w) + _362.xyz;
        _392 = normalize((_297 * _365.w) + ((_365.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _388 = _338;
        _389 = 0.5;
        _390 = 0.0;
        _391 = _332;
        _392 = _297;
    }
    bool _402 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _408;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339 + 18u)].w > 0.0) && _402)
    {
        _408 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _408 = 1.0;
    }
    float _455;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _340)].z > 0.0)
    {
        float3 _423 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _434 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_423.x), int(_423.y), int(_423.z), 0).xyz), 0));
        _455 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_434.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_423 / float3(_434.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _455 = _408;
    }
    float3 _469 = ((_391 - (_391 * _390)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _476 = (mix(float3(0.07999999821186065673828125 * _389), _391, float3(_390)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _479 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _484;
    if (_479)
    {
        _484 = _469 + (_476 * 0.449999988079071044921875);
    }
    else
    {
        _484 = _469;
    }
    float3 _486 = select(_476, float3(0.0), bool3(_479));
    float3 _488 = float3(dot(_486, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _495 = float3(_333);
    float3 _563;
    if (_402)
    {
        float3 _515 = fast::clamp((_239 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _519 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _515);
        float4 _523 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _515);
        float4 _526 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _515);
        float4 _544 = _172;
        _544.y = (-0.48860299587249755859375) * _392.y;
        float4 _547 = _544;
        _547.z = 0.48860299587249755859375 * _392.z;
        float4 _550 = _547;
        _550.w = (-0.48860299587249755859375) * _392.x;
        float4 _551 = _550;
        _551.x = 0.886227548122406005859375;
        float3 _553 = _551.yzw * 2.094395160675048828125;
        float4 _554 = float4(_551.x, _553.x, _553.y, _553.z);
        float3 _556 = float3(0.0);
        _556.x = dot(float4(_519.x, _523.x, _526.x, _519.w), _554);
        float3 _558 = _556;
        _558.y = dot(float4(_519.y, _523.y, _526.y, _523.w), _554);
        float3 _560 = _558;
        _560.z = dot(float4(_519.z, _523.z, _526.zw), _554);
        _563 = fast::max(float3(0.0), _560) * float3(0.3183098733425140380859375);
    }
    else
    {
        _563 = float3(0.0);
    }
    float _589;
    float _590;
    float3 _591;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _579;
        float _580;
        if (_402)
        {
            _579 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _580 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _579 = _392;
            _580 = 1.0;
        }
        float _581 = 1.0 - _580;
        float _583 = 1.0 - (_581 * _581);
        _589 = mix(fast::clamp(dot(_579, _392), 0.0, 1.0), 1.0, _583);
        _590 = _580;
        _591 = mix(_579, _392, float3(_583));
    }
    else
    {
        _589 = 1.0;
        _590 = 1.0;
        _591 = _392;
    }
    float4 _595 = float4(_591, 1.0);
    float3 _599 = _169;
    _599.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _595);
    float3 _603 = _599;
    _603.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _595);
    float3 _607 = _603;
    _607.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _595);
    float4 _610 = _595.xyzz * _595.yzzx;
    float3 _614 = _169;
    _614.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _610);
    float3 _618 = _614;
    _618.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _610);
    float3 _622 = _618;
    _622.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _610);
    float3 _637 = (_563 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_607 + _622) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_591.x * _591.x) - (_591.y * _591.y)))) * View.View_SkyLightColor.xyz) * (_590 * _589));
    float3 _659 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _688;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _687;
        if (any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339 + 19u)].xyz + float3(1.0))))
        {
            _687 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _687 = _659;
        }
        _688 = _687;
    }
    else
    {
        _688 = _659;
    }
    float4 _695 = float4(((mix(float3(0.0), _484 + (_486 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_637 * _484) * fast::max(_495, ((((((_391 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _333) + ((_391 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _333) + ((_391 * 2.755199909210205078125) + float3(0.69029998779296875))) * _333))) + _688) * 1.0, 0.0);
    float4 _702;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _701 = _695;
        _701.w = 0.0;
        _702 = _701;
    }
    else
    {
        _702 = _695;
    }
    float2 _706 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _714 = (_392 * 0.5) + float3(0.5);
    float4 _716 = float4(_714.x, _714.y, _714.z, float4(0.0).w);
    _716.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _340)].y;
    float4 _717 = float4(0.0);
    _717.x = _390;
    float4 _718 = _717;
    _718.y = _389;
    float4 _719 = _718;
    _719.z = _388;
    float4 _720 = _719;
    _720.w = 0.50588238239288330078125;
    float4 _732 = float4(_391.x, _391.y, _391.z, float4(0.0).w);
    _732.w = ((log2(((dot(_637, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_495, ((((((_488 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _333) + ((_488 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _333) + ((_488 * 2.755199909210205078125) + float3(0.69029998779296875))) * _333).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_706.xyx * _706.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _702 * View.View_PreExposure;
    out.out_var_SV_Target1 = _716;
    out.out_var_SV_Target2 = _720;
    out.out_var_SV_Target3 = _732;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_455, 1.0, 1.0, 1.0);
    return out;
}

