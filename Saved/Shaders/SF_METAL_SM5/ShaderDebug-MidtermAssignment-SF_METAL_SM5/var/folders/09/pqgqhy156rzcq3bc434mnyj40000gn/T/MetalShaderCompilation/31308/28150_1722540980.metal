

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
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float4 _196 = {};
constant float3 _197 = {};
constant float _213 = {};
constant float4 _214 = {};

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

fragment MainPS_out Main_00006df6_66abe3b4(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _260 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _271 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _213, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _276 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _280 = _276.xyz / float3(_276.w);
    float3 _281 = _280 - View.View_PreViewTranslation;
    float4 _289 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _292 = (_289.xy * float2(2.0)) - float2(1.0);
    float2 _301 = (normalize(-_280) * _260).xy;
    float2 _303 = (_301 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _305 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _303, bias(View.View_MaterialTextureMipBias));
    float2 _308 = (_305.xy * float2(2.0)) - float2(1.0);
    float2 _317 = (_301 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _319 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _317, bias(View.View_MaterialTextureMipBias));
    float2 _322 = (_319.xy * float2(2.0)) - float2(1.0);
    float2 _331 = (_301 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _333 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _331, bias(View.View_MaterialTextureMipBias));
    float2 _336 = (_333.xy * float2(2.0)) - float2(1.0);
    float2 _345 = (_301 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _347 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _345, bias(View.View_MaterialTextureMipBias));
    float2 _350 = (_347.xy * float2(2.0)) - float2(1.0);
    float2 _359 = (_301 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _361 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _359, bias(View.View_MaterialTextureMipBias));
    float2 _364 = (_361.xy * float2(2.0)) - float2(1.0);
    float2 _373 = (_301 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _375 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _373, bias(View.View_MaterialTextureMipBias));
    float2 _378 = (_375.xy * float2(2.0)) - float2(1.0);
    float2 _387 = (_301 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _389 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _387, bias(View.View_MaterialTextureMipBias));
    float2 _392 = (_389.xy * float2(2.0)) - float2(1.0);
    float2 _401 = (_301 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _403 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _401, bias(View.View_MaterialTextureMipBias));
    float2 _406 = (_403.xy * float2(2.0)) - float2(1.0);
    float2 _415 = (_301 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _417 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _415, bias(View.View_MaterialTextureMipBias));
    float2 _420 = (_417.xy * float2(2.0)) - float2(1.0);
    float2 _429 = (_301 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _431 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _429, bias(View.View_MaterialTextureMipBias));
    float2 _434 = (_431.xy * float2(2.0)) - float2(1.0);
    float2 _443 = (_301 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _445 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _443, bias(View.View_MaterialTextureMipBias));
    float2 _448 = (_445.xy * float2(2.0)) - float2(1.0);
    float4 _459 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _462 = _459.x;
    float3 _463 = float3(_462);
    float4 _466 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _468 = _466.x;
    float3 _469 = float3(_468);
    float4 _472 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _474 = _472.x;
    float3 _475 = float3(_474);
    float4 _478 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _480 = _478.x;
    float3 _481 = float3(_480);
    float4 _484 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _486 = _484.x;
    float3 _487 = float3(_486);
    float4 _490 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _492 = _490.x;
    float3 _493 = float3(_492);
    float4 _496 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _498 = _496.x;
    float3 _499 = float3(_498);
    float4 _502 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _504 = _502.x;
    float3 _505 = float3(_504);
    float4 _508 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _510 = _508.x;
    float3 _511 = float3(_510);
    float4 _514 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _516 = _514.x;
    float3 _517 = float3(_516);
    float4 _520 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _522 = _520.x;
    float3 _523 = float3(_522);
    float3 _532 = normalize(_260 * normalize((mix(float4(_292, sqrt(fast::clamp(1.0 - dot(_292, _292), 0.0, 1.0)), 1.0).xyz, mix(float4(_308, sqrt(fast::clamp(1.0 - dot(_308, _308), 0.0, 1.0)), 1.0).xyz, mix(float4(_322, sqrt(fast::clamp(1.0 - dot(_322, _322), 0.0, 1.0)), 1.0).xyz, mix(float4(_336, sqrt(fast::clamp(1.0 - dot(_336, _336), 0.0, 1.0)), 1.0).xyz, mix(float4(_350, sqrt(fast::clamp(1.0 - dot(_350, _350), 0.0, 1.0)), 1.0).xyz, mix(float4(_364, sqrt(fast::clamp(1.0 - dot(_364, _364), 0.0, 1.0)), 1.0).xyz, mix(float4(_378, sqrt(fast::clamp(1.0 - dot(_378, _378), 0.0, 1.0)), 1.0).xyz, mix(float4(_392, sqrt(fast::clamp(1.0 - dot(_392, _392), 0.0, 1.0)), 1.0).xyz, mix(float4(_406, sqrt(fast::clamp(1.0 - dot(_406, _406), 0.0, 1.0)), 1.0).xyz, mix(float4(_420, sqrt(fast::clamp(1.0 - dot(_420, _420), 0.0, 1.0)), 1.0).xyz, mix(float4(_434, sqrt(fast::clamp(1.0 - dot(_434, _434), 0.0, 1.0)), 1.0).xyz, float4(_448, sqrt(fast::clamp(1.0 - dot(_448, _448), 0.0, 1.0)), 1.0).xyz, _463), _469), _475), _481), _487), _493), _499), _505), _511), _517), _523) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _543 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _553 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_303 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _563 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_317 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _573 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_331 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _583 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_345 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _589 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_359 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _595 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_373 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _601 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_387 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _607 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_401 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _613 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_415 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _619 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_429 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _625 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_443 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _629 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _443, bias(View.View_MaterialTextureMipBias));
    float4 _633 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _634 = _633.x;
    float3 _660 = fast::clamp(mix(_543.xyz * 1.0, mix((_553.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _516, -0.0), 1.0), mix((_563.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _510, -0.0), 1.0), mix((_573.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _504, -0.0), 1.0), mix(_583.xyz * 0.699999988079071044921875, mix(_589.xyz * 0.60000002384185791015625, mix(_595.xyz * 0.5, mix(_601.xyz * 0.4000000059604644775390625, mix(_607.xyz * 0.300000011920928955078125, mix(_613.xyz * 0.20000000298023223876953125, mix(_619.xyz * 0.1500000059604644775390625, mix(_625.xyz * 0.13799999654293060302734375, _629.xyz * 0.300000011920928955078125, float3(_634)), _463), _469), _475), _481), _487), _493), _499), _505), _511), _517), _523), float3(0.0), float3(1.0));
    float _665 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_634 * _462) * _468) * _474) * _480) * _486) * _492) * _498) * _504) * _510) * _516) * _522), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _666 = in.in_var_PRIMITIVE_ID * 36u;
    uint _667 = _666 + 20u;
    float _715;
    float _716;
    float _717;
    float3 _718;
    float3 _719;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _667)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _685 = ((_271.xy / float2(_271.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _689 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _685, level(0.0));
        float4 _692 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _685, level(0.0));
        float4 _695 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _685, level(0.0));
        float _705 = _695.w;
        _715 = (_665 * _705) + _695.z;
        _716 = (0.4000000059604644775390625 * _705) + _695.y;
        _717 = _695.x;
        _718 = (_660 * _689.w) + _689.xyz;
        _719 = normalize((_532 * _692.w) + ((_692.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _715 = _665;
        _716 = 0.4000000059604644775390625;
        _717 = 0.0;
        _718 = _660;
        _719 = _532;
    }
    bool _729 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _735;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _666 + 18u)].w > 0.0) && _729)
    {
        _735 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _735 = 1.0;
    }
    float _782;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _667)].z > 0.0)
    {
        float3 _750 = fast::clamp((_281 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _761 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_750.x), int(_750.y), int(_750.z), 0).xyz), 0));
        _782 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_761.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_750 / float3(_761.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _782 = _735;
    }
    float3 _796 = ((_718 - (_718 * _717)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _803 = (mix(float3(0.07999999821186065673828125 * _716), _718, float3(_717)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _806 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _811;
    if (_806)
    {
        _811 = _796 + (_803 * 0.449999988079071044921875);
    }
    else
    {
        _811 = _796;
    }
    float3 _813 = select(_803, float3(0.0), bool3(_806));
    float3 _815 = float3(dot(_813, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _901;
    if (_729)
    {
        float4 _851 = _214;
        _851.y = (-0.48860299587249755859375) * _719.y;
        float4 _854 = _851;
        _854.z = 0.48860299587249755859375 * _719.z;
        float4 _857 = _854;
        _857.w = (-0.48860299587249755859375) * _719.x;
        float3 _858 = _719 * _719;
        float4 _861 = _196;
        _861.x = (1.09254801273345947265625 * _719.x) * _719.y;
        float4 _864 = _861;
        _864.y = ((-1.09254801273345947265625) * _719.y) * _719.z;
        float4 _869 = _864;
        _869.z = 0.3153919875621795654296875 * ((3.0 * _858.z) - 1.0);
        float4 _872 = _869;
        _872.w = ((-1.09254801273345947265625) * _719.x) * _719.z;
        float4 _876 = _857;
        _876.x = 0.886227548122406005859375;
        float3 _878 = _876.yzw * 2.094395160675048828125;
        float4 _879 = float4(_876.x, _878.x, _878.y, _878.z);
        float4 _880 = _872 * 0.785398185253143310546875;
        float _881 = (_858.x - _858.y) * 0.4290426075458526611328125;
        float3 _887 = float3(0.0);
        _887.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _879) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _880)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _881);
        float3 _893 = _887;
        _893.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _879) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _880)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _881);
        float3 _899 = _893;
        _899.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _879) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _880)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _881);
        _901 = fast::max(float3(0.0), _899);
    }
    else
    {
        _901 = float3(0.0);
    }
    float _927;
    float _928;
    float3 _929;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _917;
        float _918;
        if (_729)
        {
            _917 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _918 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _917 = _719;
            _918 = 1.0;
        }
        float _919 = 1.0 - _918;
        float _921 = 1.0 - (_919 * _919);
        _927 = mix(fast::clamp(dot(_917, _719), 0.0, 1.0), 1.0, _921);
        _928 = _918;
        _929 = mix(_917, _719, float3(_921));
    }
    else
    {
        _927 = 1.0;
        _928 = 1.0;
        _929 = _719;
    }
    float4 _933 = float4(_929, 1.0);
    float3 _937 = _197;
    _937.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _933);
    float3 _941 = _937;
    _941.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _933);
    float3 _945 = _941;
    _945.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _933);
    float4 _948 = _933.xyzz * _933.yzzx;
    float3 _952 = _197;
    _952.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _948);
    float3 _956 = _952;
    _956.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _948);
    float3 _960 = _956;
    _960.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _948);
    float3 _975 = (_901 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_945 + _960) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_929.x * _929.x) - (_929.y * _929.y)))) * View.View_SkyLightColor.xyz) * (_928 * _927));
    float3 _997 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1026;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1025;
        if (any(abs(_281 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _666 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _666 + 19u)].xyz + float3(1.0))))
        {
            _1025 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_281, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1025 = _997;
        }
        _1026 = _1025;
    }
    else
    {
        _1026 = _997;
    }
    float4 _1033 = float4(((mix(float3(0.0), _811 + (_813 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_975 * _811) * fast::max(float3(1.0), ((((((_718 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_718 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_718 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1026) * 1.0, 0.0);
    float4 _1040;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1039 = _1033;
        _1039.w = 0.0;
        _1040 = _1039;
    }
    else
    {
        _1040 = _1033;
    }
    float2 _1044 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1052 = (_719 * 0.5) + float3(0.5);
    float4 _1054 = float4(_1052.x, _1052.y, _1052.z, float4(0.0).w);
    _1054.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _667)].y;
    float4 _1055 = float4(0.0);
    _1055.x = _717;
    float4 _1056 = _1055;
    _1056.y = _716;
    float4 _1057 = _1056;
    _1057.z = _715;
    float4 _1058 = _1057;
    _1058.w = 0.50588238239288330078125;
    float4 _1070 = float4(_718.x, _718.y, _718.z, float4(0.0).w);
    _1070.w = ((log2(((dot(_975, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_815 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_815 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_815 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1044.xyx * _1044.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1040 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1054;
    out.out_var_SV_Target2 = _1058;
    out.out_var_SV_Target3 = _1070;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_782, 1.0, 1.0, 1.0);
    return out;
}

