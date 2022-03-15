

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

constant float4 _162 = {};
constant float3 _163 = {};
constant float _165 = {};
constant float4 _166 = {};

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

fragment MainPS_out Main_0000492d_4a6b1efd(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _165, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _233 = (_228.xyz / float3(_228.w)) - View.View_PreViewTranslation;
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float _249 = sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)) + 1.0;
    float2 _250 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _254 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float _261 = sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0));
    float3 _267 = float3(_242, _249);
    float3 _270 = float3(float4(_257, _261, 1.0).xy * (-1.0), _261);
    float3 _282 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_267 * dot(_267, _270)) - (_270 * _249)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _293 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float4 _297 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _302 = fast::clamp(_293.xyz, float3(0.0), float3(1.0));
    float _303 = fast::clamp(_297.x, 0.0, 1.0);
    float _308 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _309 = in.in_var_PRIMITIVE_ID * 36u;
    uint _310 = _309 + 20u;
    float _358;
    float _359;
    float _360;
    float3 _361;
    float3 _362;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _328 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _332 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _335 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _338 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float _348 = _338.w;
        _358 = (_308 * _348) + _338.z;
        _359 = (0.5 * _348) + _338.y;
        _360 = _338.x;
        _361 = (_302 * _332.w) + _332.xyz;
        _362 = normalize((_282 * _335.w) + ((_335.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _358 = _308;
        _359 = 0.5;
        _360 = 0.0;
        _361 = _302;
        _362 = _282;
    }
    bool _372 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _378;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 18u)].w > 0.0) && _372)
    {
        _378 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _378 = 1.0;
    }
    float _425;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].z > 0.0)
    {
        float3 _393 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
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
    float3 _465 = float3(_303);
    float3 _545;
    if (_372)
    {
        float4 _495 = _166;
        _495.y = (-0.48860299587249755859375) * _362.y;
        float4 _498 = _495;
        _498.z = 0.48860299587249755859375 * _362.z;
        float4 _501 = _498;
        _501.w = (-0.48860299587249755859375) * _362.x;
        float3 _502 = _362 * _362;
        float4 _505 = _162;
        _505.x = (1.09254801273345947265625 * _362.x) * _362.y;
        float4 _508 = _505;
        _508.y = ((-1.09254801273345947265625) * _362.y) * _362.z;
        float4 _513 = _508;
        _513.z = 0.3153919875621795654296875 * ((3.0 * _502.z) - 1.0);
        float4 _516 = _513;
        _516.w = ((-1.09254801273345947265625) * _362.x) * _362.z;
        float4 _520 = _501;
        _520.x = 0.886227548122406005859375;
        float3 _522 = _520.yzw * 2.094395160675048828125;
        float4 _523 = float4(_520.x, _522.x, _522.y, _522.z);
        float4 _524 = _516 * 0.785398185253143310546875;
        float _525 = (_502.x - _502.y) * 0.4290426075458526611328125;
        float3 _531 = float3(0.0);
        _531.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _523) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _524)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _525);
        float3 _537 = _531;
        _537.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _523) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _524)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _525);
        float3 _543 = _537;
        _543.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _523) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _524)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _525);
        _545 = fast::max(float3(0.0), _543);
    }
    else
    {
        _545 = float3(0.0);
    }
    float _571;
    float _572;
    float3 _573;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _561;
        float _562;
        if (_372)
        {
            _561 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _562 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _561 = _362;
            _562 = 1.0;
        }
        float _563 = 1.0 - _562;
        float _565 = 1.0 - (_563 * _563);
        _571 = mix(fast::clamp(dot(_561, _362), 0.0, 1.0), 1.0, _565);
        _572 = _562;
        _573 = mix(_561, _362, float3(_565));
    }
    else
    {
        _571 = 1.0;
        _572 = 1.0;
        _573 = _362;
    }
    float4 _577 = float4(_573, 1.0);
    float3 _581 = _163;
    _581.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _577);
    float3 _585 = _581;
    _585.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _577);
    float3 _589 = _585;
    _589.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _577);
    float4 _592 = _577.xyzz * _577.yzzx;
    float3 _596 = _163;
    _596.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _592);
    float3 _600 = _596;
    _600.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _592);
    float3 _604 = _600;
    _604.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _592);
    float3 _619 = (_545 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_589 + _604) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_573.x * _573.x) - (_573.y * _573.y)))) * View.View_SkyLightColor.xyz) * (_572 * _571));
    float3 _641 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _670;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _669;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 19u)].xyz + float3(1.0))))
        {
            _669 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _669 = _641;
        }
        _670 = _669;
    }
    else
    {
        _670 = _641;
    }
    float4 _677 = float4(((mix(float3(0.0), _454 + (_456 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_619 * _454) * fast::max(_465, ((((((_361 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _303) + ((_361 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _303) + ((_361 * 2.755199909210205078125) + float3(0.69029998779296875))) * _303))) + _670) * 1.0, 0.0);
    float4 _684;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _683 = _677;
        _683.w = 0.0;
        _684 = _683;
    }
    else
    {
        _684 = _677;
    }
    float2 _688 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _696 = (_362 * 0.5) + float3(0.5);
    float4 _698 = float4(_696.x, _696.y, _696.z, float4(0.0).w);
    _698.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].y;
    float4 _699 = float4(0.0);
    _699.x = _360;
    float4 _700 = _699;
    _700.y = _359;
    float4 _701 = _700;
    _701.z = _358;
    float4 _702 = _701;
    _702.w = 0.50588238239288330078125;
    float4 _714 = float4(_361.x, _361.y, _361.z, float4(0.0).w);
    _714.w = ((log2(((dot(_619, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_465, ((((((_458 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _303) + ((_458 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _303) + ((_458 * 2.755199909210205078125) + float3(0.69029998779296875))) * _303).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_688.xyx * _688.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _684 * View.View_PreExposure;
    out.out_var_SV_Target1 = _698;
    out.out_var_SV_Target2 = _702;
    out.out_var_SV_Target3 = _714;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_425, 1.0, 1.0, 1.0);
    return out;
}

