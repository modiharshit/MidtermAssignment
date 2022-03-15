

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
    char _m15_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[48];
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003de0_5f6eb979(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    float2 _223 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float2 _232 = (_229.xy * float2(2.0)) - float2(1.0);
    float2 _240 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.3499999940395355224609375;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float2 _245 = (_242.xy * float2(2.0)) - float2(1.0);
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _262 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _267 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _271 = (_257.x + 0.5) * ((_262.x + 0.5) * (_267.x + 0.5));
    float _274 = fast::min(fast::max(mix(-2.0, 0.699999988079071044921875, _271), 0.0), 1.0);
    float3 _277 = float3(_274);
    float4 _283 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _310;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _310 = _213.w;
                break;
            }
            else
            {
                float _294 = _213.z;
                _310 = ((_294 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_294 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _325 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_232, sqrt(fast::clamp(1.0 - dot(_232, _232), 0.0, 1.0)), 1.0).xyz, float4(_245, sqrt(fast::clamp(1.0 - dot(_245, _245), 0.0, 1.0)), 1.0).xyz, _277), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _283.x) + _310) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _338 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float4 _340 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _240, bias(View.View_MaterialTextureMipBias));
    float3 _350 = fast::clamp(mix(float3(0.6349999904632568359375), float3(1.0), float3(_271)) * mix(_338.xyz, _340.xyz, _277), float3(0.0), float3(1.0));
    float _355 = (fast::clamp(mix(0.800000011920928955078125, 0.300000011920928955078125, _271 * mix(_338.w, _340.w, _274)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _356 = in.in_var_PRIMITIVE_ID * 36u;
    uint _357 = _356 + 20u;
    float _405;
    float _406;
    float _407;
    float3 _408;
    float3 _409;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _375 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _379 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _375, level(0.0));
        float4 _382 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _375, level(0.0));
        float4 _385 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _375, level(0.0));
        float _395 = _385.w;
        _405 = (_355 * _395) + _385.z;
        _406 = (0.5 * _395) + _385.y;
        _407 = _385.x;
        _408 = (_350 * _379.w) + _379.xyz;
        _409 = normalize((_325 * _382.w) + ((_382.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _405 = _355;
        _406 = 0.5;
        _407 = 0.0;
        _408 = _350;
        _409 = _325;
    }
    float _458;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357)].z > 0.0)
    {
        float3 _426 = fast::clamp((_222 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _437 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_426.x), int(_426.y), int(_426.z), 0).xyz), 0));
        _458 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_437.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_426 / float3(_437.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _458 = 1.0;
    }
    float3 _472 = ((_408 - (_408 * _407)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _479 = (mix(float3(0.07999999821186065673828125 * _406), _408, float3(_407)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _482 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _487;
    if (_482)
    {
        _487 = _472 + (_479 * 0.449999988079071044921875);
    }
    else
    {
        _487 = _472;
    }
    float4 _493 = float4(_409, 1.0);
    float3 _497 = _155;
    _497.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _493);
    float3 _501 = _497;
    _501.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _493);
    float3 _505 = _501;
    _505.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _493);
    float4 _508 = _493.xyzz * _493.yzzx;
    float3 _512 = _155;
    _512.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _508);
    float3 _516 = _512;
    _516.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _508);
    float3 _520 = _516;
    _520.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _508);
    float3 _554 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _583;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _582;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356 + 19u)].xyz + float3(1.0))))
        {
            _582 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _582 = _554;
        }
        _583 = _582;
    }
    else
    {
        _583 = _554;
    }
    float4 _590 = float4(((mix(float3(0.0), _487 + (select(_479, float3(0.0), bool3(_482)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_505 + _520) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_409.x * _409.x) - (_409.y * _409.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _487) * fast::max(float3(1.0), ((((((_408 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_408 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_408 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _583) * 1.0, 0.0);
    float4 _597;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _596 = _590;
        _596.w = 0.0;
        _597 = _596;
    }
    else
    {
        _597 = _590;
    }
    float2 _601 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _609 = (_409 * 0.5) + float3(0.5);
    float4 _611 = float4(_609.x, _609.y, _609.z, float4(0.0).w);
    _611.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357)].y;
    float4 _612 = float4(0.0);
    _612.x = _407;
    float4 _613 = _612;
    _613.y = _406;
    float4 _614 = _613;
    _614.z = _405;
    float4 _615 = _614;
    _615.w = 0.50588238239288330078125;
    float4 _618 = float4(_408.x, _408.y, _408.z, float4(0.0).w);
    _618.w = (fract(dot(_601.xyx * _601.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _597 * View.View_PreExposure;
    out.out_var_SV_Target1 = _611;
    out.out_var_SV_Target2 = _615;
    out.out_var_SV_Target3 = _618;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_458, 1.0, 1.0, 1.0);
    return out;
}

