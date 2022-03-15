

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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000038d7_39769ce3(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _196 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _141, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float3 _214 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _227 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _229 = fast::clamp(_227.xyz, float3(0.0), float3(1.0));
    float _233 = (0.949999988079071044921875 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _234 = in.in_var_PRIMITIVE_ID * 36u;
    uint _235 = _234 + 20u;
    float _283;
    float _284;
    float _285;
    float3 _286;
    float3 _287;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _253 = ((_196.xy / float2(_196.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _257 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _253, level(0.0));
        float4 _260 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _253, level(0.0));
        float4 _263 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _253, level(0.0));
        float _273 = _263.w;
        _283 = (_233 * _273) + _263.z;
        _284 = (0.20000000298023223876953125 * _273) + _263.y;
        _285 = _263.x;
        _286 = (_229 * _257.w) + _257.xyz;
        _287 = normalize((_214 * _260.w) + ((_260.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _283 = _233;
        _284 = 0.20000000298023223876953125;
        _285 = 0.0;
        _286 = _229;
        _287 = _214;
    }
    float3 _302 = ((_286 - (_286 * _285)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _309 = (mix(float3(0.07999999821186065673828125 * _284), _286, float3(_285)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _312 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _317;
    if (_312)
    {
        _317 = _302 + (_309 * 0.449999988079071044921875);
    }
    else
    {
        _317 = _302;
    }
    float3 _319 = select(_309, float3(0.0), bool3(_312));
    float3 _321 = float3(dot(_319, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _336 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _341 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _336);
    float4 _343 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_336 + float2(0.0, 0.5)));
    uint _349 = in.in_var_LIGHTMAP_ID * 15u;
    uint _350 = _349 + 4u;
    uint _355 = _349 + 6u;
    float3 _360 = _341.xyz;
    float _412;
    float _413;
    float3 _414;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _396 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _400 = _396.w;
        float _401 = _400 * _400;
        float3 _403 = normalize(((_396.xyz * 2.0) - float3(1.0)).xyz);
        float _404 = 1.0 - _401;
        float _406 = 1.0 - (_404 * _404);
        _412 = mix(fast::clamp(dot(_403, _287), 0.0, 1.0), 1.0, _406);
        _413 = _401;
        _414 = mix(_403, _287, float3(_406));
    }
    else
    {
        _412 = 1.0;
        _413 = 1.0;
        _414 = _287;
    }
    float4 _418 = float4(_414, 1.0);
    float3 _422 = _140;
    _422.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _418);
    float3 _426 = _422;
    _426.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _418);
    float3 _430 = _426;
    _430.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _418);
    float4 _433 = _418.xyzz * _418.yzzx;
    float3 _437 = _140;
    _437.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _433);
    float3 _441 = _437;
    _441.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _433);
    float3 _445 = _441;
    _445.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _433);
    float3 _460 = (((((_360 * _360) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _350)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _355)].xyz) * ((exp2(((_341.w + ((_343.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _350)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _355)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_343 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _349 + 7u)], float4(_287.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_430 + _445) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_414.x * _414.x) - (_414.y * _414.y)))) * View.View_SkyLightColor.xyz) * (_413 * _412));
    float3 _482 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _511;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _510;
        if (any(abs(_206 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234 + 19u)].xyz + float3(1.0))))
        {
            _510 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _510 = _482;
        }
        _511 = _510;
    }
    else
    {
        _511 = _482;
    }
    float4 _518 = float4(((mix(float3(0.0), _317 + (_319 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_460 * _317) * fast::max(float3(1.0), ((((((_286 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_286 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_286 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _511) * 1.0, 0.0);
    float4 _525;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _524 = _518;
        _524.w = 0.0;
        _525 = _524;
    }
    else
    {
        _525 = _518;
    }
    float2 _529 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _537 = (_287 * 0.5) + float3(0.5);
    float4 _539 = float4(_537.x, _537.y, _537.z, float4(0.0).w);
    _539.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _235)].y;
    float4 _540 = float4(0.0);
    _540.x = _285;
    float4 _541 = _540;
    _541.y = _284;
    float4 _542 = _541;
    _542.z = _283;
    float4 _543 = _542;
    _543.w = 0.75686275959014892578125;
    float4 _555 = float4(_286.x, _286.y, _286.z, float4(0.0).w);
    _555.w = ((log2(((dot(_460, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_321 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_321 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_321 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_529.xyx * _529.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _525 * View.View_PreExposure;
    out.out_var_SV_Target1 = _539;
    out.out_var_SV_Target2 = _543;
    out.out_var_SV_Target3 = _555;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

