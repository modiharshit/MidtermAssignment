

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_Primitive
{
    char _m0_pad[64];
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[204];
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

constant float4 _147 = {};
constant float _149 = {};
constant float4 _150 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
};

fragment MainPS_out Main_000038cf_585dca8f(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _149, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float3 _232 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _250 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _250) : (in.in_var_COLOR1.w < _250)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _261 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _265 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _310;
    float _311;
    float _312;
    float3 _313;
    float3 _314;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _282 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _286 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        float4 _289 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        float4 _292 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _282, level(0.0));
        _310 = (_265 * _292.w) + _292.z;
        _311 = _292.y;
        _312 = _292.x;
        _313 = (_261 * _286.w) + _286.xyz;
        _314 = normalize((_232 * _289.w) + ((_289.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _310 = _265;
        _311 = 0.0;
        _312 = 0.0;
        _313 = _261;
        _314 = _232;
    }
    bool _322 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _328;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _322)
    {
        _328 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _328 = 1.0;
    }
    float _375;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _343 = fast::clamp((_218 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _354 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_343.x), int(_343.y), int(_343.z), 0).xyz), 0));
        _375 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_354.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_343 / float3(_354.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _375 = _328;
    }
    float3 _389 = ((_313 - (_313 * _312)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _396 = (mix(float3(0.07999999821186065673828125 * _311), _313, float3(_312)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _399 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _404;
    if (_399)
    {
        _404 = _389 + (_396 * 0.449999988079071044921875);
    }
    else
    {
        _404 = _389;
    }
    float3 _406 = select(_396, float3(0.0), bool3(_399));
    float3 _408 = float3(dot(_406, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _494;
    if (_322)
    {
        float4 _444 = _150;
        _444.y = (-0.48860299587249755859375) * _314.y;
        float4 _447 = _444;
        _447.z = 0.48860299587249755859375 * _314.z;
        float4 _450 = _447;
        _450.w = (-0.48860299587249755859375) * _314.x;
        float3 _451 = _314 * _314;
        float4 _454 = _147;
        _454.x = (1.09254801273345947265625 * _314.x) * _314.y;
        float4 _457 = _454;
        _457.y = ((-1.09254801273345947265625) * _314.y) * _314.z;
        float4 _462 = _457;
        _462.z = 0.3153919875621795654296875 * ((3.0 * _451.z) - 1.0);
        float4 _465 = _462;
        _465.w = ((-1.09254801273345947265625) * _314.x) * _314.z;
        float4 _469 = _450;
        _469.x = 0.886227548122406005859375;
        float3 _471 = _469.yzw * 2.094395160675048828125;
        float4 _472 = float4(_469.x, _471.x, _471.y, _471.z);
        float4 _473 = _465 * 0.785398185253143310546875;
        float _474 = (_451.x - _451.y) * 0.4290426075458526611328125;
        float3 _480 = float3(0.0);
        _480.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _472) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _473)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _474);
        float3 _486 = _480;
        _486.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _472) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _473)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _474);
        float3 _492 = _486;
        _492.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _472) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _473)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _474);
        _494 = fast::max(float3(0.0), _492);
    }
    else
    {
        _494 = float3(0.0);
    }
    float3 _497 = _494 * View.View_IndirectLightingColorScale;
    float3 _519 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _545;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _544;
        if (any(abs(_218 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _544 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _544 = _519;
        }
        _545 = _544;
    }
    else
    {
        _545 = _519;
    }
    float4 _552 = float4(((mix(float3(0.0), _404 + (_406 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_497 * _404) * fast::max(float3(1.0), ((((((_313 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_313 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_313 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _545) * 1.0, 0.0);
    float4 _559;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _558 = _552;
        _558.w = 0.0;
        _559 = _558;
    }
    else
    {
        _559 = _552;
    }
    float2 _563 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _571 = (_314 * 0.5) + float3(0.5);
    float4 _573 = float4(_571.x, _571.y, _571.z, float4(0.0).w);
    _573.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _574 = float4(0.0);
    _574.x = _312;
    float4 _575 = _574;
    _575.y = _311;
    float4 _576 = _575;
    _576.z = _310;
    float4 _577 = _576;
    _577.w = 0.50588238239288330078125;
    float4 _589 = float4(_313.x, _313.y, _313.z, float4(0.0).w);
    _589.w = ((log2(((dot(_497, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_408 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_408 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_408 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_563.xyx * _563.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _559 * View.View_PreExposure;
    out.out_var_SV_Target1 = _573;
    out.out_var_SV_Target2 = _577;
    out.out_var_SV_Target3 = _589;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_375, 1.0, 1.0, 1.0);
    return out;
}

