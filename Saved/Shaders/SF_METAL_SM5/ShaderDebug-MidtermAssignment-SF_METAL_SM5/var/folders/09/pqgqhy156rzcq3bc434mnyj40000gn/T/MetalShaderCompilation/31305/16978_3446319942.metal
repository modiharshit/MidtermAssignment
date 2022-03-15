

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
    char _m18_pad[48];
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
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

constant float3 _165 = {};

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

fragment MainPS_out Main_00004252_cd6aab46(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _221 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _225 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _230 = (_225.xyz / float3(_225.w)) - View.View_PreViewTranslation;
    float2 _237 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float _253 = sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)) + 1.0;
    float _261 = sin(((_230.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _268 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_261 * (-0.0599999986588954925537109375), _261 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float3 _280 = float4(_271, sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _283 = float3(_246, _253);
    float3 _287 = float3(_280.xy * (-1.0), _280.z);
    float3 _291 = (_283 * dot(_283, _287)) - (_287 * _253);
    float _293 = _291.z + 1.0;
    float2 _297 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _297, bias(View.View_MaterialTextureMipBias));
    float2 _302 = (_299.xy * float2(2.0)) - float2(1.0);
    float4 _314 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _341;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _341 = _221.w;
                break;
            }
            else
            {
                float _325 = _221.z;
                _341 = ((_325 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_325 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _348 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _314.x) + _341) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _349 = mix(float4(_302, sqrt(fast::clamp(1.0 - dot(_302, _302), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _348);
    float3 _354 = float3(_291.xy, _293);
    float3 _358 = float3(_349.xy * (-1.0), _349.z);
    float3 _370 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_354 * dot(_354, _358)) - (_358 * _293)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _381 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _297, bias(View.View_MaterialTextureMipBias));
    float4 _383 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float3 _398 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_381.x * _383.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _348), float3(0.0), float3(1.0));
    float _402 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _403 = in.in_var_PRIMITIVE_ID * 36u;
    uint _404 = _403 + 20u;
    float _452;
    float _453;
    float _454;
    float3 _455;
    float3 _456;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _404)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _422 = ((_221.xy / float2(_221.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _426 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _422, level(0.0));
        float4 _429 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _422, level(0.0));
        float4 _432 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _422, level(0.0));
        float _442 = _432.w;
        _452 = (_402 * _442) + _432.z;
        _453 = (0.5 * _442) + _432.y;
        _454 = _432.x;
        _455 = (_398 * _426.w) + _426.xyz;
        _456 = normalize((_370 * _429.w) + ((_429.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _452 = _402;
        _453 = 0.5;
        _454 = 0.0;
        _455 = _398;
        _456 = _370;
    }
    float3 _471 = ((_455 - (_455 * _454)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _478 = (mix(float3(0.07999999821186065673828125 * _453), _455, float3(_454)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _481 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _486;
    if (_481)
    {
        _486 = _471 + (_478 * 0.449999988079071044921875);
    }
    else
    {
        _486 = _471;
    }
    float3 _488 = select(_478, float3(0.0), bool3(_481));
    float3 _490 = float3(dot(_488, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _505 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _510 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _505);
    float4 _512 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_505 + float2(0.0, 0.5)));
    uint _514 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _524 = (_510.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _514 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _514 + 6u)].xyz;
    float _525 = dot(_524, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _544 = (exp2((_525 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_512 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _514 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _514 + 7u)], float4(_456.yzx, 1.0)));
    float4 _555 = float4(_456, 1.0);
    float3 _559 = _165;
    _559.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _555);
    float3 _563 = _559;
    _563.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _555);
    float3 _567 = _563;
    _567.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _555);
    float4 _570 = _555.xyzz * _555.yzzx;
    float3 _574 = _165;
    _574.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _570);
    float3 _578 = _574;
    _578.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _570);
    float3 _582 = _578;
    _582.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _570);
    float3 _596 = (float4(_524 * (_544 / _525), _544).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_567 + _582) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_456.x * _456.x) - (_456.y * _456.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _618 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _647;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _646;
        if (any(abs(_230 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403 + 19u)].xyz + float3(1.0))))
        {
            _646 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_230, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _646 = _618;
        }
        _647 = _646;
    }
    else
    {
        _647 = _618;
    }
    float4 _654 = float4(((mix(float3(0.0), _486 + (_488 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_596 * _486) * fast::max(float3(1.0), ((((((_455 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_455 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_455 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _647) * 1.0, 0.0);
    float4 _661;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _660 = _654;
        _660.w = 0.0;
        _661 = _660;
    }
    else
    {
        _661 = _654;
    }
    float2 _665 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _673 = (_456 * 0.5) + float3(0.5);
    float4 _675 = float4(_673.x, _673.y, _673.z, float4(0.0).w);
    _675.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _404)].y;
    float4 _676 = float4(0.0);
    _676.x = _454;
    float4 _677 = _676;
    _677.y = _453;
    float4 _678 = _677;
    _678.z = _452;
    float4 _679 = _678;
    _679.w = 0.75686275959014892578125;
    float4 _691 = float4(_455.x, _455.y, _455.z, float4(0.0).w);
    _691.w = ((log2(((dot(_596, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_490 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_490 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_490 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_665.xyx * _665.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _661 * View.View_PreExposure;
    out.out_var_SV_Target1 = _675;
    out.out_var_SV_Target2 = _679;
    out.out_var_SV_Target3 = _691;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

