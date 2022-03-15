

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

constant float4 _163 = {};
constant float3 _164 = {};
constant float4 _166 = {};

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

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000049d2_7104c784(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD2.xy * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float3 _263 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _275 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * 20.0), bias(View.View_MaterialTextureMipBias));
    float _277 = mix(0.4000000059604644775390625, 1.0, _275.x);
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _306;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _306 = _226.w;
                break;
            }
            else
            {
                float _290 = _226.z;
                _306 = ((_290 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_290 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _310 = fast::min(fast::max((_306 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _311 = _281.y;
    float4 _315 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD2.xy * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _317 = _315.y;
    float3 _330 = fast::clamp(float3(mix(_277, 1.0 - _277, mix(_311, 1.0, _310)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_317 + mix(_311, 0.0, _310), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _335 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _317) + mix(mix(0.699999988079071044921875, 1.0, _311), 1.0, _310), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _382;
    float _383;
    float _384;
    float3 _385;
    float3 _386;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _352 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _356 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _359 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _352, level(0.0));
        float _372 = _362.w;
        _382 = (_335 * _372) + _362.z;
        _383 = (0.5 * _372) + _362.y;
        _384 = _362.x;
        _385 = (_330 * _356.w) + _356.xyz;
        _386 = normalize((_263 * _359.w) + ((_359.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _382 = _335;
        _383 = 0.5;
        _384 = 0.0;
        _385 = _330;
        _386 = _263;
    }
    bool _394 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _400;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _394)
    {
        _400 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _400 = 1.0;
    }
    float _447;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _415 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _426 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_415.x), int(_415.y), int(_415.z), 0).xyz), 0));
        _447 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_426.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_415 / float3(_426.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _447 = _400;
    }
    float3 _461 = ((_385 - (_385 * _384)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _468 = (mix(float3(0.07999999821186065673828125 * _383), _385, float3(_384)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _471 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _476;
    if (_471)
    {
        _476 = _461 + (_468 * 0.449999988079071044921875);
    }
    else
    {
        _476 = _461;
    }
    float3 _478 = select(_468, float3(0.0), bool3(_471));
    float3 _480 = float3(dot(_478, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _566;
    if (_394)
    {
        float4 _516 = _166;
        _516.y = (-0.48860299587249755859375) * _386.y;
        float4 _519 = _516;
        _519.z = 0.48860299587249755859375 * _386.z;
        float4 _522 = _519;
        _522.w = (-0.48860299587249755859375) * _386.x;
        float3 _523 = _386 * _386;
        float4 _526 = _163;
        _526.x = (1.09254801273345947265625 * _386.x) * _386.y;
        float4 _529 = _526;
        _529.y = ((-1.09254801273345947265625) * _386.y) * _386.z;
        float4 _534 = _529;
        _534.z = 0.3153919875621795654296875 * ((3.0 * _523.z) - 1.0);
        float4 _537 = _534;
        _537.w = ((-1.09254801273345947265625) * _386.x) * _386.z;
        float4 _541 = _522;
        _541.x = 0.886227548122406005859375;
        float3 _543 = _541.yzw * 2.094395160675048828125;
        float4 _544 = float4(_541.x, _543.x, _543.y, _543.z);
        float4 _545 = _537 * 0.785398185253143310546875;
        float _546 = (_523.x - _523.y) * 0.4290426075458526611328125;
        float3 _552 = float3(0.0);
        _552.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _546);
        float3 _558 = _552;
        _558.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _546);
        float3 _564 = _558;
        _564.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _544) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _545)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _546);
        _566 = fast::max(float3(0.0), _564);
    }
    else
    {
        _566 = float3(0.0);
    }
    float _592;
    float _593;
    float3 _594;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _582;
        float _583;
        if (_394)
        {
            _582 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _583 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _582 = _386;
            _583 = 1.0;
        }
        float _584 = 1.0 - _583;
        float _586 = 1.0 - (_584 * _584);
        _592 = mix(fast::clamp(dot(_582, _386), 0.0, 1.0), 1.0, _586);
        _593 = _583;
        _594 = mix(_582, _386, float3(_586));
    }
    else
    {
        _592 = 1.0;
        _593 = 1.0;
        _594 = _386;
    }
    float4 _598 = float4(_594, 1.0);
    float3 _602 = _164;
    _602.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _598);
    float3 _606 = _602;
    _606.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _598);
    float3 _610 = _606;
    _610.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _598);
    float4 _613 = _598.xyzz * _598.yzzx;
    float3 _617 = _164;
    _617.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _613);
    float3 _621 = _617;
    _621.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _613);
    float3 _625 = _621;
    _625.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _613);
    float3 _640 = (_566 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_610 + _625) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_594.x * _594.x) - (_594.y * _594.y)))) * View.View_SkyLightColor.xyz) * (_593 * _592));
    float3 _662 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _688;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _687;
        if (any(abs(_235 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _687 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _687 = _662;
        }
        _688 = _687;
    }
    else
    {
        _688 = _662;
    }
    float4 _695 = float4(((mix(float3(0.0), _476 + (_478 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_640 * _476) * fast::max(float3(1.0), ((((((_385 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_385 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_385 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _688) * 1.0, 0.0);
    float4 _702;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _701 = _695;
        _701.w = 0.0;
        _702 = _701;
    }
    else
    {
        _702 = _695;
    }
    float2 _706 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _714 = (_386 * 0.5) + float3(0.5);
    float4 _716 = float4(_714.x, _714.y, _714.z, float4(0.0).w);
    _716.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _717 = float4(0.0);
    _717.x = _384;
    float4 _718 = _717;
    _718.y = _383;
    float4 _719 = _718;
    _719.z = _382;
    float4 _720 = _719;
    _720.w = 0.50588238239288330078125;
    float4 _732 = float4(_385.x, _385.y, _385.z, float4(0.0).w);
    _732.w = ((log2(((dot(_640, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_480 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_480 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_480 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_706.xyx * _706.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _702 * View.View_PreExposure;
    out.out_var_SV_Target1 = _716;
    out.out_var_SV_Target2 = _720;
    out.out_var_SV_Target3 = _732;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_447, 1.0, 1.0, 1.0);
    return out;
}

