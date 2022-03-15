

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

constant float3 _170 = {};

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

fragment MainPS_out Main_00004935_0f4bd460(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _236 = (_231.xyz / float3(_231.w)) - View.View_PreViewTranslation;
    float2 _243 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float _259 = sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)) + 1.0;
    float _267 = sin(((_236.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _274 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_267 * (-0.0599999986588954925537109375), _267 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _277 = (_274.xy * float2(2.0)) - float2(1.0);
    float3 _286 = float4(_277, sqrt(fast::clamp(1.0 - dot(_277, _277), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _289 = float3(_252, _259);
    float3 _293 = float3(_286.xy * (-1.0), _286.z);
    float3 _297 = (_289 * dot(_289, _293)) - (_293 * _259);
    float _299 = _297.z + 1.0;
    float2 _303 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _305 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _303, bias(View.View_MaterialTextureMipBias));
    float2 _308 = (_305.xy * float2(2.0)) - float2(1.0);
    float4 _320 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _347;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _347 = _227.w;
                break;
            }
            else
            {
                float _331 = _227.z;
                _347 = ((_331 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_331 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _354 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _320.x) + _347) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _355 = mix(float4(_308, sqrt(fast::clamp(1.0 - dot(_308, _308), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _354);
    float3 _360 = float3(_297.xy, _299);
    float3 _364 = float3(_355.xy * (-1.0), _355.z);
    float3 _376 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_360 * dot(_360, _364)) - (_364 * _299)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _387 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _303, bias(View.View_MaterialTextureMipBias));
    float4 _389 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _243, bias(View.View_MaterialTextureMipBias));
    float3 _404 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_387.x * _389.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _354), float3(0.0), float3(1.0));
    float _408 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _409 = in.in_var_PRIMITIVE_ID * 36u;
    uint _410 = _409 + 20u;
    float _458;
    float _459;
    float _460;
    float3 _461;
    float3 _462;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _410)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _428 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _432 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _428, level(0.0));
        float4 _435 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _428, level(0.0));
        float4 _438 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _428, level(0.0));
        float _448 = _438.w;
        _458 = (_408 * _448) + _438.z;
        _459 = (0.5 * _448) + _438.y;
        _460 = _438.x;
        _461 = (_404 * _432.w) + _432.xyz;
        _462 = normalize((_376 * _435.w) + ((_435.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _458 = _408;
        _459 = 0.5;
        _460 = 0.0;
        _461 = _404;
        _462 = _376;
    }
    float4 _469 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _470 = in.in_var_LIGHTMAP_ID * 15u;
    uint _471 = _470 + 1u;
    float4 _478 = fast::clamp((_469 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _471)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _471)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _495 = ((_461 - (_461 * _460)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _502 = (mix(float3(0.07999999821186065673828125 * _459), _461, float3(_460)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _505 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _510;
    if (_505)
    {
        _510 = _495 + (_502 * 0.449999988079071044921875);
    }
    else
    {
        _510 = _495;
    }
    float3 _512 = select(_502, float3(0.0), bool3(_505));
    float3 _514 = float3(dot(_512, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _529 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _533 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _529);
    float4 _535 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_529 + float2(0.0, 0.5)));
    uint _541 = _470 + 4u;
    uint _546 = _470 + 6u;
    float3 _551 = _533.xyz;
    float _603;
    float _604;
    float3 _605;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _587 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _591 = _587.w;
        float _592 = _591 * _591;
        float3 _594 = normalize(((_587.xyz * 2.0) - float3(1.0)).xyz);
        float _595 = 1.0 - _592;
        float _597 = 1.0 - (_595 * _595);
        _603 = mix(fast::clamp(dot(_594, _462), 0.0, 1.0), 1.0, _597);
        _604 = _592;
        _605 = mix(_594, _462, float3(_597));
    }
    else
    {
        _603 = 1.0;
        _604 = 1.0;
        _605 = _462;
    }
    float4 _609 = float4(_605, 1.0);
    float3 _613 = _170;
    _613.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _609);
    float3 _617 = _613;
    _617.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _609);
    float3 _621 = _617;
    _621.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _609);
    float4 _624 = _609.xyzz * _609.yzzx;
    float3 _628 = _170;
    _628.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _624);
    float3 _632 = _628;
    _632.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _624);
    float3 _636 = _632;
    _636.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _624);
    float3 _651 = (((((_551 * _551) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _541)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _546)].xyz) * ((exp2(((_533.w + ((_535.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _541)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _546)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_535 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _470 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _470 + 7u)], float4(_462.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_621 + _636) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_605.x * _605.x) - (_605.y * _605.y)))) * View.View_SkyLightColor.xyz) * (_604 * _603));
    float3 _673 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _702;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _701;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _409 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _409 + 19u)].xyz + float3(1.0))))
        {
            _701 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _701 = _673;
        }
        _702 = _701;
    }
    else
    {
        _702 = _673;
    }
    float4 _709 = float4(((mix(float3(0.0), _510 + (_512 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_651 * _510) * fast::max(float3(1.0), ((((((_461 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_461 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_461 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _702) * 1.0, 0.0);
    float4 _716;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _715 = _709;
        _715.w = 0.0;
        _716 = _715;
    }
    else
    {
        _716 = _709;
    }
    float2 _720 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _728 = (_462 * 0.5) + float3(0.5);
    float4 _730 = float4(_728.x, _728.y, _728.z, float4(0.0).w);
    _730.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _410)].y;
    float4 _731 = float4(0.0);
    _731.x = _460;
    float4 _732 = _731;
    _732.y = _459;
    float4 _733 = _732;
    _733.z = _458;
    float4 _734 = _733;
    _734.w = 0.50588238239288330078125;
    float4 _746 = float4(_461.x, _461.y, _461.z, float4(0.0).w);
    _746.w = ((log2(((dot(_651, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_514 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_514 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_514 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_720.xyx * _720.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _716 * View.View_PreExposure;
    out.out_var_SV_Target1 = _730;
    out.out_var_SV_Target2 = _734;
    out.out_var_SV_Target3 = _746;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _470)] * _478) * _478;
    return out;
}

