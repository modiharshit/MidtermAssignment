

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

fragment MainPS_out Main_00004f32_c6457de7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _235 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _243 = _239.xyz / float3(_239.w);
    float3 _244 = _243 - View.View_PreViewTranslation;
    float4 _252 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _255 = (_252.xy * float2(2.0)) - float2(1.0);
    float4 _267 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _294;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _294 = _235.w;
                break;
            }
            else
            {
                float _278 = _235.z;
                _294 = ((_278 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_278 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _310 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_255, sqrt(fast::clamp(1.0 - dot(_255, _255), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _267.x) + _294) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _322 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _327 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _332 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _336 = (_322.x + 0.5) * ((_327.x + 0.5) * (_332.x + 0.5));
    float4 _340 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _342 = _340.xyz * _336;
    float _344 = _342.x;
    float _348 = _342.y;
    float _352 = _342.z;
    float _361 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_243)))), 9.9999997473787516355514526367188e-05);
    float3 _370 = fast::clamp(mix(_342 * 0.5, float3((_344 <= 0.0) ? 0.0 : pow(_344, 0.4000000059604644775390625), (_348 <= 0.0) ? 0.0 : pow(_348, 0.4000000059604644775390625), (_352 <= 0.0) ? 0.0 : pow(_352, 0.4000000059604644775390625)), float3((_361 <= 0.0) ? 0.0 : pow(_361, 3.0))), float3(0.0), float3(1.0));
    float _375 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _336 * _340.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _376 = in.in_var_PRIMITIVE_ID * 36u;
    uint _377 = _376 + 20u;
    float _425;
    float _426;
    float _427;
    float3 _428;
    float3 _429;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _377)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _395 = ((_235.xy / float2(_235.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _399 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _395, level(0.0));
        float4 _402 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _395, level(0.0));
        float4 _405 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _395, level(0.0));
        float _415 = _405.w;
        _425 = (_375 * _415) + _405.z;
        _426 = (0.5 * _415) + _405.y;
        _427 = _405.x;
        _428 = (_370 * _399.w) + _399.xyz;
        _429 = normalize((_310 * _402.w) + ((_402.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _425 = _375;
        _426 = 0.5;
        _427 = 0.0;
        _428 = _370;
        _429 = _310;
    }
    bool _439 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _445;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376 + 18u)].w > 0.0) && _439)
    {
        _445 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _445 = 1.0;
    }
    float _492;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _377)].z > 0.0)
    {
        float3 _460 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _471 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_460.x), int(_460.y), int(_460.z), 0).xyz), 0));
        _492 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_471.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_460 / float3(_471.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _492 = _445;
    }
    float3 _506 = ((_428 - (_428 * _427)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _513 = (mix(float3(0.07999999821186065673828125 * _426), _428, float3(_427)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _516 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _521;
    if (_516)
    {
        _521 = _506 + (_513 * 0.449999988079071044921875);
    }
    else
    {
        _521 = _506;
    }
    float3 _523 = select(_513, float3(0.0), bool3(_516));
    float3 _525 = float3(dot(_523, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _611;
    if (_439)
    {
        float4 _561 = _175;
        _561.y = (-0.48860299587249755859375) * _429.y;
        float4 _564 = _561;
        _564.z = 0.48860299587249755859375 * _429.z;
        float4 _567 = _564;
        _567.w = (-0.48860299587249755859375) * _429.x;
        float3 _568 = _429 * _429;
        float4 _571 = _172;
        _571.x = (1.09254801273345947265625 * _429.x) * _429.y;
        float4 _574 = _571;
        _574.y = ((-1.09254801273345947265625) * _429.y) * _429.z;
        float4 _579 = _574;
        _579.z = 0.3153919875621795654296875 * ((3.0 * _568.z) - 1.0);
        float4 _582 = _579;
        _582.w = ((-1.09254801273345947265625) * _429.x) * _429.z;
        float4 _586 = _567;
        _586.x = 0.886227548122406005859375;
        float3 _588 = _586.yzw * 2.094395160675048828125;
        float4 _589 = float4(_586.x, _588.x, _588.y, _588.z);
        float4 _590 = _582 * 0.785398185253143310546875;
        float _591 = (_568.x - _568.y) * 0.4290426075458526611328125;
        float3 _597 = float3(0.0);
        _597.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _589) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _590)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _591);
        float3 _603 = _597;
        _603.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _589) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _590)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _591);
        float3 _609 = _603;
        _609.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _589) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _590)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _591);
        _611 = fast::max(float3(0.0), _609);
    }
    else
    {
        _611 = float3(0.0);
    }
    float _637;
    float _638;
    float3 _639;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _627;
        float _628;
        if (_439)
        {
            _627 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _628 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _627 = _429;
            _628 = 1.0;
        }
        float _629 = 1.0 - _628;
        float _631 = 1.0 - (_629 * _629);
        _637 = mix(fast::clamp(dot(_627, _429), 0.0, 1.0), 1.0, _631);
        _638 = _628;
        _639 = mix(_627, _429, float3(_631));
    }
    else
    {
        _637 = 1.0;
        _638 = 1.0;
        _639 = _429;
    }
    float4 _643 = float4(_639, 1.0);
    float3 _647 = _173;
    _647.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _643);
    float3 _651 = _647;
    _651.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _643);
    float3 _655 = _651;
    _655.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _643);
    float4 _658 = _643.xyzz * _643.yzzx;
    float3 _662 = _173;
    _662.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _658);
    float3 _666 = _662;
    _666.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _658);
    float3 _670 = _666;
    _670.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _658);
    float3 _685 = (_611 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_655 + _670) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_639.x * _639.x) - (_639.y * _639.y)))) * View.View_SkyLightColor.xyz) * (_638 * _637));
    float3 _707 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _736;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _735;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _376 + 19u)].xyz + float3(1.0))))
        {
            _735 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _735 = _707;
        }
        _736 = _735;
    }
    else
    {
        _736 = _707;
    }
    float4 _743 = float4(((mix(float3(0.0), _521 + (_523 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_685 * _521) * fast::max(float3(1.0), ((((((_428 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_428 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_428 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _736) * 1.0, 0.0);
    float4 _750;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _749 = _743;
        _749.w = 0.0;
        _750 = _749;
    }
    else
    {
        _750 = _743;
    }
    float2 _754 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _762 = (_429 * 0.5) + float3(0.5);
    float4 _764 = float4(_762.x, _762.y, _762.z, float4(0.0).w);
    _764.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _377)].y;
    float4 _765 = float4(0.0);
    _765.x = _427;
    float4 _766 = _765;
    _766.y = _426;
    float4 _767 = _766;
    _767.z = _425;
    float4 _768 = _767;
    _768.w = 0.50588238239288330078125;
    float4 _780 = float4(_428.x, _428.y, _428.z, float4(0.0).w);
    _780.w = ((log2(((dot(_685, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_525 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_525 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_525 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_754.xyx * _754.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _750 * View.View_PreExposure;
    out.out_var_SV_Target1 = _764;
    out.out_var_SV_Target2 = _768;
    out.out_var_SV_Target3 = _780;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_492, 1.0, 1.0, 1.0);
    return out;
}

