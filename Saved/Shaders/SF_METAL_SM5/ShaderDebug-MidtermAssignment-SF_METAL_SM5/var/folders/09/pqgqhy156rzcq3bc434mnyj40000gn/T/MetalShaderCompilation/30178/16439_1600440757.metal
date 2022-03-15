

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[204];
    float Primitive_UseSingleSampleShadowFromStationaryLights;
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
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

constant float4 _161 = {};

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD1_0 [[user(locn2)]];
};

fragment MainPS_out Main_00004037_5f64c9b5(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD1 = {};
    in_var_TEXCOORD1[0] = in.in_var_TEXCOORD1_0;
    float4 _220 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float3 _257 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _271 = mix(0.4000000059604644775390625, 1.0, _269.x);
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _300;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _300 = _220.w;
                break;
            }
            else
            {
                float _284 = _220.z;
                _300 = ((_284 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_284 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _304 = fast::min(fast::max((_300 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _305 = _275.y;
    float4 _309 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _311 = _309.y;
    float3 _324 = fast::clamp(float3(mix(_271, 1.0 - _271, mix(_305, 1.0, _304)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_311 + mix(_305, 0.0, _304), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _329 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _311) + mix(mix(0.699999988079071044921875, 1.0, _305), 1.0, _304), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _376;
    float _377;
    float _378;
    float3 _379;
    float3 _380;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _346 = ((_220.xy / float2(_220.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _350 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float4 _353 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float4 _356 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _346, level(0.0));
        float _366 = _356.w;
        _376 = (_329 * _366) + _356.z;
        _377 = (0.5 * _366) + _356.y;
        _378 = _356.x;
        _379 = (_324 * _350.w) + _350.xyz;
        _380 = normalize((_257 * _353.w) + ((_353.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _376 = _329;
        _377 = 0.5;
        _378 = 0.0;
        _379 = _324;
        _380 = _257;
    }
    bool _388 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _394;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _388)
    {
        _394 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _394 = 1.0;
    }
    float _441;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _409 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _420 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_409.x), int(_409.y), int(_409.z), 0).xyz), 0));
        _441 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_420.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_409 / float3(_420.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _441 = _394;
    }
    float3 _455 = ((_379 - (_379 * _378)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _462 = (mix(float3(0.07999999821186065673828125 * _377), _379, float3(_378)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _465 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _470;
    if (_465)
    {
        _470 = _455 + (_462 * 0.449999988079071044921875);
    }
    else
    {
        _470 = _455;
    }
    float3 _472 = select(_462, float3(0.0), bool3(_465));
    float3 _474 = float3(dot(_472, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _548;
    if (_388)
    {
        float3 _500 = fast::clamp((_229 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _504 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _500);
        float4 _508 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _500);
        float4 _511 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _500);
        float4 _529 = _161;
        _529.y = (-0.48860299587249755859375) * _380.y;
        float4 _532 = _529;
        _532.z = 0.48860299587249755859375 * _380.z;
        float4 _535 = _532;
        _535.w = (-0.48860299587249755859375) * _380.x;
        float4 _536 = _535;
        _536.x = 0.886227548122406005859375;
        float3 _538 = _536.yzw * 2.094395160675048828125;
        float4 _539 = float4(_536.x, _538.x, _538.y, _538.z);
        float3 _541 = float3(0.0);
        _541.x = dot(float4(_504.x, _508.x, _511.x, _504.w), _539);
        float3 _543 = _541;
        _543.y = dot(float4(_504.y, _508.y, _511.y, _508.w), _539);
        float3 _545 = _543;
        _545.z = dot(float4(_504.z, _508.z, _511.zw), _539);
        _548 = fast::max(float3(0.0), _545) * float3(0.3183098733425140380859375);
    }
    else
    {
        _548 = float3(0.0);
    }
    float3 _551 = _548 * View.View_IndirectLightingColorScale;
    float3 _573 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _599;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _598;
        if (any(abs(_229 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _598 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _598 = _573;
        }
        _599 = _598;
    }
    else
    {
        _599 = _573;
    }
    float4 _606 = float4(((mix(float3(0.0), _470 + (_472 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_551 * _470) * fast::max(float3(1.0), ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _599) * 1.0, 0.0);
    float4 _613;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _612 = _606;
        _612.w = 0.0;
        _613 = _612;
    }
    else
    {
        _613 = _606;
    }
    float2 _617 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _625 = (_380 * 0.5) + float3(0.5);
    float4 _627 = float4(_625.x, _625.y, _625.z, float4(0.0).w);
    _627.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _628 = float4(0.0);
    _628.x = _378;
    float4 _629 = _628;
    _629.y = _377;
    float4 _630 = _629;
    _630.z = _376;
    float4 _631 = _630;
    _631.w = 0.50588238239288330078125;
    float4 _643 = float4(_379.x, _379.y, _379.z, float4(0.0).w);
    _643.w = ((log2(((dot(_551, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_474 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_474 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_474 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_617.xyx * _617.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _613 * View.View_PreExposure;
    out.out_var_SV_Target1 = _627;
    out.out_var_SV_Target2 = _631;
    out.out_var_SV_Target3 = _643;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_441, 1.0, 1.0, 1.0);
    return out;
}

