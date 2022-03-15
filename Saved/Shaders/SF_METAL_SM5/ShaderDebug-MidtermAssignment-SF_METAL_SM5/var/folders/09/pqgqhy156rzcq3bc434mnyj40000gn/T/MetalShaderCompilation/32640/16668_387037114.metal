

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

constant float3 _146 = {};
constant float _148 = {};
constant float4 _149 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000411c_1711b7ba(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _148, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _207 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = (_207.xyz / float3(_207.w)) - View.View_PreViewTranslation;
    float3 _220 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _229 = in.in_var_PRIMITIVE_ID * 36u;
    uint _230 = _229 + 20u;
    float _275;
    float _276;
    float _277;
    float3 _278;
    float3 _279;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _248 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _255 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float4 _258 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float _267 = _258.w;
        _275 = (View.View_RoughnessOverrideParameter.x * _267) + _258.z;
        _276 = (0.5 * _267) + _258.y;
        _277 = _258.x;
        _278 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0)).xyz;
        _279 = normalize((_220 * _255.w) + ((_255.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _275 = View.View_RoughnessOverrideParameter.x;
        _276 = 0.5;
        _277 = 0.0;
        _278 = float3(0.0);
        _279 = _220;
    }
    bool _289 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _295;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 18u)].w > 0.0) && _289)
    {
        _295 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _295 = 1.0;
    }
    float _342;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].z > 0.0)
    {
        float3 _310 = fast::clamp((_212 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _321 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_310.x), int(_310.y), int(_310.z), 0).xyz), 0));
        _342 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_321.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_310 / float3(_321.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _342 = _295;
    }
    float3 _356 = ((_278 - (_278 * _277)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _363 = (mix(float3(0.07999999821186065673828125 * _276), _278, float3(_277)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _366 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _371;
    if (_366)
    {
        _371 = _356 + (_363 * 0.449999988079071044921875);
    }
    else
    {
        _371 = _356;
    }
    float3 _373 = select(_363, float3(0.0), bool3(_366));
    float3 _375 = float3(dot(_373, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _449;
    if (_289)
    {
        float3 _401 = fast::clamp((_212 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _405 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _401);
        float4 _409 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _401);
        float4 _412 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _401);
        float4 _430 = _149;
        _430.y = (-0.48860299587249755859375) * _279.y;
        float4 _433 = _430;
        _433.z = 0.48860299587249755859375 * _279.z;
        float4 _436 = _433;
        _436.w = (-0.48860299587249755859375) * _279.x;
        float4 _437 = _436;
        _437.x = 0.886227548122406005859375;
        float3 _439 = _437.yzw * 2.094395160675048828125;
        float4 _440 = float4(_437.x, _439.x, _439.y, _439.z);
        float3 _442 = float3(0.0);
        _442.x = dot(float4(_405.x, _409.x, _412.x, _405.w), _440);
        float3 _444 = _442;
        _444.y = dot(float4(_405.y, _409.y, _412.y, _409.w), _440);
        float3 _446 = _444;
        _446.z = dot(float4(_405.z, _409.z, _412.zw), _440);
        _449 = fast::max(float3(0.0), _446) * float3(0.3183098733425140380859375);
    }
    else
    {
        _449 = float3(0.0);
    }
    float _475;
    float _476;
    float3 _477;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _465;
        float _466;
        if (_289)
        {
            _465 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _466 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _465 = _279;
            _466 = 1.0;
        }
        float _467 = 1.0 - _466;
        float _469 = 1.0 - (_467 * _467);
        _475 = mix(fast::clamp(dot(_465, _279), 0.0, 1.0), 1.0, _469);
        _476 = _466;
        _477 = mix(_465, _279, float3(_469));
    }
    else
    {
        _475 = 1.0;
        _476 = 1.0;
        _477 = _279;
    }
    float4 _481 = float4(_477, 1.0);
    float3 _485 = _146;
    _485.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _481);
    float3 _489 = _485;
    _489.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _481);
    float3 _493 = _489;
    _493.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _481);
    float4 _496 = _481.xyzz * _481.yzzx;
    float3 _500 = _146;
    _500.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _496);
    float3 _504 = _500;
    _504.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _496);
    float3 _508 = _504;
    _508.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _496);
    float3 _523 = (_449 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_493 + _508) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_477.x * _477.x) - (_477.y * _477.y)))) * View.View_SkyLightColor.xyz) * (_476 * _475));
    float3 _545 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _574;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _573;
        if (any(abs(_212 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 19u)].xyz + float3(1.0))))
        {
            _573 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_212, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _573 = _545;
        }
        _574 = _573;
    }
    else
    {
        _574 = _545;
    }
    float4 _581 = float4(((mix(float3(0.0), _371 + (_373 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_523 * _371) * fast::max(float3(1.0), ((((((_278 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_278 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_278 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _574) * 1.0, 0.0);
    float4 _588;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _587 = _581;
        _587.w = 0.0;
        _588 = _587;
    }
    else
    {
        _588 = _581;
    }
    float2 _592 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _600 = (_279 * 0.5) + float3(0.5);
    float4 _602 = float4(_600.x, _600.y, _600.z, float4(0.0).w);
    _602.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _230)].y;
    float4 _603 = float4(0.0);
    _603.x = _277;
    float4 _604 = _603;
    _604.y = _276;
    float4 _605 = _604;
    _605.z = _275;
    float4 _606 = _605;
    _606.w = 0.50588238239288330078125;
    float4 _618 = float4(_278.x, _278.y, _278.z, float4(0.0).w);
    _618.w = ((log2(((dot(_523, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_375 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_375 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_375 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_592.xyx * _592.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _588 * View.View_PreExposure;
    out.out_var_SV_Target1 = _602;
    out.out_var_SV_Target2 = _606;
    out.out_var_SV_Target3 = _618;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_342, 1.0, 1.0, 1.0);
    return out;
}

