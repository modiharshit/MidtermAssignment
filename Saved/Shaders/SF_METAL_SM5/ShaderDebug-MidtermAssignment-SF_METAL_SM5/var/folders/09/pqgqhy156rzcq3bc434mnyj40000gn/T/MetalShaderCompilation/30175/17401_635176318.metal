

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
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

constant float4 _154 = {};
constant float3 _155 = {};
constant float _157 = {};
constant float4 _158 = {};

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
    float4 in_var_COLOR1 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000043f9_25dc057e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _208 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _214 = float4((_208 - float2(0.5)) * float2(2.0, -2.0), _157, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _219 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _224 = (_219.xyz / float3(_219.w)) - View.View_PreViewTranslation;
    float3 _232 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_208 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _240 = _239.xyz;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _257 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _257) : (in.in_var_COLOR1.w < _257)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _268 = fast::clamp(_240, float3(0.0), float3(1.0));
    float _272 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _319;
    float _320;
    float _321;
    float3 _322;
    float3 _323;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _289 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _293 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _289, level(0.0));
        float4 _296 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _289, level(0.0));
        float4 _299 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _289, level(0.0));
        float _309 = _299.w;
        _319 = (_272 * _309) + _299.z;
        _320 = (0.5 * _309) + _299.y;
        _321 = _299.x;
        _322 = (_268 * _293.w) + _293.xyz;
        _323 = normalize((_232 * _296.w) + ((_296.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _319 = _272;
        _320 = 0.5;
        _321 = 0.0;
        _322 = _268;
        _323 = _232;
    }
    bool _331 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _337;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _331)
    {
        _337 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _337 = 1.0;
    }
    float _384;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _352 = fast::clamp((_224 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _363 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_352.x), int(_352.y), int(_352.z), 0).xyz), 0));
        _384 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_363.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_352 / float3(_363.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _384 = _337;
    }
    float3 _398 = ((_322 - (_322 * _321)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _405 = (mix(float3(0.07999999821186065673828125 * _320), _322, float3(_321)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _408 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _413;
    if (_408)
    {
        _413 = _398 + (_405 * 0.449999988079071044921875);
    }
    else
    {
        _413 = _398;
    }
    float3 _415 = select(_405, float3(0.0), bool3(_408));
    float3 _417 = float3(dot(_415, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _503;
    if (_331)
    {
        float4 _453 = _158;
        _453.y = (-0.48860299587249755859375) * _323.y;
        float4 _456 = _453;
        _456.z = 0.48860299587249755859375 * _323.z;
        float4 _459 = _456;
        _459.w = (-0.48860299587249755859375) * _323.x;
        float3 _460 = _323 * _323;
        float4 _463 = _154;
        _463.x = (1.09254801273345947265625 * _323.x) * _323.y;
        float4 _466 = _463;
        _466.y = ((-1.09254801273345947265625) * _323.y) * _323.z;
        float4 _471 = _466;
        _471.z = 0.3153919875621795654296875 * ((3.0 * _460.z) - 1.0);
        float4 _474 = _471;
        _474.w = ((-1.09254801273345947265625) * _323.x) * _323.z;
        float4 _478 = _459;
        _478.x = 0.886227548122406005859375;
        float3 _480 = _478.yzw * 2.094395160675048828125;
        float4 _481 = float4(_478.x, _480.x, _480.y, _480.z);
        float4 _482 = _474 * 0.785398185253143310546875;
        float _483 = (_460.x - _460.y) * 0.4290426075458526611328125;
        float3 _489 = float3(0.0);
        _489.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _481) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _482)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _483);
        float3 _495 = _489;
        _495.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _481) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _482)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _483);
        float3 _501 = _495;
        _501.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _481) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _482)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _483);
        _503 = fast::max(float3(0.0), _501);
    }
    else
    {
        _503 = float3(0.0);
    }
    float _529;
    float _530;
    float3 _531;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _519;
        float _520;
        if (_331)
        {
            _519 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _520 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _519 = _323;
            _520 = 1.0;
        }
        float _521 = 1.0 - _520;
        float _523 = 1.0 - (_521 * _521);
        _529 = mix(fast::clamp(dot(_519, _323), 0.0, 1.0), 1.0, _523);
        _530 = _520;
        _531 = mix(_519, _323, float3(_523));
    }
    else
    {
        _529 = 1.0;
        _530 = 1.0;
        _531 = _323;
    }
    float4 _535 = float4(_531, 1.0);
    float3 _539 = _155;
    _539.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _535);
    float3 _543 = _539;
    _543.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _535);
    float3 _547 = _543;
    _547.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _535);
    float4 _550 = _535.xyzz * _535.yzzx;
    float3 _554 = _155;
    _554.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _550);
    float3 _558 = _554;
    _558.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _550);
    float3 _562 = _558;
    _562.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _550);
    float3 _577 = (_503 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_547 + _562) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_531.x * _531.x) - (_531.y * _531.y)))) * View.View_SkyLightColor.xyz) * (_530 * _529));
    float3 _599 = fast::max(mix(_240, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _625;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _624;
        if (any(abs(_224 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _624 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_224, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _624 = _599;
        }
        _625 = _624;
    }
    else
    {
        _625 = _599;
    }
    float4 _632 = float4(((mix(float3(0.0), _413 + (_415 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_577 * _413) * fast::max(float3(1.0), ((((((_322 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_322 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_322 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _625) * 1.0, 0.0);
    float4 _639;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _638 = _632;
        _638.w = 0.0;
        _639 = _638;
    }
    else
    {
        _639 = _632;
    }
    float2 _643 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _651 = (_323 * 0.5) + float3(0.5);
    float4 _653 = float4(_651.x, _651.y, _651.z, float4(0.0).w);
    _653.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _654 = float4(0.0);
    _654.x = _321;
    float4 _655 = _654;
    _655.y = _320;
    float4 _656 = _655;
    _656.z = _319;
    float4 _657 = _656;
    _657.w = 0.50588238239288330078125;
    float4 _669 = float4(_322.x, _322.y, _322.z, float4(0.0).w);
    _669.w = ((log2(((dot(_577, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_417 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_417 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_417 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_643.xyx * _643.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _639 * View.View_PreExposure;
    out.out_var_SV_Target1 = _653;
    out.out_var_SV_Target2 = _657;
    out.out_var_SV_Target3 = _669;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_384, 1.0, 1.0, 1.0);
    return out;
}

