

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

constant float4 _167 = {};
constant float3 _168 = {};
constant float4 _170 = {};

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

fragment MainPS_out Main_00004b77_a6ba5e02(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float2 _240 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _288;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _288 = _230.w;
                break;
            }
            else
            {
                float _272 = _230.z;
                _288 = ((_272 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_272 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _293 = fast::min(fast::max(((mix(-2000.0, 2000.0, _261.x) + _288) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _304 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_293)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _315 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float4 _319 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float3 _325 = fast::clamp(_315.xyz, float3(0.0), float3(1.0));
    float _326 = fast::clamp(_315.x, 0.0, 1.0);
    float _327 = fast::clamp(_319.w, 0.0, 1.0);
    float _332 = (fast::clamp(mix(_319.x, 0.300000011920928955078125, _293), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _333 = in.in_var_PRIMITIVE_ID * 36u;
    uint _334 = _333 + 20u;
    float _382;
    float _383;
    float _384;
    float3 _385;
    float3 _386;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _352 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _356 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _359 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float _372 = _362.w;
        _382 = (_332 * _372) + _362.z;
        _383 = (_326 * _372) + _362.y;
        _384 = _362.x;
        _385 = (_325 * _356.w) + _356.xyz;
        _386 = normalize((_304 * _359.w) + ((_359.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = _332;
        _383 = _326;
        _384 = 0.0;
        _385 = _325;
        _386 = _304;
    }
    bool _396 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _402;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333 + 18u)].w > 0.0) && _396)
    {
        _402 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _402 = 1.0;
    }
    float _449;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334)].z > 0.0)
    {
        float3 _417 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _428 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_417.x), int(_417.y), int(_417.z), 0).xyz), 0));
        _449 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_428.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_417 / float3(_428.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _449 = _402;
    }
    float3 _463 = ((_385 - (_385 * _384)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _470 = (mix(float3(0.07999999821186065673828125 * _383), _385, float3(_384)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _473 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _478;
    if (_473)
    {
        _478 = _463 + (_470 * 0.449999988079071044921875);
    }
    else
    {
        _478 = _463;
    }
    float3 _480 = select(_470, float3(0.0), bool3(_473));
    float3 _482 = float3(dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _489 = float3(_327);
    float3 _569;
    if (_396)
    {
        float4 _519 = _170;
        _519.y = (-0.48860299587249755859375) * _386.y;
        float4 _522 = _519;
        _522.z = 0.48860299587249755859375 * _386.z;
        float4 _525 = _522;
        _525.w = (-0.48860299587249755859375) * _386.x;
        float3 _526 = _386 * _386;
        float4 _529 = _167;
        _529.x = (1.09254801273345947265625 * _386.x) * _386.y;
        float4 _532 = _529;
        _532.y = ((-1.09254801273345947265625) * _386.y) * _386.z;
        float4 _537 = _532;
        _537.z = 0.3153919875621795654296875 * ((3.0 * _526.z) - 1.0);
        float4 _540 = _537;
        _540.w = ((-1.09254801273345947265625) * _386.x) * _386.z;
        float4 _544 = _525;
        _544.x = 0.886227548122406005859375;
        float3 _546 = _544.yzw * 2.094395160675048828125;
        float4 _547 = float4(_544.x, _546.x, _546.y, _546.z);
        float4 _548 = _540 * 0.785398185253143310546875;
        float _549 = (_526.x - _526.y) * 0.4290426075458526611328125;
        float3 _555 = float3(0.0);
        _555.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _547) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _548)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _549);
        float3 _561 = _555;
        _561.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _547) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _548)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _549);
        float3 _567 = _561;
        _567.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _547) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _548)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _549);
        _569 = fast::max(float3(0.0), _567);
    }
    else
    {
        _569 = float3(0.0);
    }
    float _595;
    float _596;
    float3 _597;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _585;
        float _586;
        if (_396)
        {
            _585 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _586 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _585 = _386;
            _586 = 1.0;
        }
        float _587 = 1.0 - _586;
        float _589 = 1.0 - (_587 * _587);
        _595 = mix(fast::clamp(dot(_585, _386), 0.0, 1.0), 1.0, _589);
        _596 = _586;
        _597 = mix(_585, _386, float3(_589));
    }
    else
    {
        _595 = 1.0;
        _596 = 1.0;
        _597 = _386;
    }
    float4 _601 = float4(_597, 1.0);
    float3 _605 = _168;
    _605.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _601);
    float3 _609 = _605;
    _609.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _601);
    float3 _613 = _609;
    _613.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _601);
    float4 _616 = _601.xyzz * _601.yzzx;
    float3 _620 = _168;
    _620.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _616);
    float3 _624 = _620;
    _624.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _616);
    float3 _628 = _624;
    _628.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _616);
    float3 _643 = (_569 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_613 + _628) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_597.x * _597.x) - (_597.y * _597.y)))) * View.View_SkyLightColor.xyz) * (_596 * _595));
    float3 _665 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _694;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _693;
        if (any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333 + 19u)].xyz + float3(1.0))))
        {
            _693 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _693 = _665;
        }
        _694 = _693;
    }
    else
    {
        _694 = _665;
    }
    float4 _701 = float4(((mix(float3(0.0), _478 + (_480 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_643 * _478) * fast::max(_489, ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _327) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _327) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * _327))) + _694) * 1.0, 0.0);
    float4 _708;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _707 = _701;
        _707.w = 0.0;
        _708 = _707;
    }
    else
    {
        _708 = _701;
    }
    float2 _712 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _720 = (_386 * 0.5) + float3(0.5);
    float4 _722 = float4(_720.x, _720.y, _720.z, float4(0.0).w);
    _722.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334)].y;
    float4 _723 = float4(0.0);
    _723.x = _384;
    float4 _724 = _723;
    _724.y = _383;
    float4 _725 = _724;
    _725.z = _382;
    float4 _726 = _725;
    _726.w = 0.50588238239288330078125;
    float4 _738 = float4(_385.x, _385.y, _385.z, float4(0.0).w);
    _738.w = ((log2(((dot(_643, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_489, ((((((_482 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _327) + ((_482 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _327) + ((_482 * 2.755199909210205078125) + float3(0.69029998779296875))) * _327).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_712.xyx * _712.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _708 * View.View_PreExposure;
    out.out_var_SV_Target1 = _722;
    out.out_var_SV_Target2 = _726;
    out.out_var_SV_Target3 = _738;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_449, 1.0, 1.0, 1.0);
    return out;
}

