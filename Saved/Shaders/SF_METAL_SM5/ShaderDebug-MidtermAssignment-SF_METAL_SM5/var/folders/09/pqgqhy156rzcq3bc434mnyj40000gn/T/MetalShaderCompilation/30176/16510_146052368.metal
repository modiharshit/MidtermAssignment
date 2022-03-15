

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

constant float4 _159 = {};

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
};

fragment MainPS_out Main_0000407e_08b49510(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float3 _255 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_238, sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _267 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _269 = mix(0.4000000059604644775390625, 1.0, _267.x);
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _298;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _298 = _218.w;
                break;
            }
            else
            {
                float _282 = _218.z;
                _298 = ((_282 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_282 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _302 = fast::min(fast::max((_298 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _303 = _273.y;
    float4 _307 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _309 = _307.y;
    float3 _322 = fast::clamp(float3(mix(_269, 1.0 - _269, mix(_303, 1.0, _302)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_309 + mix(_303, 0.0, _302), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _327 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _309) + mix(mix(0.699999988079071044921875, 1.0, _303), 1.0, _302), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _374;
    float _375;
    float _376;
    float3 _377;
    float3 _378;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _344 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _348 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float4 _351 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float4 _354 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _344, level(0.0));
        float _364 = _354.w;
        _374 = (_327 * _364) + _354.z;
        _375 = (0.5 * _364) + _354.y;
        _376 = _354.x;
        _377 = (_322 * _348.w) + _348.xyz;
        _378 = normalize((_255 * _351.w) + ((_351.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _374 = _327;
        _375 = 0.5;
        _376 = 0.0;
        _377 = _322;
        _378 = _255;
    }
    bool _386 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _392;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _386)
    {
        _392 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _392 = 1.0;
    }
    float _439;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _407 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _418 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_407.x), int(_407.y), int(_407.z), 0).xyz), 0));
        _439 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_418.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_407 / float3(_418.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _439 = _392;
    }
    float3 _453 = ((_377 - (_377 * _376)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _460 = (mix(float3(0.07999999821186065673828125 * _375), _377, float3(_376)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _463 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _468;
    if (_463)
    {
        _468 = _453 + (_460 * 0.449999988079071044921875);
    }
    else
    {
        _468 = _453;
    }
    float3 _470 = select(_460, float3(0.0), bool3(_463));
    float3 _472 = float3(dot(_470, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _546;
    if (_386)
    {
        float3 _498 = fast::clamp((_227 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _502 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _498);
        float4 _506 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _498);
        float4 _509 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _498);
        float4 _527 = _159;
        _527.y = (-0.48860299587249755859375) * _378.y;
        float4 _530 = _527;
        _530.z = 0.48860299587249755859375 * _378.z;
        float4 _533 = _530;
        _533.w = (-0.48860299587249755859375) * _378.x;
        float4 _534 = _533;
        _534.x = 0.886227548122406005859375;
        float3 _536 = _534.yzw * 2.094395160675048828125;
        float4 _537 = float4(_534.x, _536.x, _536.y, _536.z);
        float3 _539 = float3(0.0);
        _539.x = dot(float4(_502.x, _506.x, _509.x, _502.w), _537);
        float3 _541 = _539;
        _541.y = dot(float4(_502.y, _506.y, _509.y, _506.w), _537);
        float3 _543 = _541;
        _543.z = dot(float4(_502.z, _506.z, _509.zw), _537);
        _546 = fast::max(float3(0.0), _543) * float3(0.3183098733425140380859375);
    }
    else
    {
        _546 = float3(0.0);
    }
    float3 _549 = _546 * View.View_IndirectLightingColorScale;
    float3 _571 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _597;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _596;
        if (any(abs(_227 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _596 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _596 = _571;
        }
        _597 = _596;
    }
    else
    {
        _597 = _571;
    }
    float4 _604 = float4(((mix(float3(0.0), _468 + (_470 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_549 * _468) * fast::max(float3(1.0), ((((((_377 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_377 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_377 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _597) * 1.0, 0.0);
    float4 _611;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _610 = _604;
        _610.w = 0.0;
        _611 = _610;
    }
    else
    {
        _611 = _604;
    }
    float2 _615 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _623 = (_378 * 0.5) + float3(0.5);
    float4 _625 = float4(_623.x, _623.y, _623.z, float4(0.0).w);
    _625.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _626 = float4(0.0);
    _626.x = _376;
    float4 _627 = _626;
    _627.y = _375;
    float4 _628 = _627;
    _628.z = _374;
    float4 _629 = _628;
    _629.w = 0.50588238239288330078125;
    float4 _641 = float4(_377.x, _377.y, _377.z, float4(0.0).w);
    _641.w = ((log2(((dot(_549, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_472 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_472 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_472 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_615.xyx * _615.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _611 * View.View_PreExposure;
    out.out_var_SV_Target1 = _625;
    out.out_var_SV_Target2 = _629;
    out.out_var_SV_Target3 = _641;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_439, 1.0, 1.0, 1.0);
    return out;
}

