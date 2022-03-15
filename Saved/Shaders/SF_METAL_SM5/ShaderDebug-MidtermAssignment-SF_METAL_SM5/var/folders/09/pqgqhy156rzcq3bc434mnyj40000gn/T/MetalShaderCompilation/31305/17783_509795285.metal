

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

constant float4 _158 = {};
constant float3 _159 = {};
constant float _161 = {};
constant float4 _162 = {};

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

fragment MainPS_out Main_00004577_1e62dbd5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _161, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float3 _237 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _261 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float3 _268 = fast::clamp(float3(mix(1.0, 0.89999997615814208984375, (_251.x + 0.5) * ((_256.x + 0.5) * (_261.x + 0.5)))), float3(0.0), float3(1.0));
    float _272 = (0.25 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _273 = in.in_var_PRIMITIVE_ID * 36u;
    uint _274 = _273 + 20u;
    float _323;
    float _324;
    float _325;
    float3 _326;
    float3 _327;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _274)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _292 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _296 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _292, level(0.0));
        float4 _299 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _292, level(0.0));
        float4 _302 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _292, level(0.0));
        float _312 = _302.w;
        _323 = (_272 * _312) + _302.z;
        _324 = (0.5 * _312) + _302.y;
        _325 = _312 + _302.x;
        _326 = (_268 * _296.w) + _296.xyz;
        _327 = normalize((_237 * _299.w) + ((_299.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _323 = _272;
        _324 = 0.5;
        _325 = 1.0;
        _326 = _268;
        _327 = _237;
    }
    bool _337 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _343;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273 + 18u)].w > 0.0) && _337)
    {
        _343 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _343 = 1.0;
    }
    float _390;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _274)].z > 0.0)
    {
        float3 _358 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _369 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_358.x), int(_358.y), int(_358.z), 0).xyz), 0));
        _390 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_369.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_358 / float3(_369.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _390 = _343;
    }
    float3 _404 = ((_326 - (_326 * _325)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _411 = (mix(float3(0.07999999821186065673828125 * _324), _326, float3(_325)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _414 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _419;
    if (_414)
    {
        _419 = _404 + (_411 * 0.449999988079071044921875);
    }
    else
    {
        _419 = _404;
    }
    float3 _421 = select(_411, float3(0.0), bool3(_414));
    float3 _423 = float3(dot(_421, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _509;
    if (_337)
    {
        float4 _459 = _162;
        _459.y = (-0.48860299587249755859375) * _327.y;
        float4 _462 = _459;
        _462.z = 0.48860299587249755859375 * _327.z;
        float4 _465 = _462;
        _465.w = (-0.48860299587249755859375) * _327.x;
        float3 _466 = _327 * _327;
        float4 _469 = _158;
        _469.x = (1.09254801273345947265625 * _327.x) * _327.y;
        float4 _472 = _469;
        _472.y = ((-1.09254801273345947265625) * _327.y) * _327.z;
        float4 _477 = _472;
        _477.z = 0.3153919875621795654296875 * ((3.0 * _466.z) - 1.0);
        float4 _480 = _477;
        _480.w = ((-1.09254801273345947265625) * _327.x) * _327.z;
        float4 _484 = _465;
        _484.x = 0.886227548122406005859375;
        float3 _486 = _484.yzw * 2.094395160675048828125;
        float4 _487 = float4(_484.x, _486.x, _486.y, _486.z);
        float4 _488 = _480 * 0.785398185253143310546875;
        float _489 = (_466.x - _466.y) * 0.4290426075458526611328125;
        float3 _495 = float3(0.0);
        _495.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _487) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _488)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _489);
        float3 _501 = _495;
        _501.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _487) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _488)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _489);
        float3 _507 = _501;
        _507.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _487) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _488)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _489);
        _509 = fast::max(float3(0.0), _507);
    }
    else
    {
        _509 = float3(0.0);
    }
    float _535;
    float _536;
    float3 _537;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _525;
        float _526;
        if (_337)
        {
            _525 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _526 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _525 = _327;
            _526 = 1.0;
        }
        float _527 = 1.0 - _526;
        float _529 = 1.0 - (_527 * _527);
        _535 = mix(fast::clamp(dot(_525, _327), 0.0, 1.0), 1.0, _529);
        _536 = _526;
        _537 = mix(_525, _327, float3(_529));
    }
    else
    {
        _535 = 1.0;
        _536 = 1.0;
        _537 = _327;
    }
    float4 _541 = float4(_537, 1.0);
    float3 _545 = _159;
    _545.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _541);
    float3 _549 = _545;
    _549.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _541);
    float3 _553 = _549;
    _553.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _541);
    float4 _556 = _541.xyzz * _541.yzzx;
    float3 _560 = _159;
    _560.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _556);
    float3 _564 = _560;
    _564.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _556);
    float3 _568 = _564;
    _568.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _556);
    float3 _583 = (_509 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_553 + _568) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_537.x * _537.x) - (_537.y * _537.y)))) * View.View_SkyLightColor.xyz) * (_536 * _535));
    float3 _605 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _634;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _633;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _273 + 19u)].xyz + float3(1.0))))
        {
            _633 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _633 = _605;
        }
        _634 = _633;
    }
    else
    {
        _634 = _605;
    }
    float4 _641 = float4(((mix(float3(0.0), _419 + (_421 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_583 * _419) * fast::max(float3(1.0), ((((((_326 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_326 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_326 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _634) * 1.0, 0.0);
    float4 _648;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _647 = _641;
        _647.w = 0.0;
        _648 = _647;
    }
    else
    {
        _648 = _641;
    }
    float2 _652 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _660 = (_327 * 0.5) + float3(0.5);
    float4 _662 = float4(_660.x, _660.y, _660.z, float4(0.0).w);
    _662.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _274)].y;
    float4 _663 = float4(0.0);
    _663.x = _325;
    float4 _664 = _663;
    _664.y = _324;
    float4 _665 = _664;
    _665.z = _323;
    float4 _666 = _665;
    _666.w = 0.50588238239288330078125;
    float4 _678 = float4(_326.x, _326.y, _326.z, float4(0.0).w);
    _678.w = ((log2(((dot(_583, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_423 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_423 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_423 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_652.xyx * _652.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _648 * View.View_PreExposure;
    out.out_var_SV_Target1 = _662;
    out.out_var_SV_Target2 = _666;
    out.out_var_SV_Target3 = _678;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_390, 1.0, 1.0, 1.0);
    return out;
}

