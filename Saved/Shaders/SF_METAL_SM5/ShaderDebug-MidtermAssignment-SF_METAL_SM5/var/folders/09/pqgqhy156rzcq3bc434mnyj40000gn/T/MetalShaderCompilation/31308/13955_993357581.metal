

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

fragment MainPS_out Main_00003683_3b356f0d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _185 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _134, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _190 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _195 = (_190.xyz / float3(_190.w)) - View.View_PreViewTranslation;
    float3 _203 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _214 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _215 = in.in_var_PRIMITIVE_ID * 36u;
    uint _216 = _215 + 20u;
    float _264;
    float _265;
    float _266;
    float3 _267;
    float3 _268;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _216)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _234 = ((_185.xy / float2(_185.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _238 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float4 _241 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float4 _244 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _234, level(0.0));
        float _254 = _244.w;
        _264 = (_214 * _254) + _244.z;
        _265 = (0.5 * _254) + _244.y;
        _266 = _244.x;
        _267 = (float3(0.300000011920928955078125) * _238.w) + _238.xyz;
        _268 = normalize((_203 * _241.w) + ((_241.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _264 = _214;
        _265 = 0.5;
        _266 = 0.0;
        _267 = float3(0.300000011920928955078125);
        _268 = _203;
    }
    float3 _283 = ((_267 - (_267 * _266)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _290 = (mix(float3(0.07999999821186065673828125 * _265), _267, float3(_266)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _293 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _298;
    if (_293)
    {
        _298 = _283 + (_290 * 0.449999988079071044921875);
    }
    else
    {
        _298 = _283;
    }
    float3 _300 = select(_290, float3(0.0), bool3(_293));
    float3 _302 = float3(dot(_300, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _317 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _322 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _317);
    float4 _324 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_317 + float2(0.0, 0.5)));
    uint _330 = in.in_var_LIGHTMAP_ID * 15u;
    uint _331 = _330 + 4u;
    uint _336 = _330 + 6u;
    float3 _341 = _322.xyz;
    float _393;
    float _394;
    float3 _395;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _377 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _381 = _377.w;
        float _382 = _381 * _381;
        float3 _384 = normalize(((_377.xyz * 2.0) - float3(1.0)).xyz);
        float _385 = 1.0 - _382;
        float _387 = 1.0 - (_385 * _385);
        _393 = mix(fast::clamp(dot(_384, _268), 0.0, 1.0), 1.0, _387);
        _394 = _382;
        _395 = mix(_384, _268, float3(_387));
    }
    else
    {
        _393 = 1.0;
        _394 = 1.0;
        _395 = _268;
    }
    float4 _399 = float4(_395, 1.0);
    float3 _403 = _133;
    _403.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _399);
    float3 _407 = _403;
    _407.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _399);
    float3 _411 = _407;
    _411.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _399);
    float4 _414 = _399.xyzz * _399.yzzx;
    float3 _418 = _133;
    _418.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _414);
    float3 _422 = _418;
    _422.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _414);
    float3 _426 = _422;
    _426.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _414);
    float3 _441 = (((((_341 * _341) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336)].xyz) * ((exp2(((_322.w + ((_324.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_324 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330 + 7u)], float4(_268.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_411 + _426) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_395.x * _395.x) - (_395.y * _395.y)))) * View.View_SkyLightColor.xyz) * (_394 * _393));
    float3 _463 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _492;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _491;
        if (any(abs(_195 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _215 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _215 + 19u)].xyz + float3(1.0))))
        {
            _491 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_195, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _491 = _463;
        }
        _492 = _491;
    }
    else
    {
        _492 = _463;
    }
    float4 _499 = float4(((mix(float3(0.0), _298 + (_300 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_441 * _298) * fast::max(float3(1.0), ((((((_267 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_267 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_267 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _492) * 1.0, 0.0);
    float4 _506;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _505 = _499;
        _505.w = 0.0;
        _506 = _505;
    }
    else
    {
        _506 = _499;
    }
    float2 _510 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _518 = (_268 * 0.5) + float3(0.5);
    float4 _520 = float4(_518.x, _518.y, _518.z, float4(0.0).w);
    _520.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _216)].y;
    float4 _521 = float4(0.0);
    _521.x = _266;
    float4 _522 = _521;
    _522.y = _265;
    float4 _523 = _522;
    _523.z = _264;
    float4 _524 = _523;
    _524.w = 0.75686275959014892578125;
    float4 _536 = float4(_267.x, _267.y, _267.z, float4(0.0).w);
    _536.w = ((log2(((dot(_441, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_302 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_302 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_302 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_510.xyx * _510.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _506 * View.View_PreExposure;
    out.out_var_SV_Target1 = _520;
    out.out_var_SV_Target2 = _524;
    out.out_var_SV_Target3 = _536;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

