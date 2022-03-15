

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
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

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _194 = {};
constant float _210 = {};
constant float4 _211 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00006467_bb15036e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _254 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _265 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _210, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _270 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _274 = _270.xyz / float3(_270.w);
    float3 _275 = _274 - View.View_PreViewTranslation;
    float4 _283 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _286 = (_283.xy * float2(2.0)) - float2(1.0);
    float2 _295 = (normalize(-_274) * _254).xy;
    float2 _297 = (_295 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _297, bias(View.View_MaterialTextureMipBias));
    float2 _302 = (_299.xy * float2(2.0)) - float2(1.0);
    float2 _311 = (_295 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _313 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _311, bias(View.View_MaterialTextureMipBias));
    float2 _316 = (_313.xy * float2(2.0)) - float2(1.0);
    float2 _325 = (_295 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _327 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _325, bias(View.View_MaterialTextureMipBias));
    float2 _330 = (_327.xy * float2(2.0)) - float2(1.0);
    float2 _339 = (_295 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _341 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _339, bias(View.View_MaterialTextureMipBias));
    float2 _344 = (_341.xy * float2(2.0)) - float2(1.0);
    float2 _353 = (_295 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _355 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _353, bias(View.View_MaterialTextureMipBias));
    float2 _358 = (_355.xy * float2(2.0)) - float2(1.0);
    float2 _367 = (_295 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _369 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _367, bias(View.View_MaterialTextureMipBias));
    float2 _372 = (_369.xy * float2(2.0)) - float2(1.0);
    float2 _381 = (_295 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _383 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _381, bias(View.View_MaterialTextureMipBias));
    float2 _386 = (_383.xy * float2(2.0)) - float2(1.0);
    float2 _395 = (_295 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _397 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _395, bias(View.View_MaterialTextureMipBias));
    float2 _400 = (_397.xy * float2(2.0)) - float2(1.0);
    float2 _409 = (_295 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _411 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _409, bias(View.View_MaterialTextureMipBias));
    float2 _414 = (_411.xy * float2(2.0)) - float2(1.0);
    float2 _423 = (_295 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _425 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _423, bias(View.View_MaterialTextureMipBias));
    float2 _428 = (_425.xy * float2(2.0)) - float2(1.0);
    float2 _437 = (_295 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _439 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _437, bias(View.View_MaterialTextureMipBias));
    float2 _442 = (_439.xy * float2(2.0)) - float2(1.0);
    float4 _453 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _456 = _453.x;
    float3 _457 = float3(_456);
    float4 _460 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _462 = _460.x;
    float3 _463 = float3(_462);
    float4 _466 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _468 = _466.x;
    float3 _469 = float3(_468);
    float4 _472 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _474 = _472.x;
    float3 _475 = float3(_474);
    float4 _478 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _480 = _478.x;
    float3 _481 = float3(_480);
    float4 _484 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _486 = _484.x;
    float3 _487 = float3(_486);
    float4 _490 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _492 = _490.x;
    float3 _493 = float3(_492);
    float4 _496 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _498 = _496.x;
    float3 _499 = float3(_498);
    float4 _502 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _504 = _502.x;
    float3 _505 = float3(_504);
    float4 _508 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _510 = _508.x;
    float3 _511 = float3(_510);
    float4 _514 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _516 = _514.x;
    float3 _517 = float3(_516);
    float3 _526 = normalize(_254 * normalize((mix(float4(_286, sqrt(fast::clamp(1.0 - dot(_286, _286), 0.0, 1.0)), 1.0).xyz, mix(float4(_302, sqrt(fast::clamp(1.0 - dot(_302, _302), 0.0, 1.0)), 1.0).xyz, mix(float4(_316, sqrt(fast::clamp(1.0 - dot(_316, _316), 0.0, 1.0)), 1.0).xyz, mix(float4(_330, sqrt(fast::clamp(1.0 - dot(_330, _330), 0.0, 1.0)), 1.0).xyz, mix(float4(_344, sqrt(fast::clamp(1.0 - dot(_344, _344), 0.0, 1.0)), 1.0).xyz, mix(float4(_358, sqrt(fast::clamp(1.0 - dot(_358, _358), 0.0, 1.0)), 1.0).xyz, mix(float4(_372, sqrt(fast::clamp(1.0 - dot(_372, _372), 0.0, 1.0)), 1.0).xyz, mix(float4(_386, sqrt(fast::clamp(1.0 - dot(_386, _386), 0.0, 1.0)), 1.0).xyz, mix(float4(_400, sqrt(fast::clamp(1.0 - dot(_400, _400), 0.0, 1.0)), 1.0).xyz, mix(float4(_414, sqrt(fast::clamp(1.0 - dot(_414, _414), 0.0, 1.0)), 1.0).xyz, mix(float4(_428, sqrt(fast::clamp(1.0 - dot(_428, _428), 0.0, 1.0)), 1.0).xyz, float4(_442, sqrt(fast::clamp(1.0 - dot(_442, _442), 0.0, 1.0)), 1.0).xyz, _457), _463), _469), _475), _481), _487), _493), _499), _505), _511), _517) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _537 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _547 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_297 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _557 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_311 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _567 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_325 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _577 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_339 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _583 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_353 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _589 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_367 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _595 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_381 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _601 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_395 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _607 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_409 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _613 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_423 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _619 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_437 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _623 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _437, bias(View.View_MaterialTextureMipBias));
    float4 _627 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _628 = _627.x;
    float3 _654 = fast::clamp(mix(_537.xyz * 1.0, mix((_547.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _510, -0.0), 1.0), mix((_557.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _504, -0.0), 1.0), mix((_567.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _498, -0.0), 1.0), mix(_577.xyz * 0.699999988079071044921875, mix(_583.xyz * 0.60000002384185791015625, mix(_589.xyz * 0.5, mix(_595.xyz * 0.4000000059604644775390625, mix(_601.xyz * 0.300000011920928955078125, mix(_607.xyz * 0.20000000298023223876953125, mix(_613.xyz * 0.1500000059604644775390625, mix(_619.xyz * 0.13799999654293060302734375, _623.xyz * 0.300000011920928955078125, float3(_628)), _457), _463), _469), _475), _481), _487), _493), _499), _505), _511), _517), float3(0.0), float3(1.0));
    float _659 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_628 * _456) * _462) * _468) * _474) * _480) * _486) * _492) * _498) * _504) * _510) * _516), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _660 = in.in_var_PRIMITIVE_ID * 36u;
    uint _661 = _660 + 20u;
    float _709;
    float _710;
    float _711;
    float3 _712;
    float3 _713;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _661)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _679 = ((_265.xy / float2(_265.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _683 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _679, level(0.0));
        float4 _686 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _679, level(0.0));
        float4 _689 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _679, level(0.0));
        float _699 = _689.w;
        _709 = (_659 * _699) + _689.z;
        _710 = (0.4000000059604644775390625 * _699) + _689.y;
        _711 = _689.x;
        _712 = (_654 * _683.w) + _683.xyz;
        _713 = normalize((_526 * _686.w) + ((_686.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _709 = _659;
        _710 = 0.4000000059604644775390625;
        _711 = 0.0;
        _712 = _654;
        _713 = _526;
    }
    bool _723 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _729;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _660 + 18u)].w > 0.0) && _723)
    {
        _729 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _729 = 1.0;
    }
    float _776;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _661)].z > 0.0)
    {
        float3 _744 = fast::clamp((_275 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _755 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_744.x), int(_744.y), int(_744.z), 0).xyz), 0));
        _776 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_755.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_744 / float3(_755.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _776 = _729;
    }
    float3 _790 = ((_712 - (_712 * _711)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _797 = (mix(float3(0.07999999821186065673828125 * _710), _712, float3(_711)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _800 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _805;
    if (_800)
    {
        _805 = _790 + (_797 * 0.449999988079071044921875);
    }
    else
    {
        _805 = _790;
    }
    float3 _807 = select(_797, float3(0.0), bool3(_800));
    float3 _809 = float3(dot(_807, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _895;
    if (_723)
    {
        float4 _845 = _211;
        _845.y = (-0.48860299587249755859375) * _713.y;
        float4 _848 = _845;
        _848.z = 0.48860299587249755859375 * _713.z;
        float4 _851 = _848;
        _851.w = (-0.48860299587249755859375) * _713.x;
        float3 _852 = _713 * _713;
        float4 _855 = _194;
        _855.x = (1.09254801273345947265625 * _713.x) * _713.y;
        float4 _858 = _855;
        _858.y = ((-1.09254801273345947265625) * _713.y) * _713.z;
        float4 _863 = _858;
        _863.z = 0.3153919875621795654296875 * ((3.0 * _852.z) - 1.0);
        float4 _866 = _863;
        _866.w = ((-1.09254801273345947265625) * _713.x) * _713.z;
        float4 _870 = _851;
        _870.x = 0.886227548122406005859375;
        float3 _872 = _870.yzw * 2.094395160675048828125;
        float4 _873 = float4(_870.x, _872.x, _872.y, _872.z);
        float4 _874 = _866 * 0.785398185253143310546875;
        float _875 = (_852.x - _852.y) * 0.4290426075458526611328125;
        float3 _881 = float3(0.0);
        _881.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _873) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _874)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _875);
        float3 _887 = _881;
        _887.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _873) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _874)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _875);
        float3 _893 = _887;
        _893.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _873) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _874)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _875);
        _895 = fast::max(float3(0.0), _893);
    }
    else
    {
        _895 = float3(0.0);
    }
    float3 _898 = _895 * View.View_IndirectLightingColorScale;
    float3 _920 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _949;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _948;
        if (any(abs(_275 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _660 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _660 + 19u)].xyz + float3(1.0))))
        {
            _948 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_275, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _948 = _920;
        }
        _949 = _948;
    }
    else
    {
        _949 = _920;
    }
    float4 _956 = float4(((mix(float3(0.0), _805 + (_807 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_898 * _805) * fast::max(float3(1.0), ((((((_712 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_712 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_712 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _949) * 1.0, 0.0);
    float4 _963;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _962 = _956;
        _962.w = 0.0;
        _963 = _962;
    }
    else
    {
        _963 = _956;
    }
    float2 _967 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _975 = (_713 * 0.5) + float3(0.5);
    float4 _977 = float4(_975.x, _975.y, _975.z, float4(0.0).w);
    _977.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _661)].y;
    float4 _978 = float4(0.0);
    _978.x = _711;
    float4 _979 = _978;
    _979.y = _710;
    float4 _980 = _979;
    _980.z = _709;
    float4 _981 = _980;
    _981.w = 0.50588238239288330078125;
    float4 _993 = float4(_712.x, _712.y, _712.z, float4(0.0).w);
    _993.w = ((log2(((dot(_898, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_809 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_809 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_809 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_967.xyx * _967.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _963 * View.View_PreExposure;
    out.out_var_SV_Target1 = _977;
    out.out_var_SV_Target2 = _981;
    out.out_var_SV_Target3 = _993;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_776, 1.0, 1.0, 1.0);
    return out;
}

