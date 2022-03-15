

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

constant float3 _161 = {};
constant float _163 = {};
constant float4 _164 = {};

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

fragment MainPS_out Main_00004959_c2dc1d2f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _226 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _231 = (_226.xyz / float3(_226.w)) - View.View_PreViewTranslation;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _256 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _278 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _282 = (_268.x + 0.5) * ((_273.x + 0.5) * (_278.x + 0.5));
    float4 _288 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _294 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_282)) * _288.xyz, float3(0.0), float3(1.0));
    float _299 = (fast::clamp(mix(0.800000011920928955078125, 0.4000000059604644775390625, _282 * _288.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _300 = in.in_var_PRIMITIVE_ID * 36u;
    uint _301 = _300 + 20u;
    float _349;
    float _350;
    float _351;
    float3 _352;
    float3 _353;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _319 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _323 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _326 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _319, level(0.0));
        float _339 = _329.w;
        _349 = (_299 * _339) + _329.z;
        _350 = (0.5 * _339) + _329.y;
        _351 = _329.x;
        _352 = (_294 * _323.w) + _323.xyz;
        _353 = normalize((_256 * _326.w) + ((_326.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _349 = _299;
        _350 = 0.5;
        _351 = 0.0;
        _352 = _294;
        _353 = _256;
    }
    bool _363 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _369;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 18u)].w > 0.0) && _363)
    {
        _369 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _369 = 1.0;
    }
    float _416;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].z > 0.0)
    {
        float3 _384 = fast::clamp((_231 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _395 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_384.x), int(_384.y), int(_384.z), 0).xyz), 0));
        _416 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_395.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_384 / float3(_395.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _416 = _369;
    }
    float3 _430 = ((_352 - (_352 * _351)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _437 = (mix(float3(0.07999999821186065673828125 * _350), _352, float3(_351)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _440 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _445;
    if (_440)
    {
        _445 = _430 + (_437 * 0.449999988079071044921875);
    }
    else
    {
        _445 = _430;
    }
    float3 _447 = select(_437, float3(0.0), bool3(_440));
    float3 _449 = float3(dot(_447, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _523;
    if (_363)
    {
        float3 _475 = fast::clamp((_231 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _479 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _475);
        float4 _483 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _475);
        float4 _486 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _475);
        float4 _504 = _164;
        _504.y = (-0.48860299587249755859375) * _353.y;
        float4 _507 = _504;
        _507.z = 0.48860299587249755859375 * _353.z;
        float4 _510 = _507;
        _510.w = (-0.48860299587249755859375) * _353.x;
        float4 _511 = _510;
        _511.x = 0.886227548122406005859375;
        float3 _513 = _511.yzw * 2.094395160675048828125;
        float4 _514 = float4(_511.x, _513.x, _513.y, _513.z);
        float3 _516 = float3(0.0);
        _516.x = dot(float4(_479.x, _483.x, _486.x, _479.w), _514);
        float3 _518 = _516;
        _518.y = dot(float4(_479.y, _483.y, _486.y, _483.w), _514);
        float3 _520 = _518;
        _520.z = dot(float4(_479.z, _483.z, _486.zw), _514);
        _523 = fast::max(float3(0.0), _520) * float3(0.3183098733425140380859375);
    }
    else
    {
        _523 = float3(0.0);
    }
    float _549;
    float _550;
    float3 _551;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _539;
        float _540;
        if (_363)
        {
            _539 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _540 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _539 = _353;
            _540 = 1.0;
        }
        float _541 = 1.0 - _540;
        float _543 = 1.0 - (_541 * _541);
        _549 = mix(fast::clamp(dot(_539, _353), 0.0, 1.0), 1.0, _543);
        _550 = _540;
        _551 = mix(_539, _353, float3(_543));
    }
    else
    {
        _549 = 1.0;
        _550 = 1.0;
        _551 = _353;
    }
    float4 _555 = float4(_551, 1.0);
    float3 _559 = _161;
    _559.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _555);
    float3 _563 = _559;
    _563.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _555);
    float3 _567 = _563;
    _567.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _555);
    float4 _570 = _555.xyzz * _555.yzzx;
    float3 _574 = _161;
    _574.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _570);
    float3 _578 = _574;
    _578.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _570);
    float3 _582 = _578;
    _582.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _570);
    float3 _597 = (_523 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_567 + _582) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_551.x * _551.x) - (_551.y * _551.y)))) * View.View_SkyLightColor.xyz) * (_550 * _549));
    float3 _619 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _648;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _647;
        if (any(abs(_231 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300 + 19u)].xyz + float3(1.0))))
        {
            _647 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_231, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _647 = _619;
        }
        _648 = _647;
    }
    else
    {
        _648 = _619;
    }
    float4 _655 = float4(((mix(float3(0.0), _445 + (_447 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_597 * _445) * fast::max(float3(1.0), ((((((_352 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_352 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_352 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _648) * 1.0, 0.0);
    float4 _662;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _661 = _655;
        _661.w = 0.0;
        _662 = _661;
    }
    else
    {
        _662 = _655;
    }
    float2 _666 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _674 = (_353 * 0.5) + float3(0.5);
    float4 _676 = float4(_674.x, _674.y, _674.z, float4(0.0).w);
    _676.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _301)].y;
    float4 _677 = float4(0.0);
    _677.x = _351;
    float4 _678 = _677;
    _678.y = _350;
    float4 _679 = _678;
    _679.z = _349;
    float4 _680 = _679;
    _680.w = 0.50588238239288330078125;
    float4 _692 = float4(_352.x, _352.y, _352.z, float4(0.0).w);
    _692.w = ((log2(((dot(_597, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_449 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_449 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_449 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_666.xyx * _666.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _662 * View.View_PreExposure;
    out.out_var_SV_Target1 = _676;
    out.out_var_SV_Target2 = _680;
    out.out_var_SV_Target3 = _692;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_416, 1.0, 1.0, 1.0);
    return out;
}

