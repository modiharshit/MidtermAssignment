

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

constant float3 _137 = {};
constant float _138 = {};

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

fragment MainPS_out Main_00003580_1c6df04b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _185 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _138, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _190 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _195 = (_190.xyz / float3(_190.w)) - View.View_PreViewTranslation;
    float3 _203 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _211 = in.in_var_PRIMITIVE_ID * 36u;
    uint _212 = _211 + 20u;
    float _259;
    float _260;
    float _261;
    float3 _262;
    float3 _263;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _230 = ((_185.xy / float2(_185.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _234 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float4 _237 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float4 _240 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _230, level(0.0));
        float _250 = _240.w;
        _259 = _250 + _240.z;
        _260 = (0.5 * _250) + _240.y;
        _261 = _240.x;
        _262 = (float3(0.180000007152557373046875) * _234.w) + _234.xyz;
        _263 = normalize((_203 * _237.w) + ((_237.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _259 = 1.0;
        _260 = 0.5;
        _261 = 0.0;
        _262 = float3(0.180000007152557373046875);
        _263 = _203;
    }
    float4 _270 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _271 = in.in_var_LIGHTMAP_ID * 15u;
    uint _272 = _271 + 1u;
    float4 _279 = fast::clamp((_270 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _272)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _272)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _305 = (((_262 - (_262 * _261)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _260), _262, float3(_261)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float2 _307 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _311 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _307);
    float4 _313 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_307 + float2(0.0, 0.5)));
    uint _319 = _271 + 4u;
    uint _324 = _271 + 6u;
    float3 _329 = _311.xyz;
    float _381;
    float _382;
    float3 _383;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _365 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _369 = _365.w;
        float _370 = _369 * _369;
        float3 _372 = normalize(((_365.xyz * 2.0) - float3(1.0)).xyz);
        float _373 = 1.0 - _370;
        float _375 = 1.0 - (_373 * _373);
        _381 = mix(fast::clamp(dot(_372, _263), 0.0, 1.0), 1.0, _375);
        _382 = _370;
        _383 = mix(_372, _263, float3(_375));
    }
    else
    {
        _381 = 1.0;
        _382 = 1.0;
        _383 = _263;
    }
    float4 _387 = float4(_383, 1.0);
    float3 _391 = _137;
    _391.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _387);
    float3 _395 = _391;
    _395.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _387);
    float3 _399 = _395;
    _399.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _387);
    float4 _402 = _387.xyzz * _387.yzzx;
    float3 _406 = _137;
    _406.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _402);
    float3 _410 = _406;
    _410.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _402);
    float3 _414 = _410;
    _414.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _402);
    float3 _429 = (((((_329 * _329) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324)].xyz) * ((exp2(((_311.w + ((_313.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _319)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_313 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _271 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _271 + 7u)], float4(_263.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_399 + _414) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_383.x * _383.x) - (_383.y * _383.y)))) * View.View_SkyLightColor.xyz) * (_382 * _381));
    float3 _449 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _478;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _477;
        if (any(abs(_195 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _211 + 19u)].xyz + float3(1.0))))
        {
            _477 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_195, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _477 = _449;
        }
        _478 = _477;
    }
    else
    {
        _478 = _449;
    }
    float4 _485 = float4(((mix(float3(0.0), _305, float3(View.View_UnlitViewmodeMask)) + ((_429 * _305) * fast::max(float3(1.0), ((((((_262 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_262 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_262 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _478) * 1.0, 0.0);
    float4 _492;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _491 = _485;
        _491.w = 0.0;
        _492 = _491;
    }
    else
    {
        _492 = _485;
    }
    float2 _496 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _504 = (_263 * 0.5) + float3(0.5);
    float4 _506 = float4(_504.x, _504.y, _504.z, float4(0.0).w);
    _506.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _212)].y;
    float4 _507 = float4(0.0);
    _507.x = _261;
    float4 _508 = _507;
    _508.y = _260;
    float4 _509 = _508;
    _509.z = _259;
    float4 _510 = _509;
    _510.w = 0.50588238239288330078125;
    float4 _521 = float4(_262.x, _262.y, _262.z, float4(0.0).w);
    _521.w = ((log2((dot(_429, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_496.xyx * _496.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _492 * View.View_PreExposure;
    out.out_var_SV_Target1 = _506;
    out.out_var_SV_Target2 = _510;
    out.out_var_SV_Target3 = _521;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _271)] * _279) * _279;
    return out;
}

