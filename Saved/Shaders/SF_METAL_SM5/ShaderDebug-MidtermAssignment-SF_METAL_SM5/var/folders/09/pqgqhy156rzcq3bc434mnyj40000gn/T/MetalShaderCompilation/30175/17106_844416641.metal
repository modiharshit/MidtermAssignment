

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

constant float4 _151 = {};
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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000042d2_3254c681(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float2 _203 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _209 = float4((_203 - float2(0.5)) * float2(2.0, -2.0), _154, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _214 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = (_214.xyz / float3(_214.w)) - View.View_PreViewTranslation;
    float3 _227 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_203 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _235 = _234.xyz;
    float3 _243 = fast::clamp(_235, float3(0.0), float3(1.0));
    float _247 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _248 = in.in_var_PRIMITIVE_ID * 36u;
    uint _249 = _248 + 20u;
    float _297;
    float _298;
    float _299;
    float3 _300;
    float3 _301;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _267 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _271 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _267, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _267, level(0.0));
        float4 _277 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _267, level(0.0));
        float _287 = _277.w;
        _297 = (_247 * _287) + _277.z;
        _298 = (0.5 * _287) + _277.y;
        _299 = _277.x;
        _300 = (_243 * _271.w) + _271.xyz;
        _301 = normalize((_227 * _274.w) + ((_274.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _297 = _247;
        _298 = 0.5;
        _299 = 0.0;
        _300 = _243;
        _301 = _227;
    }
    bool _311 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _317;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248 + 18u)].w > 0.0) && _311)
    {
        _317 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _317 = 1.0;
    }
    float _364;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249)].z > 0.0)
    {
        float3 _332 = fast::clamp((_219 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _343 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_332.x), int(_332.y), int(_332.z), 0).xyz), 0));
        _364 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_343.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_332 / float3(_343.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _364 = _317;
    }
    float3 _378 = ((_300 - (_300 * _299)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _385 = (mix(float3(0.07999999821186065673828125 * _298), _300, float3(_299)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _388 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _393;
    if (_388)
    {
        _393 = _378 + (_385 * 0.449999988079071044921875);
    }
    else
    {
        _393 = _378;
    }
    float3 _395 = select(_385, float3(0.0), bool3(_388));
    float3 _397 = float3(dot(_395, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _483;
    if (_311)
    {
        float4 _433 = _155;
        _433.y = (-0.48860299587249755859375) * _301.y;
        float4 _436 = _433;
        _436.z = 0.48860299587249755859375 * _301.z;
        float4 _439 = _436;
        _439.w = (-0.48860299587249755859375) * _301.x;
        float3 _440 = _301 * _301;
        float4 _443 = _151;
        _443.x = (1.09254801273345947265625 * _301.x) * _301.y;
        float4 _446 = _443;
        _446.y = ((-1.09254801273345947265625) * _301.y) * _301.z;
        float4 _451 = _446;
        _451.z = 0.3153919875621795654296875 * ((3.0 * _440.z) - 1.0);
        float4 _454 = _451;
        _454.w = ((-1.09254801273345947265625) * _301.x) * _301.z;
        float4 _458 = _439;
        _458.x = 0.886227548122406005859375;
        float3 _460 = _458.yzw * 2.094395160675048828125;
        float4 _461 = float4(_458.x, _460.x, _460.y, _460.z);
        float4 _462 = _454 * 0.785398185253143310546875;
        float _463 = (_440.x - _440.y) * 0.4290426075458526611328125;
        float3 _469 = float3(0.0);
        _469.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _461) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _462)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _463);
        float3 _475 = _469;
        _475.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _461) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _462)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _463);
        float3 _481 = _475;
        _481.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _461) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _462)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _463);
        _483 = fast::max(float3(0.0), _481);
    }
    else
    {
        _483 = float3(0.0);
    }
    float _509;
    float _510;
    float3 _511;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _499;
        float _500;
        if (_311)
        {
            _499 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _500 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _499 = _301;
            _500 = 1.0;
        }
        float _501 = 1.0 - _500;
        float _503 = 1.0 - (_501 * _501);
        _509 = mix(fast::clamp(dot(_499, _301), 0.0, 1.0), 1.0, _503);
        _510 = _500;
        _511 = mix(_499, _301, float3(_503));
    }
    else
    {
        _509 = 1.0;
        _510 = 1.0;
        _511 = _301;
    }
    float4 _515 = float4(_511, 1.0);
    float3 _519 = _152;
    _519.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _515);
    float3 _523 = _519;
    _523.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _515);
    float3 _527 = _523;
    _527.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _515);
    float4 _530 = _515.xyzz * _515.yzzx;
    float3 _534 = _152;
    _534.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _530);
    float3 _538 = _534;
    _538.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _530);
    float3 _542 = _538;
    _542.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _530);
    float3 _557 = (_483 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_527 + _542) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_511.x * _511.x) - (_511.y * _511.y)))) * View.View_SkyLightColor.xyz) * (_510 * _509));
    float3 _579 = fast::max(mix(_235, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _608;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _607;
        if (any(abs(_219 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _248 + 19u)].xyz + float3(1.0))))
        {
            _607 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_219, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _607 = _579;
        }
        _608 = _607;
    }
    else
    {
        _608 = _579;
    }
    float4 _615 = float4(((mix(float3(0.0), _393 + (_395 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_557 * _393) * fast::max(float3(1.0), ((((((_300 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_300 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_300 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _608) * 1.0, 0.0);
    float4 _622;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _621 = _615;
        _621.w = 0.0;
        _622 = _621;
    }
    else
    {
        _622 = _615;
    }
    float2 _626 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _634 = (_301 * 0.5) + float3(0.5);
    float4 _636 = float4(_634.x, _634.y, _634.z, float4(0.0).w);
    _636.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249)].y;
    float4 _637 = float4(0.0);
    _637.x = _299;
    float4 _638 = _637;
    _638.y = _298;
    float4 _639 = _638;
    _639.z = _297;
    float4 _640 = _639;
    _640.w = 0.50588238239288330078125;
    float4 _652 = float4(_300.x, _300.y, _300.z, float4(0.0).w);
    _652.w = ((log2(((dot(_557, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_626.xyx * _626.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _622 * View.View_PreExposure;
    out.out_var_SV_Target1 = _636;
    out.out_var_SV_Target2 = _640;
    out.out_var_SV_Target3 = _652;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_364, 1.0, 1.0, 1.0);
    return out;
}

