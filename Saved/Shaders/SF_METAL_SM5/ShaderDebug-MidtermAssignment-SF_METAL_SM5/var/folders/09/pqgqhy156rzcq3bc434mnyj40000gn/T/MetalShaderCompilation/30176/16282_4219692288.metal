

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

constant float4 _156 = {};

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
    float4 in_var_TEXCOORD2 [[user(locn2)]];
};

fragment MainPS_out Main_00003f9a_fb836500(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _214 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _218 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _223 = (_218.xyz / float3(_218.w)) - View.View_PreViewTranslation;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD2.xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float3 _251 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_234, sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _265 = mix(0.4000000059604644775390625, 1.0, _263.x);
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _294;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _294 = _214.w;
                break;
            }
            else
            {
                float _278 = _214.z;
                _294 = ((_278 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_278 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _298 = fast::min(fast::max((_294 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _299 = _269.y;
    float4 _303 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _305 = _303.y;
    float3 _318 = fast::clamp(float3(mix(_265, 1.0 - _265, mix(_299, 1.0, _298)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_305 + mix(_299, 0.0, _298), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _323 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _305) + mix(mix(0.699999988079071044921875, 1.0, _299), 1.0, _298), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _370;
    float _371;
    float _372;
    float3 _373;
    float3 _374;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _340 = ((_214.xy / float2(_214.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _344 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float _360 = _350.w;
        _370 = (_323 * _360) + _350.z;
        _371 = (0.5 * _360) + _350.y;
        _372 = _350.x;
        _373 = (_318 * _344.w) + _344.xyz;
        _374 = normalize((_251 * _347.w) + ((_347.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _370 = _323;
        _371 = 0.5;
        _372 = 0.0;
        _373 = _318;
        _374 = _251;
    }
    bool _382 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _388;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _382)
    {
        _388 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _388 = 1.0;
    }
    float _435;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _403 = fast::clamp((_223 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _414 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_403.x), int(_403.y), int(_403.z), 0).xyz), 0));
        _435 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_414.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_403 / float3(_414.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _435 = _388;
    }
    float3 _449 = ((_373 - (_373 * _372)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _456 = (mix(float3(0.07999999821186065673828125 * _371), _373, float3(_372)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _459 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _464;
    if (_459)
    {
        _464 = _449 + (_456 * 0.449999988079071044921875);
    }
    else
    {
        _464 = _449;
    }
    float3 _466 = select(_456, float3(0.0), bool3(_459));
    float3 _468 = float3(dot(_466, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _542;
    if (_382)
    {
        float3 _494 = fast::clamp((_223 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _498 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _494);
        float4 _502 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _494);
        float4 _505 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _494);
        float4 _523 = _156;
        _523.y = (-0.48860299587249755859375) * _374.y;
        float4 _526 = _523;
        _526.z = 0.48860299587249755859375 * _374.z;
        float4 _529 = _526;
        _529.w = (-0.48860299587249755859375) * _374.x;
        float4 _530 = _529;
        _530.x = 0.886227548122406005859375;
        float3 _532 = _530.yzw * 2.094395160675048828125;
        float4 _533 = float4(_530.x, _532.x, _532.y, _532.z);
        float3 _535 = float3(0.0);
        _535.x = dot(float4(_498.x, _502.x, _505.x, _498.w), _533);
        float3 _537 = _535;
        _537.y = dot(float4(_498.y, _502.y, _505.y, _502.w), _533);
        float3 _539 = _537;
        _539.z = dot(float4(_498.z, _502.z, _505.zw), _533);
        _542 = fast::max(float3(0.0), _539) * float3(0.3183098733425140380859375);
    }
    else
    {
        _542 = float3(0.0);
    }
    float3 _545 = _542 * View.View_IndirectLightingColorScale;
    float3 _567 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _593;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _592;
        if (any(abs(_223 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _592 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_223, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _592 = _567;
        }
        _593 = _592;
    }
    else
    {
        _593 = _567;
    }
    float4 _600 = float4(((mix(float3(0.0), _464 + (_466 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_545 * _464) * fast::max(float3(1.0), ((((((_373 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_373 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_373 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _593) * 1.0, 0.0);
    float4 _607;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _606 = _600;
        _606.w = 0.0;
        _607 = _606;
    }
    else
    {
        _607 = _600;
    }
    float2 _611 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _619 = (_374 * 0.5) + float3(0.5);
    float4 _621 = float4(_619.x, _619.y, _619.z, float4(0.0).w);
    _621.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _622 = float4(0.0);
    _622.x = _372;
    float4 _623 = _622;
    _623.y = _371;
    float4 _624 = _623;
    _624.z = _370;
    float4 _625 = _624;
    _625.w = 0.50588238239288330078125;
    float4 _637 = float4(_373.x, _373.y, _373.z, float4(0.0).w);
    _637.w = ((log2(((dot(_545, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_468 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_468 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_468 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_611.xyx * _611.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _607 * View.View_PreExposure;
    out.out_var_SV_Target1 = _621;
    out.out_var_SV_Target2 = _625;
    out.out_var_SV_Target3 = _637;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_435, 1.0, 1.0, 1.0);
    return out;
}

