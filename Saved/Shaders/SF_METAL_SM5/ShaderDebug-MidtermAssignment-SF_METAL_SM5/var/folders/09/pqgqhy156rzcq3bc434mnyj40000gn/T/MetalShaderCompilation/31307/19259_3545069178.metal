

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

constant float3 _166 = {};
constant float _168 = {};
constant float4 _169 = {};

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

fragment MainPS_out Main_00004b3b_d34d767a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _215 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _168, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = _231.xyz / float3(_231.w);
    float3 _236 = _235 - View.View_PreViewTranslation;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _251 = ((normalize(-_235) * _215).xy * ((0.0599999986588954925537109375 * _245.x) + (-0.021600000560283660888671875))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _251, bias(View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float3 _274 = normalize(_215 * normalize((float4(_258, sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _286 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125), bias(View.View_MaterialTextureMipBias));
    float4 _291 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0030000000260770320892333984375), bias(View.View_MaterialTextureMipBias));
    float4 _304 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _251, bias(View.View_MaterialTextureMipBias));
    float _307 = _304.w;
    float3 _312 = fast::clamp(_304.xyz * ((_286.x + 0.5) * ((_291.x + 0.5) * (_296.x + 0.5))), float3(0.0), float3(1.0));
    float _313 = fast::clamp(_307 * 4.0, 0.0, 1.0);
    float _318 = (fast::clamp(fast::min(fast::max(mix(1.0, -1.75, _307), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _319 = in.in_var_PRIMITIVE_ID * 36u;
    uint _320 = _319 + 20u;
    float _368;
    float _369;
    float _370;
    float3 _371;
    float3 _372;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _338 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _342 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float4 _345 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float4 _348 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _338, level(0.0));
        float _358 = _348.w;
        _368 = (_318 * _358) + _348.z;
        _369 = (_313 * _358) + _348.y;
        _370 = _348.x;
        _371 = (_312 * _342.w) + _342.xyz;
        _372 = normalize((_274 * _345.w) + ((_345.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _368 = _318;
        _369 = _313;
        _370 = 0.0;
        _371 = _312;
        _372 = _274;
    }
    bool _382 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _388;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319 + 18u)].w > 0.0) && _382)
    {
        _388 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _388 = 1.0;
    }
    float _435;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320)].z > 0.0)
    {
        float3 _403 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _414 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_403.x), int(_403.y), int(_403.z), 0).xyz), 0));
        _435 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_414.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_403 / float3(_414.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _435 = _388;
    }
    float3 _449 = ((_371 - (_371 * _370)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _456 = (mix(float3(0.07999999821186065673828125 * _369), _371, float3(_370)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _459 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _464;
    if (_459)
    {
        _464 = _449 + (_456 * 0.449999988079071044921875);
    }
    else
    {
        _464 = _449;
    }
    float3 _466 = select(_456, float3(0.0), bool3(_459));
    float3 _468 = float3(dot(_466, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _542;
    if (_382)
    {
        float3 _494 = fast::clamp((_236 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _498 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _494);
        float4 _502 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _494);
        float4 _505 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _494);
        float4 _523 = _169;
        _523.y = (-0.48860299587249755859375) * _372.y;
        float4 _526 = _523;
        _526.z = 0.48860299587249755859375 * _372.z;
        float4 _529 = _526;
        _529.w = (-0.48860299587249755859375) * _372.x;
        float4 _530 = _529;
        _530.x = 0.886227548122406005859375;
        float3 _532 = _530.yzw * 2.094395160675048828125;
        float4 _533 = float4(_530.x, _532.x, _532.y, _532.z);
        float3 _535 = float3(0.0);
        _535.x = dot(float4(_498.x, _502.x, _505.x, _498.w), _533);
        float3 _537 = _535;
        _537.y = dot(float4(_498.y, _502.y, _505.y, _502.w), _533);
        float3 _539 = _537;
        _539.z = dot(float4(_498.z, _502.z, _505.zw), _533);
        _542 = fast::max(float3(0.0), _539) * float3(0.3183098733425140380859375);
    }
    else
    {
        _542 = float3(0.0);
    }
    float _568;
    float _569;
    float3 _570;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _558;
        float _559;
        if (_382)
        {
            _558 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _559 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _558 = _372;
            _559 = 1.0;
        }
        float _560 = 1.0 - _559;
        float _562 = 1.0 - (_560 * _560);
        _568 = mix(fast::clamp(dot(_558, _372), 0.0, 1.0), 1.0, _562);
        _569 = _559;
        _570 = mix(_558, _372, float3(_562));
    }
    else
    {
        _568 = 1.0;
        _569 = 1.0;
        _570 = _372;
    }
    float4 _574 = float4(_570, 1.0);
    float3 _578 = _166;
    _578.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _574);
    float3 _582 = _578;
    _582.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _574);
    float3 _586 = _582;
    _586.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _574);
    float4 _589 = _574.xyzz * _574.yzzx;
    float3 _593 = _166;
    _593.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _589);
    float3 _597 = _593;
    _597.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _589);
    float3 _601 = _597;
    _601.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _589);
    float3 _616 = (_542 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_586 + _601) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_570.x * _570.x) - (_570.y * _570.y)))) * View.View_SkyLightColor.xyz) * (_569 * _568));
    float3 _638 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _667;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _666;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319 + 19u)].xyz + float3(1.0))))
        {
            _666 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _666 = _638;
        }
        _667 = _666;
    }
    else
    {
        _667 = _638;
    }
    float4 _674 = float4(((mix(float3(0.0), _464 + (_466 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_616 * _464) * fast::max(float3(1.0), ((((((_371 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_371 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_371 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _667) * 1.0, 0.0);
    float4 _681;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _680 = _674;
        _680.w = 0.0;
        _681 = _680;
    }
    else
    {
        _681 = _674;
    }
    float2 _685 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _693 = (_372 * 0.5) + float3(0.5);
    float4 _695 = float4(_693.x, _693.y, _693.z, float4(0.0).w);
    _695.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320)].y;
    float4 _696 = float4(0.0);
    _696.x = _370;
    float4 _697 = _696;
    _697.y = _369;
    float4 _698 = _697;
    _698.z = _368;
    float4 _699 = _698;
    _699.w = 0.50588238239288330078125;
    float4 _711 = float4(_371.x, _371.y, _371.z, float4(0.0).w);
    _711.w = ((log2(((dot(_616, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_468 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_468 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_468 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_685.xyx * _685.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _681 * View.View_PreExposure;
    out.out_var_SV_Target1 = _695;
    out.out_var_SV_Target2 = _699;
    out.out_var_SV_Target3 = _711;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_435, 1.0, 1.0, 1.0);
    return out;
}

