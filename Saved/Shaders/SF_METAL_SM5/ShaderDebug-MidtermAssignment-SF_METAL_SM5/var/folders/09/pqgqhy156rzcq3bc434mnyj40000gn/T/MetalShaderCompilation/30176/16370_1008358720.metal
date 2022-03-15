

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

constant float4 _161 = {};
constant float4 _163 = {};

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
    float4 in_var_TEXCOORD3_0 [[user(locn2)]];
};

fragment MainPS_out Main_00003ff2_3c1a5540(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _226 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _231 = (_226.xyz / float3(_226.w)) - View.View_PreViewTranslation;
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float3 _259 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_242, sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _271 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _273 = mix(0.4000000059604644775390625, 1.0, _271.x);
    float4 _277 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _302;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _302 = _222.w;
                break;
            }
            else
            {
                float _286 = _222.z;
                _302 = ((_286 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_286 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _306 = fast::min(fast::max((_302 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _307 = _277.y;
    float4 _311 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _313 = _311.y;
    float3 _326 = fast::clamp(float3(mix(_273, 1.0 - _273, mix(_307, 1.0, _306)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_313 + mix(_307, 0.0, _306), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _331 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _313) + mix(mix(0.699999988079071044921875, 1.0, _307), 1.0, _306), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _378;
    float _379;
    float _380;
    float3 _381;
    float3 _382;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _348 = ((_222.xy / float2(_222.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _352 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float4 _355 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _348, level(0.0));
        float _368 = _358.w;
        _378 = (_331 * _368) + _358.z;
        _379 = (0.5 * _368) + _358.y;
        _380 = _358.x;
        _381 = (_326 * _352.w) + _352.xyz;
        _382 = normalize((_259 * _355.w) + ((_355.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _378 = _331;
        _379 = 0.5;
        _380 = 0.0;
        _381 = _326;
        _382 = _259;
    }
    bool _390 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _396;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _390)
    {
        _396 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _396 = 1.0;
    }
    float _443;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _411 = fast::clamp((_231 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _422 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_411.x), int(_411.y), int(_411.z), 0).xyz), 0));
        _443 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_422.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_411 / float3(_422.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _443 = _396;
    }
    float3 _457 = ((_381 - (_381 * _380)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _464 = (mix(float3(0.07999999821186065673828125 * _379), _381, float3(_380)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _467 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _472;
    if (_467)
    {
        _472 = _457 + (_464 * 0.449999988079071044921875);
    }
    else
    {
        _472 = _457;
    }
    float3 _474 = select(_464, float3(0.0), bool3(_467));
    float3 _476 = float3(dot(_474, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _562;
    if (_390)
    {
        float4 _512 = _163;
        _512.y = (-0.48860299587249755859375) * _382.y;
        float4 _515 = _512;
        _515.z = 0.48860299587249755859375 * _382.z;
        float4 _518 = _515;
        _518.w = (-0.48860299587249755859375) * _382.x;
        float3 _519 = _382 * _382;
        float4 _522 = _161;
        _522.x = (1.09254801273345947265625 * _382.x) * _382.y;
        float4 _525 = _522;
        _525.y = ((-1.09254801273345947265625) * _382.y) * _382.z;
        float4 _530 = _525;
        _530.z = 0.3153919875621795654296875 * ((3.0 * _519.z) - 1.0);
        float4 _533 = _530;
        _533.w = ((-1.09254801273345947265625) * _382.x) * _382.z;
        float4 _537 = _518;
        _537.x = 0.886227548122406005859375;
        float3 _539 = _537.yzw * 2.094395160675048828125;
        float4 _540 = float4(_537.x, _539.x, _539.y, _539.z);
        float4 _541 = _533 * 0.785398185253143310546875;
        float _542 = (_519.x - _519.y) * 0.4290426075458526611328125;
        float3 _548 = float3(0.0);
        _548.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _540) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _541)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _542);
        float3 _554 = _548;
        _554.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _540) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _541)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _542);
        float3 _560 = _554;
        _560.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _540) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _541)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _542);
        _562 = fast::max(float3(0.0), _560);
    }
    else
    {
        _562 = float3(0.0);
    }
    float3 _565 = _562 * View.View_IndirectLightingColorScale;
    float3 _587 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _613;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _612;
        if (any(abs(_231 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _612 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_231, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _612 = _587;
        }
        _613 = _612;
    }
    else
    {
        _613 = _587;
    }
    float4 _620 = float4(((mix(float3(0.0), _472 + (_474 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_565 * _472) * fast::max(float3(1.0), ((((((_381 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_381 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_381 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _613) * 1.0, 0.0);
    float4 _627;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _626 = _620;
        _626.w = 0.0;
        _627 = _626;
    }
    else
    {
        _627 = _620;
    }
    float2 _631 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _639 = (_382 * 0.5) + float3(0.5);
    float4 _641 = float4(_639.x, _639.y, _639.z, float4(0.0).w);
    _641.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _642 = float4(0.0);
    _642.x = _380;
    float4 _643 = _642;
    _643.y = _379;
    float4 _644 = _643;
    _644.z = _378;
    float4 _645 = _644;
    _645.w = 0.50588238239288330078125;
    float4 _657 = float4(_381.x, _381.y, _381.z, float4(0.0).w);
    _657.w = ((log2(((dot(_565, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_476 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_476 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_476 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_631.xyx * _631.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _627 * View.View_PreExposure;
    out.out_var_SV_Target1 = _641;
    out.out_var_SV_Target2 = _645;
    out.out_var_SV_Target3 = _657;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_443, 1.0, 1.0, 1.0);
    return out;
}

