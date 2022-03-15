

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[452];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m14_pad[124];
    float View_ShowDecalsMask;
    char _m15_pad[184];
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

constant float3 _133 = {};
constant float _134 = {};

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

fragment MainPS_out Main_000032d1_ce8557ef(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _181 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _134, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _186 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _191 = (_186.xyz / float3(_186.w)) - View.View_PreViewTranslation;
    float3 _199 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _207 = in.in_var_PRIMITIVE_ID * 36u;
    uint _208 = _207 + 20u;
    float _255;
    float _256;
    float _257;
    float3 _258;
    float3 _259;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _226 = ((_181.xy / float2(_181.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _230 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _226, level(0.0));
        float4 _233 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _226, level(0.0));
        float4 _236 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _226, level(0.0));
        float _246 = _236.w;
        _255 = _246 + _236.z;
        _256 = (0.5 * _246) + _236.y;
        _257 = _236.x;
        _258 = (float3(0.180000007152557373046875) * _230.w) + _230.xyz;
        _259 = normalize((_199 * _233.w) + ((_233.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _255 = 1.0;
        _256 = 0.5;
        _257 = 0.0;
        _258 = float3(0.180000007152557373046875);
        _259 = _199;
    }
    float3 _283 = (((_258 - (_258 * _257)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _256), _258, float3(_257)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float2 _285 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _290 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _285);
    float4 _292 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_285 + float2(0.0, 0.5)));
    uint _298 = in.in_var_LIGHTMAP_ID * 15u;
    uint _299 = _298 + 4u;
    uint _304 = _298 + 6u;
    float3 _309 = _290.xyz;
    float _361;
    float _362;
    float3 _363;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _345 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _349 = _345.w;
        float _350 = _349 * _349;
        float3 _352 = normalize(((_345.xyz * 2.0) - float3(1.0)).xyz);
        float _353 = 1.0 - _350;
        float _355 = 1.0 - (_353 * _353);
        _361 = mix(fast::clamp(dot(_352, _259), 0.0, 1.0), 1.0, _355);
        _362 = _350;
        _363 = mix(_352, _259, float3(_355));
    }
    else
    {
        _361 = 1.0;
        _362 = 1.0;
        _363 = _259;
    }
    float4 _367 = float4(_363, 1.0);
    float3 _371 = _133;
    _371.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _367);
    float3 _375 = _371;
    _375.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _367);
    float3 _379 = _375;
    _379.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _367);
    float4 _382 = _367.xyzz * _367.yzzx;
    float3 _386 = _133;
    _386.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _382);
    float3 _390 = _386;
    _390.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _382);
    float3 _394 = _390;
    _394.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _382);
    float3 _409 = (((((_309 * _309) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _299)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _304)].xyz) * ((exp2(((_290.w + ((_292.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _299)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _304)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_292 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _298 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _298 + 7u)], float4(_259.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_379 + _394) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_363.x * _363.x) - (_363.y * _363.y)))) * View.View_SkyLightColor.xyz) * (_362 * _361));
    float3 _429 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _458;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _457;
        if (any(abs(_191 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207 + 19u)].xyz + float3(1.0))))
        {
            _457 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_191, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _457 = _429;
        }
        _458 = _457;
    }
    else
    {
        _458 = _429;
    }
    float4 _465 = float4(((mix(float3(0.0), _283, float3(View.View_UnlitViewmodeMask)) + ((_409 * _283) * fast::max(float3(1.0), ((((((_258 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_258 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_258 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _458) * 1.0, 0.0);
    float4 _472;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _471 = _465;
        _471.w = 0.0;
        _472 = _471;
    }
    else
    {
        _472 = _465;
    }
    float2 _476 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _484 = (_259 * 0.5) + float3(0.5);
    float4 _486 = float4(_484.x, _484.y, _484.z, float4(0.0).w);
    _486.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208)].y;
    float4 _487 = float4(0.0);
    _487.x = _257;
    float4 _488 = _487;
    _488.y = _256;
    float4 _489 = _488;
    _489.z = _255;
    float4 _490 = _489;
    _490.w = 0.75686275959014892578125;
    float4 _501 = float4(_258.x, _258.y, _258.z, float4(0.0).w);
    _501.w = ((log2((dot(_409, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_476.xyx * _476.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _472 * View.View_PreExposure;
    out.out_var_SV_Target1 = _486;
    out.out_var_SV_Target2 = _490;
    out.out_var_SV_Target3 = _501;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

