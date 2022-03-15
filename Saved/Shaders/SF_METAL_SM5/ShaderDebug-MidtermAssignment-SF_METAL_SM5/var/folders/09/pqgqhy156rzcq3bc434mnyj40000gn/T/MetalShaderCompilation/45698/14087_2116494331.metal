

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _138 = {};
constant float4 _139 = {};

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

fragment MainPS_out Main_00003707_7e2723fb(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    float4 _192 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _138, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _197 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _202 = (_197.xyz / float3(_197.w)) - View.View_PreViewTranslation;
    float3 _210 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _225 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _226 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _231 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _278;
    float _279;
    float _280;
    float3 _281;
    float3 _282;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _248 = ((_192.xy / float2(_192.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _252 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float4 _255 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float4 _258 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _248, level(0.0));
        float _268 = _258.w;
        _278 = (_231 * _268) + _258.z;
        _279 = (_226 * _268) + _258.y;
        _280 = _258.x;
        _281 = (_225 * _252.w) + _252.xyz;
        _282 = normalize((_210 * _255.w) + ((_255.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _278 = _231;
        _279 = _226;
        _280 = 0.0;
        _281 = _225;
        _282 = _210;
    }
    bool _290 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _296;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _290)
    {
        _296 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _296 = 1.0;
    }
    float _343;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _311 = fast::clamp((_202 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _322 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_311.x), int(_311.y), int(_311.z), 0).xyz), 0));
        _343 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_322.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_311 / float3(_322.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _343 = _296;
    }
    float3 _357 = ((_281 - (_281 * _280)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _364 = (mix(float3(0.07999999821186065673828125 * _279), _281, float3(_280)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _367 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _372;
    if (_367)
    {
        _372 = _357 + (_364 * 0.449999988079071044921875);
    }
    else
    {
        _372 = _357;
    }
    float3 _374 = select(_364, float3(0.0), bool3(_367));
    float3 _376 = float3(dot(_374, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _450;
    if (_290)
    {
        float3 _402 = fast::clamp((_202 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _406 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _402);
        float4 _410 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _402);
        float4 _413 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _402);
        float4 _431 = _139;
        _431.y = (-0.48860299587249755859375) * _282.y;
        float4 _434 = _431;
        _434.z = 0.48860299587249755859375 * _282.z;
        float4 _437 = _434;
        _437.w = (-0.48860299587249755859375) * _282.x;
        float4 _438 = _437;
        _438.x = 0.886227548122406005859375;
        float3 _440 = _438.yzw * 2.094395160675048828125;
        float4 _441 = float4(_438.x, _440.x, _440.y, _440.z);
        float3 _443 = float3(0.0);
        _443.x = dot(float4(_406.x, _410.x, _413.x, _406.w), _441);
        float3 _445 = _443;
        _445.y = dot(float4(_406.y, _410.y, _413.y, _410.w), _441);
        float3 _447 = _445;
        _447.z = dot(float4(_406.z, _410.z, _413.zw), _441);
        _450 = fast::max(float3(0.0), _447) * float3(0.3183098733425140380859375);
    }
    else
    {
        _450 = float3(0.0);
    }
    float3 _453 = _450 * View.View_IndirectLightingColorScale;
    float3 _475 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _501;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _500;
        if (any(abs(_202 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _500 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_202, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _500 = _475;
        }
        _501 = _500;
    }
    else
    {
        _501 = _475;
    }
    float4 _508 = float4(((mix(float3(0.0), _372 + (_374 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_453 * _372) * fast::max(float3(1.0), ((((((_281 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_281 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_281 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _501) * 1.0, 0.0);
    float4 _515;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _514 = _508;
        _514.w = 0.0;
        _515 = _514;
    }
    else
    {
        _515 = _508;
    }
    float2 _519 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _527 = (_282 * 0.5) + float3(0.5);
    float4 _529 = float4(_527.x, _527.y, _527.z, float4(0.0).w);
    _529.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _530 = float4(0.0);
    _530.x = _280;
    float4 _531 = _530;
    _531.y = _279;
    float4 _532 = _531;
    _532.z = _278;
    float4 _533 = _532;
    _533.w = 0.50588238239288330078125;
    float4 _545 = float4(_281.x, _281.y, _281.z, float4(0.0).w);
    _545.w = ((log2(((dot(_453, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_376 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_376 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_376 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_519.xyx * _519.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _515 * View.View_PreExposure;
    out.out_var_SV_Target1 = _529;
    out.out_var_SV_Target2 = _533;
    out.out_var_SV_Target3 = _545;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_343, 1.0, 1.0, 1.0);
    return out;
}

