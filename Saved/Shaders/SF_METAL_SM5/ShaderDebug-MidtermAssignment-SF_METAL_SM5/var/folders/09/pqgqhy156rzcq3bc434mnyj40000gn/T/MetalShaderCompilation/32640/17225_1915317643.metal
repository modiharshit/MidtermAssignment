

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
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

constant float3 _154 = {};
constant float _155 = {};

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

fragment MainPS_out Main_00004349_72296d8b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _199 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _210 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = _215.xyz / float3(_215.w);
    float3 _220 = _219 - View.View_PreViewTranslation;
    float2 _224 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _230 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _224, bias(View.View_MaterialTextureMipBias));
    float2 _236 = ((normalize(-_219) * _199).xy * ((0.00999999977648258209228515625 * _230.w) + (-0.008000000379979610443115234375))) + _224;
    float4 _240 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float3 _259 = normalize(_199 * normalize((float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _271 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _281 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _285 = (_271.x + 0.5) * ((_276.x + 0.5) * (_281.x + 0.5));
    float4 _288 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float4 _294 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _236, bias(View.View_MaterialTextureMipBias));
    float3 _299 = fast::clamp(_288.xyz * mix(0.5, 1.0, _285), float3(0.0), float3(1.0));
    float _300 = fast::clamp(_294.y, 0.0, 1.0);
    float _305 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _285 * _294.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _306 = in.in_var_PRIMITIVE_ID * 36u;
    uint _307 = _306 + 20u;
    float _355;
    float _356;
    float _357;
    float3 _358;
    float3 _359;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _325 = ((_210.xy / float2(_210.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _329 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float4 _332 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float4 _335 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float _345 = _335.w;
        _355 = (_305 * _345) + _335.z;
        _356 = (0.5 * _345) + _335.y;
        _357 = _335.x;
        _358 = (_299 * _329.w) + _329.xyz;
        _359 = normalize((_259 * _332.w) + ((_332.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _355 = _305;
        _356 = 0.5;
        _357 = 0.0;
        _358 = _299;
        _359 = _259;
    }
    float4 _366 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _367 = in.in_var_LIGHTMAP_ID * 15u;
    uint _368 = _367 + 1u;
    float4 _375 = fast::clamp((_366 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _368)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _392 = ((_358 - (_358 * _357)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _399 = (mix(float3(0.07999999821186065673828125 * _356), _358, float3(_357)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _402 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _407;
    if (_402)
    {
        _407 = _392 + (_399 * 0.449999988079071044921875);
    }
    else
    {
        _407 = _392;
    }
    float3 _409 = select(_399, float3(0.0), bool3(_402));
    float3 _411 = float3(dot(_409, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _418 = float3(_300);
    float2 _427 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _431 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _427);
    float4 _433 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_427 + float2(0.0, 0.5)));
    uint _439 = _367 + 4u;
    uint _444 = _367 + 6u;
    float3 _449 = _431.xyz;
    float _501;
    float _502;
    float3 _503;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _485 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _489 = _485.w;
        float _490 = _489 * _489;
        float3 _492 = normalize(((_485.xyz * 2.0) - float3(1.0)).xyz);
        float _493 = 1.0 - _490;
        float _495 = 1.0 - (_493 * _493);
        _501 = mix(fast::clamp(dot(_492, _359), 0.0, 1.0), 1.0, _495);
        _502 = _490;
        _503 = mix(_492, _359, float3(_495));
    }
    else
    {
        _501 = 1.0;
        _502 = 1.0;
        _503 = _359;
    }
    float4 _507 = float4(_503, 1.0);
    float3 _511 = _154;
    _511.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _507);
    float3 _515 = _511;
    _515.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _507);
    float3 _519 = _515;
    _519.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _507);
    float4 _522 = _507.xyzz * _507.yzzx;
    float3 _526 = _154;
    _526.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _522);
    float3 _530 = _526;
    _530.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _522);
    float3 _534 = _530;
    _534.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _522);
    float3 _549 = (((((_449 * _449) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _439)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _444)].xyz) * ((exp2(((_431.w + ((_433.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _439)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _444)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_433 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _367 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _367 + 7u)], float4(_359.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_519 + _534) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_503.x * _503.x) - (_503.y * _503.y)))) * View.View_SkyLightColor.xyz) * (_502 * _501));
    float3 _571 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _600;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _599;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 19u)].xyz + float3(1.0))))
        {
            _599 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _599 = _571;
        }
        _600 = _599;
    }
    else
    {
        _600 = _571;
    }
    float4 _607 = float4(((mix(float3(0.0), _407 + (_409 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_549 * _407) * fast::max(_418, ((((((_358 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _300) + ((_358 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _300) + ((_358 * 2.755199909210205078125) + float3(0.69029998779296875))) * _300))) + _600) * 1.0, 0.0);
    float4 _614;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _613 = _607;
        _613.w = 0.0;
        _614 = _613;
    }
    else
    {
        _614 = _607;
    }
    float2 _618 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _626 = (_359 * 0.5) + float3(0.5);
    float4 _628 = float4(_626.x, _626.y, _626.z, float4(0.0).w);
    _628.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].y;
    float4 _629 = float4(0.0);
    _629.x = _357;
    float4 _630 = _629;
    _630.y = _356;
    float4 _631 = _630;
    _631.z = _355;
    float4 _632 = _631;
    _632.w = 0.50588238239288330078125;
    float4 _644 = float4(_358.x, _358.y, _358.z, float4(0.0).w);
    _644.w = ((log2(((dot(_549, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_418, ((((((_411 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _300) + ((_411 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _300) + ((_411 * 2.755199909210205078125) + float3(0.69029998779296875))) * _300).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_618.xyx * _618.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _614 * View.View_PreExposure;
    out.out_var_SV_Target1 = _628;
    out.out_var_SV_Target2 = _632;
    out.out_var_SV_Target3 = _644;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _367)] * _375) * _375;
    return out;
}

