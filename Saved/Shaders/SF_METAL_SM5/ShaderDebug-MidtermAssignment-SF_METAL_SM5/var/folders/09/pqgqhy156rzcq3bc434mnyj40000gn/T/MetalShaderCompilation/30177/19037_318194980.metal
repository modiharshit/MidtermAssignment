

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

constant float4 _168 = {};
constant float3 _169 = {};
constant float4 _171 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn0)]];
    float4 in_var_TANGENTX [[user(locn2)]];
    float4 in_var_TANGENTZ [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004a5d_12f74524(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _232 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = (_236.xyz / float3(_236.w)) - View.View_PreViewTranslation;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float3 _269 = normalize(float3x3(in.in_var_TANGENTX.xyz, cross(in.in_var_TANGENTZ.xyz, in.in_var_TANGENTX.xyz) * in.in_var_TANGENTZ.w, in.in_var_TANGENTZ.xyz) * normalize(((float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _283 = mix(0.4000000059604644775390625, 1.0, _281.x);
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _312;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _312 = _232.w;
                break;
            }
            else
            {
                float _296 = _232.z;
                _312 = ((_296 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_296 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _316 = fast::min(fast::max((_312 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _317 = _287.y;
    float4 _321 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _323 = _321.y;
    float3 _336 = fast::clamp(float3(mix(_283, 1.0 - _283, mix(_317, 1.0, _316)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_323 + mix(_317, 0.0, _316), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _341 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _323) + mix(mix(0.699999988079071044921875, 1.0, _317), 1.0, _316), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _388;
    float _389;
    float _390;
    float3 _391;
    float3 _392;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _358 = ((_232.xy / float2(_232.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _362 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float4 _365 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float4 _368 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float _378 = _368.w;
        _388 = (_341 * _378) + _368.z;
        _389 = (0.5 * _378) + _368.y;
        _390 = _368.x;
        _391 = (_336 * _362.w) + _362.xyz;
        _392 = normalize((_269 * _365.w) + ((_365.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _388 = _341;
        _389 = 0.5;
        _390 = 0.0;
        _391 = _336;
        _392 = _269;
    }
    bool _400 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _406;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _400)
    {
        _406 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _406 = 1.0;
    }
    float _453;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _421 = fast::clamp((_241 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _432 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_421.x), int(_421.y), int(_421.z), 0).xyz), 0));
        _453 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_432.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_421 / float3(_432.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _453 = _406;
    }
    float3 _467 = ((_391 - (_391 * _390)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _474 = (mix(float3(0.07999999821186065673828125 * _389), _391, float3(_390)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _477 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _482;
    if (_477)
    {
        _482 = _467 + (_474 * 0.449999988079071044921875);
    }
    else
    {
        _482 = _467;
    }
    float3 _484 = select(_474, float3(0.0), bool3(_477));
    float3 _486 = float3(dot(_484, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _572;
    if (_400)
    {
        float4 _522 = _171;
        _522.y = (-0.48860299587249755859375) * _392.y;
        float4 _525 = _522;
        _525.z = 0.48860299587249755859375 * _392.z;
        float4 _528 = _525;
        _528.w = (-0.48860299587249755859375) * _392.x;
        float3 _529 = _392 * _392;
        float4 _532 = _168;
        _532.x = (1.09254801273345947265625 * _392.x) * _392.y;
        float4 _535 = _532;
        _535.y = ((-1.09254801273345947265625) * _392.y) * _392.z;
        float4 _540 = _535;
        _540.z = 0.3153919875621795654296875 * ((3.0 * _529.z) - 1.0);
        float4 _543 = _540;
        _543.w = ((-1.09254801273345947265625) * _392.x) * _392.z;
        float4 _547 = _528;
        _547.x = 0.886227548122406005859375;
        float3 _549 = _547.yzw * 2.094395160675048828125;
        float4 _550 = float4(_547.x, _549.x, _549.y, _549.z);
        float4 _551 = _543 * 0.785398185253143310546875;
        float _552 = (_529.x - _529.y) * 0.4290426075458526611328125;
        float3 _558 = float3(0.0);
        _558.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _550) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _551)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _552);
        float3 _564 = _558;
        _564.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _550) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _551)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _552);
        float3 _570 = _564;
        _570.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _550) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _551)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _552);
        _572 = fast::max(float3(0.0), _570);
    }
    else
    {
        _572 = float3(0.0);
    }
    float _598;
    float _599;
    float3 _600;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _588;
        float _589;
        if (_400)
        {
            _588 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _589 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _588 = _392;
            _589 = 1.0;
        }
        float _590 = 1.0 - _589;
        float _592 = 1.0 - (_590 * _590);
        _598 = mix(fast::clamp(dot(_588, _392), 0.0, 1.0), 1.0, _592);
        _599 = _589;
        _600 = mix(_588, _392, float3(_592));
    }
    else
    {
        _598 = 1.0;
        _599 = 1.0;
        _600 = _392;
    }
    float4 _604 = float4(_600, 1.0);
    float3 _608 = _169;
    _608.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _604);
    float3 _612 = _608;
    _612.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _604);
    float3 _616 = _612;
    _616.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _604);
    float4 _619 = _604.xyzz * _604.yzzx;
    float3 _623 = _169;
    _623.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _619);
    float3 _627 = _623;
    _627.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _619);
    float3 _631 = _627;
    _631.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _619);
    float3 _646 = (_572 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_616 + _631) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_600.x * _600.x) - (_600.y * _600.y)))) * View.View_SkyLightColor.xyz) * (_599 * _598));
    float3 _668 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _694;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _693;
        if (any(abs(_241 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _693 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _693 = _668;
        }
        _694 = _693;
    }
    else
    {
        _694 = _668;
    }
    float4 _701 = float4(((mix(float3(0.0), _482 + (_484 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_646 * _482) * fast::max(float3(1.0), ((((((_391 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_391 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_391 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _694) * 1.0, 0.0);
    float4 _708;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _707 = _701;
        _707.w = 0.0;
        _708 = _707;
    }
    else
    {
        _708 = _701;
    }
    float2 _712 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _720 = (_392 * 0.5) + float3(0.5);
    float4 _722 = float4(_720.x, _720.y, _720.z, float4(0.0).w);
    _722.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _723 = float4(0.0);
    _723.x = _390;
    float4 _724 = _723;
    _724.y = _389;
    float4 _725 = _724;
    _725.z = _388;
    float4 _726 = _725;
    _726.w = 0.50588238239288330078125;
    float4 _738 = float4(_391.x, _391.y, _391.z, float4(0.0).w);
    _738.w = ((log2(((dot(_646, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_486 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_486 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_486 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_712.xyx * _712.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _708 * View.View_PreExposure;
    out.out_var_SV_Target1 = _722;
    out.out_var_SV_Target2 = _726;
    out.out_var_SV_Target3 = _738;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_453, 1.0, 1.0, 1.0);
    return out;
}

