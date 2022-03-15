

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
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

fragment MainPS_out Main_000040b0_be828ba3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _205 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _210 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = (_210.xyz / float3(_210.w)) - View.View_PreViewTranslation;
    float3 _223 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _232 = in.in_var_PRIMITIVE_ID * 36u;
    uint _233 = _232 + 20u;
    float _278;
    float _279;
    float _280;
    float3 _281;
    float3 _282;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _251 = ((_205.xy / float2(_205.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _258 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float4 _261 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0));
        float _270 = _261.w;
        _278 = (View.View_RoughnessOverrideParameter.x * _270) + _261.z;
        _279 = (0.5 * _270) + _261.y;
        _280 = _261.x;
        _281 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _251, level(0.0)).xyz;
        _282 = normalize((_223 * _258.w) + ((_258.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _278 = View.View_RoughnessOverrideParameter.x;
        _279 = 0.5;
        _280 = 0.0;
        _281 = float3(0.0);
        _282 = _223;
    }
    bool _292 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _298;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 18u)].w > 0.0) && _292)
    {
        _298 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _298 = 1.0;
    }
    float _345;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].z > 0.0)
    {
        float3 _313 = fast::clamp((_215 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _324 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_313.x), int(_313.y), int(_313.z), 0).xyz), 0));
        _345 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_324.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_313 / float3(_324.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _345 = _298;
    }
    float3 _359 = ((_281 - (_281 * _280)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _366 = (mix(float3(0.07999999821186065673828125 * _279), _281, float3(_280)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _369 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _374;
    if (_369)
    {
        _374 = _359 + (_366 * 0.449999988079071044921875);
    }
    else
    {
        _374 = _359;
    }
    float3 _376 = select(_366, float3(0.0), bool3(_369));
    float3 _378 = float3(dot(_376, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _464;
    if (_292)
    {
        float4 _414 = _152;
        _414.y = (-0.48860299587249755859375) * _282.y;
        float4 _417 = _414;
        _417.z = 0.48860299587249755859375 * _282.z;
        float4 _420 = _417;
        _420.w = (-0.48860299587249755859375) * _282.x;
        float3 _421 = _282 * _282;
        float4 _424 = _148;
        _424.x = (1.09254801273345947265625 * _282.x) * _282.y;
        float4 _427 = _424;
        _427.y = ((-1.09254801273345947265625) * _282.y) * _282.z;
        float4 _432 = _427;
        _432.z = 0.3153919875621795654296875 * ((3.0 * _421.z) - 1.0);
        float4 _435 = _432;
        _435.w = ((-1.09254801273345947265625) * _282.x) * _282.z;
        float4 _439 = _420;
        _439.x = 0.886227548122406005859375;
        float3 _441 = _439.yzw * 2.094395160675048828125;
        float4 _442 = float4(_439.x, _441.x, _441.y, _441.z);
        float4 _443 = _435 * 0.785398185253143310546875;
        float _444 = (_421.x - _421.y) * 0.4290426075458526611328125;
        float3 _450 = float3(0.0);
        _450.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _442) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _443)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _444);
        float3 _456 = _450;
        _456.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _442) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _443)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _444);
        float3 _462 = _456;
        _462.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _442) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _443)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _444);
        _464 = fast::max(float3(0.0), _462);
    }
    else
    {
        _464 = float3(0.0);
    }
    float _490;
    float _491;
    float3 _492;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _480;
        float _481;
        if (_292)
        {
            _480 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _481 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _480 = _282;
            _481 = 1.0;
        }
        float _482 = 1.0 - _481;
        float _484 = 1.0 - (_482 * _482);
        _490 = mix(fast::clamp(dot(_480, _282), 0.0, 1.0), 1.0, _484);
        _491 = _481;
        _492 = mix(_480, _282, float3(_484));
    }
    else
    {
        _490 = 1.0;
        _491 = 1.0;
        _492 = _282;
    }
    float4 _496 = float4(_492, 1.0);
    float3 _500 = _149;
    _500.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _496);
    float3 _504 = _500;
    _504.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _496);
    float3 _508 = _504;
    _508.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _496);
    float4 _511 = _496.xyzz * _496.yzzx;
    float3 _515 = _149;
    _515.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _511);
    float3 _519 = _515;
    _519.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _511);
    float3 _523 = _519;
    _523.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _511);
    float3 _538 = (_464 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_508 + _523) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_492.x * _492.x) - (_492.y * _492.y)))) * View.View_SkyLightColor.xyz) * (_491 * _490));
    float3 _560 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _589;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _588;
        if (any(abs(_215 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 19u)].xyz + float3(1.0))))
        {
            _588 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_215, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _588 = _560;
        }
        _589 = _588;
    }
    else
    {
        _589 = _560;
    }
    float4 _596 = float4(((mix(float3(0.0), _374 + (_376 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_538 * _374) * fast::max(float3(1.0), ((((((_281 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_281 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_281 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _589) * 1.0, 0.0);
    float4 _603;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _602 = _596;
        _602.w = 0.0;
        _603 = _602;
    }
    else
    {
        _603 = _596;
    }
    float2 _607 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _615 = (_282 * 0.5) + float3(0.5);
    float4 _617 = float4(_615.x, _615.y, _615.z, float4(0.0).w);
    _617.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233)].y;
    float4 _618 = float4(0.0);
    _618.x = _280;
    float4 _619 = _618;
    _619.y = _279;
    float4 _620 = _619;
    _620.z = _278;
    float4 _621 = _620;
    _621.w = 0.50588238239288330078125;
    float4 _633 = float4(_281.x, _281.y, _281.z, float4(0.0).w);
    _633.w = ((log2(((dot(_538, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_378 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_378 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_378 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_607.xyx * _607.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _603 * View.View_PreExposure;
    out.out_var_SV_Target1 = _617;
    out.out_var_SV_Target2 = _621;
    out.out_var_SV_Target3 = _633;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_345, 1.0, 1.0, 1.0);
    return out;
}

