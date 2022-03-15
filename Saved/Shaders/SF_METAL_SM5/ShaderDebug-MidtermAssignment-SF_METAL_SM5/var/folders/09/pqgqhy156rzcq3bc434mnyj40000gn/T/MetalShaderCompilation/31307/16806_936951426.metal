

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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _152 = {};
constant float _153 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000041a6_37d8be82(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _153, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float4 _224 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _227 = (_224.xy * float2(2.0)) - float2(1.0);
    float _234 = sqrt(fast::clamp(1.0 - dot(_227, _227), 0.0, 1.0)) + 1.0;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _249 = float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _252 = float3(_227, _234);
    float3 _256 = float3(_249.xy * (-1.0), _249.z);
    float3 _268 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_252 * dot(_252, _256)) - (_256 * _234)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _285 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _294 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _298 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_280.x + 0.5) * (_285.x + 0.5))) * _294.xyz, float3(0.0), float3(1.0));
    float _299 = fast::clamp(_294.w, 0.0, 1.0);
    float _303 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _304 = in.in_var_PRIMITIVE_ID * 36u;
    uint _305 = _304 + 20u;
    float _353;
    float _354;
    float _355;
    float3 _356;
    float3 _357;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _323 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _327 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _323, level(0.0));
        float4 _330 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _323, level(0.0));
        float4 _333 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _323, level(0.0));
        float _343 = _333.w;
        _353 = (_303 * _343) + _333.z;
        _354 = (_299 * _343) + _333.y;
        _355 = _333.x;
        _356 = (_298 * _327.w) + _327.xyz;
        _357 = normalize((_268 * _330.w) + ((_330.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _353 = _303;
        _354 = _299;
        _355 = 0.0;
        _356 = _298;
        _357 = _268;
    }
    float4 _364 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _365 = in.in_var_LIGHTMAP_ID * 15u;
    uint _366 = _365 + 1u;
    float4 _373 = fast::clamp((_364 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _366)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _366)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _390 = ((_356 - (_356 * _355)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _397 = (mix(float3(0.07999999821186065673828125 * _354), _356, float3(_355)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _400 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _405;
    if (_400)
    {
        _405 = _390 + (_397 * 0.449999988079071044921875);
    }
    else
    {
        _405 = _390;
    }
    float3 _407 = select(_397, float3(0.0), bool3(_400));
    float3 _409 = float3(dot(_407, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _424 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _428 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _424);
    float4 _430 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_424 + float2(0.0, 0.5)));
    uint _436 = _365 + 4u;
    uint _441 = _365 + 6u;
    float3 _446 = _428.xyz;
    float _498;
    float _499;
    float3 _500;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _482 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _486 = _482.w;
        float _487 = _486 * _486;
        float3 _489 = normalize(((_482.xyz * 2.0) - float3(1.0)).xyz);
        float _490 = 1.0 - _487;
        float _492 = 1.0 - (_490 * _490);
        _498 = mix(fast::clamp(dot(_489, _357), 0.0, 1.0), 1.0, _492);
        _499 = _487;
        _500 = mix(_489, _357, float3(_492));
    }
    else
    {
        _498 = 1.0;
        _499 = 1.0;
        _500 = _357;
    }
    float4 _504 = float4(_500, 1.0);
    float3 _508 = _152;
    _508.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _504);
    float3 _512 = _508;
    _512.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _504);
    float3 _516 = _512;
    _516.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _504);
    float4 _519 = _504.xyzz * _504.yzzx;
    float3 _523 = _152;
    _523.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _519);
    float3 _527 = _523;
    _527.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _519);
    float3 _531 = _527;
    _531.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _519);
    float3 _546 = (((((_446 * _446) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _436)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _441)].xyz) * ((exp2(((_428.w + ((_430.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _436)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _441)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_430 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _365 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _365 + 7u)], float4(_357.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_516 + _531) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_500.x * _500.x) - (_500.y * _500.y)))) * View.View_SkyLightColor.xyz) * (_499 * _498));
    float3 _568 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _597;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _596;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304 + 19u)].xyz + float3(1.0))))
        {
            _596 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _596 = _568;
        }
        _597 = _596;
    }
    else
    {
        _597 = _568;
    }
    float4 _604 = float4(((mix(float3(0.0), _405 + (_407 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_546 * _405) * fast::max(float3(1.0), ((((((_356 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_356 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_356 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _597) * 1.0, 0.0);
    float4 _611;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _610 = _604;
        _610.w = 0.0;
        _611 = _610;
    }
    else
    {
        _611 = _604;
    }
    float2 _615 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _623 = (_357 * 0.5) + float3(0.5);
    float4 _625 = float4(_623.x, _623.y, _623.z, float4(0.0).w);
    _625.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305)].y;
    float4 _626 = float4(0.0);
    _626.x = _355;
    float4 _627 = _626;
    _627.y = _354;
    float4 _628 = _627;
    _628.z = _353;
    float4 _629 = _628;
    _629.w = 0.50588238239288330078125;
    float4 _641 = float4(_356.x, _356.y, _356.z, float4(0.0).w);
    _641.w = ((log2(((dot(_546, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_409 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_409 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_409 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_615.xyx * _615.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _611 * View.View_PreExposure;
    out.out_var_SV_Target1 = _625;
    out.out_var_SV_Target2 = _629;
    out.out_var_SV_Target3 = _641;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _365)] * _373) * _373;
    return out;
}

