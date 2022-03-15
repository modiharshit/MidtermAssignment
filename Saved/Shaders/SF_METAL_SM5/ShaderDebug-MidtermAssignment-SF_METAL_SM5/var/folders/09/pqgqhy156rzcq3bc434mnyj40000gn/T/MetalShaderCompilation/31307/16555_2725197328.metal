

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

constant float3 _151 = {};

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

fragment MainPS_out Main_000040ab_a26f3610(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _207 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    float2 _217 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _223 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _217, bias(View.View_MaterialTextureMipBias));
    float2 _226 = (_223.xy * float2(2.0)) - float2(1.0);
    float4 _238 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _265;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _265 = _207.w;
                break;
            }
            else
            {
                float _249 = _207.z;
                _265 = ((_249 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_249 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _270 = fast::min(fast::max(((mix(-2000.0, 2000.0, _238.x) + _265) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _281 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_226, sqrt(fast::clamp(1.0 - dot(_226, _226), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_270)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _292 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _217, bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _217, bias(View.View_MaterialTextureMipBias));
    float3 _302 = fast::clamp(_292.xyz, float3(0.0), float3(1.0));
    float _303 = fast::clamp(_292.x, 0.0, 1.0);
    float _304 = fast::clamp(_296.w, 0.0, 1.0);
    float _309 = (fast::clamp(mix(_296.x, 0.300000011920928955078125, _270), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _310 = in.in_var_PRIMITIVE_ID * 36u;
    uint _311 = _310 + 20u;
    float _359;
    float _360;
    float _361;
    float3 _362;
    float3 _363;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _329 = ((_207.xy / float2(_207.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _333 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _329, level(0.0));
        float4 _336 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _329, level(0.0));
        float4 _339 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _329, level(0.0));
        float _349 = _339.w;
        _359 = (_309 * _349) + _339.z;
        _360 = (_303 * _349) + _339.y;
        _361 = _339.x;
        _362 = (_302 * _333.w) + _333.xyz;
        _363 = normalize((_281 * _336.w) + ((_336.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _359 = _309;
        _360 = _303;
        _361 = 0.0;
        _362 = _302;
        _363 = _281;
    }
    float3 _378 = ((_362 - (_362 * _361)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _385 = (mix(float3(0.07999999821186065673828125 * _360), _362, float3(_361)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _388 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _393;
    if (_388)
    {
        _393 = _378 + (_385 * 0.449999988079071044921875);
    }
    else
    {
        _393 = _378;
    }
    float3 _395 = select(_385, float3(0.0), bool3(_388));
    float3 _397 = float3(dot(_395, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _404 = float3(_304);
    float2 _413 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _418 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _413);
    float4 _420 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_413 + float2(0.0, 0.5)));
    uint _426 = in.in_var_LIGHTMAP_ID * 15u;
    uint _427 = _426 + 4u;
    uint _432 = _426 + 6u;
    float3 _437 = _418.xyz;
    float _489;
    float _490;
    float3 _491;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _473 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _477 = _473.w;
        float _478 = _477 * _477;
        float3 _480 = normalize(((_473.xyz * 2.0) - float3(1.0)).xyz);
        float _481 = 1.0 - _478;
        float _483 = 1.0 - (_481 * _481);
        _489 = mix(fast::clamp(dot(_480, _363), 0.0, 1.0), 1.0, _483);
        _490 = _478;
        _491 = mix(_480, _363, float3(_483));
    }
    else
    {
        _489 = 1.0;
        _490 = 1.0;
        _491 = _363;
    }
    float4 _495 = float4(_491, 1.0);
    float3 _499 = _151;
    _499.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _495);
    float3 _503 = _499;
    _503.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _495);
    float3 _507 = _503;
    _507.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _495);
    float4 _510 = _495.xyzz * _495.yzzx;
    float3 _514 = _151;
    _514.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _510);
    float3 _518 = _514;
    _518.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _510);
    float3 _522 = _518;
    _522.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _510);
    float3 _537 = (((((_437 * _437) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _427)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].xyz) * ((exp2(((_418.w + ((_420.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _427)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_420 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _426 + 7u)], float4(_363.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_507 + _522) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_491.x * _491.x) - (_491.y * _491.y)))) * View.View_SkyLightColor.xyz) * (_490 * _489));
    float3 _559 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _588;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _587;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _310 + 19u)].xyz + float3(1.0))))
        {
            _587 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _587 = _559;
        }
        _588 = _587;
    }
    else
    {
        _588 = _559;
    }
    float4 _595 = float4(((mix(float3(0.0), _393 + (_395 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_537 * _393) * fast::max(_404, ((((((_362 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _304) + ((_362 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _304) + ((_362 * 2.755199909210205078125) + float3(0.69029998779296875))) * _304))) + _588) * 1.0, 0.0);
    float4 _602;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _601 = _595;
        _601.w = 0.0;
        _602 = _601;
    }
    else
    {
        _602 = _595;
    }
    float2 _606 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _614 = (_363 * 0.5) + float3(0.5);
    float4 _616 = float4(_614.x, _614.y, _614.z, float4(0.0).w);
    _616.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _311)].y;
    float4 _617 = float4(0.0);
    _617.x = _361;
    float4 _618 = _617;
    _618.y = _360;
    float4 _619 = _618;
    _619.z = _359;
    float4 _620 = _619;
    _620.w = 0.75686275959014892578125;
    float4 _632 = float4(_362.x, _362.y, _362.z, float4(0.0).w);
    _632.w = ((log2(((dot(_537, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_404, ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _304) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _304) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * _304).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_606.xyx * _606.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _602 * View.View_PreExposure;
    out.out_var_SV_Target1 = _616;
    out.out_var_SV_Target2 = _620;
    out.out_var_SV_Target3 = _632;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

