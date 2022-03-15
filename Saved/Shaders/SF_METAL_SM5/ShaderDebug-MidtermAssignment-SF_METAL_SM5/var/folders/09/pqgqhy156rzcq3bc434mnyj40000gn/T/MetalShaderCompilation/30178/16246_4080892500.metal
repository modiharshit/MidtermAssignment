

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
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _159 = {};
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
    float2 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TEXCOORD10_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn2)]];
};

fragment MainPS_out Main_00003f76_f33d7a54(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float2, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    float4 _236 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0] * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _239 = (_236.xy * float2(2.0)) - float2(1.0);
    float3 _256 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_239, sqrt(fast::clamp(1.0 - dot(_239, _239), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * 20.0), bias(View.View_MaterialTextureMipBias));
    float _270 = mix(0.4000000059604644775390625, 1.0, _268.x);
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _299;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _299 = _219.w;
                break;
            }
            else
            {
                float _283 = _219.z;
                _299 = ((_283 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_283 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _303 = fast::min(fast::max((_299 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _304 = _274.y;
    float4 _308 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _310 = _308.y;
    float3 _323 = fast::clamp(float3(mix(_270, 1.0 - _270, mix(_304, 1.0, _303)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_310 + mix(_304, 0.0, _303), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _328 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _310) + mix(mix(0.699999988079071044921875, 1.0, _304), 1.0, _303), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _375;
    float _376;
    float _377;
    float3 _378;
    float3 _379;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _345 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _349 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _345, level(0.0));
        float4 _352 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _345, level(0.0));
        float4 _355 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _345, level(0.0));
        float _365 = _355.w;
        _375 = (_328 * _365) + _355.z;
        _376 = (0.5 * _365) + _355.y;
        _377 = _355.x;
        _378 = (_323 * _349.w) + _349.xyz;
        _379 = normalize((_256 * _352.w) + ((_352.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _375 = _328;
        _376 = 0.5;
        _377 = 0.0;
        _378 = _323;
        _379 = _256;
    }
    bool _387 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _393;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _387)
    {
        _393 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _393 = 1.0;
    }
    float _440;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _408 = fast::clamp((_228 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _419 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_408.x), int(_408.y), int(_408.z), 0).xyz), 0));
        _440 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_419.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_408 / float3(_419.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _440 = _393;
    }
    float3 _454 = ((_378 - (_378 * _377)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _461 = (mix(float3(0.07999999821186065673828125 * _376), _378, float3(_377)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _464 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _469;
    if (_464)
    {
        _469 = _454 + (_461 * 0.449999988079071044921875);
    }
    else
    {
        _469 = _454;
    }
    float3 _471 = select(_461, float3(0.0), bool3(_464));
    float3 _473 = float3(dot(_471, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _559;
    if (_387)
    {
        float4 _509 = _161;
        _509.y = (-0.48860299587249755859375) * _379.y;
        float4 _512 = _509;
        _512.z = 0.48860299587249755859375 * _379.z;
        float4 _515 = _512;
        _515.w = (-0.48860299587249755859375) * _379.x;
        float3 _516 = _379 * _379;
        float4 _519 = _159;
        _519.x = (1.09254801273345947265625 * _379.x) * _379.y;
        float4 _522 = _519;
        _522.y = ((-1.09254801273345947265625) * _379.y) * _379.z;
        float4 _527 = _522;
        _527.z = 0.3153919875621795654296875 * ((3.0 * _516.z) - 1.0);
        float4 _530 = _527;
        _530.w = ((-1.09254801273345947265625) * _379.x) * _379.z;
        float4 _534 = _515;
        _534.x = 0.886227548122406005859375;
        float3 _536 = _534.yzw * 2.094395160675048828125;
        float4 _537 = float4(_534.x, _536.x, _536.y, _536.z);
        float4 _538 = _530 * 0.785398185253143310546875;
        float _539 = (_516.x - _516.y) * 0.4290426075458526611328125;
        float3 _545 = float3(0.0);
        _545.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _537) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _538)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _539);
        float3 _551 = _545;
        _551.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _537) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _538)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _539);
        float3 _557 = _551;
        _557.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _537) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _538)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _539);
        _559 = fast::max(float3(0.0), _557);
    }
    else
    {
        _559 = float3(0.0);
    }
    float3 _562 = _559 * View.View_IndirectLightingColorScale;
    float3 _584 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _610;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _609;
        if (any(abs(_228 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _609 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _609 = _584;
        }
        _610 = _609;
    }
    else
    {
        _610 = _584;
    }
    float4 _617 = float4(((mix(float3(0.0), _469 + (_471 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_562 * _469) * fast::max(float3(1.0), ((((((_378 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_378 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_378 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _610) * 1.0, 0.0);
    float4 _624;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _623 = _617;
        _623.w = 0.0;
        _624 = _623;
    }
    else
    {
        _624 = _617;
    }
    float2 _628 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _636 = (_379 * 0.5) + float3(0.5);
    float4 _638 = float4(_636.x, _636.y, _636.z, float4(0.0).w);
    _638.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _639 = float4(0.0);
    _639.x = _377;
    float4 _640 = _639;
    _640.y = _376;
    float4 _641 = _640;
    _641.z = _375;
    float4 _642 = _641;
    _642.w = 0.50588238239288330078125;
    float4 _654 = float4(_378.x, _378.y, _378.z, float4(0.0).w);
    _654.w = ((log2(((dot(_562, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_473 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_473 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_473 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_628.xyx * _628.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _624 * View.View_PreExposure;
    out.out_var_SV_Target1 = _638;
    out.out_var_SV_Target2 = _642;
    out.out_var_SV_Target3 = _654;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_440, 1.0, 1.0, 1.0);
    return out;
}

