

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
    char _m17_pad[188];
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
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _170 = {};

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

fragment MainPS_out Main_00004614_7b8c197a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = (_231.xyz / float3(_231.w)) - View.View_PreViewTranslation;
    float2 _237 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float2 _254 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _254, bias(View.View_MaterialTextureMipBias));
    float2 _259 = (_256.xy * float2(2.0)) - float2(1.0);
    float4 _271 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _278 = (_271.x + 0.5) * _276.x;
    float _280 = fast::min(fast::max(_278, 0.0), 1.0);
    float3 _283 = float3(_280);
    float4 _289 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _316;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _316 = _227.w;
                break;
            }
            else
            {
                float _300 = _227.z;
                _316 = ((_300 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_300 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _331 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz, float4(_259, sqrt(fast::clamp(1.0 - dot(_259, _259), 0.0, 1.0)), 1.0).xyz, _283), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _289.x) + _316) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _343 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float4 _345 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _254, bias(View.View_MaterialTextureMipBias));
    float3 _355 = fast::clamp(mix(_343.xyz, _345.xyz, _283) * mix(0.60000002384185791015625, 1.0, _278), float3(0.0), float3(1.0));
    float _360 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _278 * mix(_343.w, _345.w, _280)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _361 = in.in_var_PRIMITIVE_ID * 36u;
    uint _362 = _361 + 20u;
    float _410;
    float _411;
    float _412;
    float3 _413;
    float3 _414;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _380 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _384 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _380, level(0.0));
        float4 _387 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _380, level(0.0));
        float4 _390 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _380, level(0.0));
        float _400 = _390.w;
        _410 = (_360 * _400) + _390.z;
        _411 = (0.5 * _400) + _390.y;
        _412 = _390.x;
        _413 = (_355 * _384.w) + _384.xyz;
        _414 = normalize((_331 * _387.w) + ((_387.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _410 = _360;
        _411 = 0.5;
        _412 = 0.0;
        _413 = _355;
        _414 = _331;
    }
    bool _424 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _430;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361 + 18u)].w > 0.0) && _424)
    {
        _430 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _430 = 1.0;
    }
    float _477;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362)].z > 0.0)
    {
        float3 _445 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _456 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_445.x), int(_445.y), int(_445.z), 0).xyz), 0));
        _477 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_456.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_445 / float3(_456.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _477 = _430;
    }
    float3 _491 = ((_413 - (_413 * _412)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _498 = (mix(float3(0.07999999821186065673828125 * _411), _413, float3(_412)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _501 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _506;
    if (_501)
    {
        _506 = _491 + (_498 * 0.449999988079071044921875);
    }
    else
    {
        _506 = _491;
    }
    float3 _508 = select(_498, float3(0.0), bool3(_501));
    float3 _510 = float3(dot(_508, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _584;
    if (_424)
    {
        float3 _536 = fast::clamp((_236 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _540 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _536);
        float4 _544 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _536);
        float4 _547 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _536);
        float4 _565 = _170;
        _565.y = (-0.48860299587249755859375) * _414.y;
        float4 _568 = _565;
        _568.z = 0.48860299587249755859375 * _414.z;
        float4 _571 = _568;
        _571.w = (-0.48860299587249755859375) * _414.x;
        float4 _572 = _571;
        _572.x = 0.886227548122406005859375;
        float3 _574 = _572.yzw * 2.094395160675048828125;
        float4 _575 = float4(_572.x, _574.x, _574.y, _574.z);
        float3 _577 = float3(0.0);
        _577.x = dot(float4(_540.x, _544.x, _547.x, _540.w), _575);
        float3 _579 = _577;
        _579.y = dot(float4(_540.y, _544.y, _547.y, _544.w), _575);
        float3 _581 = _579;
        _581.z = dot(float4(_540.z, _544.z, _547.zw), _575);
        _584 = fast::max(float3(0.0), _581) * float3(0.3183098733425140380859375);
    }
    else
    {
        _584 = float3(0.0);
    }
    float3 _587 = _584 * View.View_IndirectLightingColorScale;
    float3 _609 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _638;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _637;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _361 + 19u)].xyz + float3(1.0))))
        {
            _637 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _637 = _609;
        }
        _638 = _637;
    }
    else
    {
        _638 = _609;
    }
    float4 _645 = float4(((mix(float3(0.0), _506 + (_508 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_587 * _506) * fast::max(float3(1.0), ((((((_413 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_413 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_413 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _638) * 1.0, 0.0);
    float4 _652;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _651 = _645;
        _651.w = 0.0;
        _652 = _651;
    }
    else
    {
        _652 = _645;
    }
    float2 _656 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _664 = (_414 * 0.5) + float3(0.5);
    float4 _666 = float4(_664.x, _664.y, _664.z, float4(0.0).w);
    _666.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362)].y;
    float4 _667 = float4(0.0);
    _667.x = _412;
    float4 _668 = _667;
    _668.y = _411;
    float4 _669 = _668;
    _669.z = _410;
    float4 _670 = _669;
    _670.w = 0.50588238239288330078125;
    float4 _682 = float4(_413.x, _413.y, _413.z, float4(0.0).w);
    _682.w = ((log2(((dot(_587, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_510 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_510 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_510 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_656.xyx * _656.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _652 * View.View_PreExposure;
    out.out_var_SV_Target1 = _666;
    out.out_var_SV_Target2 = _670;
    out.out_var_SV_Target3 = _682;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_477, 1.0, 1.0, 1.0);
    return out;
}

