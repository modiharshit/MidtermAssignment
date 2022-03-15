

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
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _155 = {};

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

fragment MainPS_out Main_000043db_19914cff(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float4 _226 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _229 = (_226.xy * float2(2.0)) - float2(1.0);
    float2 _239 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _243 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float _270;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _270 = _211.w;
                break;
            }
            else
            {
                float _254 = _211.z;
                _270 = ((_254 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_254 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _276 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _243.x) + _270) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _285 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_229, sqrt(fast::clamp(1.0 - dot(_229, _229), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _276) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _297 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _300 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _309 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _310 = _309.x;
    float _314 = _309.y;
    float _318 = _309.z;
    float4 _324 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _239, bias(View.View_MaterialTextureMipBias));
    float _325 = _324.x;
    float _329 = _324.y;
    float _333 = _324.z;
    float3 _341 = fast::min(fast::max(mix(float3((_310 <= 0.0) ? 0.0 : pow(_310, 2.0), (_314 <= 0.0) ? 0.0 : pow(_314, 2.0), (_318 <= 0.0) ? 0.0 : pow(_318, 2.0)), float3((_325 <= 0.0) ? 0.0 : pow(_325, 2.0), (_329 <= 0.0) ? 0.0 : pow(_329, 2.0), (_333 <= 0.0) ? 0.0 : pow(_333, 2.0)), _276) * fast::min(fast::max(1.0 - (_297.x * _300.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _346 = fast::clamp(mix(_341, float3(dot(_341, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _348 = in.in_var_PRIMITIVE_ID * 36u;
    uint _349 = _348 + 20u;
    float _397;
    float _398;
    float _399;
    float3 _400;
    float3 _401;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _367 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _371 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float4 _374 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float4 _377 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _367, level(0.0));
        float _387 = _377.w;
        _397 = (View.View_RoughnessOverrideParameter.x * _387) + _377.z;
        _398 = (0.5 * _387) + _377.y;
        _399 = _377.x;
        _400 = (_346 * _371.w) + _371.xyz;
        _401 = normalize((_285 * _374.w) + ((_374.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _397 = View.View_RoughnessOverrideParameter.x;
        _398 = 0.5;
        _399 = 0.0;
        _400 = _346;
        _401 = _285;
    }
    float3 _416 = ((_400 - (_400 * _399)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _423 = (mix(float3(0.07999999821186065673828125 * _398), _400, float3(_399)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _426 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _431;
    if (_426)
    {
        _431 = _416 + (_423 * 0.449999988079071044921875);
    }
    else
    {
        _431 = _416;
    }
    float3 _433 = select(_423, float3(0.0), bool3(_426));
    float3 _435 = float3(dot(_433, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _450 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _455 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _450);
    float4 _457 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_450 + float2(0.0, 0.5)));
    uint _463 = in.in_var_LIGHTMAP_ID * 15u;
    uint _464 = _463 + 4u;
    uint _469 = _463 + 6u;
    float3 _474 = _455.xyz;
    float _526;
    float _527;
    float3 _528;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _510 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _514 = _510.w;
        float _515 = _514 * _514;
        float3 _517 = normalize(((_510.xyz * 2.0) - float3(1.0)).xyz);
        float _518 = 1.0 - _515;
        float _520 = 1.0 - (_518 * _518);
        _526 = mix(fast::clamp(dot(_517, _401), 0.0, 1.0), 1.0, _520);
        _527 = _515;
        _528 = mix(_517, _401, float3(_520));
    }
    else
    {
        _526 = 1.0;
        _527 = 1.0;
        _528 = _401;
    }
    float4 _532 = float4(_528, 1.0);
    float3 _536 = _155;
    _536.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _532);
    float3 _540 = _536;
    _540.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _532);
    float3 _544 = _540;
    _544.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _532);
    float4 _547 = _532.xyzz * _532.yzzx;
    float3 _551 = _155;
    _551.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _547);
    float3 _555 = _551;
    _555.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _547);
    float3 _559 = _555;
    _559.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _547);
    float3 _574 = (((((_474 * _474) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _464)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _469)].xyz) * ((exp2(((_455.w + ((_457.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _464)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _469)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_457 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463 + 7u)], float4(_401.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_544 + _559) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_528.x * _528.x) - (_528.y * _528.y)))) * View.View_SkyLightColor.xyz) * (_527 * _526));
    float3 _596 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _625;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _624;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348 + 19u)].xyz + float3(1.0))))
        {
            _624 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _624 = _596;
        }
        _625 = _624;
    }
    else
    {
        _625 = _596;
    }
    float4 _632 = float4(((mix(float3(0.0), _431 + (_433 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_574 * _431) * fast::max(float3(1.0), ((((((_400 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_400 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_400 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _625) * 1.0, 0.0);
    float4 _639;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _638 = _632;
        _638.w = 0.0;
        _639 = _638;
    }
    else
    {
        _639 = _632;
    }
    float2 _643 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _651 = (_401 * 0.5) + float3(0.5);
    float4 _653 = float4(_651.x, _651.y, _651.z, float4(0.0).w);
    _653.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _349)].y;
    float4 _654 = float4(0.0);
    _654.x = _399;
    float4 _655 = _654;
    _655.y = _398;
    float4 _656 = _655;
    _656.z = _397;
    float4 _657 = _656;
    _657.w = 0.75686275959014892578125;
    float4 _669 = float4(_400.x, _400.y, _400.z, float4(0.0).w);
    _669.w = ((log2(((dot(_574, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_435 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_435 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_435 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_643.xyx * _643.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _639 * View.View_PreExposure;
    out.out_var_SV_Target1 = _653;
    out.out_var_SV_Target2 = _657;
    out.out_var_SV_Target3 = _669;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

