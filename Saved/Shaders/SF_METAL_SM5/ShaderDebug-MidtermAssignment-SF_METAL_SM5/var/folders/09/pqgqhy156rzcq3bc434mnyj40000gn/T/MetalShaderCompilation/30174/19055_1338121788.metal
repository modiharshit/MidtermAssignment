

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
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

constant float4 _169 = {};
constant float3 _170 = {};
constant float4 _172 = {};

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

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004a6f_4fc21e3c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD1 = {};
    in_var_TEXCOORD1[0] = in.in_var_TEXCOORD1_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _233 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _237 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _242 = (_237.xyz / float3(_237.w)) - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _253 = (_250.xy * float2(2.0)) - float2(1.0);
    float3 _270 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_253, sqrt(fast::clamp(1.0 - dot(_253, _253), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _282 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _284 = mix(0.4000000059604644775390625, 1.0, _282.x);
    float4 _288 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _313;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _313 = _233.w;
                break;
            }
            else
            {
                float _297 = _233.z;
                _313 = ((_297 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_297 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _317 = fast::min(fast::max((_313 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _318 = _288.y;
    float4 _322 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _324 = _322.y;
    float3 _337 = fast::clamp(float3(mix(_284, 1.0 - _284, mix(_318, 1.0, _317)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_324 + mix(_318, 0.0, _317), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _342 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _324) + mix(mix(0.699999988079071044921875, 1.0, _318), 1.0, _317), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _389;
    float _390;
    float _391;
    float3 _392;
    float3 _393;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _359 = ((_233.xy / float2(_233.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _363 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _366 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float4 _369 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _359, level(0.0));
        float _379 = _369.w;
        _389 = (_342 * _379) + _369.z;
        _390 = (0.5 * _379) + _369.y;
        _391 = _369.x;
        _392 = (_337 * _363.w) + _363.xyz;
        _393 = normalize((_270 * _366.w) + ((_366.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _389 = _342;
        _390 = 0.5;
        _391 = 0.0;
        _392 = _337;
        _393 = _270;
    }
    bool _401 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _407;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _401)
    {
        _407 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _407 = 1.0;
    }
    float _454;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _422 = fast::clamp((_242 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _433 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_422.x), int(_422.y), int(_422.z), 0).xyz), 0));
        _454 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_433.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_422 / float3(_433.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _454 = _407;
    }
    float3 _468 = ((_392 - (_392 * _391)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _475 = (mix(float3(0.07999999821186065673828125 * _390), _392, float3(_391)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _478 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _483;
    if (_478)
    {
        _483 = _468 + (_475 * 0.449999988079071044921875);
    }
    else
    {
        _483 = _468;
    }
    float3 _485 = select(_475, float3(0.0), bool3(_478));
    float3 _487 = float3(dot(_485, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _573;
    if (_401)
    {
        float4 _523 = _172;
        _523.y = (-0.48860299587249755859375) * _393.y;
        float4 _526 = _523;
        _526.z = 0.48860299587249755859375 * _393.z;
        float4 _529 = _526;
        _529.w = (-0.48860299587249755859375) * _393.x;
        float3 _530 = _393 * _393;
        float4 _533 = _169;
        _533.x = (1.09254801273345947265625 * _393.x) * _393.y;
        float4 _536 = _533;
        _536.y = ((-1.09254801273345947265625) * _393.y) * _393.z;
        float4 _541 = _536;
        _541.z = 0.3153919875621795654296875 * ((3.0 * _530.z) - 1.0);
        float4 _544 = _541;
        _544.w = ((-1.09254801273345947265625) * _393.x) * _393.z;
        float4 _548 = _529;
        _548.x = 0.886227548122406005859375;
        float3 _550 = _548.yzw * 2.094395160675048828125;
        float4 _551 = float4(_548.x, _550.x, _550.y, _550.z);
        float4 _552 = _544 * 0.785398185253143310546875;
        float _553 = (_530.x - _530.y) * 0.4290426075458526611328125;
        float3 _559 = float3(0.0);
        _559.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _551) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _552)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _553);
        float3 _565 = _559;
        _565.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _551) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _552)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _553);
        float3 _571 = _565;
        _571.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _551) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _552)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _553);
        _573 = fast::max(float3(0.0), _571);
    }
    else
    {
        _573 = float3(0.0);
    }
    float _599;
    float _600;
    float3 _601;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _589;
        float _590;
        if (_401)
        {
            _589 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _590 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _589 = _393;
            _590 = 1.0;
        }
        float _591 = 1.0 - _590;
        float _593 = 1.0 - (_591 * _591);
        _599 = mix(fast::clamp(dot(_589, _393), 0.0, 1.0), 1.0, _593);
        _600 = _590;
        _601 = mix(_589, _393, float3(_593));
    }
    else
    {
        _599 = 1.0;
        _600 = 1.0;
        _601 = _393;
    }
    float4 _605 = float4(_601, 1.0);
    float3 _609 = _170;
    _609.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _605);
    float3 _613 = _609;
    _613.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _605);
    float3 _617 = _613;
    _617.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _605);
    float4 _620 = _605.xyzz * _605.yzzx;
    float3 _624 = _170;
    _624.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _620);
    float3 _628 = _624;
    _628.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _620);
    float3 _632 = _628;
    _632.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _620);
    float3 _647 = (_573 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_617 + _632) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_601.x * _601.x) - (_601.y * _601.y)))) * View.View_SkyLightColor.xyz) * (_600 * _599));
    float3 _669 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _695;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _694;
        if (any(abs(_242 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _694 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_242, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _694 = _669;
        }
        _695 = _694;
    }
    else
    {
        _695 = _669;
    }
    float4 _702 = float4(((mix(float3(0.0), _483 + (_485 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_647 * _483) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _695) * 1.0, 0.0);
    float4 _709;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _708 = _702;
        _708.w = 0.0;
        _709 = _708;
    }
    else
    {
        _709 = _702;
    }
    float2 _713 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _721 = (_393 * 0.5) + float3(0.5);
    float4 _723 = float4(_721.x, _721.y, _721.z, float4(0.0).w);
    _723.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _724 = float4(0.0);
    _724.x = _391;
    float4 _725 = _724;
    _725.y = _390;
    float4 _726 = _725;
    _726.z = _389;
    float4 _727 = _726;
    _727.w = 0.50588238239288330078125;
    float4 _739 = float4(_392.x, _392.y, _392.z, float4(0.0).w);
    _739.w = ((log2(((dot(_647, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_487 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_487 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_487 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_713.xyx * _713.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _709 * View.View_PreExposure;
    out.out_var_SV_Target1 = _723;
    out.out_var_SV_Target2 = _727;
    out.out_var_SV_Target3 = _739;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_454, 1.0, 1.0, 1.0);
    return out;
}

