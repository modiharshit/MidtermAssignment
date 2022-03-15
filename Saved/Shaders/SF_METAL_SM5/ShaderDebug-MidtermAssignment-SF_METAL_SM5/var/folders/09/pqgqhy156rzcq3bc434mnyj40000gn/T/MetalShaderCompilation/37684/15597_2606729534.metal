

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float3 _146 = {};
constant float _147 = {};

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

fragment MainPS_out Main_00003ced_9b5f893e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _201 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _147, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _206 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _211 = (_206.xyz / float3(_206.w)) - View.View_PreViewTranslation;
    float4 _217 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _220 = (_217.xy * float2(2.0)) - float2(1.0);
    float3 _236 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_220, sqrt(fast::clamp(1.0 - dot(_220, _220), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _247 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _254 = _247.y;
    float _260 = _247.z;
    float _263 = _247.x;
    float3 _281 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_254)), Material.Material_VectorExpressions[7].xyz, float3(_260)) * _263, float3(0.0), float3(1.0));
    float _282 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _254), Material.Material_ScalarExpressions[0].w, _260), 0.0, 1.0);
    float _283 = fast::clamp(_263, 0.0, 1.0);
    float _288 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _254), Material.Material_ScalarExpressions[1].z, _260), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _289 = in.in_var_PRIMITIVE_ID * 36u;
    uint _290 = _289 + 20u;
    float _340;
    float _341;
    float _342;
    float3 _343;
    float3 _344;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _308 = ((_201.xy / float2(_201.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _312 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _315 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float4 _318 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _308, level(0.0));
        float _328 = _318.w;
        _340 = (_288 * _328) + _318.z;
        _341 = (0.5 * _328) + _318.y;
        _342 = (_282 * _328) + _318.x;
        _343 = (_281 * _312.w) + _312.xyz;
        _344 = normalize((_236 * _315.w) + ((_315.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _340 = _288;
        _341 = 0.5;
        _342 = _282;
        _343 = _281;
        _344 = _236;
    }
    float3 _359 = ((_343 - (_343 * _342)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _366 = (mix(float3(0.07999999821186065673828125 * _341), _343, float3(_342)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _369 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _374;
    if (_369)
    {
        _374 = _359 + (_366 * 0.449999988079071044921875);
    }
    else
    {
        _374 = _359;
    }
    float3 _376 = select(_366, float3(0.0), bool3(_369));
    float3 _378 = float3(dot(_376, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _385 = float3(_283);
    float2 _394 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _399 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _394);
    float4 _401 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_394 + float2(0.0, 0.5)));
    uint _407 = in.in_var_LIGHTMAP_ID * 15u;
    uint _408 = _407 + 4u;
    uint _413 = _407 + 6u;
    float3 _418 = _399.xyz;
    float _470;
    float _471;
    float3 _472;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _454 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _458 = _454.w;
        float _459 = _458 * _458;
        float3 _461 = normalize(((_454.xyz * 2.0) - float3(1.0)).xyz);
        float _462 = 1.0 - _459;
        float _464 = 1.0 - (_462 * _462);
        _470 = mix(fast::clamp(dot(_461, _344), 0.0, 1.0), 1.0, _464);
        _471 = _459;
        _472 = mix(_461, _344, float3(_464));
    }
    else
    {
        _470 = 1.0;
        _471 = 1.0;
        _472 = _344;
    }
    float4 _476 = float4(_472, 1.0);
    float3 _480 = _146;
    _480.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _476);
    float3 _484 = _480;
    _484.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _476);
    float3 _488 = _484;
    _488.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _476);
    float4 _491 = _476.xyzz * _476.yzzx;
    float3 _495 = _146;
    _495.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _491);
    float3 _499 = _495;
    _499.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _491);
    float3 _503 = _499;
    _503.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _491);
    float3 _518 = (((((_418 * _418) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _408)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _413)].xyz) * ((exp2(((_399.w + ((_401.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _408)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _413)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_401 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _407 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _407 + 7u)], float4(_344.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_488 + _503) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_472.x * _472.x) - (_472.y * _472.y)))) * View.View_SkyLightColor.xyz) * (_471 * _470));
    float3 _540 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _569;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _568;
        if (any(abs(_211 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289 + 19u)].xyz + float3(1.0))))
        {
            _568 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_211, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _568 = _540;
        }
        _569 = _568;
    }
    else
    {
        _569 = _540;
    }
    float4 _576 = float4(((mix(float3(0.0), _374 + (_376 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_518 * _374) * fast::max(_385, ((((((_343 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _283) + ((_343 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _283) + ((_343 * 2.755199909210205078125) + float3(0.69029998779296875))) * _283))) + _569) * 1.0, 0.0);
    float4 _583;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _582 = _576;
        _582.w = 0.0;
        _583 = _582;
    }
    else
    {
        _583 = _576;
    }
    float2 _587 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _595 = (_344 * 0.5) + float3(0.5);
    float4 _597 = float4(_595.x, _595.y, _595.z, float4(0.0).w);
    _597.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _290)].y;
    float4 _598 = float4(0.0);
    _598.x = _342;
    float4 _599 = _598;
    _599.y = _341;
    float4 _600 = _599;
    _600.z = _340;
    float4 _601 = _600;
    _601.w = 0.75686275959014892578125;
    float4 _613 = float4(_343.x, _343.y, _343.z, float4(0.0).w);
    _613.w = ((log2(((dot(_518, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_385, ((((((_378 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _283) + ((_378 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _283) + ((_378 * 2.755199909210205078125) + float3(0.69029998779296875))) * _283).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_587.xyx * _587.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _583 * View.View_PreExposure;
    out.out_var_SV_Target1 = _597;
    out.out_var_SV_Target2 = _601;
    out.out_var_SV_Target3 = _613;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

