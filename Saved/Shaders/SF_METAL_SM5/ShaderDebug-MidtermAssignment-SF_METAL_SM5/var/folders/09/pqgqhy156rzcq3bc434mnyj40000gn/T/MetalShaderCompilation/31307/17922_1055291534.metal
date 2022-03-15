

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

constant float3 _156 = {};
constant float _158 = {};
constant float4 _159 = {};

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

fragment MainPS_out Main_00004602_3ee6788e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _158, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float3 _234 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _253 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _258 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float3 _265 = fast::clamp(float3(mix(1.0, 0.89999997615814208984375, (_248.x + 0.5) * ((_253.x + 0.5) * (_258.x + 0.5)))), float3(0.0), float3(1.0));
    float _269 = (0.4000000059604644775390625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _270 = in.in_var_PRIMITIVE_ID * 36u;
    uint _271 = _270 + 20u;
    float _320;
    float _321;
    float _322;
    float3 _323;
    float3 _324;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _271)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _289 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _293 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _289, level(0.0));
        float4 _296 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _289, level(0.0));
        float4 _299 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _289, level(0.0));
        float _309 = _299.w;
        _320 = (_269 * _309) + _299.z;
        _321 = (0.5 * _309) + _299.y;
        _322 = _309 + _299.x;
        _323 = (_265 * _293.w) + _293.xyz;
        _324 = normalize((_234 * _296.w) + ((_296.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _320 = _269;
        _321 = 0.5;
        _322 = 1.0;
        _323 = _265;
        _324 = _234;
    }
    bool _334 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _340;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _270 + 18u)].w > 0.0) && _334)
    {
        _340 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _340 = 1.0;
    }
    float _387;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _271)].z > 0.0)
    {
        float3 _355 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _366 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_355.x), int(_355.y), int(_355.z), 0).xyz), 0));
        _387 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_366.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_355 / float3(_366.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _387 = _340;
    }
    float3 _401 = ((_323 - (_323 * _322)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _408 = (mix(float3(0.07999999821186065673828125 * _321), _323, float3(_322)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _411 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _416;
    if (_411)
    {
        _416 = _401 + (_408 * 0.449999988079071044921875);
    }
    else
    {
        _416 = _401;
    }
    float3 _418 = select(_408, float3(0.0), bool3(_411));
    float3 _420 = float3(dot(_418, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _494;
    if (_334)
    {
        float3 _446 = fast::clamp((_226 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _450 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _446);
        float4 _454 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _446);
        float4 _457 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _446);
        float4 _475 = _159;
        _475.y = (-0.48860299587249755859375) * _324.y;
        float4 _478 = _475;
        _478.z = 0.48860299587249755859375 * _324.z;
        float4 _481 = _478;
        _481.w = (-0.48860299587249755859375) * _324.x;
        float4 _482 = _481;
        _482.x = 0.886227548122406005859375;
        float3 _484 = _482.yzw * 2.094395160675048828125;
        float4 _485 = float4(_482.x, _484.x, _484.y, _484.z);
        float3 _487 = float3(0.0);
        _487.x = dot(float4(_450.x, _454.x, _457.x, _450.w), _485);
        float3 _489 = _487;
        _489.y = dot(float4(_450.y, _454.y, _457.y, _454.w), _485);
        float3 _491 = _489;
        _491.z = dot(float4(_450.z, _454.z, _457.zw), _485);
        _494 = fast::max(float3(0.0), _491) * float3(0.3183098733425140380859375);
    }
    else
    {
        _494 = float3(0.0);
    }
    float _520;
    float _521;
    float3 _522;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _510;
        float _511;
        if (_334)
        {
            _510 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _511 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _510 = _324;
            _511 = 1.0;
        }
        float _512 = 1.0 - _511;
        float _514 = 1.0 - (_512 * _512);
        _520 = mix(fast::clamp(dot(_510, _324), 0.0, 1.0), 1.0, _514);
        _521 = _511;
        _522 = mix(_510, _324, float3(_514));
    }
    else
    {
        _520 = 1.0;
        _521 = 1.0;
        _522 = _324;
    }
    float4 _526 = float4(_522, 1.0);
    float3 _530 = _156;
    _530.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _526);
    float3 _534 = _530;
    _534.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _526);
    float3 _538 = _534;
    _538.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _526);
    float4 _541 = _526.xyzz * _526.yzzx;
    float3 _545 = _156;
    _545.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _541);
    float3 _549 = _545;
    _549.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _541);
    float3 _553 = _549;
    _553.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _541);
    float3 _568 = (_494 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_538 + _553) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_522.x * _522.x) - (_522.y * _522.y)))) * View.View_SkyLightColor.xyz) * (_521 * _520));
    float3 _590 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _619;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _618;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _270 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _270 + 19u)].xyz + float3(1.0))))
        {
            _618 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _618 = _590;
        }
        _619 = _618;
    }
    else
    {
        _619 = _590;
    }
    float4 _626 = float4(((mix(float3(0.0), _416 + (_418 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_568 * _416) * fast::max(float3(1.0), ((((((_323 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_323 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_323 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _619) * 1.0, 0.0);
    float4 _633;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _632 = _626;
        _632.w = 0.0;
        _633 = _632;
    }
    else
    {
        _633 = _626;
    }
    float2 _637 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _645 = (_324 * 0.5) + float3(0.5);
    float4 _647 = float4(_645.x, _645.y, _645.z, float4(0.0).w);
    _647.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _271)].y;
    float4 _648 = float4(0.0);
    _648.x = _322;
    float4 _649 = _648;
    _649.y = _321;
    float4 _650 = _649;
    _650.z = _320;
    float4 _651 = _650;
    _651.w = 0.50588238239288330078125;
    float4 _663 = float4(_323.x, _323.y, _323.z, float4(0.0).w);
    _663.w = ((log2(((dot(_568, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_420 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_420 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_420 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_637.xyx * _637.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _633 * View.View_PreExposure;
    out.out_var_SV_Target1 = _647;
    out.out_var_SV_Target2 = _651;
    out.out_var_SV_Target3 = _663;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_387, 1.0, 1.0, 1.0);
    return out;
}

