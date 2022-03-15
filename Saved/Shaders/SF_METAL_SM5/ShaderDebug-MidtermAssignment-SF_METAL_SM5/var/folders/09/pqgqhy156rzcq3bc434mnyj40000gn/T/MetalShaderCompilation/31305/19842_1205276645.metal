

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

constant float4 _172 = {};
constant float3 _173 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_00004d82_47d70fe5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _235 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = (_239.xyz / float3(_239.w)) - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _253 = (_250.xy * float2(2.0)) - float2(1.0);
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _292;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _292 = _235.w;
                break;
            }
            else
            {
                float _276 = _235.z;
                _292 = ((_276 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_276 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _308 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_253, sqrt(fast::clamp(1.0 - dot(_253, _253), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _265.x) + _292) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _320 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _325 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _334 = (_320.x + 0.5) * ((_325.x + 0.5) * (_330.x + 0.5));
    float4 _340 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _346 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_334)) * _340.xyz, float3(0.0), float3(1.0));
    float _351 = (fast::clamp(mix(0.800000011920928955078125, 0.300000011920928955078125, _334 * _340.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _352 = in.in_var_PRIMITIVE_ID * 36u;
    uint _353 = _352 + 20u;
    float _401;
    float _402;
    float _403;
    float3 _404;
    float3 _405;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _371 = ((_235.xy / float2(_235.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _375 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float4 _378 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _371, level(0.0));
        float _391 = _381.w;
        _401 = (_351 * _391) + _381.z;
        _402 = (0.5 * _391) + _381.y;
        _403 = _381.x;
        _404 = (_346 * _375.w) + _375.xyz;
        _405 = normalize((_308 * _378.w) + ((_378.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _401 = _351;
        _402 = 0.5;
        _403 = 0.0;
        _404 = _346;
        _405 = _308;
    }
    bool _415 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _421;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 18u)].w > 0.0) && _415)
    {
        _421 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _421 = 1.0;
    }
    float _468;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].z > 0.0)
    {
        float3 _436 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _447 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_436.x), int(_436.y), int(_436.z), 0).xyz), 0));
        _468 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_447.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_436 / float3(_447.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _468 = _421;
    }
    float3 _482 = ((_404 - (_404 * _403)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _489 = (mix(float3(0.07999999821186065673828125 * _402), _404, float3(_403)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _492 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _497;
    if (_492)
    {
        _497 = _482 + (_489 * 0.449999988079071044921875);
    }
    else
    {
        _497 = _482;
    }
    float3 _499 = select(_489, float3(0.0), bool3(_492));
    float3 _501 = float3(dot(_499, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _587;
    if (_415)
    {
        float4 _537 = _175;
        _537.y = (-0.48860299587249755859375) * _405.y;
        float4 _540 = _537;
        _540.z = 0.48860299587249755859375 * _405.z;
        float4 _543 = _540;
        _543.w = (-0.48860299587249755859375) * _405.x;
        float3 _544 = _405 * _405;
        float4 _547 = _172;
        _547.x = (1.09254801273345947265625 * _405.x) * _405.y;
        float4 _550 = _547;
        _550.y = ((-1.09254801273345947265625) * _405.y) * _405.z;
        float4 _555 = _550;
        _555.z = 0.3153919875621795654296875 * ((3.0 * _544.z) - 1.0);
        float4 _558 = _555;
        _558.w = ((-1.09254801273345947265625) * _405.x) * _405.z;
        float4 _562 = _543;
        _562.x = 0.886227548122406005859375;
        float3 _564 = _562.yzw * 2.094395160675048828125;
        float4 _565 = float4(_562.x, _564.x, _564.y, _564.z);
        float4 _566 = _558 * 0.785398185253143310546875;
        float _567 = (_544.x - _544.y) * 0.4290426075458526611328125;
        float3 _573 = float3(0.0);
        _573.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _565) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _566)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _567);
        float3 _579 = _573;
        _579.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _565) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _566)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _567);
        float3 _585 = _579;
        _585.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _565) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _566)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _567);
        _587 = fast::max(float3(0.0), _585);
    }
    else
    {
        _587 = float3(0.0);
    }
    float _613;
    float _614;
    float3 _615;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _603;
        float _604;
        if (_415)
        {
            _603 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _604 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _603 = _405;
            _604 = 1.0;
        }
        float _605 = 1.0 - _604;
        float _607 = 1.0 - (_605 * _605);
        _613 = mix(fast::clamp(dot(_603, _405), 0.0, 1.0), 1.0, _607);
        _614 = _604;
        _615 = mix(_603, _405, float3(_607));
    }
    else
    {
        _613 = 1.0;
        _614 = 1.0;
        _615 = _405;
    }
    float4 _619 = float4(_615, 1.0);
    float3 _623 = _173;
    _623.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _619);
    float3 _627 = _623;
    _627.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _619);
    float3 _631 = _627;
    _631.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _619);
    float4 _634 = _619.xyzz * _619.yzzx;
    float3 _638 = _173;
    _638.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _634);
    float3 _642 = _638;
    _642.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _634);
    float3 _646 = _642;
    _646.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _634);
    float3 _661 = (_587 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_631 + _646) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_615.x * _615.x) - (_615.y * _615.y)))) * View.View_SkyLightColor.xyz) * (_614 * _613));
    float3 _683 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _712;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _711;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _352 + 19u)].xyz + float3(1.0))))
        {
            _711 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _711 = _683;
        }
        _712 = _711;
    }
    else
    {
        _712 = _683;
    }
    float4 _719 = float4(((mix(float3(0.0), _497 + (_499 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_661 * _497) * fast::max(float3(1.0), ((((((_404 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_404 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_404 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _712) * 1.0, 0.0);
    float4 _726;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _725 = _719;
        _725.w = 0.0;
        _726 = _725;
    }
    else
    {
        _726 = _719;
    }
    float2 _730 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _738 = (_405 * 0.5) + float3(0.5);
    float4 _740 = float4(_738.x, _738.y, _738.z, float4(0.0).w);
    _740.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _353)].y;
    float4 _741 = float4(0.0);
    _741.x = _403;
    float4 _742 = _741;
    _742.y = _402;
    float4 _743 = _742;
    _743.z = _401;
    float4 _744 = _743;
    _744.w = 0.50588238239288330078125;
    float4 _756 = float4(_404.x, _404.y, _404.z, float4(0.0).w);
    _756.w = ((log2(((dot(_661, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_501 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_501 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_501 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_730.xyx * _730.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _726 * View.View_PreExposure;
    out.out_var_SV_Target1 = _740;
    out.out_var_SV_Target2 = _744;
    out.out_var_SV_Target3 = _756;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_468, 1.0, 1.0, 1.0);
    return out;
}

