

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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _150 = {};
constant float _151 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004110_3d2e7699(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _151, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    float4 _222 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _225 = (_222.xy * float2(2.0)) - float2(1.0);
    float _232 = sqrt(fast::clamp(1.0 - dot(_225, _225), 0.0, 1.0)) + 1.0;
    float2 _233 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _237 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float _244 = sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0));
    float3 _250 = float3(_225, _232);
    float3 _253 = float3(float4(_240, _244, 1.0).xy * (-1.0), _244);
    float3 _265 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_250 * dot(_250, _253)) - (_253 * _232)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _276 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float4 _280 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _285 = fast::clamp(_276.xyz, float3(0.0), float3(1.0));
    float _286 = fast::clamp(_280.x, 0.0, 1.0);
    float _291 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _292 = in.in_var_PRIMITIVE_ID * 36u;
    uint _293 = _292 + 20u;
    float _341;
    float _342;
    float _343;
    float3 _344;
    float3 _345;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _311 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _315 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _311, level(0.0));
        float4 _318 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _311, level(0.0));
        float4 _321 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _311, level(0.0));
        float _331 = _321.w;
        _341 = (_291 * _331) + _321.z;
        _342 = (0.5 * _331) + _321.y;
        _343 = _321.x;
        _344 = (_285 * _315.w) + _315.xyz;
        _345 = normalize((_265 * _318.w) + ((_318.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _341 = _291;
        _342 = 0.5;
        _343 = 0.0;
        _344 = _285;
        _345 = _265;
    }
    float4 _352 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _353 = in.in_var_LIGHTMAP_ID * 15u;
    uint _354 = _353 + 1u;
    float4 _361 = fast::clamp((_352 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _354)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _354)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _378 = ((_344 - (_344 * _343)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _385 = (mix(float3(0.07999999821186065673828125 * _342), _344, float3(_343)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _388 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _393;
    if (_388)
    {
        _393 = _378 + (_385 * 0.449999988079071044921875);
    }
    else
    {
        _393 = _378;
    }
    float3 _395 = select(_385, float3(0.0), bool3(_388));
    float3 _397 = float3(dot(_395, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _404 = float3(_286);
    float2 _413 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _417 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _413);
    float4 _419 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_413 + float2(0.0, 0.5)));
    uint _425 = _353 + 4u;
    uint _430 = _353 + 6u;
    float3 _435 = _417.xyz;
    float _487;
    float _488;
    float3 _489;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _471 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _475 = _471.w;
        float _476 = _475 * _475;
        float3 _478 = normalize(((_471.xyz * 2.0) - float3(1.0)).xyz);
        float _479 = 1.0 - _476;
        float _481 = 1.0 - (_479 * _479);
        _487 = mix(fast::clamp(dot(_478, _345), 0.0, 1.0), 1.0, _481);
        _488 = _476;
        _489 = mix(_478, _345, float3(_481));
    }
    else
    {
        _487 = 1.0;
        _488 = 1.0;
        _489 = _345;
    }
    float4 _493 = float4(_489, 1.0);
    float3 _497 = _150;
    _497.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _493);
    float3 _501 = _497;
    _501.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _493);
    float3 _505 = _501;
    _505.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _493);
    float4 _508 = _493.xyzz * _493.yzzx;
    float3 _512 = _150;
    _512.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _508);
    float3 _516 = _512;
    _516.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _508);
    float3 _520 = _516;
    _520.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _508);
    float3 _535 = (((((_435 * _435) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _425)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _430)].xyz) * ((exp2(((_417.w + ((_419.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _425)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _430)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_419 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _353 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _353 + 7u)], float4(_345.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_505 + _520) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_489.x * _489.x) - (_489.y * _489.y)))) * View.View_SkyLightColor.xyz) * (_488 * _487));
    float3 _557 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _586;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _585;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _292 + 19u)].xyz + float3(1.0))))
        {
            _585 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _585 = _557;
        }
        _586 = _585;
    }
    else
    {
        _586 = _557;
    }
    float4 _593 = float4(((mix(float3(0.0), _393 + (_395 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_535 * _393) * fast::max(_404, ((((((_344 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _286) + ((_344 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _286) + ((_344 * 2.755199909210205078125) + float3(0.69029998779296875))) * _286))) + _586) * 1.0, 0.0);
    float4 _600;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _599 = _593;
        _599.w = 0.0;
        _600 = _599;
    }
    else
    {
        _600 = _593;
    }
    float2 _604 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _612 = (_345 * 0.5) + float3(0.5);
    float4 _614 = float4(_612.x, _612.y, _612.z, float4(0.0).w);
    _614.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _293)].y;
    float4 _615 = float4(0.0);
    _615.x = _343;
    float4 _616 = _615;
    _616.y = _342;
    float4 _617 = _616;
    _617.z = _341;
    float4 _618 = _617;
    _618.w = 0.50588238239288330078125;
    float4 _630 = float4(_344.x, _344.y, _344.z, float4(0.0).w);
    _630.w = ((log2(((dot(_535, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_404, ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _286) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _286) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * _286).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_604.xyx * _604.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _600 * View.View_PreExposure;
    out.out_var_SV_Target1 = _614;
    out.out_var_SV_Target2 = _618;
    out.out_var_SV_Target3 = _630;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _353)] * _361) * _361;
    return out;
}

