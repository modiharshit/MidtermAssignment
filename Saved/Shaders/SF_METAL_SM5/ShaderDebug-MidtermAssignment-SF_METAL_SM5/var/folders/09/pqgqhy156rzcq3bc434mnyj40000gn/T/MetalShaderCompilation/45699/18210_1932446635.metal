

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
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
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    char _m1_pad[16];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _161 = {};
constant float _163 = {};
constant float4 _164 = {};
constant float3 _165 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

fragment MainPS_out Main_00004722_732ecbab(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_3 [[texture(10)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float3x3 _219 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _163, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = (_236.xyz / float3(_236.w)) - View.View_PreViewTranslation;
    float3 _246 = (Primitive.Primitive_LocalToWorld * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _258 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _261 = (float3(-0.5) + _258.xyz) * 2.0;
    float3 _277 = ((((_246 / float3(sqrt(dot(_246, _246)))) * _219) * (-1.0)) * _261.z) + (float3(_261.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _219));
    float3 _289 = normalize(_219 * normalize(((_277 / float3(sqrt(dot(_277, _277)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _300 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _307 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _323 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _323) : (in.in_var_COLOR1.w < _323)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((_300.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _338 = fast::clamp(_300.xyz, float3(0.0), float3(1.0));
    float _343 = (fast::clamp(_258.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _353 = (fast::clamp(float4(_307.xyz, _161).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _401;
    float _402;
    float _403;
    float _404;
    float3 _405;
    float3 _406;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _370 = ((_231.xy / float2(_231.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _374 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _377 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _380 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float _382 = _374.w;
        float _390 = _380.w;
        _401 = _353 * _382;
        _402 = (_343 * _390) + _380.z;
        _403 = (0.5 * _390) + _380.y;
        _404 = _380.x;
        _405 = (_338 * _382) + _374.xyz;
        _406 = normalize((_289 * _377.w) + ((_377.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _401 = _353;
        _402 = _343;
        _403 = 0.5;
        _404 = 0.0;
        _405 = _338;
        _406 = _289;
    }
    bool _414 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _420;
    if ((Primitive.Primitive_UseSingleSampleShadowFromStationaryLights > 0.0) && _414)
    {
        _420 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _420 = 1.0;
    }
    float _467;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        float3 _435 = fast::clamp((_241 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _446 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_435.x), int(_435.y), int(_435.z), 0).xyz), 0));
        _467 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_446.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_435 / float3(_446.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _467 = _420;
    }
    float3 _470 = sqrt(fast::clamp(_401, float3(0.0), float3(1.0)));
    float4 _472 = float4(_470.x, _470.y, _470.z, float4(0.0).w);
    _472.w = 1.0;
    float3 _477 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _478 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _496 = ((_405 - (_405 * _404)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _503 = (mix(float3(0.07999999821186065673828125 * _403), _405, float3(_404)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _506 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _511;
    if (_506)
    {
        _511 = _496 + (_503 * 0.449999988079071044921875);
    }
    else
    {
        _511 = _496;
    }
    float3 _513 = select(_503, float3(0.0), bool3(_506));
    float3 _515 = float3(dot(_513, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _611;
    float3 _612;
    if (_414)
    {
        float3 _541 = fast::clamp((_241 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _545 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _541);
        float4 _549 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _541);
        float4 _552 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _541);
        float4 _557 = float4(_545.x, _549.x, _552.x, _545.w);
        float4 _562 = float4(_545.y, _549.y, _552.y, _549.w);
        float4 _567 = float4(_545.z, _549.z, _552.zw);
        float4 _570 = _164;
        _570.y = (-0.48860299587249755859375) * _406.y;
        float4 _573 = _570;
        _573.z = 0.48860299587249755859375 * _406.z;
        float4 _576 = _573;
        _576.w = (-0.48860299587249755859375) * _406.x;
        float4 _577 = _576;
        _577.x = 0.886227548122406005859375;
        float3 _579 = _577.yzw * 2.094395160675048828125;
        float4 _580 = float4(_577.x, _579.x, _579.y, _579.z);
        float3 _582 = float3(0.0);
        _582.x = dot(_557, _580);
        float3 _584 = _582;
        _584.y = dot(_562, _580);
        float3 _586 = _584;
        _586.z = dot(_567, _580);
        float3 _589 = -_406;
        float4 _592 = _164;
        _592.y = (-0.48860299587249755859375) * _589.y;
        float4 _595 = _592;
        _595.z = 0.48860299587249755859375 * _589.z;
        float4 _598 = _595;
        _598.w = (-0.48860299587249755859375) * _589.x;
        float4 _599 = _598;
        _599.x = 0.886227548122406005859375;
        float3 _601 = _599.yzw * 2.094395160675048828125;
        float4 _602 = float4(_599.x, _601.x, _601.y, _601.z);
        float3 _604 = _165;
        _604.x = dot(_557, _602);
        float3 _606 = _604;
        _606.y = dot(_562, _602);
        float3 _608 = _606;
        _608.z = dot(_567, _602);
        _611 = fast::max(float3(0.0), _608) * float3(0.3183098733425140380859375);
        _612 = fast::max(float3(0.0), _586) * float3(0.3183098733425140380859375);
    }
    else
    {
        _611 = float3(0.0);
        _612 = float3(0.0);
    }
    float3 _615 = _612 * View.View_IndirectLightingColorScale;
    float3 _640 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _666;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _665;
        if (any(abs(_241 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _665 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _665 = _640;
        }
        _666 = _665;
    }
    else
    {
        _666 = _640;
    }
    float4 _673 = float4(((mix(float3(0.0), _511 + (_513 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_615 * _511) + ((_611 * View.View_IndirectLightingColorScale) * _401)) * fast::max(float3(1.0), ((((((_405 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_405 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_405 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _666) * 1.0, 0.0);
    float4 _680;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _679 = _673;
        _679.w = 0.0;
        _680 = _679;
    }
    else
    {
        _680 = _673;
    }
    float2 _684 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _692 = (_406 * 0.5) + float3(0.5);
    float4 _694 = float4(_692.x, _692.y, _692.z, float4(0.0).w);
    _694.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _695 = float4(0.0);
    _695.x = _404;
    float4 _696 = _695;
    _696.y = _403;
    float4 _697 = _696;
    _697.z = fast::max(_402, fast::clamp((pow(fast::max(dot(_477, _477), dot(_478, _478)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _698 = _697;
    _698.w = 0.525490224361419677734375;
    float4 _710 = float4(_405.x, _405.y, _405.z, float4(0.0).w);
    _710.w = ((log2(((dot(_615, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_515 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_515 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_515 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_684.xyx * _684.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _680 * View.View_PreExposure;
    out.out_var_SV_Target1 = _694;
    out.out_var_SV_Target2 = _698;
    out.out_var_SV_Target3 = _710;
    out.out_var_SV_Target4 = _472;
    out.out_var_SV_Target5 = float4(_467, 1.0, 1.0, 1.0);
    return out;
}

