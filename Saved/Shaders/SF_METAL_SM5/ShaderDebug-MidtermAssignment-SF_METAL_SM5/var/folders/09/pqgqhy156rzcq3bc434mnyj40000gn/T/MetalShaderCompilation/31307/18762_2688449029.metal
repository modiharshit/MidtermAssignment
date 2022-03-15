

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

constant float3 _159 = {};
constant float _161 = {};
constant float4 _162 = {};

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

fragment MainPS_out Main_0000494a_a03e7a05(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _161, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_238, sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _271 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _280 = (_266.x + 0.5) * ((_271.x + 0.5) * (_276.x + 0.5));
    float4 _286 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _292 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_280)) * _286.xyz, float3(0.0), float3(1.0));
    float _297 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _280 * _286.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _298 = in.in_var_PRIMITIVE_ID * 36u;
    uint _299 = _298 + 20u;
    float _348;
    float _349;
    float _350;
    float3 _351;
    float3 _352;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _317 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _321 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _317, level(0.0));
        float4 _324 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _317, level(0.0));
        float4 _327 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _317, level(0.0));
        float _337 = _327.w;
        _348 = (_297 * _337) + _327.z;
        _349 = (0.5 * _337) + _327.y;
        _350 = _337 + _327.x;
        _351 = (_292 * _321.w) + _321.xyz;
        _352 = normalize((_254 * _324.w) + ((_324.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _348 = _297;
        _349 = 0.5;
        _350 = 1.0;
        _351 = _292;
        _352 = _254;
    }
    bool _362 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _368;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 18u)].w > 0.0) && _362)
    {
        _368 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _368 = 1.0;
    }
    float _415;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299)].z > 0.0)
    {
        float3 _383 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _394 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_383.x), int(_383.y), int(_383.z), 0).xyz), 0));
        _415 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_394.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_383 / float3(_394.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _415 = _368;
    }
    float3 _429 = ((_351 - (_351 * _350)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _436 = (mix(float3(0.07999999821186065673828125 * _349), _351, float3(_350)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _439 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _444;
    if (_439)
    {
        _444 = _429 + (_436 * 0.449999988079071044921875);
    }
    else
    {
        _444 = _429;
    }
    float3 _446 = select(_436, float3(0.0), bool3(_439));
    float3 _448 = float3(dot(_446, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _522;
    if (_362)
    {
        float3 _474 = fast::clamp((_229 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _478 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _474);
        float4 _482 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _474);
        float4 _485 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _474);
        float4 _503 = _162;
        _503.y = (-0.48860299587249755859375) * _352.y;
        float4 _506 = _503;
        _506.z = 0.48860299587249755859375 * _352.z;
        float4 _509 = _506;
        _509.w = (-0.48860299587249755859375) * _352.x;
        float4 _510 = _509;
        _510.x = 0.886227548122406005859375;
        float3 _512 = _510.yzw * 2.094395160675048828125;
        float4 _513 = float4(_510.x, _512.x, _512.y, _512.z);
        float3 _515 = float3(0.0);
        _515.x = dot(float4(_478.x, _482.x, _485.x, _478.w), _513);
        float3 _517 = _515;
        _517.y = dot(float4(_478.y, _482.y, _485.y, _482.w), _513);
        float3 _519 = _517;
        _519.z = dot(float4(_478.z, _482.z, _485.zw), _513);
        _522 = fast::max(float3(0.0), _519) * float3(0.3183098733425140380859375);
    }
    else
    {
        _522 = float3(0.0);
    }
    float _548;
    float _549;
    float3 _550;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _538;
        float _539;
        if (_362)
        {
            _538 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _539 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _538 = _352;
            _539 = 1.0;
        }
        float _540 = 1.0 - _539;
        float _542 = 1.0 - (_540 * _540);
        _548 = mix(fast::clamp(dot(_538, _352), 0.0, 1.0), 1.0, _542);
        _549 = _539;
        _550 = mix(_538, _352, float3(_542));
    }
    else
    {
        _548 = 1.0;
        _549 = 1.0;
        _550 = _352;
    }
    float4 _554 = float4(_550, 1.0);
    float3 _558 = _159;
    _558.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _554);
    float3 _562 = _558;
    _562.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _554);
    float3 _566 = _562;
    _566.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _554);
    float4 _569 = _554.xyzz * _554.yzzx;
    float3 _573 = _159;
    _573.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _569);
    float3 _577 = _573;
    _577.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _569);
    float3 _581 = _577;
    _581.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _569);
    float3 _596 = (_522 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_566 + _581) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_550.x * _550.x) - (_550.y * _550.y)))) * View.View_SkyLightColor.xyz) * (_549 * _548));
    float3 _618 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _647;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _646;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _298 + 19u)].xyz + float3(1.0))))
        {
            _646 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _646 = _618;
        }
        _647 = _646;
    }
    else
    {
        _647 = _618;
    }
    float4 _654 = float4(((mix(float3(0.0), _444 + (_446 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_596 * _444) * fast::max(float3(1.0), ((((((_351 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_351 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_351 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _647) * 1.0, 0.0);
    float4 _661;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _660 = _654;
        _660.w = 0.0;
        _661 = _660;
    }
    else
    {
        _661 = _654;
    }
    float2 _665 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _673 = (_352 * 0.5) + float3(0.5);
    float4 _675 = float4(_673.x, _673.y, _673.z, float4(0.0).w);
    _675.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299)].y;
    float4 _676 = float4(0.0);
    _676.x = _350;
    float4 _677 = _676;
    _677.y = _349;
    float4 _678 = _677;
    _678.z = _348;
    float4 _679 = _678;
    _679.w = 0.50588238239288330078125;
    float4 _691 = float4(_351.x, _351.y, _351.z, float4(0.0).w);
    _691.w = ((log2(((dot(_596, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_448 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_448 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_448 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_665.xyx * _665.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _661 * View.View_PreExposure;
    out.out_var_SV_Target1 = _675;
    out.out_var_SV_Target2 = _679;
    out.out_var_SV_Target3 = _691;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_415, 1.0, 1.0, 1.0);
    return out;
}

