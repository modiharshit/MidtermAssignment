

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _161 = {};
constant float3 _162 = {};
constant float _164 = {};
constant float4 _165 = {};

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

fragment MainPS_out Main_000047b9_b0d6e9c5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _164, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _226 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _231 = (_226.xyz / float3(_226.w)) - View.View_PreViewTranslation;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _256 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _267 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _274 = _267.y;
    float _280 = _267.z;
    float _283 = _267.x;
    float3 _301 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_274)), Material.Material_VectorExpressions[7].xyz, float3(_280)) * _283, float3(0.0), float3(1.0));
    float _302 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _274), Material.Material_ScalarExpressions[0].w, _280), 0.0, 1.0);
    float _303 = fast::clamp(_283, 0.0, 1.0);
    float _308 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _274), Material.Material_ScalarExpressions[1].z, _280), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _309 = in.in_var_PRIMITIVE_ID * 36u;
    uint _310 = _309 + 20u;
    float _360;
    float _361;
    float _362;
    float3 _363;
    float3 _364;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _328 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _332 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _335 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float4 _338 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _328, level(0.0));
        float _348 = _338.w;
        _360 = (_308 * _348) + _338.z;
        _361 = (0.5 * _348) + _338.y;
        _362 = (_302 * _348) + _338.x;
        _363 = (_301 * _332.w) + _332.xyz;
        _364 = normalize((_256 * _335.w) + ((_335.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _360 = _308;
        _361 = 0.5;
        _362 = _302;
        _363 = _301;
        _364 = _256;
    }
    bool _374 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _380;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 18u)].w > 0.0) && _374)
    {
        _380 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _380 = 1.0;
    }
    float _427;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].z > 0.0)
    {
        float3 _395 = fast::clamp((_231 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _406 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_395.x), int(_395.y), int(_395.z), 0).xyz), 0));
        _427 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_406.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_395 / float3(_406.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _427 = _380;
    }
    float3 _441 = ((_363 - (_363 * _362)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _448 = (mix(float3(0.07999999821186065673828125 * _361), _363, float3(_362)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _451 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _456;
    if (_451)
    {
        _456 = _441 + (_448 * 0.449999988079071044921875);
    }
    else
    {
        _456 = _441;
    }
    float3 _458 = select(_448, float3(0.0), bool3(_451));
    float3 _460 = float3(dot(_458, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _467 = float3(_303);
    float3 _547;
    if (_374)
    {
        float4 _497 = _165;
        _497.y = (-0.48860299587249755859375) * _364.y;
        float4 _500 = _497;
        _500.z = 0.48860299587249755859375 * _364.z;
        float4 _503 = _500;
        _503.w = (-0.48860299587249755859375) * _364.x;
        float3 _504 = _364 * _364;
        float4 _507 = _161;
        _507.x = (1.09254801273345947265625 * _364.x) * _364.y;
        float4 _510 = _507;
        _510.y = ((-1.09254801273345947265625) * _364.y) * _364.z;
        float4 _515 = _510;
        _515.z = 0.3153919875621795654296875 * ((3.0 * _504.z) - 1.0);
        float4 _518 = _515;
        _518.w = ((-1.09254801273345947265625) * _364.x) * _364.z;
        float4 _522 = _503;
        _522.x = 0.886227548122406005859375;
        float3 _524 = _522.yzw * 2.094395160675048828125;
        float4 _525 = float4(_522.x, _524.x, _524.y, _524.z);
        float4 _526 = _518 * 0.785398185253143310546875;
        float _527 = (_504.x - _504.y) * 0.4290426075458526611328125;
        float3 _533 = float3(0.0);
        _533.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _525) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _526)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _527);
        float3 _539 = _533;
        _539.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _525) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _526)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _527);
        float3 _545 = _539;
        _545.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _525) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _526)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _527);
        _547 = fast::max(float3(0.0), _545);
    }
    else
    {
        _547 = float3(0.0);
    }
    float _573;
    float _574;
    float3 _575;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _563;
        float _564;
        if (_374)
        {
            _563 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _564 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _563 = _364;
            _564 = 1.0;
        }
        float _565 = 1.0 - _564;
        float _567 = 1.0 - (_565 * _565);
        _573 = mix(fast::clamp(dot(_563, _364), 0.0, 1.0), 1.0, _567);
        _574 = _564;
        _575 = mix(_563, _364, float3(_567));
    }
    else
    {
        _573 = 1.0;
        _574 = 1.0;
        _575 = _364;
    }
    float4 _579 = float4(_575, 1.0);
    float3 _583 = _162;
    _583.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _579);
    float3 _587 = _583;
    _587.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _579);
    float3 _591 = _587;
    _591.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _579);
    float4 _594 = _579.xyzz * _579.yzzx;
    float3 _598 = _162;
    _598.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _594);
    float3 _602 = _598;
    _602.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _594);
    float3 _606 = _602;
    _606.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _594);
    float3 _621 = (_547 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_591 + _606) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_575.x * _575.x) - (_575.y * _575.y)))) * View.View_SkyLightColor.xyz) * (_574 * _573));
    float3 _643 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _672;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _671;
        if (any(abs(_231 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _309 + 19u)].xyz + float3(1.0))))
        {
            _671 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_231, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _671 = _643;
        }
        _672 = _671;
    }
    else
    {
        _672 = _643;
    }
    float4 _679 = float4(((mix(float3(0.0), _456 + (_458 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_621 * _456) * fast::max(_467, ((((((_363 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _303) + ((_363 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _303) + ((_363 * 2.755199909210205078125) + float3(0.69029998779296875))) * _303))) + _672) * 1.0, 0.0);
    float4 _686;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _685 = _679;
        _685.w = 0.0;
        _686 = _685;
    }
    else
    {
        _686 = _679;
    }
    float2 _690 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _698 = (_364 * 0.5) + float3(0.5);
    float4 _700 = float4(_698.x, _698.y, _698.z, float4(0.0).w);
    _700.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310)].y;
    float4 _701 = float4(0.0);
    _701.x = _362;
    float4 _702 = _701;
    _702.y = _361;
    float4 _703 = _702;
    _703.z = _360;
    float4 _704 = _703;
    _704.w = 0.50588238239288330078125;
    float4 _716 = float4(_363.x, _363.y, _363.z, float4(0.0).w);
    _716.w = ((log2(((dot(_621, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_467, ((((((_460 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _303) + ((_460 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _303) + ((_460 * 2.755199909210205078125) + float3(0.69029998779296875))) * _303).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_690.xyx * _690.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _686 * View.View_PreExposure;
    out.out_var_SV_Target1 = _700;
    out.out_var_SV_Target2 = _704;
    out.out_var_SV_Target3 = _716;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_427, 1.0, 1.0, 1.0);
    return out;
}

