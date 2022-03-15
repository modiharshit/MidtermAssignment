

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m20_pad[124];
    float View_ShowDecalsMask;
    char _m21_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _166 = {};

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

fragment MainPS_out Main_00004686_1e91dca6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float2 _239 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float _255 = sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)) + 1.0;
    float _263 = sin(((_232.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _270 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_263 * (-0.0599999986588954925537109375), _263 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _273 = (_270.xy * float2(2.0)) - float2(1.0);
    float3 _282 = float4(_273, sqrt(fast::clamp(1.0 - dot(_273, _273), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _285 = float3(_248, _255);
    float3 _289 = float3(_282.xy * (-1.0), _282.z);
    float3 _293 = (_285 * dot(_285, _289)) - (_289 * _255);
    float _295 = _293.z + 1.0;
    float2 _299 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _301 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _299, bias(View.View_MaterialTextureMipBias));
    float2 _304 = (_301.xy * float2(2.0)) - float2(1.0);
    float4 _316 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _343;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _343 = _223.w;
                break;
            }
            else
            {
                float _327 = _223.z;
                _343 = ((_327 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_327 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _350 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _316.x) + _343) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _351 = mix(float4(_304, sqrt(fast::clamp(1.0 - dot(_304, _304), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _350);
    float3 _356 = float3(_293.xy, _295);
    float3 _360 = float3(_351.xy * (-1.0), _351.z);
    float3 _372 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_356 * dot(_356, _360)) - (_360 * _295)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _383 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _299, bias(View.View_MaterialTextureMipBias));
    float4 _385 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float3 _400 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_383.x * _385.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _350), float3(0.0), float3(1.0));
    float _404 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _405 = in.in_var_PRIMITIVE_ID * 36u;
    uint _406 = _405 + 20u;
    float _454;
    float _455;
    float _456;
    float3 _457;
    float3 _458;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _406)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _424 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _428 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _424, level(0.0));
        float4 _431 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _424, level(0.0));
        float4 _434 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _424, level(0.0));
        float _444 = _434.w;
        _454 = (_404 * _444) + _434.z;
        _455 = (0.5 * _444) + _434.y;
        _456 = _434.x;
        _457 = (_400 * _428.w) + _428.xyz;
        _458 = normalize((_372 * _431.w) + ((_431.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _454 = _404;
        _455 = 0.5;
        _456 = 0.0;
        _457 = _400;
        _458 = _372;
    }
    float3 _473 = ((_457 - (_457 * _456)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _480 = (mix(float3(0.07999999821186065673828125 * _455), _457, float3(_456)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _483 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _488;
    if (_483)
    {
        _488 = _473 + (_480 * 0.449999988079071044921875);
    }
    else
    {
        _488 = _473;
    }
    float3 _490 = select(_480, float3(0.0), bool3(_483));
    float3 _492 = float3(dot(_490, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _507 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _512 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _507);
    float4 _514 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_507 + float2(0.0, 0.5)));
    uint _520 = in.in_var_LIGHTMAP_ID * 15u;
    uint _521 = _520 + 4u;
    uint _526 = _520 + 6u;
    float3 _531 = _512.xyz;
    float _583;
    float _584;
    float3 _585;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _567 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _571 = _567.w;
        float _572 = _571 * _571;
        float3 _574 = normalize(((_567.xyz * 2.0) - float3(1.0)).xyz);
        float _575 = 1.0 - _572;
        float _577 = 1.0 - (_575 * _575);
        _583 = mix(fast::clamp(dot(_574, _458), 0.0, 1.0), 1.0, _577);
        _584 = _572;
        _585 = mix(_574, _458, float3(_577));
    }
    else
    {
        _583 = 1.0;
        _584 = 1.0;
        _585 = _458;
    }
    float4 _589 = float4(_585, 1.0);
    float3 _593 = _166;
    _593.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _589);
    float3 _597 = _593;
    _597.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _589);
    float3 _601 = _597;
    _601.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _589);
    float4 _604 = _589.xyzz * _589.yzzx;
    float3 _608 = _166;
    _608.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _604);
    float3 _612 = _608;
    _612.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _604);
    float3 _616 = _612;
    _616.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _604);
    float3 _631 = (((((_531 * _531) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _521)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _526)].xyz) * ((exp2(((_512.w + ((_514.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _521)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _526)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_514 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _520 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _520 + 7u)], float4(_458.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_601 + _616) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_585.x * _585.x) - (_585.y * _585.y)))) * View.View_SkyLightColor.xyz) * (_584 * _583));
    float3 _653 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _682;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _681;
        if (any(abs(_232 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _405 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _405 + 19u)].xyz + float3(1.0))))
        {
            _681 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _681 = _653;
        }
        _682 = _681;
    }
    else
    {
        _682 = _653;
    }
    float4 _689 = float4(((mix(float3(0.0), _488 + (_490 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_631 * _488) * fast::max(float3(1.0), ((((((_457 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_457 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_457 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _682) * 1.0, 0.0);
    float4 _696;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _695 = _689;
        _695.w = 0.0;
        _696 = _695;
    }
    else
    {
        _696 = _689;
    }
    float2 _700 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _708 = (_458 * 0.5) + float3(0.5);
    float4 _710 = float4(_708.x, _708.y, _708.z, float4(0.0).w);
    _710.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _406)].y;
    float4 _711 = float4(0.0);
    _711.x = _456;
    float4 _712 = _711;
    _712.y = _455;
    float4 _713 = _712;
    _713.z = _454;
    float4 _714 = _713;
    _714.w = 0.75686275959014892578125;
    float4 _726 = float4(_457.x, _457.y, _457.z, float4(0.0).w);
    _726.w = ((log2(((dot(_631, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_492 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_492 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_492 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_700.xyx * _700.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _696 * View.View_PreExposure;
    out.out_var_SV_Target1 = _710;
    out.out_var_SV_Target2 = _714;
    out.out_var_SV_Target3 = _726;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

