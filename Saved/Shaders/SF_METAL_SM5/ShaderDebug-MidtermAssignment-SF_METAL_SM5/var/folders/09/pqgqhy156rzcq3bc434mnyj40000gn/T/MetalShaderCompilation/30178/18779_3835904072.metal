

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    float4 IndirectLightingCache_PointSkyBentNormal;
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

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
    float2 in_var_TEXCOORD0 [[user(locn0)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000495b_e4a34048(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float4 _234 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in.in_var_TEXCOORD0 * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _237 = (_234.xy * float2(2.0)) - float2(1.0);
    float3 _254 = normalize(float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0)) * normalize(((float4(_237, sqrt(fast::clamp(1.0 - dot(_237, _237), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * 20.0), bias(View.View_MaterialTextureMipBias));
    float _268 = mix(0.4000000059604644775390625, 1.0, _266.x);
    float4 _272 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _297;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _297 = _217.w;
                break;
            }
            else
            {
                float _281 = _217.z;
                _297 = ((_281 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_281 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _301 = fast::min(fast::max((_297 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _302 = _272.y;
    float4 _306 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in.in_var_TEXCOORD0 * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _308 = _306.y;
    float3 _321 = fast::clamp(float3(mix(_268, 1.0 - _268, mix(_302, 1.0, _301)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_308 + mix(_302, 0.0, _301), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _326 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _308) + mix(mix(0.699999988079071044921875, 1.0, _302), 1.0, _301), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _373;
    float _374;
    float _375;
    float3 _376;
    float3 _377;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _343 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _347 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _353 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float _363 = _353.w;
        _373 = (_326 * _363) + _353.z;
        _374 = (0.5 * _363) + _353.y;
        _375 = _353.x;
        _376 = (_321 * _347.w) + _347.xyz;
        _377 = normalize((_254 * _350.w) + ((_350.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _373 = _326;
        _374 = 0.5;
        _375 = 0.0;
        _376 = _321;
        _377 = _254;
    }
    bool _385 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _391;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _385)
    {
        _391 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _391 = 1.0;
    }
    float _438;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _406 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _417 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_406.x), int(_406.y), int(_406.z), 0).xyz), 0));
        _438 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_417.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_406 / float3(_417.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _438 = _391;
    }
    float3 _452 = ((_376 - (_376 * _375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _459 = (mix(float3(0.07999999821186065673828125 * _374), _376, float3(_375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _462 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _467;
    if (_462)
    {
        _467 = _452 + (_459 * 0.449999988079071044921875);
    }
    else
    {
        _467 = _452;
    }
    float3 _469 = select(_459, float3(0.0), bool3(_462));
    float3 _471 = float3(dot(_469, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _545;
    if (_385)
    {
        float3 _497 = fast::clamp((_226 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _501 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _497);
        float4 _505 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _497);
        float4 _508 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _497);
        float4 _526 = _166;
        _526.y = (-0.48860299587249755859375) * _377.y;
        float4 _529 = _526;
        _529.z = 0.48860299587249755859375 * _377.z;
        float4 _532 = _529;
        _532.w = (-0.48860299587249755859375) * _377.x;
        float4 _533 = _532;
        _533.x = 0.886227548122406005859375;
        float3 _535 = _533.yzw * 2.094395160675048828125;
        float4 _536 = float4(_533.x, _535.x, _535.y, _535.z);
        float3 _538 = float3(0.0);
        _538.x = dot(float4(_501.x, _505.x, _508.x, _501.w), _536);
        float3 _540 = _538;
        _540.y = dot(float4(_501.y, _505.y, _508.y, _505.w), _536);
        float3 _542 = _540;
        _542.z = dot(float4(_501.z, _505.z, _508.zw), _536);
        _545 = fast::max(float3(0.0), _542) * float3(0.3183098733425140380859375);
    }
    else
    {
        _545 = float3(0.0);
    }
    float _571;
    float _572;
    float3 _573;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _561;
        float _562;
        if (_385)
        {
            _561 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _562 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _561 = _377;
            _562 = 1.0;
        }
        float _563 = 1.0 - _562;
        float _565 = 1.0 - (_563 * _563);
        _571 = mix(fast::clamp(dot(_561, _377), 0.0, 1.0), 1.0, _565);
        _572 = _562;
        _573 = mix(_561, _377, float3(_565));
    }
    else
    {
        _571 = 1.0;
        _572 = 1.0;
        _573 = _377;
    }
    float4 _577 = float4(_573, 1.0);
    float3 _581 = _164;
    _581.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _577);
    float3 _585 = _581;
    _585.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _577);
    float3 _589 = _585;
    _589.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _577);
    float4 _592 = _577.xyzz * _577.yzzx;
    float3 _596 = _164;
    _596.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _592);
    float3 _600 = _596;
    _600.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _592);
    float3 _604 = _600;
    _604.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _592);
    float3 _619 = (_545 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_589 + _604) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_573.x * _573.x) - (_573.y * _573.y)))) * View.View_SkyLightColor.xyz) * (_572 * _571));
    float3 _641 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _667;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _666;
        if (any(abs(_226 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _666 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _666 = _641;
        }
        _667 = _666;
    }
    else
    {
        _667 = _641;
    }
    float4 _674 = float4(((mix(float3(0.0), _467 + (_469 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_619 * _467) * fast::max(float3(1.0), ((((((_376 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_376 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_376 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _667) * 1.0, 0.0);
    float4 _681;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _680 = _674;
        _680.w = 0.0;
        _681 = _680;
    }
    else
    {
        _681 = _674;
    }
    float2 _685 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _693 = (_377 * 0.5) + float3(0.5);
    float4 _695 = float4(_693.x, _693.y, _693.z, float4(0.0).w);
    _695.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _696 = float4(0.0);
    _696.x = _375;
    float4 _697 = _696;
    _697.y = _374;
    float4 _698 = _697;
    _698.z = _373;
    float4 _699 = _698;
    _699.w = 0.50588238239288330078125;
    float4 _711 = float4(_376.x, _376.y, _376.z, float4(0.0).w);
    _711.w = ((log2(((dot(_619, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_471 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_471 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_471 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_685.xyx * _685.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _681 * View.View_PreExposure;
    out.out_var_SV_Target1 = _695;
    out.out_var_SV_Target2 = _699;
    out.out_var_SV_Target3 = _711;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_438, 1.0, 1.0, 1.0);
    return out;
}

