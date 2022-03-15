

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _132 = {};
constant float _133 = {};

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

fragment MainPS_out Main_000032fd_25ad55e7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _183 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _188 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _193 = (_188.xyz / float3(_188.w)) - View.View_PreViewTranslation;
    float3 _201 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _216 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _217 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _222 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _223 = in.in_var_PRIMITIVE_ID * 36u;
    uint _224 = _223 + 20u;
    float _274;
    float _275;
    float _276;
    float3 _277;
    float3 _278;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _224)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _242 = ((_183.xy / float2(_183.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _246 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _242, level(0.0));
        float4 _249 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _242, level(0.0));
        float4 _252 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _242, level(0.0));
        float _262 = _252.w;
        _274 = (_222 * _262) + _252.z;
        _275 = (0.5 * _262) + _252.y;
        _276 = (_217 * _262) + _252.x;
        _277 = (_216 * _246.w) + _246.xyz;
        _278 = normalize((_201 * _249.w) + ((_249.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _274 = _222;
        _275 = 0.5;
        _276 = _217;
        _277 = _216;
        _278 = _201;
    }
    float3 _293 = ((_277 - (_277 * _276)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _300 = (mix(float3(0.07999999821186065673828125 * _275), _277, float3(_276)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _303 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _308;
    if (_303)
    {
        _308 = _293 + (_300 * 0.449999988079071044921875);
    }
    else
    {
        _308 = _293;
    }
    float3 _310 = select(_300, float3(0.0), bool3(_303));
    float3 _312 = float3(dot(_310, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _327 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _332 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _327);
    float4 _334 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_327 + float2(0.0, 0.5)));
    uint _336 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _346 = (_332.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336 + 6u)].xyz;
    float _347 = dot(_346, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _366 = (exp2((_347 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_334 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _336 + 7u)], float4(_278.yzx, 1.0)));
    float4 _377 = float4(_278, 1.0);
    float3 _381 = _132;
    _381.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _377);
    float3 _385 = _381;
    _385.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _377);
    float3 _389 = _385;
    _389.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _377);
    float4 _392 = _377.xyzz * _377.yzzx;
    float3 _396 = _132;
    _396.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _392);
    float3 _400 = _396;
    _400.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _392);
    float3 _404 = _400;
    _404.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _392);
    float3 _418 = (float4(_346 * (_366 / _347), _366).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_389 + _404) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_278.x * _278.x) - (_278.y * _278.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _440 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _469;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _468;
        if (any(abs(_193 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _223 + 19u)].xyz + float3(1.0))))
        {
            _468 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_193, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _468 = _440;
        }
        _469 = _468;
    }
    else
    {
        _469 = _440;
    }
    float4 _476 = float4(((mix(float3(0.0), _308 + (_310 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_418 * _308) * fast::max(float3(1.0), ((((((_277 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_277 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_277 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _469) * 1.0, 0.0);
    float4 _483;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _482 = _476;
        _482.w = 0.0;
        _483 = _482;
    }
    else
    {
        _483 = _476;
    }
    float2 _487 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _495 = (_278 * 0.5) + float3(0.5);
    float4 _497 = float4(_495.x, _495.y, _495.z, float4(0.0).w);
    _497.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _224)].y;
    float4 _498 = float4(0.0);
    _498.x = _276;
    float4 _499 = _498;
    _499.y = _275;
    float4 _500 = _499;
    _500.z = _274;
    float4 _501 = _500;
    _501.w = 0.75686275959014892578125;
    float4 _513 = float4(_277.x, _277.y, _277.z, float4(0.0).w);
    _513.w = ((log2(((dot(_418, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_312 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_312 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_312 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_487.xyx * _487.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _483 * View.View_PreExposure;
    out.out_var_SV_Target1 = _497;
    out.out_var_SV_Target2 = _501;
    out.out_var_SV_Target3 = _513;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

