

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

constant float3 _171 = {};
constant float4 _173 = {};

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

fragment MainPS_out Main_00004fa2_9825233a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = _237.xyz / float3(_237.w);
    float3 _242 = _241 - View.View_PreViewTranslation;
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
                _292 = _233.w;
                break;
            }
            else
            {
                float _276 = _233.z;
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
    float4 _338 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _340 = _338.xyz * _334;
    float _342 = _340.x;
    float _346 = _340.y;
    float _350 = _340.z;
    float _359 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_241)))), 9.9999997473787516355514526367188e-05);
    float3 _368 = fast::clamp(mix(_340 * 0.5, float3((_342 <= 0.0) ? 0.0 : pow(_342, 0.4000000059604644775390625), (_346 <= 0.0) ? 0.0 : pow(_346, 0.4000000059604644775390625), (_350 <= 0.0) ? 0.0 : pow(_350, 0.4000000059604644775390625)), float3((_359 <= 0.0) ? 0.0 : pow(_359, 3.0))), float3(0.0), float3(1.0));
    float _373 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _334 * _338.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _374 = in.in_var_PRIMITIVE_ID * 36u;
    uint _375 = _374 + 20u;
    float _423;
    float _424;
    float _425;
    float3 _426;
    float3 _427;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _393 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _397 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float4 _400 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float4 _403 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _393, level(0.0));
        float _413 = _403.w;
        _423 = (_373 * _413) + _403.z;
        _424 = (0.5 * _413) + _403.y;
        _425 = _403.x;
        _426 = (_368 * _397.w) + _397.xyz;
        _427 = normalize((_308 * _400.w) + ((_400.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _423 = _373;
        _424 = 0.5;
        _425 = 0.0;
        _426 = _368;
        _427 = _308;
    }
    bool _437 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _443;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _374 + 18u)].w > 0.0) && _437)
    {
        _443 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _443 = 1.0;
    }
    float _490;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375)].z > 0.0)
    {
        float3 _458 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _469 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_458.x), int(_458.y), int(_458.z), 0).xyz), 0));
        _490 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_469.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_458 / float3(_469.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _490 = _443;
    }
    float3 _504 = ((_426 - (_426 * _425)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _511 = (mix(float3(0.07999999821186065673828125 * _424), _426, float3(_425)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _514 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _519;
    if (_514)
    {
        _519 = _504 + (_511 * 0.449999988079071044921875);
    }
    else
    {
        _519 = _504;
    }
    float3 _521 = select(_511, float3(0.0), bool3(_514));
    float3 _523 = float3(dot(_521, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _597;
    if (_437)
    {
        float3 _549 = fast::clamp((_242 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _553 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _549);
        float4 _557 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _549);
        float4 _560 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _549);
        float4 _578 = _173;
        _578.y = (-0.48860299587249755859375) * _427.y;
        float4 _581 = _578;
        _581.z = 0.48860299587249755859375 * _427.z;
        float4 _584 = _581;
        _584.w = (-0.48860299587249755859375) * _427.x;
        float4 _585 = _584;
        _585.x = 0.886227548122406005859375;
        float3 _587 = _585.yzw * 2.094395160675048828125;
        float4 _588 = float4(_585.x, _587.x, _587.y, _587.z);
        float3 _590 = float3(0.0);
        _590.x = dot(float4(_553.x, _557.x, _560.x, _553.w), _588);
        float3 _592 = _590;
        _592.y = dot(float4(_553.y, _557.y, _560.y, _557.w), _588);
        float3 _594 = _592;
        _594.z = dot(float4(_553.z, _557.z, _560.zw), _588);
        _597 = fast::max(float3(0.0), _594) * float3(0.3183098733425140380859375);
    }
    else
    {
        _597 = float3(0.0);
    }
    float _623;
    float _624;
    float3 _625;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _613;
        float _614;
        if (_437)
        {
            _613 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _614 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _613 = _427;
            _614 = 1.0;
        }
        float _615 = 1.0 - _614;
        float _617 = 1.0 - (_615 * _615);
        _623 = mix(fast::clamp(dot(_613, _427), 0.0, 1.0), 1.0, _617);
        _624 = _614;
        _625 = mix(_613, _427, float3(_617));
    }
    else
    {
        _623 = 1.0;
        _624 = 1.0;
        _625 = _427;
    }
    float4 _629 = float4(_625, 1.0);
    float3 _633 = _171;
    _633.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _629);
    float3 _637 = _633;
    _637.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _629);
    float3 _641 = _637;
    _641.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _629);
    float4 _644 = _629.xyzz * _629.yzzx;
    float3 _648 = _171;
    _648.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _644);
    float3 _652 = _648;
    _652.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _644);
    float3 _656 = _652;
    _656.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _644);
    float3 _671 = (_597 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_641 + _656) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_625.x * _625.x) - (_625.y * _625.y)))) * View.View_SkyLightColor.xyz) * (_624 * _623));
    float3 _693 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _722;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _721;
        if (any(abs(_242 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _374 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _374 + 19u)].xyz + float3(1.0))))
        {
            _721 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _721 = _693;
        }
        _722 = _721;
    }
    else
    {
        _722 = _693;
    }
    float4 _729 = float4(((mix(float3(0.0), _519 + (_521 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_671 * _519) * fast::max(float3(1.0), ((((((_426 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_426 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_426 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _722) * 1.0, 0.0);
    float4 _736;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _735 = _729;
        _735.w = 0.0;
        _736 = _735;
    }
    else
    {
        _736 = _729;
    }
    float2 _740 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _748 = (_427 * 0.5) + float3(0.5);
    float4 _750 = float4(_748.x, _748.y, _748.z, float4(0.0).w);
    _750.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _375)].y;
    float4 _751 = float4(0.0);
    _751.x = _425;
    float4 _752 = _751;
    _752.y = _424;
    float4 _753 = _752;
    _753.z = _423;
    float4 _754 = _753;
    _754.w = 0.50588238239288330078125;
    float4 _766 = float4(_426.x, _426.y, _426.z, float4(0.0).w);
    _766.w = ((log2(((dot(_671, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_523 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_523 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_523 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_740.xyx * _740.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _736 * View.View_PreExposure;
    out.out_var_SV_Target1 = _750;
    out.out_var_SV_Target2 = _754;
    out.out_var_SV_Target3 = _766;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_490, 1.0, 1.0, 1.0);
    return out;
}

