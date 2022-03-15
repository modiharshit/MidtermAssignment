

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

constant float3 _135 = {};
constant float _136 = {};

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

fragment MainPS_out Main_00003680_fbc6b4d0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _187 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _136, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _192 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _197 = (_192.xyz / float3(_192.w)) - View.View_PreViewTranslation;
    float3 _205 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _216 = (0.699999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _217 = in.in_var_PRIMITIVE_ID * 36u;
    uint _218 = _217 + 20u;
    float _266;
    float _267;
    float _268;
    float3 _269;
    float3 _270;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _218)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _236 = ((_187.xy / float2(_187.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _240 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _236, level(0.0));
        float4 _243 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _236, level(0.0));
        float4 _246 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _236, level(0.0));
        float _256 = _246.w;
        _266 = (_216 * _256) + _246.z;
        _267 = (0.5 * _256) + _246.y;
        _268 = _246.x;
        _269 = (float3(0.180000007152557373046875) * _240.w) + _240.xyz;
        _270 = normalize((_205 * _243.w) + ((_243.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _266 = _216;
        _267 = 0.5;
        _268 = 0.0;
        _269 = float3(0.180000007152557373046875);
        _270 = _205;
    }
    float3 _285 = ((_269 - (_269 * _268)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _292 = (mix(float3(0.07999999821186065673828125 * _267), _269, float3(_268)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _295 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _300;
    if (_295)
    {
        _300 = _285 + (_292 * 0.449999988079071044921875);
    }
    else
    {
        _300 = _285;
    }
    float3 _302 = select(_292, float3(0.0), bool3(_295));
    float3 _304 = float3(dot(_302, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _319 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _324 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _319);
    float4 _326 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_319 + float2(0.0, 0.5)));
    uint _332 = in.in_var_LIGHTMAP_ID * 15u;
    uint _333 = _332 + 4u;
    uint _338 = _332 + 6u;
    float3 _343 = _324.xyz;
    float _395;
    float _396;
    float3 _397;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _379 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _383 = _379.w;
        float _384 = _383 * _383;
        float3 _386 = normalize(((_379.xyz * 2.0) - float3(1.0)).xyz);
        float _387 = 1.0 - _384;
        float _389 = 1.0 - (_387 * _387);
        _395 = mix(fast::clamp(dot(_386, _270), 0.0, 1.0), 1.0, _389);
        _396 = _384;
        _397 = mix(_386, _270, float3(_389));
    }
    else
    {
        _395 = 1.0;
        _396 = 1.0;
        _397 = _270;
    }
    float4 _401 = float4(_397, 1.0);
    float3 _405 = _135;
    _405.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _401);
    float3 _409 = _405;
    _409.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _401);
    float3 _413 = _409;
    _413.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _401);
    float4 _416 = _401.xyzz * _401.yzzx;
    float3 _420 = _135;
    _420.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _416);
    float3 _424 = _420;
    _424.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _416);
    float3 _428 = _424;
    _428.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _416);
    float3 _443 = (((((_343 * _343) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _333)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338)].xyz) * ((exp2(((_324.w + ((_326.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _333)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _338)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_326 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _332 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _332 + 7u)], float4(_270.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_413 + _428) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_397.x * _397.x) - (_397.y * _397.y)))) * View.View_SkyLightColor.xyz) * (_396 * _395));
    float3 _465 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _494;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _493;
        if (any(abs(_197 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 19u)].xyz + float3(1.0))))
        {
            _493 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_197, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _493 = _465;
        }
        _494 = _493;
    }
    else
    {
        _494 = _465;
    }
    float4 _501 = float4(((mix(float3(0.0), _300 + (_302 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_443 * _300) * fast::max(float3(1.0), ((((((_269 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_269 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_269 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _494) * 1.0, 0.0);
    float4 _508;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _507 = _501;
        _507.w = 0.0;
        _508 = _507;
    }
    else
    {
        _508 = _501;
    }
    float2 _512 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _520 = (_270 * 0.5) + float3(0.5);
    float4 _522 = float4(_520.x, _520.y, _520.z, float4(0.0).w);
    _522.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _218)].y;
    float4 _523 = float4(0.0);
    _523.x = _268;
    float4 _524 = _523;
    _524.y = _267;
    float4 _525 = _524;
    _525.z = _266;
    float4 _526 = _525;
    _526.w = 0.75686275959014892578125;
    float4 _538 = float4(_269.x, _269.y, _269.z, float4(0.0).w);
    _538.w = ((log2(((dot(_443, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_304 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_304 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_304 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_512.xyx * _512.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _508 * View.View_PreExposure;
    out.out_var_SV_Target1 = _522;
    out.out_var_SV_Target2 = _526;
    out.out_var_SV_Target3 = _538;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

