

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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

constant float3 _157 = {};
constant float _159 = {};
constant float4 _160 = {};

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

fragment MainPS_out Main_000046ce_f82ace0c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _159, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _226 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _231 = (_226.xyz / float3(_226.w)) - View.View_PreViewTranslation;
    uint _232 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float3 _265 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if ((_276.w - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _283 = fast::clamp(_276.xyz, float3(0.0), float3(1.0));
    float _287 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _288 = _232 + 20u;
    float _336;
    float _337;
    float _338;
    float3 _339;
    float3 _340;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _306 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _310 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _306, level(0.0));
        float4 _313 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _306, level(0.0));
        float4 _316 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _306, level(0.0));
        float _326 = _316.w;
        _336 = (_287 * _326) + _316.z;
        _337 = (0.5 * _326) + _316.y;
        _338 = _316.x;
        _339 = (_283 * _310.w) + _310.xyz;
        _340 = normalize((_265 * _313.w) + ((_313.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _336 = _287;
        _337 = 0.5;
        _338 = 0.0;
        _339 = _283;
        _340 = _265;
    }
    bool _350 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _356;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 18u)].w > 0.0) && _350)
    {
        _356 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _356 = 1.0;
    }
    float _403;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288)].z > 0.0)
    {
        float3 _371 = fast::clamp((_231 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _382 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_371.x), int(_371.y), int(_371.z), 0).xyz), 0));
        _403 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_382.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_371 / float3(_382.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _403 = _356;
    }
    float3 _417 = ((_339 - (_339 * _338)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _424 = (mix(float3(0.07999999821186065673828125 * _337), _339, float3(_338)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _427 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _432;
    if (_427)
    {
        _432 = _417 + (_424 * 0.449999988079071044921875);
    }
    else
    {
        _432 = _417;
    }
    float3 _434 = select(_424, float3(0.0), bool3(_427));
    float3 _436 = float3(dot(_434, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _510;
    if (_350)
    {
        float3 _462 = fast::clamp((_231 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _466 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _462);
        float4 _470 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _462);
        float4 _473 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _462);
        float4 _491 = _160;
        _491.y = (-0.48860299587249755859375) * _340.y;
        float4 _494 = _491;
        _494.z = 0.48860299587249755859375 * _340.z;
        float4 _497 = _494;
        _497.w = (-0.48860299587249755859375) * _340.x;
        float4 _498 = _497;
        _498.x = 0.886227548122406005859375;
        float3 _500 = _498.yzw * 2.094395160675048828125;
        float4 _501 = float4(_498.x, _500.x, _500.y, _500.z);
        float3 _503 = float3(0.0);
        _503.x = dot(float4(_466.x, _470.x, _473.x, _466.w), _501);
        float3 _505 = _503;
        _505.y = dot(float4(_466.y, _470.y, _473.y, _470.w), _501);
        float3 _507 = _505;
        _507.z = dot(float4(_466.z, _470.z, _473.zw), _501);
        _510 = fast::max(float3(0.0), _507) * float3(0.3183098733425140380859375);
    }
    else
    {
        _510 = float3(0.0);
    }
    float _536;
    float _537;
    float3 _538;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _526;
        float _527;
        if (_350)
        {
            _526 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _527 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _526 = _340;
            _527 = 1.0;
        }
        float _528 = 1.0 - _527;
        float _530 = 1.0 - (_528 * _528);
        _536 = mix(fast::clamp(dot(_526, _340), 0.0, 1.0), 1.0, _530);
        _537 = _527;
        _538 = mix(_526, _340, float3(_530));
    }
    else
    {
        _536 = 1.0;
        _537 = 1.0;
        _538 = _340;
    }
    float4 _542 = float4(_538, 1.0);
    float3 _546 = _157;
    _546.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _542);
    float3 _550 = _546;
    _550.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _542);
    float3 _554 = _550;
    _554.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _542);
    float4 _557 = _542.xyzz * _542.yzzx;
    float3 _561 = _157;
    _561.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _557);
    float3 _565 = _561;
    _565.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _557);
    float3 _569 = _565;
    _569.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _557);
    float3 _584 = (_510 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_554 + _569) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_538.x * _538.x) - (_538.y * _538.y)))) * View.View_SkyLightColor.xyz) * (_537 * _536));
    float3 _606 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _635;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _634;
        if (any(abs(_231 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _232 + 19u)].xyz + float3(1.0))))
        {
            _634 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_231, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _634 = _606;
        }
        _635 = _634;
    }
    else
    {
        _635 = _606;
    }
    float4 _642 = float4(((mix(float3(0.0), _432 + (_434 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_584 * _432) * fast::max(float3(1.0), ((((((_339 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_339 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_339 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _635) * 1.0, 0.0);
    float4 _649;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _648 = _642;
        _648.w = 0.0;
        _649 = _648;
    }
    else
    {
        _649 = _642;
    }
    float2 _653 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _661 = (_340 * 0.5) + float3(0.5);
    float4 _663 = float4(_661.x, _661.y, _661.z, float4(0.0).w);
    _663.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288)].y;
    float4 _664 = float4(0.0);
    _664.x = _338;
    float4 _665 = _664;
    _665.y = _337;
    float4 _666 = _665;
    _666.z = _336;
    float4 _667 = _666;
    _667.w = 0.50588238239288330078125;
    float4 _679 = float4(_339.x, _339.y, _339.z, float4(0.0).w);
    _679.w = ((log2(((dot(_584, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_436 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_436 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_436 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_653.xyx * _653.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _649 * View.View_PreExposure;
    out.out_var_SV_Target1 = _663;
    out.out_var_SV_Target2 = _667;
    out.out_var_SV_Target3 = _679;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_403, 1.0, 1.0, 1.0);
    return out;
}

