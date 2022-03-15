

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
    char _m14_pad[48];
    float4 View_SkyLightColor;
    char _m15_pad[124];
    float View_ShowDecalsMask;
    char _m16_pad[184];
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

constant float3 _131 = {};
constant float _132 = {};

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

fragment MainPS_out Main_000031b0_7be45f93(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _182 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _132, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _187 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _192 = (_187.xyz / float3(_187.w)) - View.View_PreViewTranslation;
    float3 _200 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _209 = in.in_var_PRIMITIVE_ID * 36u;
    uint _210 = _209 + 20u;
    float _255;
    float _256;
    float _257;
    float3 _258;
    float3 _259;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _210)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _228 = ((_182.xy / float2(_182.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _235 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _228, level(0.0));
        float4 _238 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _228, level(0.0));
        float _247 = _238.w;
        _255 = (View.View_RoughnessOverrideParameter.x * _247) + _238.z;
        _256 = (0.5 * _247) + _238.y;
        _257 = _238.x;
        _258 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _228, level(0.0)).xyz;
        _259 = normalize((_200 * _235.w) + ((_235.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _255 = View.View_RoughnessOverrideParameter.x;
        _256 = 0.5;
        _257 = 0.0;
        _258 = float3(0.0);
        _259 = _200;
    }
    float3 _274 = ((_258 - (_258 * _257)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _281 = (mix(float3(0.07999999821186065673828125 * _256), _258, float3(_257)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _284 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _289;
    if (_284)
    {
        _289 = _274 + (_281 * 0.449999988079071044921875);
    }
    else
    {
        _289 = _274;
    }
    float3 _291 = select(_281, float3(0.0), bool3(_284));
    float3 _293 = float3(dot(_291, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _308 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _313 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _308);
    float4 _315 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_308 + float2(0.0, 0.5)));
    uint _317 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _327 = (_313.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _317 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _317 + 6u)].xyz;
    float _328 = dot(_327, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _347 = (exp2((_328 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_315 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _317 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _317 + 7u)], float4(_259.yzx, 1.0)));
    float4 _358 = float4(_259, 1.0);
    float3 _362 = _131;
    _362.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _358);
    float3 _366 = _362;
    _366.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _358);
    float3 _370 = _366;
    _370.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _358);
    float4 _373 = _358.xyzz * _358.yzzx;
    float3 _377 = _131;
    _377.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _373);
    float3 _381 = _377;
    _381.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _373);
    float3 _385 = _381;
    _385.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _373);
    float3 _399 = (float4(_327 * (_347 / _328), _347).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_370 + _385) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_259.x * _259.x) - (_259.y * _259.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _421 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _450;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _449;
        if (any(abs(_192 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209 + 19u)].xyz + float3(1.0))))
        {
            _449 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_192, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _449 = _421;
        }
        _450 = _449;
    }
    else
    {
        _450 = _421;
    }
    float4 _457 = float4(((mix(float3(0.0), _289 + (_291 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_399 * _289) * fast::max(float3(1.0), ((((((_258 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_258 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_258 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _450) * 1.0, 0.0);
    float4 _464;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _463 = _457;
        _463.w = 0.0;
        _464 = _463;
    }
    else
    {
        _464 = _457;
    }
    float2 _468 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _476 = (_259 * 0.5) + float3(0.5);
    float4 _478 = float4(_476.x, _476.y, _476.z, float4(0.0).w);
    _478.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _210)].y;
    float4 _479 = float4(0.0);
    _479.x = _257;
    float4 _480 = _479;
    _480.y = _256;
    float4 _481 = _480;
    _481.z = _255;
    float4 _482 = _481;
    _482.w = 0.75686275959014892578125;
    float4 _494 = float4(_258.x, _258.y, _258.z, float4(0.0).w);
    _494.w = ((log2(((dot(_399, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_293 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_293 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_293 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_468.xyx * _468.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _464 * View.View_PreExposure;
    out.out_var_SV_Target1 = _478;
    out.out_var_SV_Target2 = _482;
    out.out_var_SV_Target3 = _494;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

