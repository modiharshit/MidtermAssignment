

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

constant float3 _144 = {};
constant float _145 = {};

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

fragment MainPS_out Main_00003b86_f5f878df(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _200 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _145, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float3 _218 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _233 = fast::clamp(_231.xyz, float3(0.0), float3(1.0));
    float _237 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _238 = in.in_var_PRIMITIVE_ID * 36u;
    uint _239 = _238 + 20u;
    float _287;
    float _288;
    float _289;
    float3 _290;
    float3 _291;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _257 = ((_200.xy / float2(_200.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _261 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _257, level(0.0));
        float4 _264 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _257, level(0.0));
        float4 _267 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _257, level(0.0));
        float _277 = _267.w;
        _287 = (_237 * _277) + _267.z;
        _288 = (0.20000000298023223876953125 * _277) + _267.y;
        _289 = _267.x;
        _290 = (_233 * _261.w) + _261.xyz;
        _291 = normalize((_218 * _264.w) + ((_264.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _287 = _237;
        _288 = 0.20000000298023223876953125;
        _289 = 0.0;
        _290 = _233;
        _291 = _218;
    }
    float4 _298 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _299 = in.in_var_LIGHTMAP_ID * 15u;
    uint _300 = _299 + 1u;
    float4 _307 = fast::clamp((_298 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _300)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _300)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _324 = ((_290 - (_290 * _289)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _331 = (mix(float3(0.07999999821186065673828125 * _288), _290, float3(_289)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _334 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _339;
    if (_334)
    {
        _339 = _324 + (_331 * 0.449999988079071044921875);
    }
    else
    {
        _339 = _324;
    }
    float3 _341 = select(_331, float3(0.0), bool3(_334));
    float3 _343 = float3(dot(_341, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _358 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _362 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _358);
    float4 _364 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_358 + float2(0.0, 0.5)));
    uint _370 = _299 + 4u;
    uint _375 = _299 + 6u;
    float3 _380 = _362.xyz;
    float _432;
    float _433;
    float3 _434;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _416 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _420 = _416.w;
        float _421 = _420 * _420;
        float3 _423 = normalize(((_416.xyz * 2.0) - float3(1.0)).xyz);
        float _424 = 1.0 - _421;
        float _426 = 1.0 - (_424 * _424);
        _432 = mix(fast::clamp(dot(_423, _291), 0.0, 1.0), 1.0, _426);
        _433 = _421;
        _434 = mix(_423, _291, float3(_426));
    }
    else
    {
        _432 = 1.0;
        _433 = 1.0;
        _434 = _291;
    }
    float4 _438 = float4(_434, 1.0);
    float3 _442 = _144;
    _442.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _438);
    float3 _446 = _442;
    _446.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _438);
    float3 _450 = _446;
    _450.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _438);
    float4 _453 = _438.xyzz * _438.yzzx;
    float3 _457 = _144;
    _457.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _453);
    float3 _461 = _457;
    _461.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _453);
    float3 _465 = _461;
    _465.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _453);
    float3 _480 = (((((_380 * _380) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _370)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375)].xyz) * ((exp2(((_362.w + ((_364.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _370)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _375)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_364 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _299 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _299 + 7u)], float4(_291.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_450 + _465) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_434.x * _434.x) - (_434.y * _434.y)))) * View.View_SkyLightColor.xyz) * (_433 * _432));
    float3 _502 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _531;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _530;
        if (any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 19u)].xyz + float3(1.0))))
        {
            _530 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _530 = _502;
        }
        _531 = _530;
    }
    else
    {
        _531 = _502;
    }
    float4 _538 = float4(((mix(float3(0.0), _339 + (_341 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_480 * _339) * fast::max(float3(1.0), ((((((_290 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_290 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_290 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _531) * 1.0, 0.0);
    float4 _545;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _544 = _538;
        _544.w = 0.0;
        _545 = _544;
    }
    else
    {
        _545 = _538;
    }
    float2 _549 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _557 = (_291 * 0.5) + float3(0.5);
    float4 _559 = float4(_557.x, _557.y, _557.z, float4(0.0).w);
    _559.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239)].y;
    float4 _560 = float4(0.0);
    _560.x = _289;
    float4 _561 = _560;
    _561.y = _288;
    float4 _562 = _561;
    _562.z = _287;
    float4 _563 = _562;
    _563.w = 0.50588238239288330078125;
    float4 _575 = float4(_290.x, _290.y, _290.z, float4(0.0).w);
    _575.w = ((log2(((dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_343 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_343 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_343 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_549.xyx * _549.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _545 * View.View_PreExposure;
    out.out_var_SV_Target1 = _559;
    out.out_var_SV_Target2 = _563;
    out.out_var_SV_Target3 = _575;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _299)] * _307) * _307;
    return out;
}

