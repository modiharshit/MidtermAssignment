

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

constant float4 _173 = {};
constant float3 _174 = {};
constant float4 _176 = {};

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

fragment MainPS_out Main_00004d82_86aae3fd(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _236 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _240 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _245 = (_240.xyz / float3(_240.w)) - View.View_PreViewTranslation;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _293;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _293 = _236.w;
                break;
            }
            else
            {
                float _277 = _236.z;
                _293 = ((_277 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_277 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _309 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _266.x) + _293) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _321 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _326 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _331 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _335 = (_321.x + 0.5) * ((_326.x + 0.5) * (_331.x + 0.5));
    float4 _341 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _347 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_335)) * _341.xyz, float3(0.0), float3(1.0));
    float _352 = (fast::clamp(mix(0.4000000059604644775390625, 0.800000011920928955078125, _335 * _341.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _353 = in.in_var_PRIMITIVE_ID * 36u;
    uint _354 = _353 + 20u;
    float _402;
    float _403;
    float _404;
    float3 _405;
    float3 _406;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _372 = ((_236.xy / float2(_236.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _376 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float4 _379 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float4 _382 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _372, level(0.0));
        float _392 = _382.w;
        _402 = (_352 * _392) + _382.z;
        _403 = (0.5 * _392) + _382.y;
        _404 = _382.x;
        _405 = (_347 * _376.w) + _376.xyz;
        _406 = normalize((_309 * _379.w) + ((_379.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _402 = _352;
        _403 = 0.5;
        _404 = 0.0;
        _405 = _347;
        _406 = _309;
    }
    bool _416 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _422;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353 + 18u)].w > 0.0) && _416)
    {
        _422 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _422 = 1.0;
    }
    float _469;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354)].z > 0.0)
    {
        float3 _437 = fast::clamp((_245 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _448 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_437.x), int(_437.y), int(_437.z), 0).xyz), 0));
        _469 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_448.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_437 / float3(_448.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _469 = _422;
    }
    float3 _483 = ((_405 - (_405 * _404)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _490 = (mix(float3(0.07999999821186065673828125 * _403), _405, float3(_404)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _493 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _498;
    if (_493)
    {
        _498 = _483 + (_490 * 0.449999988079071044921875);
    }
    else
    {
        _498 = _483;
    }
    float3 _500 = select(_490, float3(0.0), bool3(_493));
    float3 _502 = float3(dot(_500, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _588;
    if (_416)
    {
        float4 _538 = _176;
        _538.y = (-0.48860299587249755859375) * _406.y;
        float4 _541 = _538;
        _541.z = 0.48860299587249755859375 * _406.z;
        float4 _544 = _541;
        _544.w = (-0.48860299587249755859375) * _406.x;
        float3 _545 = _406 * _406;
        float4 _548 = _173;
        _548.x = (1.09254801273345947265625 * _406.x) * _406.y;
        float4 _551 = _548;
        _551.y = ((-1.09254801273345947265625) * _406.y) * _406.z;
        float4 _556 = _551;
        _556.z = 0.3153919875621795654296875 * ((3.0 * _545.z) - 1.0);
        float4 _559 = _556;
        _559.w = ((-1.09254801273345947265625) * _406.x) * _406.z;
        float4 _563 = _544;
        _563.x = 0.886227548122406005859375;
        float3 _565 = _563.yzw * 2.094395160675048828125;
        float4 _566 = float4(_563.x, _565.x, _565.y, _565.z);
        float4 _567 = _559 * 0.785398185253143310546875;
        float _568 = (_545.x - _545.y) * 0.4290426075458526611328125;
        float3 _574 = float3(0.0);
        _574.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _566) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _567)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _568);
        float3 _580 = _574;
        _580.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _566) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _567)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _568);
        float3 _586 = _580;
        _586.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _566) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _567)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _568);
        _588 = fast::max(float3(0.0), _586);
    }
    else
    {
        _588 = float3(0.0);
    }
    float _614;
    float _615;
    float3 _616;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _604;
        float _605;
        if (_416)
        {
            _604 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _605 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _604 = _406;
            _605 = 1.0;
        }
        float _606 = 1.0 - _605;
        float _608 = 1.0 - (_606 * _606);
        _614 = mix(fast::clamp(dot(_604, _406), 0.0, 1.0), 1.0, _608);
        _615 = _605;
        _616 = mix(_604, _406, float3(_608));
    }
    else
    {
        _614 = 1.0;
        _615 = 1.0;
        _616 = _406;
    }
    float4 _620 = float4(_616, 1.0);
    float3 _624 = _174;
    _624.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _620);
    float3 _628 = _624;
    _628.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _620);
    float3 _632 = _628;
    _632.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _620);
    float4 _635 = _620.xyzz * _620.yzzx;
    float3 _639 = _174;
    _639.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _635);
    float3 _643 = _639;
    _643.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _635);
    float3 _647 = _643;
    _647.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _635);
    float3 _662 = (_588 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_632 + _647) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_616.x * _616.x) - (_616.y * _616.y)))) * View.View_SkyLightColor.xyz) * (_615 * _614));
    float3 _684 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _713;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _712;
        if (any(abs(_245 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353 + 19u)].xyz + float3(1.0))))
        {
            _712 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_245, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _712 = _684;
        }
        _713 = _712;
    }
    else
    {
        _713 = _684;
    }
    float4 _720 = float4(((mix(float3(0.0), _498 + (_500 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_662 * _498) * fast::max(float3(1.0), ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _713) * 1.0, 0.0);
    float4 _727;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _726 = _720;
        _726.w = 0.0;
        _727 = _726;
    }
    else
    {
        _727 = _720;
    }
    float2 _731 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _739 = (_406 * 0.5) + float3(0.5);
    float4 _741 = float4(_739.x, _739.y, _739.z, float4(0.0).w);
    _741.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354)].y;
    float4 _742 = float4(0.0);
    _742.x = _404;
    float4 _743 = _742;
    _743.y = _403;
    float4 _744 = _743;
    _744.z = _402;
    float4 _745 = _744;
    _745.w = 0.50588238239288330078125;
    float4 _757 = float4(_405.x, _405.y, _405.z, float4(0.0).w);
    _757.w = ((log2(((dot(_662, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_502 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_502 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_502 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_731.xyx * _731.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _727 * View.View_PreExposure;
    out.out_var_SV_Target1 = _741;
    out.out_var_SV_Target2 = _745;
    out.out_var_SV_Target3 = _757;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_469, 1.0, 1.0, 1.0);
    return out;
}

