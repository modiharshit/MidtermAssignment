

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _139 = {};
constant float _141 = {};
constant float4 _142 = {};

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
};

fragment MainPS_out Main_0000369d_268ba055(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _194 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _141, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float3 _212 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _227 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _228 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _233 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _282;
    float _283;
    float _284;
    float3 _285;
    float3 _286;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _250 = ((_194.xy / float2(_194.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _254 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _257 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float4 _260 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _250, level(0.0));
        float _270 = _260.w;
        _282 = (_233 * _270) + _260.z;
        _283 = (0.5 * _270) + _260.y;
        _284 = (_228 * _270) + _260.x;
        _285 = (_227 * _254.w) + _254.xyz;
        _286 = normalize((_212 * _257.w) + ((_257.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _282 = _233;
        _283 = 0.5;
        _284 = _228;
        _285 = _227;
        _286 = _212;
    }
    bool _294 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _300;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _294)
    {
        _300 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _300 = 1.0;
    }
    float _347;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _315 = fast::clamp((_204 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _326 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_315.x), int(_315.y), int(_315.z), 0).xyz), 0));
        _347 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_326.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_315 / float3(_326.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _347 = _300;
    }
    float3 _361 = ((_285 - (_285 * _284)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _368 = (mix(float3(0.07999999821186065673828125 * _283), _285, float3(_284)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _371 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _376;
    if (_371)
    {
        _376 = _361 + (_368 * 0.449999988079071044921875);
    }
    else
    {
        _376 = _361;
    }
    float3 _378 = select(_368, float3(0.0), bool3(_371));
    float3 _380 = float3(dot(_378, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _466;
    if (_294)
    {
        float4 _416 = _142;
        _416.y = (-0.48860299587249755859375) * _286.y;
        float4 _419 = _416;
        _419.z = 0.48860299587249755859375 * _286.z;
        float4 _422 = _419;
        _422.w = (-0.48860299587249755859375) * _286.x;
        float3 _423 = _286 * _286;
        float4 _426 = _139;
        _426.x = (1.09254801273345947265625 * _286.x) * _286.y;
        float4 _429 = _426;
        _429.y = ((-1.09254801273345947265625) * _286.y) * _286.z;
        float4 _434 = _429;
        _434.z = 0.3153919875621795654296875 * ((3.0 * _423.z) - 1.0);
        float4 _437 = _434;
        _437.w = ((-1.09254801273345947265625) * _286.x) * _286.z;
        float4 _441 = _422;
        _441.x = 0.886227548122406005859375;
        float3 _443 = _441.yzw * 2.094395160675048828125;
        float4 _444 = float4(_441.x, _443.x, _443.y, _443.z);
        float4 _445 = _437 * 0.785398185253143310546875;
        float _446 = (_423.x - _423.y) * 0.4290426075458526611328125;
        float3 _452 = float3(0.0);
        _452.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _444) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _445)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _446);
        float3 _458 = _452;
        _458.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _444) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _445)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _446);
        float3 _464 = _458;
        _464.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _444) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _445)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _446);
        _466 = fast::max(float3(0.0), _464);
    }
    else
    {
        _466 = float3(0.0);
    }
    float3 _469 = _466 * View.View_IndirectLightingColorScale;
    float3 _491 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _517;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _516;
        if (any(abs(_204 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _516 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _516 = _491;
        }
        _517 = _516;
    }
    else
    {
        _517 = _491;
    }
    float4 _524 = float4(((mix(float3(0.0), _376 + (_378 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_469 * _376) * fast::max(float3(1.0), ((((((_285 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_285 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_285 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _517) * 1.0, 0.0);
    float4 _531;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _530 = _524;
        _530.w = 0.0;
        _531 = _530;
    }
    else
    {
        _531 = _524;
    }
    float2 _535 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _543 = (_286 * 0.5) + float3(0.5);
    float4 _545 = float4(_543.x, _543.y, _543.z, float4(0.0).w);
    _545.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _546 = float4(0.0);
    _546.x = _284;
    float4 _547 = _546;
    _547.y = _283;
    float4 _548 = _547;
    _548.z = _282;
    float4 _549 = _548;
    _549.w = 0.50588238239288330078125;
    float4 _561 = float4(_285.x, _285.y, _285.z, float4(0.0).w);
    _561.w = ((log2(((dot(_469, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_380 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_380 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_380 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_535.xyx * _535.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _531 * View.View_PreExposure;
    out.out_var_SV_Target1 = _545;
    out.out_var_SV_Target2 = _549;
    out.out_var_SV_Target3 = _561;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_347, 1.0, 1.0, 1.0);
    return out;
}

