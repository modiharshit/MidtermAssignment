

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

struct type_LandscapeParameters
{
    char _m0_pad[144];
    float4x4 LandscapeParameters_LocalToWorldNoScaling;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _162 = {};

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
    float4 in_var_TEXCOORD1 [[user(locn1)]];
};

fragment MainPS_out Main_000042c5_bcd0ed36(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> LandscapeParameters_NormalmapTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler LandscapeParameters_NormalmapTextureSampler [[sampler(3)]], sampler Material_Texture2D_0Sampler [[sampler(4)]], sampler Material_Texture2D_1Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _205 = LandscapeParameters_NormalmapTexture.sample(LandscapeParameters_NormalmapTextureSampler, in.in_var_TEXCOORD1.zw);
    float2 _210 = (float2(_205.zw) * float2(2.0)) - float2(1.0);
    float _214 = sqrt(fast::max(1.0 - dot(_210, _210), 0.0));
    float _215 = _210.x;
    float3 _217 = float3(_215, _210.y, _214);
    float3 _220 = normalize(float3(_214, 0.0, -_215));
    float4 _244 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _248 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _253 = (_248.xyz / float3(_248.w)) - View.View_PreViewTranslation;
    float4 _261 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _264 = (_261.xy * float2(2.0)) - float2(1.0);
    float3 _281 = normalize((float3x3(LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[0].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[1].xyz, LandscapeParameters.LandscapeParameters_LocalToWorldNoScaling[2].xyz) * float3x3(_220, cross(_217, _220), _217)) * normalize(((float4(_264, sqrt(fast::clamp(1.0 - dot(_264, _264), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _293 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _295 = mix(0.4000000059604644775390625, 1.0, _293.x);
    float4 _299 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _324;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _324 = _244.w;
                break;
            }
            else
            {
                float _308 = _244.z;
                _324 = ((_308 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_308 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _328 = fast::min(fast::max((_324 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _329 = _299.y;
    float4 _333 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _335 = _333.y;
    float3 _348 = fast::clamp(float3(mix(_295, 1.0 - _295, mix(_329, 1.0, _328)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_335 + mix(_329, 0.0, _328), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _353 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _335) + mix(mix(0.699999988079071044921875, 1.0, _329), 1.0, _328), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _400;
    float _401;
    float _402;
    float3 _403;
    float3 _404;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _370 = ((_244.xy / float2(_244.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _374 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _377 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _380 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float _390 = _380.w;
        _400 = (_353 * _390) + _380.z;
        _401 = (0.5 * _390) + _380.y;
        _402 = _380.x;
        _403 = (_348 * _374.w) + _374.xyz;
        _404 = normalize((_281 * _377.w) + ((_377.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _400 = _353;
        _401 = 0.5;
        _402 = 0.0;
        _403 = _348;
        _404 = _281;
    }
    bool _412 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _418;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _412)
    {
        _418 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _418 = 1.0;
    }
    float _465;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _433 = fast::clamp((_253 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _444 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_433.x), int(_433.y), int(_433.z), 0).xyz), 0));
        _465 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_444.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_433 / float3(_444.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _465 = _418;
    }
    float3 _479 = ((_403 - (_403 * _402)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _486 = (mix(float3(0.07999999821186065673828125 * _401), _403, float3(_402)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _489 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _494;
    if (_489)
    {
        _494 = _479 + (_486 * 0.449999988079071044921875);
    }
    else
    {
        _494 = _479;
    }
    float3 _496 = select(_486, float3(0.0), bool3(_489));
    float3 _498 = float3(dot(_496, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _572;
    if (_412)
    {
        float3 _524 = fast::clamp((_253 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _528 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _524);
        float4 _532 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _524);
        float4 _535 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _524);
        float4 _553 = _162;
        _553.y = (-0.48860299587249755859375) * _404.y;
        float4 _556 = _553;
        _556.z = 0.48860299587249755859375 * _404.z;
        float4 _559 = _556;
        _559.w = (-0.48860299587249755859375) * _404.x;
        float4 _560 = _559;
        _560.x = 0.886227548122406005859375;
        float3 _562 = _560.yzw * 2.094395160675048828125;
        float4 _563 = float4(_560.x, _562.x, _562.y, _562.z);
        float3 _565 = float3(0.0);
        _565.x = dot(float4(_528.x, _532.x, _535.x, _528.w), _563);
        float3 _567 = _565;
        _567.y = dot(float4(_528.y, _532.y, _535.y, _532.w), _563);
        float3 _569 = _567;
        _569.z = dot(float4(_528.z, _532.z, _535.zw), _563);
        _572 = fast::max(float3(0.0), _569) * float3(0.3183098733425140380859375);
    }
    else
    {
        _572 = float3(0.0);
    }
    float3 _575 = _572 * View.View_IndirectLightingColorScale;
    float3 _597 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _623;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _622;
        if (any(abs(_253 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _622 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_253, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _622 = _597;
        }
        _623 = _622;
    }
    else
    {
        _623 = _597;
    }
    float4 _630 = float4(((mix(float3(0.0), _494 + (_496 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_575 * _494) * fast::max(float3(1.0), ((((((_403 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_403 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_403 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _623) * 1.0, 0.0);
    float4 _637;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _636 = _630;
        _636.w = 0.0;
        _637 = _636;
    }
    else
    {
        _637 = _630;
    }
    float2 _641 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _649 = (_404 * 0.5) + float3(0.5);
    float4 _651 = float4(_649.x, _649.y, _649.z, float4(0.0).w);
    _651.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _652 = float4(0.0);
    _652.x = _402;
    float4 _653 = _652;
    _653.y = _401;
    float4 _654 = _653;
    _654.z = _400;
    float4 _655 = _654;
    _655.w = 0.50588238239288330078125;
    float4 _667 = float4(_403.x, _403.y, _403.z, float4(0.0).w);
    _667.w = ((log2(((dot(_575, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_498 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_498 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_498 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_641.xyx * _641.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _637 * View.View_PreExposure;
    out.out_var_SV_Target1 = _651;
    out.out_var_SV_Target2 = _655;
    out.out_var_SV_Target3 = _667;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_465, 1.0, 1.0, 1.0);
    return out;
}

