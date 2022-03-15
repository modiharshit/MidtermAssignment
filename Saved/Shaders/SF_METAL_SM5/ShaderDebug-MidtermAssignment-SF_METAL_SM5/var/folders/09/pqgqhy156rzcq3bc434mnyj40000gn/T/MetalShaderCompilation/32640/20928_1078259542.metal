

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _180 = {};
constant float4 _182 = {};

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

fragment MainPS_out Main_000051c0_4044ef56(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _243 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _247 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _252 = (_247.xyz / float3(_247.w)) - View.View_PreViewTranslation;
    float2 _259 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float _275 = sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)) + 1.0;
    float _283 = sin(((_252.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _290 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_283 * (-0.0599999986588954925537109375), _283 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _293 = (_290.xy * float2(2.0)) - float2(1.0);
    float3 _302 = float4(_293, sqrt(fast::clamp(1.0 - dot(_293, _293), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _305 = float3(_268, _275);
    float3 _309 = float3(_302.xy * (-1.0), _302.z);
    float3 _313 = (_305 * dot(_305, _309)) - (_309 * _275);
    float _315 = _313.z + 1.0;
    float2 _319 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _321 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _319, bias(View.View_MaterialTextureMipBias));
    float2 _324 = (_321.xy * float2(2.0)) - float2(1.0);
    float4 _336 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _363;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _363 = _243.w;
                break;
            }
            else
            {
                float _347 = _243.z;
                _363 = ((_347 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_347 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _370 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _336.x) + _363) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _371 = mix(float4(_324, sqrt(fast::clamp(1.0 - dot(_324, _324), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _370);
    float3 _376 = float3(_313.xy, _315);
    float3 _380 = float3(_371.xy * (-1.0), _371.z);
    float3 _392 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_376 * dot(_376, _380)) - (_380 * _315)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _403 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _319, bias(View.View_MaterialTextureMipBias));
    float4 _405 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _259, bias(View.View_MaterialTextureMipBias));
    float3 _420 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_403.x * _405.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _370), float3(0.0), float3(1.0));
    float _424 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _425 = in.in_var_PRIMITIVE_ID * 36u;
    uint _426 = _425 + 20u;
    float _474;
    float _475;
    float _476;
    float3 _477;
    float3 _478;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _426)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _444 = ((_243.xy / float2(_243.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _448 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _444, level(0.0));
        float4 _451 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _444, level(0.0));
        float4 _454 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _444, level(0.0));
        float _464 = _454.w;
        _474 = (_424 * _464) + _454.z;
        _475 = (0.5 * _464) + _454.y;
        _476 = _454.x;
        _477 = (_420 * _448.w) + _448.xyz;
        _478 = normalize((_392 * _451.w) + ((_451.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _474 = _424;
        _475 = 0.5;
        _476 = 0.0;
        _477 = _420;
        _478 = _392;
    }
    bool _488 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _494;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _425 + 18u)].w > 0.0) && _488)
    {
        _494 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _494 = 1.0;
    }
    float _541;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _426)].z > 0.0)
    {
        float3 _509 = fast::clamp((_252 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _520 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_509.x), int(_509.y), int(_509.z), 0).xyz), 0));
        _541 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_520.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_509 / float3(_520.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _541 = _494;
    }
    float3 _555 = ((_477 - (_477 * _476)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _562 = (mix(float3(0.07999999821186065673828125 * _475), _477, float3(_476)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _565 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _570;
    if (_565)
    {
        _570 = _555 + (_562 * 0.449999988079071044921875);
    }
    else
    {
        _570 = _555;
    }
    float3 _572 = select(_562, float3(0.0), bool3(_565));
    float3 _574 = float3(dot(_572, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _648;
    if (_488)
    {
        float3 _600 = fast::clamp((_252 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _604 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _600);
        float4 _608 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _600);
        float4 _611 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _600);
        float4 _629 = _182;
        _629.y = (-0.48860299587249755859375) * _478.y;
        float4 _632 = _629;
        _632.z = 0.48860299587249755859375 * _478.z;
        float4 _635 = _632;
        _635.w = (-0.48860299587249755859375) * _478.x;
        float4 _636 = _635;
        _636.x = 0.886227548122406005859375;
        float3 _638 = _636.yzw * 2.094395160675048828125;
        float4 _639 = float4(_636.x, _638.x, _638.y, _638.z);
        float3 _641 = float3(0.0);
        _641.x = dot(float4(_604.x, _608.x, _611.x, _604.w), _639);
        float3 _643 = _641;
        _643.y = dot(float4(_604.y, _608.y, _611.y, _608.w), _639);
        float3 _645 = _643;
        _645.z = dot(float4(_604.z, _608.z, _611.zw), _639);
        _648 = fast::max(float3(0.0), _645) * float3(0.3183098733425140380859375);
    }
    else
    {
        _648 = float3(0.0);
    }
    float _674;
    float _675;
    float3 _676;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _664;
        float _665;
        if (_488)
        {
            _664 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _665 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _664 = _478;
            _665 = 1.0;
        }
        float _666 = 1.0 - _665;
        float _668 = 1.0 - (_666 * _666);
        _674 = mix(fast::clamp(dot(_664, _478), 0.0, 1.0), 1.0, _668);
        _675 = _665;
        _676 = mix(_664, _478, float3(_668));
    }
    else
    {
        _674 = 1.0;
        _675 = 1.0;
        _676 = _478;
    }
    float4 _680 = float4(_676, 1.0);
    float3 _684 = _180;
    _684.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _680);
    float3 _688 = _684;
    _688.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _680);
    float3 _692 = _688;
    _692.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _680);
    float4 _695 = _680.xyzz * _680.yzzx;
    float3 _699 = _180;
    _699.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _695);
    float3 _703 = _699;
    _703.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _695);
    float3 _707 = _703;
    _707.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _695);
    float3 _722 = (_648 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_692 + _707) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_676.x * _676.x) - (_676.y * _676.y)))) * View.View_SkyLightColor.xyz) * (_675 * _674));
    float3 _744 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _773;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _772;
        if (any(abs(_252 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _425 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _425 + 19u)].xyz + float3(1.0))))
        {
            _772 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_252, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _772 = _744;
        }
        _773 = _772;
    }
    else
    {
        _773 = _744;
    }
    float4 _780 = float4(((mix(float3(0.0), _570 + (_572 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_722 * _570) * fast::max(float3(1.0), ((((((_477 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_477 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_477 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _773) * 1.0, 0.0);
    float4 _787;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _786 = _780;
        _786.w = 0.0;
        _787 = _786;
    }
    else
    {
        _787 = _780;
    }
    float2 _791 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _799 = (_478 * 0.5) + float3(0.5);
    float4 _801 = float4(_799.x, _799.y, _799.z, float4(0.0).w);
    _801.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _426)].y;
    float4 _802 = float4(0.0);
    _802.x = _476;
    float4 _803 = _802;
    _803.y = _475;
    float4 _804 = _803;
    _804.z = _474;
    float4 _805 = _804;
    _805.w = 0.50588238239288330078125;
    float4 _817 = float4(_477.x, _477.y, _477.z, float4(0.0).w);
    _817.w = ((log2(((dot(_722, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_574 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_574 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_574 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_791.xyx * _791.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _787 * View.View_PreExposure;
    out.out_var_SV_Target1 = _801;
    out.out_var_SV_Target2 = _805;
    out.out_var_SV_Target3 = _817;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_541, 1.0, 1.0, 1.0);
    return out;
}

