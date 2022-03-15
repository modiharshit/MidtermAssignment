

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m22_pad[48];
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
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
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

fragment MainPS_out Main_00005254_31cce15e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    bool _327;
    float4 _236 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _240 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _245 = (_240.xyz / float3(_240.w)) - View.View_PreViewTranslation;
    float4 _257 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _260 = (_257.xy * float2(2.0)) - float2(1.0);
    float _269 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _274 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _269) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _277 = (_274.xy * float2(2.0)) - float2(1.0);
    float _289 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _294 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_289, _269) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _297 = (_294.xy * float2(2.0)) - float2(1.0);
    float4 _309 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_269, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _312 = (_309.xy * float2(2.0)) - float2(1.0);
    float _347;
    switch (0u)
    {
        default:
        {
            _327 = View.View_ViewToClip[3u].w < 1.0;
            if (_327)
            {
                _347 = _236.w;
                break;
            }
            else
            {
                float _331 = _236.z;
                _347 = ((_331 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_331 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _359 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_289, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _362 = (_359.xy * float2(2.0)) - float2(1.0);
    float4 _375 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _378 = (_375.xy * float2(2.0)) - float2(1.0);
    float _411;
    switch (0u)
    {
        default:
        {
            if (_327)
            {
                _411 = _236.w;
                break;
            }
            else
            {
                float _395 = _236.z;
                _411 = ((_395 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_395 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _425 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_260, sqrt(fast::clamp(1.0 - dot(_260, _260), 0.0, 1.0)), 1.0).xyz + (float4(_277, sqrt(fast::clamp(1.0 - dot(_277, _277), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_297, sqrt(fast::clamp(1.0 - dot(_297, _297), 0.0, 1.0)), 1.0).xyz + float4(_312, sqrt(fast::clamp(1.0 - dot(_312, _312), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_347 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_362, sqrt(fast::clamp(1.0 - dot(_362, _362), 0.0, 1.0)), 1.0).xyz + (float4(_378, sqrt(fast::clamp(1.0 - dot(_378, _378), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_411 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _436 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _440 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _441 = in.in_var_PRIMITIVE_ID * 36u;
    uint _442 = _441 + 20u;
    float _491;
    float _492;
    float _493;
    float3 _494;
    float3 _495;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _442)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _460 = ((_236.xy / float2(_236.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _464 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _460, level(0.0));
        float4 _467 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _460, level(0.0));
        float4 _470 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _460, level(0.0));
        float _480 = _470.w;
        _491 = (_440 * _480) + _470.z;
        _492 = (0.5 * _480) + _470.y;
        _493 = _480 + _470.x;
        _494 = (_436 * _464.w) + _464.xyz;
        _495 = normalize((_425 * _467.w) + ((_467.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _491 = _440;
        _492 = 0.5;
        _493 = 1.0;
        _494 = _436;
        _495 = _425;
    }
    bool _505 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _511;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _441 + 18u)].w > 0.0) && _505)
    {
        _511 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _511 = 1.0;
    }
    float _558;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _442)].z > 0.0)
    {
        float3 _526 = fast::clamp((_245 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _537 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_526.x), int(_526.y), int(_526.z), 0).xyz), 0));
        _558 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_537.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_526 / float3(_537.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _558 = _511;
    }
    float3 _572 = ((_494 - (_494 * _493)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _579 = (mix(float3(0.07999999821186065673828125 * _492), _494, float3(_493)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _582 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _587;
    if (_582)
    {
        _587 = _572 + (_579 * 0.449999988079071044921875);
    }
    else
    {
        _587 = _572;
    }
    float3 _589 = select(_579, float3(0.0), bool3(_582));
    float3 _591 = float3(dot(_589, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _677;
    if (_505)
    {
        float4 _627 = _175;
        _627.y = (-0.48860299587249755859375) * _495.y;
        float4 _630 = _627;
        _630.z = 0.48860299587249755859375 * _495.z;
        float4 _633 = _630;
        _633.w = (-0.48860299587249755859375) * _495.x;
        float3 _634 = _495 * _495;
        float4 _637 = _172;
        _637.x = (1.09254801273345947265625 * _495.x) * _495.y;
        float4 _640 = _637;
        _640.y = ((-1.09254801273345947265625) * _495.y) * _495.z;
        float4 _645 = _640;
        _645.z = 0.3153919875621795654296875 * ((3.0 * _634.z) - 1.0);
        float4 _648 = _645;
        _648.w = ((-1.09254801273345947265625) * _495.x) * _495.z;
        float4 _652 = _633;
        _652.x = 0.886227548122406005859375;
        float3 _654 = _652.yzw * 2.094395160675048828125;
        float4 _655 = float4(_652.x, _654.x, _654.y, _654.z);
        float4 _656 = _648 * 0.785398185253143310546875;
        float _657 = (_634.x - _634.y) * 0.4290426075458526611328125;
        float3 _663 = float3(0.0);
        _663.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _655) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _656)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _657);
        float3 _669 = _663;
        _669.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _655) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _656)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _657);
        float3 _675 = _669;
        _675.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _655) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _656)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _657);
        _677 = fast::max(float3(0.0), _675);
    }
    else
    {
        _677 = float3(0.0);
    }
    float _703;
    float _704;
    float3 _705;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _693;
        float _694;
        if (_505)
        {
            _693 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _694 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _693 = _495;
            _694 = 1.0;
        }
        float _695 = 1.0 - _694;
        float _697 = 1.0 - (_695 * _695);
        _703 = mix(fast::clamp(dot(_693, _495), 0.0, 1.0), 1.0, _697);
        _704 = _694;
        _705 = mix(_693, _495, float3(_697));
    }
    else
    {
        _703 = 1.0;
        _704 = 1.0;
        _705 = _495;
    }
    float4 _709 = float4(_705, 1.0);
    float3 _713 = _173;
    _713.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _709);
    float3 _717 = _713;
    _717.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _709);
    float3 _721 = _717;
    _721.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _709);
    float4 _724 = _709.xyzz * _709.yzzx;
    float3 _728 = _173;
    _728.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _724);
    float3 _732 = _728;
    _732.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _724);
    float3 _736 = _732;
    _736.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _724);
    float3 _751 = (_677 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_721 + _736) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_705.x * _705.x) - (_705.y * _705.y)))) * View.View_SkyLightColor.xyz) * (_704 * _703));
    float3 _773 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _802;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _801;
        if (any(abs(_245 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _441 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _441 + 19u)].xyz + float3(1.0))))
        {
            _801 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_245, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _801 = _773;
        }
        _802 = _801;
    }
    else
    {
        _802 = _773;
    }
    float4 _809 = float4(((mix(float3(0.0), _587 + (_589 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_751 * _587) * fast::max(float3(1.0), ((((((_494 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_494 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_494 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _802) * 1.0, 0.0);
    float4 _816;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _815 = _809;
        _815.w = 0.0;
        _816 = _815;
    }
    else
    {
        _816 = _809;
    }
    float2 _820 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _828 = (_495 * 0.5) + float3(0.5);
    float4 _830 = float4(_828.x, _828.y, _828.z, float4(0.0).w);
    _830.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _442)].y;
    float4 _831 = float4(0.0);
    _831.x = _493;
    float4 _832 = _831;
    _832.y = _492;
    float4 _833 = _832;
    _833.z = _491;
    float4 _834 = _833;
    _834.w = 0.50588238239288330078125;
    float4 _846 = float4(_494.x, _494.y, _494.z, float4(0.0).w);
    _846.w = ((log2(((dot(_751, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_591 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_591 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_591 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_820.xyx * _820.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _816 * View.View_PreExposure;
    out.out_var_SV_Target1 = _830;
    out.out_var_SV_Target2 = _834;
    out.out_var_SV_Target3 = _846;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_558, 1.0, 1.0, 1.0);
    return out;
}

