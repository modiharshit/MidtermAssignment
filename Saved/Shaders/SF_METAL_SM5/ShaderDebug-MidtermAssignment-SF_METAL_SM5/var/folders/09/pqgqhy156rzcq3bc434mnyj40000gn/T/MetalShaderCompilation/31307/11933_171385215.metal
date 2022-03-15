

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
    char _m12_pad[464];
    float4 View_SkyLightColor;
    char _m13_pad[124];
    float View_ShowDecalsMask;
    char _m14_pad[184];
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

fragment MainPS_out Main_00002e9d_0a37217f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _180 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _133, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _185 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _190 = (_185.xyz / float3(_185.w)) - View.View_PreViewTranslation;
    float3 _198 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _206 = in.in_var_PRIMITIVE_ID * 36u;
    uint _207 = _206 + 20u;
    float _254;
    float _255;
    float _256;
    float3 _257;
    float3 _258;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _225 = ((_180.xy / float2(_180.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _229 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _225, level(0.0));
        float4 _232 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _225, level(0.0));
        float4 _235 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _225, level(0.0));
        float _245 = _235.w;
        _254 = _245 + _235.z;
        _255 = (0.5 * _245) + _235.y;
        _256 = _235.x;
        _257 = (float3(0.180000007152557373046875) * _229.w) + _229.xyz;
        _258 = normalize((_198 * _232.w) + ((_232.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _254 = 1.0;
        _255 = 0.5;
        _256 = 0.0;
        _257 = float3(0.180000007152557373046875);
        _258 = _198;
    }
    float3 _282 = (((_257 - (_257 * _256)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _255), _257, float3(_256)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float2 _284 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _289 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _284);
    float4 _291 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_284 + float2(0.0, 0.5)));
    uint _293 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _303 = (_289.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293 + 6u)].xyz;
    float _304 = dot(_303, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _323 = (exp2((_304 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_291 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _293 + 7u)], float4(_258.yzx, 1.0)));
    float4 _334 = float4(_258, 1.0);
    float3 _338 = _132;
    _338.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _334);
    float3 _342 = _338;
    _342.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _334);
    float3 _346 = _342;
    _346.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _334);
    float4 _349 = _334.xyzz * _334.yzzx;
    float3 _353 = _132;
    _353.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _349);
    float3 _357 = _353;
    _357.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _349);
    float3 _361 = _357;
    _361.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _349);
    float3 _375 = (float4(_303 * (_323 / _304), _323).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_346 + _361) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_258.x * _258.x) - (_258.y * _258.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _395 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _424;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _423;
        if (any(abs(_190 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _206 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _206 + 19u)].xyz + float3(1.0))))
        {
            _423 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_190, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _423 = _395;
        }
        _424 = _423;
    }
    else
    {
        _424 = _395;
    }
    float4 _431 = float4(((mix(float3(0.0), _282, float3(View.View_UnlitViewmodeMask)) + ((_375 * _282) * fast::max(float3(1.0), ((((((_257 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_257 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_257 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _424) * 1.0, 0.0);
    float4 _438;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _437 = _431;
        _437.w = 0.0;
        _438 = _437;
    }
    else
    {
        _438 = _431;
    }
    float2 _442 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _450 = (_258 * 0.5) + float3(0.5);
    float4 _452 = float4(_450.x, _450.y, _450.z, float4(0.0).w);
    _452.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _207)].y;
    float4 _453 = float4(0.0);
    _453.x = _256;
    float4 _454 = _453;
    _454.y = _255;
    float4 _455 = _454;
    _455.z = _254;
    float4 _456 = _455;
    _456.w = 0.75686275959014892578125;
    float4 _467 = float4(_257.x, _257.y, _257.z, float4(0.0).w);
    _467.w = ((log2((dot(_375, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_442.xyx * _442.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _438 * View.View_PreExposure;
    out.out_var_SV_Target1 = _452;
    out.out_var_SV_Target2 = _456;
    out.out_var_SV_Target3 = _467;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

