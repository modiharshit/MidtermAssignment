

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

constant float3 _163 = {};
constant float4 _165 = {};

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

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004a9c_496b6fdb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float2, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _225 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _229 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _234 = (_229.xyz / float3(_229.w)) - View.View_PreViewTranslation;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (in_var_TEXCOORD0[0] * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _245 = (_242.xy * float2(2.0)) - float2(1.0);
    float3 _262 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_245, sqrt(fast::clamp(1.0 - dot(_245, _245), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * 20.0), bias(View.View_MaterialTextureMipBias));
    float _276 = mix(0.4000000059604644775390625, 1.0, _274.x);
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _305;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _305 = _225.w;
                break;
            }
            else
            {
                float _289 = _225.z;
                _305 = ((_289 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_289 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _309 = fast::min(fast::max((_305 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _310 = _280.y;
    float4 _314 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (in_var_TEXCOORD0[0] * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _316 = _314.y;
    float3 _329 = fast::clamp(float3(mix(_276, 1.0 - _276, mix(_310, 1.0, _309)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_316 + mix(_310, 0.0, _309), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _334 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _316) + mix(mix(0.699999988079071044921875, 1.0, _310), 1.0, _309), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _381;
    float _382;
    float _383;
    float3 _384;
    float3 _385;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _351 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _355 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float _371 = _361.w;
        _381 = (_334 * _371) + _361.z;
        _382 = (0.5 * _371) + _361.y;
        _383 = _361.x;
        _384 = (_329 * _355.w) + _355.xyz;
        _385 = normalize((_262 * _358.w) + ((_358.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _381 = _334;
        _382 = 0.5;
        _383 = 0.0;
        _384 = _329;
        _385 = _262;
    }
    bool _393 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _399;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _393)
    {
        _399 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _399 = 1.0;
    }
    float _446;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _414 = fast::clamp((_234 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _425 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_414.x), int(_414.y), int(_414.z), 0).xyz), 0));
        _446 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_425.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_414 / float3(_425.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _446 = _399;
    }
    float3 _460 = ((_384 - (_384 * _383)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _467 = (mix(float3(0.07999999821186065673828125 * _382), _384, float3(_383)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _470 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _475;
    if (_470)
    {
        _475 = _460 + (_467 * 0.449999988079071044921875);
    }
    else
    {
        _475 = _460;
    }
    float3 _477 = select(_467, float3(0.0), bool3(_470));
    float3 _479 = float3(dot(_477, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _553;
    if (_393)
    {
        float3 _505 = fast::clamp((_234 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _509 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _505);
        float4 _513 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _505);
        float4 _516 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _505);
        float4 _534 = _165;
        _534.y = (-0.48860299587249755859375) * _385.y;
        float4 _537 = _534;
        _537.z = 0.48860299587249755859375 * _385.z;
        float4 _540 = _537;
        _540.w = (-0.48860299587249755859375) * _385.x;
        float4 _541 = _540;
        _541.x = 0.886227548122406005859375;
        float3 _543 = _541.yzw * 2.094395160675048828125;
        float4 _544 = float4(_541.x, _543.x, _543.y, _543.z);
        float3 _546 = float3(0.0);
        _546.x = dot(float4(_509.x, _513.x, _516.x, _509.w), _544);
        float3 _548 = _546;
        _548.y = dot(float4(_509.y, _513.y, _516.y, _513.w), _544);
        float3 _550 = _548;
        _550.z = dot(float4(_509.z, _513.z, _516.zw), _544);
        _553 = fast::max(float3(0.0), _550) * float3(0.3183098733425140380859375);
    }
    else
    {
        _553 = float3(0.0);
    }
    float _579;
    float _580;
    float3 _581;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _569;
        float _570;
        if (_393)
        {
            _569 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _570 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _569 = _385;
            _570 = 1.0;
        }
        float _571 = 1.0 - _570;
        float _573 = 1.0 - (_571 * _571);
        _579 = mix(fast::clamp(dot(_569, _385), 0.0, 1.0), 1.0, _573);
        _580 = _570;
        _581 = mix(_569, _385, float3(_573));
    }
    else
    {
        _579 = 1.0;
        _580 = 1.0;
        _581 = _385;
    }
    float4 _585 = float4(_581, 1.0);
    float3 _589 = _163;
    _589.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _585);
    float3 _593 = _589;
    _593.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _585);
    float3 _597 = _593;
    _597.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _585);
    float4 _600 = _585.xyzz * _585.yzzx;
    float3 _604 = _163;
    _604.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _600);
    float3 _608 = _604;
    _608.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _600);
    float3 _612 = _608;
    _612.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _600);
    float3 _627 = (_553 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_597 + _612) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_581.x * _581.x) - (_581.y * _581.y)))) * View.View_SkyLightColor.xyz) * (_580 * _579));
    float3 _649 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _675;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _674;
        if (any(abs(_234 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _674 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_234, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _674 = _649;
        }
        _675 = _674;
    }
    else
    {
        _675 = _649;
    }
    float4 _682 = float4(((mix(float3(0.0), _475 + (_477 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_627 * _475) * fast::max(float3(1.0), ((((((_384 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_384 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_384 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _675) * 1.0, 0.0);
    float4 _689;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _688 = _682;
        _688.w = 0.0;
        _689 = _688;
    }
    else
    {
        _689 = _682;
    }
    float2 _693 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _701 = (_385 * 0.5) + float3(0.5);
    float4 _703 = float4(_701.x, _701.y, _701.z, float4(0.0).w);
    _703.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _704 = float4(0.0);
    _704.x = _383;
    float4 _705 = _704;
    _705.y = _382;
    float4 _706 = _705;
    _706.z = _381;
    float4 _707 = _706;
    _707.w = 0.50588238239288330078125;
    float4 _719 = float4(_384.x, _384.y, _384.z, float4(0.0).w);
    _719.w = ((log2(((dot(_627, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_479 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_479 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_479 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_693.xyx * _693.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _689 * View.View_PreExposure;
    out.out_var_SV_Target1 = _703;
    out.out_var_SV_Target2 = _707;
    out.out_var_SV_Target3 = _719;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_446, 1.0, 1.0, 1.0);
    return out;
}

