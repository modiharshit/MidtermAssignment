

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
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

constant float3 _140 = {};
constant float _141 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    uint in_var_LIGHTMAP_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000039b7_7d50609c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _192 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _141, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _197 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _202 = (_197.xyz / float3(_197.w)) - View.View_PreViewTranslation;
    float3 _210 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _221 = (0.64999997615814208984375 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _222 = in.in_var_PRIMITIVE_ID * 36u;
    uint _223 = _222 + 20u;
    float _272;
    float _273;
    float _274;
    float3 _275;
    float3 _276;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _241 = ((_192.xy / float2(_192.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _245 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _241, level(0.0));
        float4 _248 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _241, level(0.0));
        float4 _251 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _241, level(0.0));
        float _261 = _251.w;
        _272 = (_221 * _261) + _251.z;
        _273 = (0.5 * _261) + _251.y;
        _274 = _261 + _251.x;
        _275 = (float3(0.180000007152557373046875) * _245.w) + _245.xyz;
        _276 = normalize((_210 * _248.w) + ((_248.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _272 = _221;
        _273 = 0.5;
        _274 = 1.0;
        _275 = float3(0.180000007152557373046875);
        _276 = _210;
    }
    float4 _283 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _284 = in.in_var_LIGHTMAP_ID * 15u;
    uint _285 = _284 + 1u;
    float4 _292 = fast::clamp((_283 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _285)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _285)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float4 _297 = float4(0.0);
    _297.x = 1.0;
    float4 _298 = _297;
    _298.y = 0.0;
    float3 _312 = ((_275 - (_275 * _274)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _319 = (mix(float3(0.07999999821186065673828125 * _273), _275, float3(_274)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _322 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _327;
    if (_322)
    {
        _327 = _312 + (_319 * 0.449999988079071044921875);
    }
    else
    {
        _327 = _312;
    }
    float3 _329 = select(_319, float3(0.0), bool3(_322));
    float3 _331 = float3(dot(_329, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _346 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _350 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _346);
    float4 _352 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_346 + float2(0.0, 0.5)));
    uint _358 = _284 + 4u;
    uint _363 = _284 + 6u;
    float3 _368 = _350.xyz;
    float _420;
    float _421;
    float3 _422;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _404 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _408 = _404.w;
        float _409 = _408 * _408;
        float3 _411 = normalize(((_404.xyz * 2.0) - float3(1.0)).xyz);
        float _412 = 1.0 - _409;
        float _414 = 1.0 - (_412 * _412);
        _420 = mix(fast::clamp(dot(_411, _276), 0.0, 1.0), 1.0, _414);
        _421 = _409;
        _422 = mix(_411, _276, float3(_414));
    }
    else
    {
        _420 = 1.0;
        _421 = 1.0;
        _422 = _276;
    }
    float4 _426 = float4(_422, 1.0);
    float3 _430 = _140;
    _430.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _426);
    float3 _434 = _430;
    _434.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _426);
    float3 _438 = _434;
    _438.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _426);
    float4 _441 = _426.xyzz * _426.yzzx;
    float3 _445 = _140;
    _445.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _441);
    float3 _449 = _445;
    _449.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _441);
    float3 _453 = _449;
    _453.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _441);
    float3 _468 = (((((_368 * _368) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _358)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _363)].xyz) * ((exp2(((_350.w + ((_352.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _358)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _363)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_352 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _284 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _284 + 7u)], float4(_276.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_438 + _453) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_422.x * _422.x) - (_422.y * _422.y)))) * View.View_SkyLightColor.xyz) * (_421 * _420));
    float3 _490 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _519;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _518;
        if (any(abs(_202 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222 + 19u)].xyz + float3(1.0))))
        {
            _518 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_202, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _518 = _490;
        }
        _519 = _518;
    }
    else
    {
        _519 = _490;
    }
    float4 _526 = float4(((mix(float3(0.0), _327 + (_329 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_468 * _327) * fast::max(float3(1.0), ((((((_275 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_275 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_275 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _519) * 1.0, 0.0);
    float4 _533;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _532 = _526;
        _532.w = 0.0;
        _533 = _532;
    }
    else
    {
        _533 = _526;
    }
    float2 _537 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _545 = (_276 * 0.5) + float3(0.5);
    float4 _547 = float4(_545.x, _545.y, _545.z, float4(0.0).w);
    _547.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223)].y;
    float4 _548 = float4(0.0);
    _548.x = _274;
    float4 _549 = _548;
    _549.y = _273;
    float4 _550 = _549;
    _550.z = fast::clamp(_272, 0.0, 0.996078431606292724609375);
    float4 _551 = _550;
    _551.w = 0.517647087574005126953125;
    float4 _563 = float4(_275.x, _275.y, _275.z, float4(0.0).w);
    _563.w = ((log2(((dot(_468, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_331 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_331 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_331 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_537.xyx * _537.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _533 * View.View_PreExposure;
    out.out_var_SV_Target1 = _547;
    out.out_var_SV_Target2 = _551;
    out.out_var_SV_Target3 = _563;
    out.out_var_SV_Target4 = _298;
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _284)] * _292) * _292;
    return out;
}

