

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

constant float4 _166 = {};
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
    float4 in_var_COLOR1 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
};

fragment MainPS_out Main_000041c2_d05702c3(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float3 _265 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _279 = mix(0.4000000059604644775390625, 1.0, _277.x);
    float4 _283 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _308;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _308 = _228.w;
                break;
            }
            else
            {
                float _292 = _228.z;
                _308 = ((_292 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_292 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _312 = fast::min(fast::max((_308 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _313 = _283.y;
    float4 _317 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _319 = _317.y;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _341 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _341) : (in.in_var_COLOR1.w < _341)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _352 = fast::clamp(float3(mix(_279, 1.0 - _279, mix(_313, 1.0, _312)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_319 + mix(_313, 0.0, _312), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _357 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _319) + mix(mix(0.699999988079071044921875, 1.0, _313), 1.0, _312), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _404;
    float _405;
    float _406;
    float3 _407;
    float3 _408;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _374 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _378 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float _394 = _384.w;
        _404 = (_357 * _394) + _384.z;
        _405 = (0.5 * _394) + _384.y;
        _406 = _384.x;
        _407 = (_352 * _378.w) + _378.xyz;
        _408 = normalize((_265 * _381.w) + ((_381.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _404 = _357;
        _405 = 0.5;
        _406 = 0.0;
        _407 = _352;
        _408 = _265;
    }
    bool _416 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _422;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _416)
    {
        _422 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _422 = 1.0;
    }
    float _469;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _437 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _448 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_437.x), int(_437.y), int(_437.z), 0).xyz), 0));
        _469 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_448.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_437 / float3(_448.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _469 = _422;
    }
    float3 _483 = ((_407 - (_407 * _406)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _490 = (mix(float3(0.07999999821186065673828125 * _405), _407, float3(_406)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _493 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _498;
    if (_493)
    {
        _498 = _483 + (_490 * 0.449999988079071044921875);
    }
    else
    {
        _498 = _483;
    }
    float3 _500 = select(_490, float3(0.0), bool3(_493));
    float3 _502 = float3(dot(_500, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _588;
    if (_416)
    {
        float4 _538 = _168;
        _538.y = (-0.48860299587249755859375) * _408.y;
        float4 _541 = _538;
        _541.z = 0.48860299587249755859375 * _408.z;
        float4 _544 = _541;
        _544.w = (-0.48860299587249755859375) * _408.x;
        float3 _545 = _408 * _408;
        float4 _548 = _166;
        _548.x = (1.09254801273345947265625 * _408.x) * _408.y;
        float4 _551 = _548;
        _551.y = ((-1.09254801273345947265625) * _408.y) * _408.z;
        float4 _556 = _551;
        _556.z = 0.3153919875621795654296875 * ((3.0 * _545.z) - 1.0);
        float4 _559 = _556;
        _559.w = ((-1.09254801273345947265625) * _408.x) * _408.z;
        float4 _563 = _544;
        _563.x = 0.886227548122406005859375;
        float3 _565 = _563.yzw * 2.094395160675048828125;
        float4 _566 = float4(_563.x, _565.x, _565.y, _565.z);
        float4 _567 = _559 * 0.785398185253143310546875;
        float _568 = (_545.x - _545.y) * 0.4290426075458526611328125;
        float3 _574 = float3(0.0);
        _574.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _566) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _567)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _568);
        float3 _580 = _574;
        _580.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _566) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _567)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _568);
        float3 _586 = _580;
        _586.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _566) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _567)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _568);
        _588 = fast::max(float3(0.0), _586);
    }
    else
    {
        _588 = float3(0.0);
    }
    float3 _591 = _588 * View.View_IndirectLightingColorScale;
    float3 _613 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _639;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _638;
        if (any(abs(_237 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _638 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _638 = _613;
        }
        _639 = _638;
    }
    else
    {
        _639 = _613;
    }
    float4 _646 = float4(((mix(float3(0.0), _498 + (_500 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_591 * _498) * fast::max(float3(1.0), ((((((_407 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_407 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_407 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _639) * 1.0, 0.0);
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
    float3 _665 = (_408 * 0.5) + float3(0.5);
    float4 _667 = float4(_665.x, _665.y, _665.z, float4(0.0).w);
    _667.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _668 = float4(0.0);
    _668.x = _406;
    float4 _669 = _668;
    _669.y = _405;
    float4 _670 = _669;
    _670.z = _404;
    float4 _671 = _670;
    _671.w = 0.50588238239288330078125;
    float4 _683 = float4(_407.x, _407.y, _407.z, float4(0.0).w);
    _683.w = ((log2(((dot(_591, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_502 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_502 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_502 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_657.xyx * _657.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _653 * View.View_PreExposure;
    out.out_var_SV_Target1 = _667;
    out.out_var_SV_Target2 = _671;
    out.out_var_SV_Target3 = _683;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_469, 1.0, 1.0, 1.0);
    return out;
}

