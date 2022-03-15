

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

constant float3 _160 = {};
constant float _162 = {};
constant float4 _163 = {};

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

fragment MainPS_out Main_0000499d_8963c530(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    float4 _236 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _239 = (_236.xy * float2(2.0)) - float2(1.0);
    float _246 = sqrt(fast::clamp(1.0 - dot(_239, _239), 0.0, 1.0)) + 1.0;
    float2 _247 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _251 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float _258 = sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0));
    float3 _264 = float3(_239, _246);
    float3 _267 = float3(float4(_254, _258, 1.0).xy * (-1.0), _258);
    float3 _279 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_264 * dot(_264, _267)) - (_267 * _246)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _290 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _247, bias(View.View_MaterialTextureMipBias));
    float4 _294 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _299 = fast::clamp(_290.xyz, float3(0.0), float3(1.0));
    float _300 = fast::clamp(_294.x, 0.0, 1.0);
    float _305 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _306 = in.in_var_PRIMITIVE_ID * 36u;
    uint _307 = _306 + 20u;
    float _355;
    float _356;
    float _357;
    float3 _358;
    float3 _359;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _325 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _329 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float4 _332 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float4 _335 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float _345 = _335.w;
        _355 = (_305 * _345) + _335.z;
        _356 = (0.5 * _345) + _335.y;
        _357 = _335.x;
        _358 = (_299 * _329.w) + _329.xyz;
        _359 = normalize((_279 * _332.w) + ((_332.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _355 = _305;
        _356 = 0.5;
        _357 = 0.0;
        _358 = _299;
        _359 = _279;
    }
    bool _369 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _375;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 18u)].w > 0.0) && _369)
    {
        _375 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _375 = 1.0;
    }
    float _422;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].z > 0.0)
    {
        float3 _390 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _401 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_390.x), int(_390.y), int(_390.z), 0).xyz), 0));
        _422 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_401.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_390 / float3(_401.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _422 = _375;
    }
    float3 _436 = ((_358 - (_358 * _357)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _443 = (mix(float3(0.07999999821186065673828125 * _356), _358, float3(_357)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _446 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _451;
    if (_446)
    {
        _451 = _436 + (_443 * 0.449999988079071044921875);
    }
    else
    {
        _451 = _436;
    }
    float3 _453 = select(_443, float3(0.0), bool3(_446));
    float3 _455 = float3(dot(_453, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _462 = float3(_300);
    float3 _530;
    if (_369)
    {
        float3 _482 = fast::clamp((_230 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _486 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _482);
        float4 _490 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _482);
        float4 _493 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _482);
        float4 _511 = _163;
        _511.y = (-0.48860299587249755859375) * _359.y;
        float4 _514 = _511;
        _514.z = 0.48860299587249755859375 * _359.z;
        float4 _517 = _514;
        _517.w = (-0.48860299587249755859375) * _359.x;
        float4 _518 = _517;
        _518.x = 0.886227548122406005859375;
        float3 _520 = _518.yzw * 2.094395160675048828125;
        float4 _521 = float4(_518.x, _520.x, _520.y, _520.z);
        float3 _523 = float3(0.0);
        _523.x = dot(float4(_486.x, _490.x, _493.x, _486.w), _521);
        float3 _525 = _523;
        _525.y = dot(float4(_486.y, _490.y, _493.y, _490.w), _521);
        float3 _527 = _525;
        _527.z = dot(float4(_486.z, _490.z, _493.zw), _521);
        _530 = fast::max(float3(0.0), _527) * float3(0.3183098733425140380859375);
    }
    else
    {
        _530 = float3(0.0);
    }
    float _556;
    float _557;
    float3 _558;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _546;
        float _547;
        if (_369)
        {
            _546 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _547 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _546 = _359;
            _547 = 1.0;
        }
        float _548 = 1.0 - _547;
        float _550 = 1.0 - (_548 * _548);
        _556 = mix(fast::clamp(dot(_546, _359), 0.0, 1.0), 1.0, _550);
        _557 = _547;
        _558 = mix(_546, _359, float3(_550));
    }
    else
    {
        _556 = 1.0;
        _557 = 1.0;
        _558 = _359;
    }
    float4 _562 = float4(_558, 1.0);
    float3 _566 = _160;
    _566.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _562);
    float3 _570 = _566;
    _570.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _562);
    float3 _574 = _570;
    _574.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _562);
    float4 _577 = _562.xyzz * _562.yzzx;
    float3 _581 = _160;
    _581.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _577);
    float3 _585 = _581;
    _585.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _577);
    float3 _589 = _585;
    _589.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _577);
    float3 _604 = (_530 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_574 + _589) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_558.x * _558.x) - (_558.y * _558.y)))) * View.View_SkyLightColor.xyz) * (_557 * _556));
    float3 _626 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _655;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _654;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 19u)].xyz + float3(1.0))))
        {
            _654 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _654 = _626;
        }
        _655 = _654;
    }
    else
    {
        _655 = _626;
    }
    float4 _662 = float4(((mix(float3(0.0), _451 + (_453 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_604 * _451) * fast::max(_462, ((((((_358 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _300) + ((_358 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _300) + ((_358 * 2.755199909210205078125) + float3(0.69029998779296875))) * _300))) + _655) * 1.0, 0.0);
    float4 _669;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _668 = _662;
        _668.w = 0.0;
        _669 = _668;
    }
    else
    {
        _669 = _662;
    }
    float2 _673 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _681 = (_359 * 0.5) + float3(0.5);
    float4 _683 = float4(_681.x, _681.y, _681.z, float4(0.0).w);
    _683.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].y;
    float4 _684 = float4(0.0);
    _684.x = _357;
    float4 _685 = _684;
    _685.y = _356;
    float4 _686 = _685;
    _686.z = _355;
    float4 _687 = _686;
    _687.w = 0.50588238239288330078125;
    float4 _699 = float4(_358.x, _358.y, _358.z, float4(0.0).w);
    _699.w = ((log2(((dot(_604, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_462, ((((((_455 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _300) + ((_455 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _300) + ((_455 * 2.755199909210205078125) + float3(0.69029998779296875))) * _300).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_673.xyx * _673.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _669 * View.View_PreExposure;
    out.out_var_SV_Target1 = _683;
    out.out_var_SV_Target2 = _687;
    out.out_var_SV_Target3 = _699;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_422, 1.0, 1.0, 1.0);
    return out;
}

