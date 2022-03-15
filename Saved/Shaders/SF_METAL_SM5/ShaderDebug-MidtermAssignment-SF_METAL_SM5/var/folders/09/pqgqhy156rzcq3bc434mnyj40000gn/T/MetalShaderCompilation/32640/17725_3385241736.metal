

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

constant float3 _160 = {};

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

fragment MainPS_out Main_0000453d_c9c6b088(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _220 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _225 = (_220.xyz / float3(_220.w)) - View.View_PreViewTranslation;
    float2 _226 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _232 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _226, bias(View.View_MaterialTextureMipBias));
    float2 _235 = (_232.xy * float2(2.0)) - float2(1.0);
    float4 _247 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _274;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _274 = _216.w;
                break;
            }
            else
            {
                float _258 = _216.z;
                _274 = ((_258 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_258 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _290 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_235, sqrt(fast::clamp(1.0 - dot(_235, _235), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _247.x) + _274) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _302 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _307 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _312 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _316 = (_302.x + 0.5) * ((_307.x + 0.5) * (_312.x + 0.5));
    float4 _322 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _226, bias(View.View_MaterialTextureMipBias));
    float3 _328 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_316)) * _322.xyz, float3(0.0), float3(1.0));
    float _333 = (fast::clamp(mix(0.800000011920928955078125, 0.20000000298023223876953125, _316 * _322.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _334 = in.in_var_PRIMITIVE_ID * 36u;
    uint _335 = _334 + 20u;
    float _383;
    float _384;
    float _385;
    float3 _386;
    float3 _387;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _335)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _353 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _357 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _360 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float4 _363 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _353, level(0.0));
        float _373 = _363.w;
        _383 = (_333 * _373) + _363.z;
        _384 = (0.5 * _373) + _363.y;
        _385 = _363.x;
        _386 = (_328 * _357.w) + _357.xyz;
        _387 = normalize((_290 * _360.w) + ((_360.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _383 = _333;
        _384 = 0.5;
        _385 = 0.0;
        _386 = _328;
        _387 = _290;
    }
    float4 _394 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _395 = in.in_var_LIGHTMAP_ID * 15u;
    uint _396 = _395 + 1u;
    float4 _403 = fast::clamp((_394 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _396)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _396)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _420 = ((_386 - (_386 * _385)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _427 = (mix(float3(0.07999999821186065673828125 * _384), _386, float3(_385)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _430 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _435;
    if (_430)
    {
        _435 = _420 + (_427 * 0.449999988079071044921875);
    }
    else
    {
        _435 = _420;
    }
    float3 _437 = select(_427, float3(0.0), bool3(_430));
    float3 _439 = float3(dot(_437, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _454 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _458 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _454);
    float4 _460 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_454 + float2(0.0, 0.5)));
    uint _466 = _395 + 4u;
    uint _471 = _395 + 6u;
    float3 _476 = _458.xyz;
    float _528;
    float _529;
    float3 _530;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _512 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _516 = _512.w;
        float _517 = _516 * _516;
        float3 _519 = normalize(((_512.xyz * 2.0) - float3(1.0)).xyz);
        float _520 = 1.0 - _517;
        float _522 = 1.0 - (_520 * _520);
        _528 = mix(fast::clamp(dot(_519, _387), 0.0, 1.0), 1.0, _522);
        _529 = _517;
        _530 = mix(_519, _387, float3(_522));
    }
    else
    {
        _528 = 1.0;
        _529 = 1.0;
        _530 = _387;
    }
    float4 _534 = float4(_530, 1.0);
    float3 _538 = _160;
    _538.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _534);
    float3 _542 = _538;
    _542.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _534);
    float3 _546 = _542;
    _546.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _534);
    float4 _549 = _534.xyzz * _534.yzzx;
    float3 _553 = _160;
    _553.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _549);
    float3 _557 = _553;
    _557.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _549);
    float3 _561 = _557;
    _561.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _549);
    float3 _576 = (((((_476 * _476) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _466)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _471)].xyz) * ((exp2(((_458.w + ((_460.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _466)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _471)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_460 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _395 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _395 + 7u)], float4(_387.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_546 + _561) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_530.x * _530.x) - (_530.y * _530.y)))) * View.View_SkyLightColor.xyz) * (_529 * _528));
    float3 _598 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _627;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _626;
        if (any(abs(_225 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _334 + 19u)].xyz + float3(1.0))))
        {
            _626 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_225, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _626 = _598;
        }
        _627 = _626;
    }
    else
    {
        _627 = _598;
    }
    float4 _634 = float4(((mix(float3(0.0), _435 + (_437 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_576 * _435) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _627) * 1.0, 0.0);
    float4 _641;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _640 = _634;
        _640.w = 0.0;
        _641 = _640;
    }
    else
    {
        _641 = _634;
    }
    float2 _645 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _653 = (_387 * 0.5) + float3(0.5);
    float4 _655 = float4(_653.x, _653.y, _653.z, float4(0.0).w);
    _655.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _335)].y;
    float4 _656 = float4(0.0);
    _656.x = _385;
    float4 _657 = _656;
    _657.y = _384;
    float4 _658 = _657;
    _658.z = _383;
    float4 _659 = _658;
    _659.w = 0.50588238239288330078125;
    float4 _671 = float4(_386.x, _386.y, _386.z, float4(0.0).w);
    _671.w = ((log2(((dot(_576, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_439 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_439 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_439 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_645.xyx * _645.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _641 * View.View_PreExposure;
    out.out_var_SV_Target1 = _655;
    out.out_var_SV_Target2 = _659;
    out.out_var_SV_Target3 = _671;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _395)] * _403) * _403;
    return out;
}

