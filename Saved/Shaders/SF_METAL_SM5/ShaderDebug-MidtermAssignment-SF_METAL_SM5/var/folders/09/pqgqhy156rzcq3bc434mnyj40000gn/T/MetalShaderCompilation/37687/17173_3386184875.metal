

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

constant float3 _158 = {};
constant float _160 = {};
constant float4 _161 = {};

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

fragment MainPS_out Main_00004315_c9d514ab(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _160, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float3 _234 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _248 = fast::clamp(mix(float3(0.25), float3(0.569999992847442626953125, 0.3332314789295196533203125, 0.0342000015079975128173828125), float3(fast::min(fast::max(mix(-20.0, 20.0, in_var_TEXCOORD0[0].y), 0.0), 1.0))), float3(0.0), float3(1.0));
    float _252 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _253 = in.in_var_PRIMITIVE_ID * 36u;
    uint _254 = _253 + 20u;
    float _302;
    float _303;
    float _304;
    float3 _305;
    float3 _306;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _272 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _276 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float4 _279 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float4 _282 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _272, level(0.0));
        float _292 = _282.w;
        _302 = (_252 * _292) + _282.z;
        _303 = (0.5 * _292) + _282.y;
        _304 = _282.x;
        _305 = (_248 * _276.w) + _276.xyz;
        _306 = normalize((_234 * _279.w) + ((_279.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _302 = _252;
        _303 = 0.5;
        _304 = 0.0;
        _305 = _248;
        _306 = _234;
    }
    bool _316 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _322;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 18u)].w > 0.0) && _316)
    {
        _322 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _322 = 1.0;
    }
    float _369;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].z > 0.0)
    {
        float3 _337 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _348 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_337.x), int(_337.y), int(_337.z), 0).xyz), 0));
        _369 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_348.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_337 / float3(_348.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _369 = _322;
    }
    float3 _383 = ((_305 - (_305 * _304)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _390 = (mix(float3(0.07999999821186065673828125 * _303), _305, float3(_304)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _393 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _398;
    if (_393)
    {
        _398 = _383 + (_390 * 0.449999988079071044921875);
    }
    else
    {
        _398 = _383;
    }
    float3 _400 = select(_390, float3(0.0), bool3(_393));
    float3 _402 = float3(dot(_400, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _476;
    if (_316)
    {
        float3 _428 = fast::clamp((_226 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _432 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _428);
        float4 _436 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _428);
        float4 _439 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _428);
        float4 _457 = _161;
        _457.y = (-0.48860299587249755859375) * _306.y;
        float4 _460 = _457;
        _460.z = 0.48860299587249755859375 * _306.z;
        float4 _463 = _460;
        _463.w = (-0.48860299587249755859375) * _306.x;
        float4 _464 = _463;
        _464.x = 0.886227548122406005859375;
        float3 _466 = _464.yzw * 2.094395160675048828125;
        float4 _467 = float4(_464.x, _466.x, _466.y, _466.z);
        float3 _469 = float3(0.0);
        _469.x = dot(float4(_432.x, _436.x, _439.x, _432.w), _467);
        float3 _471 = _469;
        _471.y = dot(float4(_432.y, _436.y, _439.y, _436.w), _467);
        float3 _473 = _471;
        _473.z = dot(float4(_432.z, _436.z, _439.zw), _467);
        _476 = fast::max(float3(0.0), _473) * float3(0.3183098733425140380859375);
    }
    else
    {
        _476 = float3(0.0);
    }
    float _502;
    float _503;
    float3 _504;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _492;
        float _493;
        if (_316)
        {
            _492 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _493 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _492 = _306;
            _493 = 1.0;
        }
        float _494 = 1.0 - _493;
        float _496 = 1.0 - (_494 * _494);
        _502 = mix(fast::clamp(dot(_492, _306), 0.0, 1.0), 1.0, _496);
        _503 = _493;
        _504 = mix(_492, _306, float3(_496));
    }
    else
    {
        _502 = 1.0;
        _503 = 1.0;
        _504 = _306;
    }
    float4 _508 = float4(_504, 1.0);
    float3 _512 = _158;
    _512.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _508);
    float3 _516 = _512;
    _516.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _508);
    float3 _520 = _516;
    _520.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _508);
    float4 _523 = _508.xyzz * _508.yzzx;
    float3 _527 = _158;
    _527.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _523);
    float3 _531 = _527;
    _531.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _523);
    float3 _535 = _531;
    _535.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _523);
    float3 _550 = (_476 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_520 + _535) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_504.x * _504.x) - (_504.y * _504.y)))) * View.View_SkyLightColor.xyz) * (_503 * _502));
    float3 _572 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _601;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _600;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _253 + 19u)].xyz + float3(1.0))))
        {
            _600 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _600 = _572;
        }
        _601 = _600;
    }
    else
    {
        _601 = _572;
    }
    float4 _608 = float4(((mix(float3(0.0), _398 + (_400 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_550 * _398) * fast::max(float3(1.0), ((((((_305 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_305 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_305 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _601) * 1.0, 0.0);
    float4 _615;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _614 = _608;
        _614.w = 0.0;
        _615 = _614;
    }
    else
    {
        _615 = _608;
    }
    float2 _619 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _627 = (_306 * 0.5) + float3(0.5);
    float4 _629 = float4(_627.x, _627.y, _627.z, float4(0.0).w);
    _629.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254)].y;
    float4 _630 = float4(0.0);
    _630.x = _304;
    float4 _631 = _630;
    _631.y = _303;
    float4 _632 = _631;
    _632.z = _302;
    float4 _633 = _632;
    _633.w = 0.50588238239288330078125;
    float4 _645 = float4(_305.x, _305.y, _305.z, float4(0.0).w);
    _645.w = ((log2(((dot(_550, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_402 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_402 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_402 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_619.xyx * _619.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _615 * View.View_PreExposure;
    out.out_var_SV_Target1 = _629;
    out.out_var_SV_Target2 = _633;
    out.out_var_SV_Target3 = _645;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_369, 1.0, 1.0, 1.0);
    return out;
}

