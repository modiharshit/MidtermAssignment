

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

constant float3 _157 = {};

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

fragment MainPS_out Main_00004466_380a4e35(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = _217.xyz / float3(_217.w);
    float3 _222 = _221 - View.View_PreViewTranslation;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float4 _245 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _272;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _272 = _213.w;
                break;
            }
            else
            {
                float _256 = _213.z;
                _272 = ((_256 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_256 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _288 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_233, sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _245.x) + _272) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _300 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _305 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _310 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _314 = (_300.x + 0.5) * ((_305.x + 0.5) * (_310.x + 0.5));
    float4 _318 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _320 = _318.xyz * _314;
    float _322 = _320.x;
    float _326 = _320.y;
    float _330 = _320.z;
    float _339 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_221)))), 9.9999997473787516355514526367188e-05);
    float3 _348 = fast::clamp(mix(_320 * 0.5, float3((_322 <= 0.0) ? 0.0 : pow(_322, 0.4000000059604644775390625), (_326 <= 0.0) ? 0.0 : pow(_326, 0.4000000059604644775390625), (_330 <= 0.0) ? 0.0 : pow(_330, 0.4000000059604644775390625)), float3((_339 <= 0.0) ? 0.0 : pow(_339, 3.0))), float3(0.0), float3(1.0));
    float _353 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _314 * _318.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _354 = in.in_var_PRIMITIVE_ID * 36u;
    uint _355 = _354 + 20u;
    float _403;
    float _404;
    float _405;
    float3 _406;
    float3 _407;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _373 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _377 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float4 _380 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float4 _383 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float _393 = _383.w;
        _403 = (_353 * _393) + _383.z;
        _404 = (0.5 * _393) + _383.y;
        _405 = _383.x;
        _406 = (_348 * _377.w) + _377.xyz;
        _407 = normalize((_288 * _380.w) + ((_380.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _403 = _353;
        _404 = 0.5;
        _405 = 0.0;
        _406 = _348;
        _407 = _288;
    }
    float3 _422 = ((_406 - (_406 * _405)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _429 = (mix(float3(0.07999999821186065673828125 * _404), _406, float3(_405)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _432 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _437;
    if (_432)
    {
        _437 = _422 + (_429 * 0.449999988079071044921875);
    }
    else
    {
        _437 = _422;
    }
    float3 _439 = select(_429, float3(0.0), bool3(_432));
    float3 _441 = float3(dot(_439, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _456 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _461 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _456);
    float4 _463 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_456 + float2(0.0, 0.5)));
    uint _469 = in.in_var_LIGHTMAP_ID * 15u;
    uint _470 = _469 + 4u;
    uint _475 = _469 + 6u;
    float3 _480 = _461.xyz;
    float _532;
    float _533;
    float3 _534;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _516 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _520 = _516.w;
        float _521 = _520 * _520;
        float3 _523 = normalize(((_516.xyz * 2.0) - float3(1.0)).xyz);
        float _524 = 1.0 - _521;
        float _526 = 1.0 - (_524 * _524);
        _532 = mix(fast::clamp(dot(_523, _407), 0.0, 1.0), 1.0, _526);
        _533 = _521;
        _534 = mix(_523, _407, float3(_526));
    }
    else
    {
        _532 = 1.0;
        _533 = 1.0;
        _534 = _407;
    }
    float4 _538 = float4(_534, 1.0);
    float3 _542 = _157;
    _542.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _538);
    float3 _546 = _542;
    _546.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _538);
    float3 _550 = _546;
    _550.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _538);
    float4 _553 = _538.xyzz * _538.yzzx;
    float3 _557 = _157;
    _557.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _553);
    float3 _561 = _557;
    _561.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _553);
    float3 _565 = _561;
    _565.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _553);
    float3 _580 = (((((_480 * _480) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _470)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _475)].xyz) * ((exp2(((_461.w + ((_463.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _470)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _475)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_463 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _469 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _469 + 7u)], float4(_407.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_550 + _565) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_534.x * _534.x) - (_534.y * _534.y)))) * View.View_SkyLightColor.xyz) * (_533 * _532));
    float3 _602 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _631;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _630;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354 + 19u)].xyz + float3(1.0))))
        {
            _630 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _630 = _602;
        }
        _631 = _630;
    }
    else
    {
        _631 = _602;
    }
    float4 _638 = float4(((mix(float3(0.0), _437 + (_439 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_580 * _437) * fast::max(float3(1.0), ((((((_406 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_406 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_406 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _631) * 1.0, 0.0);
    float4 _645;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _644 = _638;
        _644.w = 0.0;
        _645 = _644;
    }
    else
    {
        _645 = _638;
    }
    float2 _649 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _657 = (_407 * 0.5) + float3(0.5);
    float4 _659 = float4(_657.x, _657.y, _657.z, float4(0.0).w);
    _659.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355)].y;
    float4 _660 = float4(0.0);
    _660.x = _405;
    float4 _661 = _660;
    _661.y = _404;
    float4 _662 = _661;
    _662.z = _403;
    float4 _663 = _662;
    _663.w = 0.75686275959014892578125;
    float4 _675 = float4(_406.x, _406.y, _406.z, float4(0.0).w);
    _675.w = ((log2(((dot(_580, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_441 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_441 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_441 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_649.xyx * _649.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _645 * View.View_PreExposure;
    out.out_var_SV_Target1 = _659;
    out.out_var_SV_Target2 = _663;
    out.out_var_SV_Target3 = _675;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

