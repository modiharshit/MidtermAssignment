

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
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _168 = {};

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

fragment MainPS_out Main_000045c7_f2305bf4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _225 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _229 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _234 = (_229.xyz / float3(_229.w)) - View.View_PreViewTranslation;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float2 _253 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float _284;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _284 = _225.w;
                break;
            }
            else
            {
                float _268 = _225.z;
                _284 = ((_268 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_268 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _290 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _257.x) + _284) - 150.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _299 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float3(0.5, 0.5, 1.0) * float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _290) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _311 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _314 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _323 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.449999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _324 = _323.x;
    float _328 = _323.y;
    float _332 = _323.z;
    float4 _338 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _253, bias(View.View_MaterialTextureMipBias));
    float _339 = _338.x;
    float _343 = _338.y;
    float _347 = _338.z;
    float3 _355 = fast::min(fast::max(mix(float3((_324 <= 0.0) ? 0.0 : pow(_324, 2.0), (_328 <= 0.0) ? 0.0 : pow(_328, 2.0), (_332 <= 0.0) ? 0.0 : pow(_332, 2.0)), float3((_339 <= 0.0) ? 0.0 : pow(_339, 2.0), (_343 <= 0.0) ? 0.0 : pow(_343, 2.0), (_347 <= 0.0) ? 0.0 : pow(_347, 2.0)), _290) * fast::min(fast::max(1.0 - (_311.x * _314.x), 0.0), 1.0), float3(0.0)), float3(1.0));
    float3 _360 = fast::clamp(mix(_355, float3(dot(_355, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375))), float3(0.4000000059604644775390625)) * 0.699999988079071044921875, float3(0.0), float3(1.0));
    uint _362 = in.in_var_PRIMITIVE_ID * 36u;
    uint _363 = _362 + 20u;
    float _411;
    float _412;
    float _413;
    float3 _414;
    float3 _415;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _381 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _385 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float4 _388 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float4 _391 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _381, level(0.0));
        float _401 = _391.w;
        _411 = (View.View_RoughnessOverrideParameter.x * _401) + _391.z;
        _412 = (0.5 * _401) + _391.y;
        _413 = _391.x;
        _414 = (_360 * _385.w) + _385.xyz;
        _415 = normalize((_299 * _388.w) + ((_388.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _411 = View.View_RoughnessOverrideParameter.x;
        _412 = 0.5;
        _413 = 0.0;
        _414 = _360;
        _415 = _299;
    }
    bool _425 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _431;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362 + 18u)].w > 0.0) && _425)
    {
        _431 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _431 = 1.0;
    }
    float _478;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363)].z > 0.0)
    {
        float3 _446 = fast::clamp((_234 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _457 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_446.x), int(_446.y), int(_446.z), 0).xyz), 0));
        _478 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_457.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_446 / float3(_457.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _478 = _431;
    }
    float3 _492 = ((_414 - (_414 * _413)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _499 = (mix(float3(0.07999999821186065673828125 * _412), _414, float3(_413)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _502 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _507;
    if (_502)
    {
        _507 = _492 + (_499 * 0.449999988079071044921875);
    }
    else
    {
        _507 = _492;
    }
    float3 _509 = select(_499, float3(0.0), bool3(_502));
    float3 _511 = float3(dot(_509, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _585;
    if (_425)
    {
        float3 _537 = fast::clamp((_234 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _541 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _537);
        float4 _545 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _537);
        float4 _548 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _537);
        float4 _566 = _168;
        _566.y = (-0.48860299587249755859375) * _415.y;
        float4 _569 = _566;
        _569.z = 0.48860299587249755859375 * _415.z;
        float4 _572 = _569;
        _572.w = (-0.48860299587249755859375) * _415.x;
        float4 _573 = _572;
        _573.x = 0.886227548122406005859375;
        float3 _575 = _573.yzw * 2.094395160675048828125;
        float4 _576 = float4(_573.x, _575.x, _575.y, _575.z);
        float3 _578 = float3(0.0);
        _578.x = dot(float4(_541.x, _545.x, _548.x, _541.w), _576);
        float3 _580 = _578;
        _580.y = dot(float4(_541.y, _545.y, _548.y, _545.w), _576);
        float3 _582 = _580;
        _582.z = dot(float4(_541.z, _545.z, _548.zw), _576);
        _585 = fast::max(float3(0.0), _582) * float3(0.3183098733425140380859375);
    }
    else
    {
        _585 = float3(0.0);
    }
    float3 _588 = _585 * View.View_IndirectLightingColorScale;
    float3 _610 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _639;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _638;
        if (any(abs(_234 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _362 + 19u)].xyz + float3(1.0))))
        {
            _638 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_234, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _638 = _610;
        }
        _639 = _638;
    }
    else
    {
        _639 = _610;
    }
    float4 _646 = float4(((mix(float3(0.0), _507 + (_509 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_588 * _507) * fast::max(float3(1.0), ((((((_414 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_414 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_414 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _639) * 1.0, 0.0);
    float4 _653;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _652 = _646;
        _652.w = 0.0;
        _653 = _652;
    }
    else
    {
        _653 = _646;
    }
    float2 _657 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _665 = (_415 * 0.5) + float3(0.5);
    float4 _667 = float4(_665.x, _665.y, _665.z, float4(0.0).w);
    _667.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _363)].y;
    float4 _668 = float4(0.0);
    _668.x = _413;
    float4 _669 = _668;
    _669.y = _412;
    float4 _670 = _669;
    _670.z = _411;
    float4 _671 = _670;
    _671.w = 0.50588238239288330078125;
    float4 _683 = float4(_414.x, _414.y, _414.z, float4(0.0).w);
    _683.w = ((log2(((dot(_588, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_511 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_511 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_511 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_657.xyx * _657.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _653 * View.View_PreExposure;
    out.out_var_SV_Target1 = _667;
    out.out_var_SV_Target2 = _671;
    out.out_var_SV_Target3 = _683;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_478, 1.0, 1.0, 1.0);
    return out;
}

