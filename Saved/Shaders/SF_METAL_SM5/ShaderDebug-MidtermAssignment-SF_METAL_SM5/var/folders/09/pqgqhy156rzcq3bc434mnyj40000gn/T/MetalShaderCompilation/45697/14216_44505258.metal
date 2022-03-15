

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
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveAdd;
    float3 IndirectLightingCache_IndirectLightingCachePrimitiveScale;
    float3 IndirectLightingCache_IndirectLightingCacheMinUV;
    float3 IndirectLightingCache_IndirectLightingCacheMaxUV;
    char _m4_pad[16];
    float IndirectLightingCache_DirectionalLightShadowing;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _140 = {};
constant float4 _141 = {};

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
};

fragment MainPS_out Main_00003788_02a718aa(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _140, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float3 _223 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _232 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _236 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _281;
    float _282;
    float _283;
    float3 _284;
    float3 _285;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _253 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _257 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _253, level(0.0));
        float4 _260 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _253, level(0.0));
        float4 _263 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _253, level(0.0));
        _281 = (_236 * _263.w) + _263.z;
        _282 = _263.y;
        _283 = _263.x;
        _284 = (_232 * _257.w) + _257.xyz;
        _285 = normalize((_223 * _260.w) + ((_260.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _281 = _236;
        _282 = 0.0;
        _283 = 0.0;
        _284 = _232;
        _285 = _223;
    }
    bool _293 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _299;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _293)
    {
        _299 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _299 = 1.0;
    }
    float _346;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _314 = fast::clamp((_209 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _325 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_314.x), int(_314.y), int(_314.z), 0).xyz), 0));
        _346 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_325.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_314 / float3(_325.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _346 = _299;
    }
    float3 _360 = ((_284 - (_284 * _283)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _367 = (mix(float3(0.07999999821186065673828125 * _282), _284, float3(_283)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _370 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _375;
    if (_370)
    {
        _375 = _360 + (_367 * 0.449999988079071044921875);
    }
    else
    {
        _375 = _360;
    }
    float3 _377 = select(_367, float3(0.0), bool3(_370));
    float3 _379 = float3(dot(_377, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _453;
    if (_293)
    {
        float3 _405 = fast::clamp((_209 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _409 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _405);
        float4 _413 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _405);
        float4 _416 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _405);
        float4 _434 = _141;
        _434.y = (-0.48860299587249755859375) * _285.y;
        float4 _437 = _434;
        _437.z = 0.48860299587249755859375 * _285.z;
        float4 _440 = _437;
        _440.w = (-0.48860299587249755859375) * _285.x;
        float4 _441 = _440;
        _441.x = 0.886227548122406005859375;
        float3 _443 = _441.yzw * 2.094395160675048828125;
        float4 _444 = float4(_441.x, _443.x, _443.y, _443.z);
        float3 _446 = float3(0.0);
        _446.x = dot(float4(_409.x, _413.x, _416.x, _409.w), _444);
        float3 _448 = _446;
        _448.y = dot(float4(_409.y, _413.y, _416.y, _413.w), _444);
        float3 _450 = _448;
        _450.z = dot(float4(_409.z, _413.z, _416.zw), _444);
        _453 = fast::max(float3(0.0), _450) * float3(0.3183098733425140380859375);
    }
    else
    {
        _453 = float3(0.0);
    }
    float3 _456 = _453 * View.View_IndirectLightingColorScale;
    float3 _478 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _504;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _503;
        if (any(abs(_209 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _503 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _503 = _478;
        }
        _504 = _503;
    }
    else
    {
        _504 = _478;
    }
    float4 _511 = float4(((mix(float3(0.0), _375 + (_377 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_456 * _375) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _504) * 1.0, 0.0);
    float4 _518;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _517 = _511;
        _517.w = 0.0;
        _518 = _517;
    }
    else
    {
        _518 = _511;
    }
    float2 _522 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _530 = (_285 * 0.5) + float3(0.5);
    float4 _532 = float4(_530.x, _530.y, _530.z, float4(0.0).w);
    _532.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _533 = float4(0.0);
    _533.x = _283;
    float4 _534 = _533;
    _534.y = _282;
    float4 _535 = _534;
    _535.z = _281;
    float4 _536 = _535;
    _536.w = 0.50588238239288330078125;
    float4 _548 = float4(_284.x, _284.y, _284.z, float4(0.0).w);
    _548.w = ((log2(((dot(_456, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_379 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_379 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_379 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_522.xyx * _522.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _518 * View.View_PreExposure;
    out.out_var_SV_Target1 = _532;
    out.out_var_SV_Target2 = _536;
    out.out_var_SV_Target3 = _548;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_346, 1.0, 1.0, 1.0);
    return out;
}

