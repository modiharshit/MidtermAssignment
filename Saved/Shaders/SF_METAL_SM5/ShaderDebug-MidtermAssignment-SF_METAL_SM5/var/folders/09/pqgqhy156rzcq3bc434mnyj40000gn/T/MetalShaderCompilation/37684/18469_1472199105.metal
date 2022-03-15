

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
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

fragment MainPS_out Main_00004825_57bff9c1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_238, sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _272 = _265.y;
    float _278 = _265.z;
    float _281 = _265.x;
    float3 _299 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_272)), Material.Material_VectorExpressions[7].xyz, float3(_278)) * _281, float3(0.0), float3(1.0));
    float _300 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _272), Material.Material_ScalarExpressions[0].w, _278), 0.0, 1.0);
    float _301 = fast::clamp(_281, 0.0, 1.0);
    float _306 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _272), Material.Material_ScalarExpressions[1].z, _278), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _307 = in.in_var_PRIMITIVE_ID * 36u;
    uint _308 = _307 + 20u;
    float _358;
    float _359;
    float _360;
    float3 _361;
    float3 _362;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _326 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _330 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float4 _333 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float4 _336 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _326, level(0.0));
        float _346 = _336.w;
        _358 = (_306 * _346) + _336.z;
        _359 = (0.5 * _346) + _336.y;
        _360 = (_300 * _346) + _336.x;
        _361 = (_299 * _330.w) + _330.xyz;
        _362 = normalize((_254 * _333.w) + ((_333.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _358 = _306;
        _359 = 0.5;
        _360 = _300;
        _361 = _299;
        _362 = _254;
    }
    bool _372 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _378;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 18u)].w > 0.0) && _372)
    {
        _378 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _378 = 1.0;
    }
    float _425;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].z > 0.0)
    {
        float3 _393 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _404 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_393.x), int(_393.y), int(_393.z), 0).xyz), 0));
        _425 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_404.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_393 / float3(_404.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _425 = _378;
    }
    float3 _439 = ((_361 - (_361 * _360)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _446 = (mix(float3(0.07999999821186065673828125 * _359), _361, float3(_360)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _449 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _454;
    if (_449)
    {
        _454 = _439 + (_446 * 0.449999988079071044921875);
    }
    else
    {
        _454 = _439;
    }
    float3 _456 = select(_446, float3(0.0), bool3(_449));
    float3 _458 = float3(dot(_456, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _465 = float3(_301);
    float3 _533;
    if (_372)
    {
        float3 _485 = fast::clamp((_229 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _489 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _485);
        float4 _493 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _485);
        float4 _496 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _485);
        float4 _514 = _163;
        _514.y = (-0.48860299587249755859375) * _362.y;
        float4 _517 = _514;
        _517.z = 0.48860299587249755859375 * _362.z;
        float4 _520 = _517;
        _520.w = (-0.48860299587249755859375) * _362.x;
        float4 _521 = _520;
        _521.x = 0.886227548122406005859375;
        float3 _523 = _521.yzw * 2.094395160675048828125;
        float4 _524 = float4(_521.x, _523.x, _523.y, _523.z);
        float3 _526 = float3(0.0);
        _526.x = dot(float4(_489.x, _493.x, _496.x, _489.w), _524);
        float3 _528 = _526;
        _528.y = dot(float4(_489.y, _493.y, _496.y, _493.w), _524);
        float3 _530 = _528;
        _530.z = dot(float4(_489.z, _493.z, _496.zw), _524);
        _533 = fast::max(float3(0.0), _530) * float3(0.3183098733425140380859375);
    }
    else
    {
        _533 = float3(0.0);
    }
    float _559;
    float _560;
    float3 _561;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _549;
        float _550;
        if (_372)
        {
            _549 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _550 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _549 = _362;
            _550 = 1.0;
        }
        float _551 = 1.0 - _550;
        float _553 = 1.0 - (_551 * _551);
        _559 = mix(fast::clamp(dot(_549, _362), 0.0, 1.0), 1.0, _553);
        _560 = _550;
        _561 = mix(_549, _362, float3(_553));
    }
    else
    {
        _559 = 1.0;
        _560 = 1.0;
        _561 = _362;
    }
    float4 _565 = float4(_561, 1.0);
    float3 _569 = _160;
    _569.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _565);
    float3 _573 = _569;
    _573.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _565);
    float3 _577 = _573;
    _577.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _565);
    float4 _580 = _565.xyzz * _565.yzzx;
    float3 _584 = _160;
    _584.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _580);
    float3 _588 = _584;
    _588.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _580);
    float3 _592 = _588;
    _592.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _580);
    float3 _607 = (_533 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_577 + _592) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_561.x * _561.x) - (_561.y * _561.y)))) * View.View_SkyLightColor.xyz) * (_560 * _559));
    float3 _629 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _658;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _657;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307 + 19u)].xyz + float3(1.0))))
        {
            _657 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _657 = _629;
        }
        _658 = _657;
    }
    else
    {
        _658 = _629;
    }
    float4 _665 = float4(((mix(float3(0.0), _454 + (_456 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_607 * _454) * fast::max(_465, ((((((_361 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _301) + ((_361 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _301) + ((_361 * 2.755199909210205078125) + float3(0.69029998779296875))) * _301))) + _658) * 1.0, 0.0);
    float4 _672;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _671 = _665;
        _671.w = 0.0;
        _672 = _671;
    }
    else
    {
        _672 = _665;
    }
    float2 _676 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _684 = (_362 * 0.5) + float3(0.5);
    float4 _686 = float4(_684.x, _684.y, _684.z, float4(0.0).w);
    _686.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _308)].y;
    float4 _687 = float4(0.0);
    _687.x = _360;
    float4 _688 = _687;
    _688.y = _359;
    float4 _689 = _688;
    _689.z = _358;
    float4 _690 = _689;
    _690.w = 0.50588238239288330078125;
    float4 _702 = float4(_361.x, _361.y, _361.z, float4(0.0).w);
    _702.w = ((log2(((dot(_607, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_465, ((((((_458 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _301) + ((_458 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _301) + ((_458 * 2.755199909210205078125) + float3(0.69029998779296875))) * _301).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_676.xyx * _676.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _672 * View.View_PreExposure;
    out.out_var_SV_Target1 = _686;
    out.out_var_SV_Target2 = _690;
    out.out_var_SV_Target3 = _702;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_425, 1.0, 1.0, 1.0);
    return out;
}

