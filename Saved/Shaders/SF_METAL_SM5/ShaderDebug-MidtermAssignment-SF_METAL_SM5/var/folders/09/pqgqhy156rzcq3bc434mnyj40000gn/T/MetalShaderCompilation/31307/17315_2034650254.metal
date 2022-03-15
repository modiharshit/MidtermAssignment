

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

constant float4 _156 = {};
constant float3 _157 = {};
constant float _159 = {};
constant float4 _160 = {};

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

fragment MainPS_out Main_000043a3_79464c8e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _159, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float3 _235 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _250 = fast::clamp(_248.xyz, float3(0.0), float3(1.0));
    float _254 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _255 = in.in_var_PRIMITIVE_ID * 36u;
    uint _256 = _255 + 20u;
    float _304;
    float _305;
    float _306;
    float3 _307;
    float3 _308;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _274 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _278 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _274, level(0.0));
        float4 _281 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _274, level(0.0));
        float4 _284 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _274, level(0.0));
        float _294 = _284.w;
        _304 = (_254 * _294) + _284.z;
        _305 = (0.20000000298023223876953125 * _294) + _284.y;
        _306 = _284.x;
        _307 = (_250 * _278.w) + _278.xyz;
        _308 = normalize((_235 * _281.w) + ((_281.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _304 = _254;
        _305 = 0.20000000298023223876953125;
        _306 = 0.0;
        _307 = _250;
        _308 = _235;
    }
    bool _318 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _324;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 18u)].w > 0.0) && _318)
    {
        _324 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _324 = 1.0;
    }
    float _371;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256)].z > 0.0)
    {
        float3 _339 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _350 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_339.x), int(_339.y), int(_339.z), 0).xyz), 0));
        _371 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_350.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_339 / float3(_350.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _371 = _324;
    }
    float3 _385 = ((_307 - (_307 * _306)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _392 = (mix(float3(0.07999999821186065673828125 * _305), _307, float3(_306)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _395 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _400;
    if (_395)
    {
        _400 = _385 + (_392 * 0.449999988079071044921875);
    }
    else
    {
        _400 = _385;
    }
    float3 _402 = select(_392, float3(0.0), bool3(_395));
    float3 _404 = float3(dot(_402, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _490;
    if (_318)
    {
        float4 _440 = _160;
        _440.y = (-0.48860299587249755859375) * _308.y;
        float4 _443 = _440;
        _443.z = 0.48860299587249755859375 * _308.z;
        float4 _446 = _443;
        _446.w = (-0.48860299587249755859375) * _308.x;
        float3 _447 = _308 * _308;
        float4 _450 = _156;
        _450.x = (1.09254801273345947265625 * _308.x) * _308.y;
        float4 _453 = _450;
        _453.y = ((-1.09254801273345947265625) * _308.y) * _308.z;
        float4 _458 = _453;
        _458.z = 0.3153919875621795654296875 * ((3.0 * _447.z) - 1.0);
        float4 _461 = _458;
        _461.w = ((-1.09254801273345947265625) * _308.x) * _308.z;
        float4 _465 = _446;
        _465.x = 0.886227548122406005859375;
        float3 _467 = _465.yzw * 2.094395160675048828125;
        float4 _468 = float4(_465.x, _467.x, _467.y, _467.z);
        float4 _469 = _461 * 0.785398185253143310546875;
        float _470 = (_447.x - _447.y) * 0.4290426075458526611328125;
        float3 _476 = float3(0.0);
        _476.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _468) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _469)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _470);
        float3 _482 = _476;
        _482.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _468) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _469)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _470);
        float3 _488 = _482;
        _488.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _468) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _469)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _470);
        _490 = fast::max(float3(0.0), _488);
    }
    else
    {
        _490 = float3(0.0);
    }
    float _516;
    float _517;
    float3 _518;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _506;
        float _507;
        if (_318)
        {
            _506 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _507 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _506 = _308;
            _507 = 1.0;
        }
        float _508 = 1.0 - _507;
        float _510 = 1.0 - (_508 * _508);
        _516 = mix(fast::clamp(dot(_506, _308), 0.0, 1.0), 1.0, _510);
        _517 = _507;
        _518 = mix(_506, _308, float3(_510));
    }
    else
    {
        _516 = 1.0;
        _517 = 1.0;
        _518 = _308;
    }
    float4 _522 = float4(_518, 1.0);
    float3 _526 = _157;
    _526.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _522);
    float3 _530 = _526;
    _530.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _522);
    float3 _534 = _530;
    _534.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _522);
    float4 _537 = _522.xyzz * _522.yzzx;
    float3 _541 = _157;
    _541.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _537);
    float3 _545 = _541;
    _545.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _537);
    float3 _549 = _545;
    _549.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _537);
    float3 _564 = (_490 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_534 + _549) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_518.x * _518.x) - (_518.y * _518.y)))) * View.View_SkyLightColor.xyz) * (_517 * _516));
    float3 _586 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _615;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _614;
        if (any(abs(_227 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _255 + 19u)].xyz + float3(1.0))))
        {
            _614 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _614 = _586;
        }
        _615 = _614;
    }
    else
    {
        _615 = _586;
    }
    float4 _622 = float4(((mix(float3(0.0), _400 + (_402 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_564 * _400) * fast::max(float3(1.0), ((((((_307 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_307 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_307 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _615) * 1.0, 0.0);
    float4 _629;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _628 = _622;
        _628.w = 0.0;
        _629 = _628;
    }
    else
    {
        _629 = _622;
    }
    float2 _633 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _641 = (_308 * 0.5) + float3(0.5);
    float4 _643 = float4(_641.x, _641.y, _641.z, float4(0.0).w);
    _643.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _256)].y;
    float4 _644 = float4(0.0);
    _644.x = _306;
    float4 _645 = _644;
    _645.y = _305;
    float4 _646 = _645;
    _646.z = _304;
    float4 _647 = _646;
    _647.w = 0.50588238239288330078125;
    float4 _659 = float4(_307.x, _307.y, _307.z, float4(0.0).w);
    _659.w = ((log2(((dot(_564, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_404 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_404 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_404 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_633.xyx * _633.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _629 * View.View_PreExposure;
    out.out_var_SV_Target1 = _643;
    out.out_var_SV_Target2 = _647;
    out.out_var_SV_Target3 = _659;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_371, 1.0, 1.0, 1.0);
    return out;
}

