

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

constant float4 _163 = {};
constant float3 _164 = {};
constant float _166 = {};
constant float4 _167 = {};

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

fragment MainPS_out Main_000048f5_b51a2357(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _166, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _229 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _234 = (_229.xyz / float3(_229.w)) - View.View_PreViewTranslation;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float3 _259 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _271 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _285 = (_271.x + 0.5) * ((_276.x + 0.5) * (_281.x + 0.5));
    float4 _291 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _297 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_285)) * _291.xyz, float3(0.0), float3(1.0));
    float _302 = (fast::clamp(mix(0.60000002384185791015625, 0.4000000059604644775390625, _285 * _291.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _303 = in.in_var_PRIMITIVE_ID * 36u;
    uint _304 = _303 + 20u;
    float _353;
    float _354;
    float _355;
    float3 _356;
    float3 _357;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _322 = ((_224.xy / float2(_224.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _326 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _332 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float _342 = _332.w;
        _353 = (_302 * _342) + _332.z;
        _354 = (0.5 * _342) + _332.y;
        _355 = _342 + _332.x;
        _356 = (_297 * _326.w) + _326.xyz;
        _357 = normalize((_259 * _329.w) + ((_329.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _353 = _302;
        _354 = 0.5;
        _355 = 1.0;
        _356 = _297;
        _357 = _259;
    }
    bool _367 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _373;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 18u)].w > 0.0) && _367)
    {
        _373 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _373 = 1.0;
    }
    float _420;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].z > 0.0)
    {
        float3 _388 = fast::clamp((_234 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _399 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_388.x), int(_388.y), int(_388.z), 0).xyz), 0));
        _420 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_399.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_388 / float3(_399.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _420 = _373;
    }
    float3 _434 = ((_356 - (_356 * _355)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _441 = (mix(float3(0.07999999821186065673828125 * _354), _356, float3(_355)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _444 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _449;
    if (_444)
    {
        _449 = _434 + (_441 * 0.449999988079071044921875);
    }
    else
    {
        _449 = _434;
    }
    float3 _451 = select(_441, float3(0.0), bool3(_444));
    float3 _453 = float3(dot(_451, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _539;
    if (_367)
    {
        float4 _489 = _167;
        _489.y = (-0.48860299587249755859375) * _357.y;
        float4 _492 = _489;
        _492.z = 0.48860299587249755859375 * _357.z;
        float4 _495 = _492;
        _495.w = (-0.48860299587249755859375) * _357.x;
        float3 _496 = _357 * _357;
        float4 _499 = _163;
        _499.x = (1.09254801273345947265625 * _357.x) * _357.y;
        float4 _502 = _499;
        _502.y = ((-1.09254801273345947265625) * _357.y) * _357.z;
        float4 _507 = _502;
        _507.z = 0.3153919875621795654296875 * ((3.0 * _496.z) - 1.0);
        float4 _510 = _507;
        _510.w = ((-1.09254801273345947265625) * _357.x) * _357.z;
        float4 _514 = _495;
        _514.x = 0.886227548122406005859375;
        float3 _516 = _514.yzw * 2.094395160675048828125;
        float4 _517 = float4(_514.x, _516.x, _516.y, _516.z);
        float4 _518 = _510 * 0.785398185253143310546875;
        float _519 = (_496.x - _496.y) * 0.4290426075458526611328125;
        float3 _525 = float3(0.0);
        _525.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _517) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _518)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _519);
        float3 _531 = _525;
        _531.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _517) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _518)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _519);
        float3 _537 = _531;
        _537.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _517) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _518)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _519);
        _539 = fast::max(float3(0.0), _537);
    }
    else
    {
        _539 = float3(0.0);
    }
    float _565;
    float _566;
    float3 _567;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _555;
        float _556;
        if (_367)
        {
            _555 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _556 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _555 = _357;
            _556 = 1.0;
        }
        float _557 = 1.0 - _556;
        float _559 = 1.0 - (_557 * _557);
        _565 = mix(fast::clamp(dot(_555, _357), 0.0, 1.0), 1.0, _559);
        _566 = _556;
        _567 = mix(_555, _357, float3(_559));
    }
    else
    {
        _565 = 1.0;
        _566 = 1.0;
        _567 = _357;
    }
    float4 _571 = float4(_567, 1.0);
    float3 _575 = _164;
    _575.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _571);
    float3 _579 = _575;
    _579.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _571);
    float3 _583 = _579;
    _583.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _571);
    float4 _586 = _571.xyzz * _571.yzzx;
    float3 _590 = _164;
    _590.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _586);
    float3 _594 = _590;
    _594.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _586);
    float3 _598 = _594;
    _598.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _586);
    float3 _613 = (_539 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_583 + _598) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_567.x * _567.x) - (_567.y * _567.y)))) * View.View_SkyLightColor.xyz) * (_566 * _565));
    float3 _635 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _664;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _663;
        if (any(abs(_234 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 19u)].xyz + float3(1.0))))
        {
            _663 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_234, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _663 = _635;
        }
        _664 = _663;
    }
    else
    {
        _664 = _635;
    }
    float4 _671 = float4(((mix(float3(0.0), _449 + (_451 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_613 * _449) * fast::max(float3(1.0), ((((((_356 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_356 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_356 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _664) * 1.0, 0.0);
    float4 _678;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _677 = _671;
        _677.w = 0.0;
        _678 = _677;
    }
    else
    {
        _678 = _671;
    }
    float2 _682 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _690 = (_357 * 0.5) + float3(0.5);
    float4 _692 = float4(_690.x, _690.y, _690.z, float4(0.0).w);
    _692.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].y;
    float4 _693 = float4(0.0);
    _693.x = _355;
    float4 _694 = _693;
    _694.y = _354;
    float4 _695 = _694;
    _695.z = _353;
    float4 _696 = _695;
    _696.w = 0.50588238239288330078125;
    float4 _708 = float4(_356.x, _356.y, _356.z, float4(0.0).w);
    _708.w = ((log2(((dot(_613, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_453 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_453 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_453 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_682.xyx * _682.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _678 * View.View_PreExposure;
    out.out_var_SV_Target1 = _692;
    out.out_var_SV_Target2 = _696;
    out.out_var_SV_Target3 = _708;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_420, 1.0, 1.0, 1.0);
    return out;
}

