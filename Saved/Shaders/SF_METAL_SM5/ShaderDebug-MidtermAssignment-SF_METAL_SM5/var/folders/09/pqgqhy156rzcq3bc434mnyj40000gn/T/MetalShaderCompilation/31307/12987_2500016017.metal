

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

fragment MainPS_out Main_000032bb_95033791(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _182 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _132, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _187 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _192 = (_187.xyz / float3(_187.w)) - View.View_PreViewTranslation;
    float3 _200 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _213 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _218 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _219 = in.in_var_PRIMITIVE_ID * 36u;
    uint _220 = _219 + 20u;
    float _269;
    float _270;
    float _271;
    float3 _272;
    float3 _273;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _238 = ((_182.xy / float2(_182.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _242 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float4 _245 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float4 _248 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _238, level(0.0));
        float _258 = _248.w;
        float _264 = 0.5 * _258;
        _269 = (_218 * _258) + _248.z;
        _270 = _264 + _248.y;
        _271 = _264 + _248.x;
        _272 = (_213 * _242.w) + _242.xyz;
        _273 = normalize((_200 * _245.w) + ((_245.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _269 = _218;
        _270 = 0.5;
        _271 = 0.5;
        _272 = _213;
        _273 = _200;
    }
    float3 _288 = ((_272 - (_272 * _271)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _295 = (mix(float3(0.07999999821186065673828125 * _270), _272, float3(_271)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _298 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _303;
    if (_298)
    {
        _303 = _288 + (_295 * 0.449999988079071044921875);
    }
    else
    {
        _303 = _288;
    }
    float3 _305 = select(_295, float3(0.0), bool3(_298));
    float3 _307 = float3(dot(_305, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _322 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _327 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _322);
    float4 _329 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_322 + float2(0.0, 0.5)));
    uint _331 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _341 = (_327.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331 + 6u)].xyz;
    float _342 = dot(_341, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _361 = (exp2((_342 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_329 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _331 + 7u)], float4(_273.yzx, 1.0)));
    float4 _372 = float4(_273, 1.0);
    float3 _376 = _131;
    _376.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _372);
    float3 _380 = _376;
    _380.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _372);
    float3 _384 = _380;
    _384.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _372);
    float4 _387 = _372.xyzz * _372.yzzx;
    float3 _391 = _131;
    _391.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _387);
    float3 _395 = _391;
    _395.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _387);
    float3 _399 = _395;
    _399.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _387);
    float3 _413 = (float4(_341 * (_361 / _342), _361).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_384 + _399) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_273.x * _273.x) - (_273.y * _273.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _435 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _464;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _463;
        if (any(abs(_192 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _219 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _219 + 19u)].xyz + float3(1.0))))
        {
            _463 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_192, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _463 = _435;
        }
        _464 = _463;
    }
    else
    {
        _464 = _435;
    }
    float4 _471 = float4(((mix(float3(0.0), _303 + (_305 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_413 * _303) * fast::max(float3(1.0), ((((((_272 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_272 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_272 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _464) * 1.0, 0.0);
    float4 _478;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _477 = _471;
        _477.w = 0.0;
        _478 = _477;
    }
    else
    {
        _478 = _471;
    }
    float2 _482 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _490 = (_273 * 0.5) + float3(0.5);
    float4 _492 = float4(_490.x, _490.y, _490.z, float4(0.0).w);
    _492.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _220)].y;
    float4 _493 = float4(0.0);
    _493.x = _271;
    float4 _494 = _493;
    _494.y = _270;
    float4 _495 = _494;
    _495.z = _269;
    float4 _496 = _495;
    _496.w = 0.75686275959014892578125;
    float4 _508 = float4(_272.x, _272.y, _272.z, float4(0.0).w);
    _508.w = ((log2(((dot(_413, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_307 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_307 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_307 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_482.xyx * _482.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _478 * View.View_PreExposure;
    out.out_var_SV_Target1 = _492;
    out.out_var_SV_Target2 = _496;
    out.out_var_SV_Target3 = _508;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

