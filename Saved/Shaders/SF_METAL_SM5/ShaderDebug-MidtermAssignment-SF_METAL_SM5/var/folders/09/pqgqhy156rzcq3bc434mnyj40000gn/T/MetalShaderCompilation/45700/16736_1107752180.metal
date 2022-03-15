

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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _148 = {};
constant float3 _149 = {};
constant float _151 = {};
constant float4 _152 = {};

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

fragment MainPS_out Main_00004160_4206f4f4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float3 _223 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _234 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _238 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _239 = in.in_var_PRIMITIVE_ID * 36u;
    uint _240 = _239 + 20u;
    float _288;
    float _289;
    float _290;
    float3 _291;
    float3 _292;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _258 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _262 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float _278 = _268.w;
        _288 = (_238 * _278) + _268.z;
        _289 = (0.5 * _278) + _268.y;
        _290 = _268.x;
        _291 = (_234 * _262.w) + _262.xyz;
        _292 = normalize((_223 * _265.w) + ((_265.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _288 = _238;
        _289 = 0.5;
        _290 = 0.0;
        _291 = _234;
        _292 = _223;
    }
    bool _302 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _308;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 18u)].w > 0.0) && _302)
    {
        _308 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _308 = 1.0;
    }
    float _355;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].z > 0.0)
    {
        float3 _323 = fast::clamp((_215 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _334 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_323.x), int(_323.y), int(_323.z), 0).xyz), 0));
        _355 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_334.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_323 / float3(_334.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _355 = _308;
    }
    float3 _369 = ((_291 - (_291 * _290)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _376 = (mix(float3(0.07999999821186065673828125 * _289), _291, float3(_290)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _379 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _384;
    if (_379)
    {
        _384 = _369 + (_376 * 0.449999988079071044921875);
    }
    else
    {
        _384 = _369;
    }
    float3 _386 = select(_376, float3(0.0), bool3(_379));
    float3 _388 = float3(dot(_386, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _474;
    if (_302)
    {
        float4 _424 = _152;
        _424.y = (-0.48860299587249755859375) * _292.y;
        float4 _427 = _424;
        _427.z = 0.48860299587249755859375 * _292.z;
        float4 _430 = _427;
        _430.w = (-0.48860299587249755859375) * _292.x;
        float3 _431 = _292 * _292;
        float4 _434 = _148;
        _434.x = (1.09254801273345947265625 * _292.x) * _292.y;
        float4 _437 = _434;
        _437.y = ((-1.09254801273345947265625) * _292.y) * _292.z;
        float4 _442 = _437;
        _442.z = 0.3153919875621795654296875 * ((3.0 * _431.z) - 1.0);
        float4 _445 = _442;
        _445.w = ((-1.09254801273345947265625) * _292.x) * _292.z;
        float4 _449 = _430;
        _449.x = 0.886227548122406005859375;
        float3 _451 = _449.yzw * 2.094395160675048828125;
        float4 _452 = float4(_449.x, _451.x, _451.y, _451.z);
        float4 _453 = _445 * 0.785398185253143310546875;
        float _454 = (_431.x - _431.y) * 0.4290426075458526611328125;
        float3 _460 = float3(0.0);
        _460.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _452) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _453)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _454);
        float3 _466 = _460;
        _466.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _452) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _453)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _454);
        float3 _472 = _466;
        _472.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _452) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _453)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _454);
        _474 = fast::max(float3(0.0), _472);
    }
    else
    {
        _474 = float3(0.0);
    }
    float _500;
    float _501;
    float3 _502;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _490;
        float _491;
        if (_302)
        {
            _490 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _491 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _490 = _292;
            _491 = 1.0;
        }
        float _492 = 1.0 - _491;
        float _494 = 1.0 - (_492 * _492);
        _500 = mix(fast::clamp(dot(_490, _292), 0.0, 1.0), 1.0, _494);
        _501 = _491;
        _502 = mix(_490, _292, float3(_494));
    }
    else
    {
        _500 = 1.0;
        _501 = 1.0;
        _502 = _292;
    }
    float4 _506 = float4(_502, 1.0);
    float3 _510 = _149;
    _510.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _506);
    float3 _514 = _510;
    _514.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _506);
    float3 _518 = _514;
    _518.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _506);
    float4 _521 = _506.xyzz * _506.yzzx;
    float3 _525 = _149;
    _525.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _521);
    float3 _529 = _525;
    _529.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _521);
    float3 _533 = _529;
    _533.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _521);
    float3 _548 = (_474 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_518 + _533) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_502.x * _502.x) - (_502.y * _502.y)))) * View.View_SkyLightColor.xyz) * (_501 * _500));
    float3 _570 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _599;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _598;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 19u)].xyz + float3(1.0))))
        {
            _598 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _598 = _570;
        }
        _599 = _598;
    }
    else
    {
        _599 = _570;
    }
    float4 _606 = float4(((mix(float3(0.0), _384 + (_386 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_548 * _384) * fast::max(float3(1.0), ((((((_291 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_291 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_291 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _599) * 1.0, 0.0);
    float4 _613;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _612 = _606;
        _612.w = 0.0;
        _613 = _612;
    }
    else
    {
        _613 = _606;
    }
    float2 _617 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _625 = (_292 * 0.5) + float3(0.5);
    float4 _627 = float4(_625.x, _625.y, _625.z, float4(0.0).w);
    _627.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].y;
    float4 _628 = float4(0.0);
    _628.x = _290;
    float4 _629 = _628;
    _629.y = _289;
    float4 _630 = _629;
    _630.z = _288;
    float4 _631 = _630;
    _631.w = 0.50588238239288330078125;
    float4 _643 = float4(_291.x, _291.y, _291.z, float4(0.0).w);
    _643.w = ((log2(((dot(_548, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_617.xyx * _617.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _613 * View.View_PreExposure;
    out.out_var_SV_Target1 = _627;
    out.out_var_SV_Target2 = _631;
    out.out_var_SV_Target3 = _643;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_355, 1.0, 1.0, 1.0);
    return out;
}

