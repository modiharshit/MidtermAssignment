

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _159 = {};
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

fragment MainPS_out Main_00004690_74dfcdaa(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float3 _255 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_239, sqrt(fast::clamp(1.0 - dot(_239, _239), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _273 = _266.y;
    float3 _283 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_273)), float3(0.0), float3(1.0));
    float _284 = fast::clamp(mix(0.0, 1.0, _273), 0.0, 1.0);
    float _285 = fast::clamp(_266.x, 0.0, 1.0);
    float _290 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _273), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _291 = in.in_var_PRIMITIVE_ID * 36u;
    uint _292 = _291 + 20u;
    float _342;
    float _343;
    float _344;
    float3 _345;
    float3 _346;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _310 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _314 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float4 _317 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float4 _320 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _310, level(0.0));
        float _330 = _320.w;
        _342 = (_290 * _330) + _320.z;
        _343 = (0.5 * _330) + _320.y;
        _344 = (_284 * _330) + _320.x;
        _345 = (_283 * _314.w) + _314.xyz;
        _346 = normalize((_255 * _317.w) + ((_317.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _342 = _290;
        _343 = 0.5;
        _344 = _284;
        _345 = _283;
        _346 = _255;
    }
    bool _356 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _362;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291 + 18u)].w > 0.0) && _356)
    {
        _362 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _362 = 1.0;
    }
    float _409;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292)].z > 0.0)
    {
        float3 _377 = fast::clamp((_230 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _388 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_377.x), int(_377.y), int(_377.z), 0).xyz), 0));
        _409 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_388.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_377 / float3(_388.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _409 = _362;
    }
    float3 _423 = ((_345 - (_345 * _344)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _430 = (mix(float3(0.07999999821186065673828125 * _343), _345, float3(_344)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _433 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _438;
    if (_433)
    {
        _438 = _423 + (_430 * 0.449999988079071044921875);
    }
    else
    {
        _438 = _423;
    }
    float3 _440 = select(_430, float3(0.0), bool3(_433));
    float3 _442 = float3(dot(_440, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _449 = float3(_285);
    float3 _529;
    if (_356)
    {
        float4 _479 = _163;
        _479.y = (-0.48860299587249755859375) * _346.y;
        float4 _482 = _479;
        _482.z = 0.48860299587249755859375 * _346.z;
        float4 _485 = _482;
        _485.w = (-0.48860299587249755859375) * _346.x;
        float3 _486 = _346 * _346;
        float4 _489 = _159;
        _489.x = (1.09254801273345947265625 * _346.x) * _346.y;
        float4 _492 = _489;
        _492.y = ((-1.09254801273345947265625) * _346.y) * _346.z;
        float4 _497 = _492;
        _497.z = 0.3153919875621795654296875 * ((3.0 * _486.z) - 1.0);
        float4 _500 = _497;
        _500.w = ((-1.09254801273345947265625) * _346.x) * _346.z;
        float4 _504 = _485;
        _504.x = 0.886227548122406005859375;
        float3 _506 = _504.yzw * 2.094395160675048828125;
        float4 _507 = float4(_504.x, _506.x, _506.y, _506.z);
        float4 _508 = _500 * 0.785398185253143310546875;
        float _509 = (_486.x - _486.y) * 0.4290426075458526611328125;
        float3 _515 = float3(0.0);
        _515.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _507) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _508)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _509);
        float3 _521 = _515;
        _521.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _507) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _508)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _509);
        float3 _527 = _521;
        _527.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _507) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _508)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _509);
        _529 = fast::max(float3(0.0), _527);
    }
    else
    {
        _529 = float3(0.0);
    }
    float _555;
    float _556;
    float3 _557;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _545;
        float _546;
        if (_356)
        {
            _545 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _546 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _545 = _346;
            _546 = 1.0;
        }
        float _547 = 1.0 - _546;
        float _549 = 1.0 - (_547 * _547);
        _555 = mix(fast::clamp(dot(_545, _346), 0.0, 1.0), 1.0, _549);
        _556 = _546;
        _557 = mix(_545, _346, float3(_549));
    }
    else
    {
        _555 = 1.0;
        _556 = 1.0;
        _557 = _346;
    }
    float4 _561 = float4(_557, 1.0);
    float3 _565 = _160;
    _565.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _561);
    float3 _569 = _565;
    _569.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _561);
    float3 _573 = _569;
    _573.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _561);
    float4 _576 = _561.xyzz * _561.yzzx;
    float3 _580 = _160;
    _580.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _576);
    float3 _584 = _580;
    _584.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _576);
    float3 _588 = _584;
    _588.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _576);
    float3 _603 = (_529 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_573 + _588) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_557.x * _557.x) - (_557.y * _557.y)))) * View.View_SkyLightColor.xyz) * (_556 * _555));
    float3 _625 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _654;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _653;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _291 + 19u)].xyz + float3(1.0))))
        {
            _653 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _653 = _625;
        }
        _654 = _653;
    }
    else
    {
        _654 = _625;
    }
    float4 _661 = float4(((mix(float3(0.0), _438 + (_440 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_603 * _438) * fast::max(_449, ((((((_345 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _285) + ((_345 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _285) + ((_345 * 2.755199909210205078125) + float3(0.69029998779296875))) * _285))) + _654) * 1.0, 0.0);
    float4 _668;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _667 = _661;
        _667.w = 0.0;
        _668 = _667;
    }
    else
    {
        _668 = _661;
    }
    float2 _672 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _680 = (_346 * 0.5) + float3(0.5);
    float4 _682 = float4(_680.x, _680.y, _680.z, float4(0.0).w);
    _682.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292)].y;
    float4 _683 = float4(0.0);
    _683.x = _344;
    float4 _684 = _683;
    _684.y = _343;
    float4 _685 = _684;
    _685.z = _342;
    float4 _686 = _685;
    _686.w = 0.50588238239288330078125;
    float4 _698 = float4(_345.x, _345.y, _345.z, float4(0.0).w);
    _698.w = ((log2(((dot(_603, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_449, ((((((_442 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _285) + ((_442 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _285) + ((_442 * 2.755199909210205078125) + float3(0.69029998779296875))) * _285).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_672.xyx * _672.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _668 * View.View_PreExposure;
    out.out_var_SV_Target1 = _682;
    out.out_var_SV_Target2 = _686;
    out.out_var_SV_Target3 = _698;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_409, 1.0, 1.0, 1.0);
    return out;
}
