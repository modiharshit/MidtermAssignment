

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
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _159 = {};
constant float _161 = {};
constant float4 _162 = {};
constant float3 _163 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

fragment MainPS_out Main_00004427_1ccaa456(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _225 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _161, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float4 _247 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _247.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _292 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _292) : (in.in_var_COLOR1.w < _292)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((in.in_var_COLOR0.w * _269.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _307 = fast::clamp(_269.xyz, float3(0.0), float3(1.0));
    float _312 = (fast::clamp(_247.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _322 = (fast::clamp(float4(_276.xyz, _159).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _370;
    float _371;
    float _372;
    float _373;
    float3 _374;
    float3 _375;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _339 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _343 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float _351 = _343.w;
        float _359 = _349.w;
        _370 = _322 * _351;
        _371 = (_312 * _359) + _349.z;
        _372 = (0.5 * _359) + _349.y;
        _373 = _349.x;
        _374 = (_307 * _351) + _343.xyz;
        _375 = normalize((_258 * _346.w) + ((_346.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _370 = _322;
        _371 = _312;
        _372 = 0.5;
        _373 = 0.0;
        _374 = _307;
        _375 = _258;
    }
    bool _383 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _389;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _383)
    {
        _389 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _389 = 1.0;
    }
    float _436;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _404 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _415 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_404.x), int(_404.y), int(_404.z), 0).xyz), 0));
        _436 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_415.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_404 / float3(_415.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _436 = _389;
    }
    float3 _439 = sqrt(fast::clamp(_370, float3(0.0), float3(1.0)));
    float4 _441 = float4(_439.x, _439.y, _439.z, float4(0.0).w);
    _441.w = 1.0;
    float3 _449 = ((_374 - (_374 * _373)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _456 = (mix(float3(0.07999999821186065673828125 * _372), _374, float3(_373)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _459 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _464;
    if (_459)
    {
        _464 = _449 + (_456 * 0.449999988079071044921875);
    }
    else
    {
        _464 = _449;
    }
    float3 _466 = select(_456, float3(0.0), bool3(_459));
    float3 _468 = float3(dot(_466, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _564;
    float3 _565;
    if (_383)
    {
        float3 _494 = fast::clamp((_235 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _498 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _494);
        float4 _502 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _494);
        float4 _505 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _494);
        float4 _510 = float4(_498.x, _502.x, _505.x, _498.w);
        float4 _515 = float4(_498.y, _502.y, _505.y, _502.w);
        float4 _520 = float4(_498.z, _502.z, _505.zw);
        float4 _523 = _162;
        _523.y = (-0.48860299587249755859375) * _375.y;
        float4 _526 = _523;
        _526.z = 0.48860299587249755859375 * _375.z;
        float4 _529 = _526;
        _529.w = (-0.48860299587249755859375) * _375.x;
        float4 _530 = _529;
        _530.x = 0.886227548122406005859375;
        float3 _532 = _530.yzw * 2.094395160675048828125;
        float4 _533 = float4(_530.x, _532.x, _532.y, _532.z);
        float3 _535 = float3(0.0);
        _535.x = dot(_510, _533);
        float3 _537 = _535;
        _537.y = dot(_515, _533);
        float3 _539 = _537;
        _539.z = dot(_520, _533);
        float3 _542 = -_375;
        float4 _545 = _162;
        _545.y = (-0.48860299587249755859375) * _542.y;
        float4 _548 = _545;
        _548.z = 0.48860299587249755859375 * _542.z;
        float4 _551 = _548;
        _551.w = (-0.48860299587249755859375) * _542.x;
        float4 _552 = _551;
        _552.x = 0.886227548122406005859375;
        float3 _554 = _552.yzw * 2.094395160675048828125;
        float4 _555 = float4(_552.x, _554.x, _554.y, _554.z);
        float3 _557 = _163;
        _557.x = dot(_510, _555);
        float3 _559 = _557;
        _559.y = dot(_515, _555);
        float3 _561 = _559;
        _561.z = dot(_520, _555);
        _564 = fast::max(float3(0.0), _561) * float3(0.3183098733425140380859375);
        _565 = fast::max(float3(0.0), _539) * float3(0.3183098733425140380859375);
    }
    else
    {
        _564 = float3(0.0);
        _565 = float3(0.0);
    }
    float3 _568 = _565 * View.View_IndirectLightingColorScale;
    float3 _593 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _619;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _618;
        if (any(abs(_235 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _618 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _618 = _593;
        }
        _619 = _618;
    }
    else
    {
        _619 = _593;
    }
    float4 _626 = float4(((mix(float3(0.0), _464 + (_466 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_568 * _464) + ((_564 * View.View_IndirectLightingColorScale) * _370)) * fast::max(float3(1.0), ((((((_374 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_374 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_374 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _619) * 1.0, 0.0);
    float4 _633;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _632 = _626;
        _632.w = 0.0;
        _633 = _632;
    }
    else
    {
        _633 = _626;
    }
    float2 _637 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _645 = (_375 * 0.5) + float3(0.5);
    float4 _647 = float4(_645.x, _645.y, _645.z, float4(0.0).w);
    _647.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _648 = float4(0.0);
    _648.x = _373;
    float4 _649 = _648;
    _649.y = _372;
    float4 _650 = _649;
    _650.z = _371;
    float4 _651 = _650;
    _651.w = 0.525490224361419677734375;
    float4 _663 = float4(_374.x, _374.y, _374.z, float4(0.0).w);
    _663.w = ((log2(((dot(_568, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_468 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_468 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_468 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_637.xyx * _637.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _633 * View.View_PreExposure;
    out.out_var_SV_Target1 = _647;
    out.out_var_SV_Target2 = _651;
    out.out_var_SV_Target3 = _663;
    out.out_var_SV_Target4 = _441;
    out.out_var_SV_Target5 = float4(_436, 1.0, 1.0, 1.0);
    return out;
}

