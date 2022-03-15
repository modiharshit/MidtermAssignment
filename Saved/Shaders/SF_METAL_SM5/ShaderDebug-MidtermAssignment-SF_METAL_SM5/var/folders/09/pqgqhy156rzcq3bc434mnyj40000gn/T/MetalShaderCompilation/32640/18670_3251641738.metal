

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _162 = {};
constant float3 _163 = {};
constant float _165 = {};
constant float4 _166 = {};

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

fragment MainPS_out Main_000048ee_c1d01d8a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _212 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _165, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = _228.xyz / float3(_228.w);
    float3 _233 = _232 - View.View_PreViewTranslation;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _248 = ((normalize(-_232) * _212).xy * ((0.0500000007450580596923828125 * _242.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _248, bias(View.View_MaterialTextureMipBias));
    float2 _255 = (_252.xy * float2(2.0)) - float2(1.0);
    float _262 = sqrt(fast::clamp(1.0 - dot(_255, _255), 0.0, 1.0)) + 1.0;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float4 _277 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _248, bias(View.View_MaterialTextureMipBias));
    float _279 = _277.y;
    float3 _281 = mix(float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_279));
    float3 _284 = float3(_255, _262);
    float3 _288 = float3(_281.xy * (-1.0), _281.z);
    float3 _300 = normalize(_212 * normalize((((_284 * dot(_284, _288)) - (_288 * _262)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _314 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _277.x, float3(0.0), float3(1.0));
    float _315 = fast::clamp(mix(1.0, 0.0, _279), 0.0, 1.0);
    float _319 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _320 = in.in_var_PRIMITIVE_ID * 36u;
    uint _321 = _320 + 20u;
    float _371;
    float _372;
    float _373;
    float3 _374;
    float3 _375;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _339 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _343 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float _359 = _349.w;
        _371 = (_319 * _359) + _349.z;
        _372 = (0.5 * _359) + _349.y;
        _373 = (_315 * _359) + _349.x;
        _374 = (_314 * _343.w) + _343.xyz;
        _375 = normalize((_300 * _346.w) + ((_346.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _371 = _319;
        _372 = 0.5;
        _373 = _315;
        _374 = _314;
        _375 = _300;
    }
    bool _385 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _391;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 18u)].w > 0.0) && _385)
    {
        _391 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _391 = 1.0;
    }
    float _438;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].z > 0.0)
    {
        float3 _406 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _417 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_406.x), int(_406.y), int(_406.z), 0).xyz), 0));
        _438 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_417.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_406 / float3(_417.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _438 = _391;
    }
    float3 _452 = ((_374 - (_374 * _373)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _459 = (mix(float3(0.07999999821186065673828125 * _372), _374, float3(_373)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _462 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _467;
    if (_462)
    {
        _467 = _452 + (_459 * 0.449999988079071044921875);
    }
    else
    {
        _467 = _452;
    }
    float3 _469 = select(_459, float3(0.0), bool3(_462));
    float3 _471 = float3(dot(_469, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _557;
    if (_385)
    {
        float4 _507 = _166;
        _507.y = (-0.48860299587249755859375) * _375.y;
        float4 _510 = _507;
        _510.z = 0.48860299587249755859375 * _375.z;
        float4 _513 = _510;
        _513.w = (-0.48860299587249755859375) * _375.x;
        float3 _514 = _375 * _375;
        float4 _517 = _162;
        _517.x = (1.09254801273345947265625 * _375.x) * _375.y;
        float4 _520 = _517;
        _520.y = ((-1.09254801273345947265625) * _375.y) * _375.z;
        float4 _525 = _520;
        _525.z = 0.3153919875621795654296875 * ((3.0 * _514.z) - 1.0);
        float4 _528 = _525;
        _528.w = ((-1.09254801273345947265625) * _375.x) * _375.z;
        float4 _532 = _513;
        _532.x = 0.886227548122406005859375;
        float3 _534 = _532.yzw * 2.094395160675048828125;
        float4 _535 = float4(_532.x, _534.x, _534.y, _534.z);
        float4 _536 = _528 * 0.785398185253143310546875;
        float _537 = (_514.x - _514.y) * 0.4290426075458526611328125;
        float3 _543 = float3(0.0);
        _543.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _535) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _536)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _537);
        float3 _549 = _543;
        _549.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _535) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _536)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _537);
        float3 _555 = _549;
        _555.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _535) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _536)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _537);
        _557 = fast::max(float3(0.0), _555);
    }
    else
    {
        _557 = float3(0.0);
    }
    float _583;
    float _584;
    float3 _585;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _573;
        float _574;
        if (_385)
        {
            _573 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _574 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _573 = _375;
            _574 = 1.0;
        }
        float _575 = 1.0 - _574;
        float _577 = 1.0 - (_575 * _575);
        _583 = mix(fast::clamp(dot(_573, _375), 0.0, 1.0), 1.0, _577);
        _584 = _574;
        _585 = mix(_573, _375, float3(_577));
    }
    else
    {
        _583 = 1.0;
        _584 = 1.0;
        _585 = _375;
    }
    float4 _589 = float4(_585, 1.0);
    float3 _593 = _163;
    _593.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _589);
    float3 _597 = _593;
    _597.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _589);
    float3 _601 = _597;
    _601.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _589);
    float4 _604 = _589.xyzz * _589.yzzx;
    float3 _608 = _163;
    _608.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _604);
    float3 _612 = _608;
    _612.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _604);
    float3 _616 = _612;
    _616.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _604);
    float3 _631 = (_557 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_601 + _616) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_585.x * _585.x) - (_585.y * _585.y)))) * View.View_SkyLightColor.xyz) * (_584 * _583));
    float3 _653 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _682;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _681;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 19u)].xyz + float3(1.0))))
        {
            _681 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _681 = _653;
        }
        _682 = _681;
    }
    else
    {
        _682 = _653;
    }
    float4 _689 = float4(((mix(float3(0.0), _467 + (_469 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_631 * _467) * fast::max(float3(1.0), ((((((_374 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_374 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_374 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _682) * 1.0, 0.0);
    float4 _696;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _695 = _689;
        _695.w = 0.0;
        _696 = _695;
    }
    else
    {
        _696 = _689;
    }
    float2 _700 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _708 = (_375 * 0.5) + float3(0.5);
    float4 _710 = float4(_708.x, _708.y, _708.z, float4(0.0).w);
    _710.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].y;
    float4 _711 = float4(0.0);
    _711.x = _373;
    float4 _712 = _711;
    _712.y = _372;
    float4 _713 = _712;
    _713.z = _371;
    float4 _714 = _713;
    _714.w = 0.50588238239288330078125;
    float4 _726 = float4(_374.x, _374.y, _374.z, float4(0.0).w);
    _726.w = ((log2(((dot(_631, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_471 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_471 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_471 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_700.xyx * _700.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _696 * View.View_PreExposure;
    out.out_var_SV_Target1 = _710;
    out.out_var_SV_Target2 = _714;
    out.out_var_SV_Target3 = _726;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_438, 1.0, 1.0, 1.0);
    return out;
}

