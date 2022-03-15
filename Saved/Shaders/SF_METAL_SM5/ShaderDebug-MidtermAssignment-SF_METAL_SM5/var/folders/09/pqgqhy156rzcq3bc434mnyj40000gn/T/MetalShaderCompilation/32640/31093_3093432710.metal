

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

constant float3 _213 = {};
constant float _215 = {};
constant float4 _216 = {};

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

fragment MainPS_out Main_00007975_b8620986(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], texture2d<float> Material_Texture2D_4 [[texture(12)]], texture2d<float> Material_Texture2D_5 [[texture(13)]], texture2d<float> Material_Texture2D_6 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], sampler Material_Texture2D_4Sampler [[sampler(7)]], sampler Material_Texture2D_5Sampler [[sampler(8)]], sampler Material_Texture2D_6Sampler [[sampler(9)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _262 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _273 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _215, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _278 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _282 = _278.xyz / float3(_278.w);
    float3 _283 = _282 - View.View_PreViewTranslation;
    float4 _291 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _294 = (_291.xy * float2(2.0)) - float2(1.0);
    float2 _303 = (normalize(-_282) * _262).xy;
    float2 _305 = (_303 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _307 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _305, bias(View.View_MaterialTextureMipBias));
    float2 _310 = (_307.xy * float2(2.0)) - float2(1.0);
    float2 _319 = (_303 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _321 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _319, bias(View.View_MaterialTextureMipBias));
    float2 _324 = (_321.xy * float2(2.0)) - float2(1.0);
    float2 _333 = (_303 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _335 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _333, bias(View.View_MaterialTextureMipBias));
    float2 _338 = (_335.xy * float2(2.0)) - float2(1.0);
    float2 _347 = (_303 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _349 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _347, bias(View.View_MaterialTextureMipBias));
    float2 _352 = (_349.xy * float2(2.0)) - float2(1.0);
    float2 _361 = (_303 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _363 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _361, bias(View.View_MaterialTextureMipBias));
    float2 _366 = (_363.xy * float2(2.0)) - float2(1.0);
    float2 _375 = (_303 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _377 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _375, bias(View.View_MaterialTextureMipBias));
    float2 _380 = (_377.xy * float2(2.0)) - float2(1.0);
    float2 _389 = (_303 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _391 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _389, bias(View.View_MaterialTextureMipBias));
    float2 _394 = (_391.xy * float2(2.0)) - float2(1.0);
    float2 _403 = (_303 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _405 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _403, bias(View.View_MaterialTextureMipBias));
    float2 _408 = (_405.xy * float2(2.0)) - float2(1.0);
    float2 _417 = (_303 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _419 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _417, bias(View.View_MaterialTextureMipBias));
    float2 _422 = (_419.xy * float2(2.0)) - float2(1.0);
    float2 _431 = (_303 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _433 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _431, bias(View.View_MaterialTextureMipBias));
    float2 _436 = (_433.xy * float2(2.0)) - float2(1.0);
    float2 _445 = (_303 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _447 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _445, bias(View.View_MaterialTextureMipBias));
    float2 _450 = (_447.xy * float2(2.0)) - float2(1.0);
    float4 _461 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _431, bias(View.View_MaterialTextureMipBias));
    float4 _468 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_461.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _472 = float3(_468.x);
    float4 _475 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _417, bias(View.View_MaterialTextureMipBias));
    float4 _480 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_475.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _483 = float3(_480.x);
    float4 _486 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _403, bias(View.View_MaterialTextureMipBias));
    float4 _491 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_486.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _494 = float3(_491.x);
    float4 _497 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _389, bias(View.View_MaterialTextureMipBias));
    float4 _502 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_497.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _505 = float3(_502.x);
    float4 _508 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _375, bias(View.View_MaterialTextureMipBias));
    float4 _513 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_508.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _516 = float3(_513.x);
    float4 _519 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _361, bias(View.View_MaterialTextureMipBias));
    float4 _524 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_519.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _527 = float3(_524.x);
    float4 _530 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _347, bias(View.View_MaterialTextureMipBias));
    float4 _535 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_530.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _538 = float3(_535.x);
    float4 _541 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _333, bias(View.View_MaterialTextureMipBias));
    float4 _546 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_541.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _548 = _546.x;
    float3 _549 = float3(_548);
    float4 _552 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _319, bias(View.View_MaterialTextureMipBias));
    float4 _557 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_552.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _559 = _557.x;
    float3 _560 = float3(_559);
    float4 _563 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _305, bias(View.View_MaterialTextureMipBias));
    float4 _568 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_563.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _570 = _568.x;
    float3 _571 = float3(_570);
    float4 _576 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _577 = _576.w;
    float4 _581 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_577 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _584 = float3(_581.x);
    float3 _593 = normalize(_262 * normalize((mix(float4(_294, sqrt(fast::clamp(1.0 - dot(_294, _294), 0.0, 1.0)), 1.0).xyz, mix(float4(_310, sqrt(fast::clamp(1.0 - dot(_310, _310), 0.0, 1.0)), 1.0).xyz, mix(float4(_324, sqrt(fast::clamp(1.0 - dot(_324, _324), 0.0, 1.0)), 1.0).xyz, mix(float4(_338, sqrt(fast::clamp(1.0 - dot(_338, _338), 0.0, 1.0)), 1.0).xyz, mix(float4(_352, sqrt(fast::clamp(1.0 - dot(_352, _352), 0.0, 1.0)), 1.0).xyz, mix(float4(_366, sqrt(fast::clamp(1.0 - dot(_366, _366), 0.0, 1.0)), 1.0).xyz, mix(float4(_380, sqrt(fast::clamp(1.0 - dot(_380, _380), 0.0, 1.0)), 1.0).xyz, mix(float4(_394, sqrt(fast::clamp(1.0 - dot(_394, _394), 0.0, 1.0)), 1.0).xyz, mix(float4(_408, sqrt(fast::clamp(1.0 - dot(_408, _408), 0.0, 1.0)), 1.0).xyz, mix(float4(_422, sqrt(fast::clamp(1.0 - dot(_422, _422), 0.0, 1.0)), 1.0).xyz, mix(float4(_436, sqrt(fast::clamp(1.0 - dot(_436, _436), 0.0, 1.0)), 1.0).xyz, float4(_450, sqrt(fast::clamp(1.0 - dot(_450, _450), 0.0, 1.0)), 1.0).xyz, _472), _483), _494), _505), _516), _527), _538), _549), _560), _571), _584) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _605 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _610 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _613 = (_605.x + 0.5) * (_610.x + 0.5);
    float4 _624 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_305 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _634 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_319 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _644 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_333 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _654 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_347 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _660 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_361 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _666 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_375 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _672 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_389 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _678 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_403 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _684 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_417 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _690 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_431 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _696 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_445 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _700 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _445, bias(View.View_MaterialTextureMipBias));
    float4 _704 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _445, bias(View.View_MaterialTextureMipBias));
    float _706 = _704.y;
    float3 _707 = _700.xyz * _706;
    float4 _710 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _445, bias(View.View_MaterialTextureMipBias));
    float4 _715 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_710.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _737 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _746 = fast::clamp(mix(_576.xyz * 1.0, mix((_624.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _570, -0.0), 1.0), mix((_634.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _559, -0.0), 1.0), mix((_644.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _548, -0.0), 1.0), mix(_654.xyz * 0.699999988079071044921875, mix(_660.xyz * 0.60000002384185791015625, mix(_666.xyz * 0.5, mix(_672.xyz * 0.4000000059604644775390625, mix(_678.xyz * 0.300000011920928955078125, mix(_684.xyz * 0.20000000298023223876953125, mix(_690.xyz * 0.1500000059604644775390625, mix(_696.xyz * 0.13799999654293060302734375, _707 * 0.800000011920928955078125, float3(_715.x)), _472), _483), _494), _505), _516), _527), _538), _549), _560), _571), _584) * mix(0.5, 1.0, _613), float3(0.0), float3(1.0));
    float _747 = fast::clamp(mix((_707 * _706) * 3.0, float3(0.4000000059604644775390625), float3(_577)).x, 0.0, 1.0);
    float _748 = fast::clamp(mix(_706, _737.y, _577), 0.0, 1.0);
    float _753 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _613) + mix(_704.x, _737.x, _577)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _754 = in.in_var_PRIMITIVE_ID * 36u;
    uint _755 = _754 + 20u;
    float _803;
    float _804;
    float _805;
    float3 _806;
    float3 _807;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _755)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _773 = ((_273.xy / float2(_273.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _777 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _773, level(0.0));
        float4 _780 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _773, level(0.0));
        float4 _783 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _773, level(0.0));
        float _793 = _783.w;
        _803 = (_753 * _793) + _783.z;
        _804 = (_747 * _793) + _783.y;
        _805 = _783.x;
        _806 = (_746 * _777.w) + _777.xyz;
        _807 = normalize((_593 * _780.w) + ((_780.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _803 = _753;
        _804 = _747;
        _805 = 0.0;
        _806 = _746;
        _807 = _593;
    }
    bool _817 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _823;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _754 + 18u)].w > 0.0) && _817)
    {
        _823 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _823 = 1.0;
    }
    float _870;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _755)].z > 0.0)
    {
        float3 _838 = fast::clamp((_283 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _849 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_838.x), int(_838.y), int(_838.z), 0).xyz), 0));
        _870 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_849.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_838 / float3(_849.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _870 = _823;
    }
    float3 _884 = ((_806 - (_806 * _805)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _891 = (mix(float3(0.07999999821186065673828125 * _804), _806, float3(_805)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _894 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _899;
    if (_894)
    {
        _899 = _884 + (_891 * 0.449999988079071044921875);
    }
    else
    {
        _899 = _884;
    }
    float3 _901 = select(_891, float3(0.0), bool3(_894));
    float3 _903 = float3(dot(_901, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _910 = float3(_748);
    float3 _978;
    if (_817)
    {
        float3 _930 = fast::clamp((_283 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _934 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _930);
        float4 _938 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _930);
        float4 _941 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _930);
        float4 _959 = _216;
        _959.y = (-0.48860299587249755859375) * _807.y;
        float4 _962 = _959;
        _962.z = 0.48860299587249755859375 * _807.z;
        float4 _965 = _962;
        _965.w = (-0.48860299587249755859375) * _807.x;
        float4 _966 = _965;
        _966.x = 0.886227548122406005859375;
        float3 _968 = _966.yzw * 2.094395160675048828125;
        float4 _969 = float4(_966.x, _968.x, _968.y, _968.z);
        float3 _971 = float3(0.0);
        _971.x = dot(float4(_934.x, _938.x, _941.x, _934.w), _969);
        float3 _973 = _971;
        _973.y = dot(float4(_934.y, _938.y, _941.y, _938.w), _969);
        float3 _975 = _973;
        _975.z = dot(float4(_934.z, _938.z, _941.zw), _969);
        _978 = fast::max(float3(0.0), _975) * float3(0.3183098733425140380859375);
    }
    else
    {
        _978 = float3(0.0);
    }
    float _1004;
    float _1005;
    float3 _1006;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _994;
        float _995;
        if (_817)
        {
            _994 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _995 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _994 = _807;
            _995 = 1.0;
        }
        float _996 = 1.0 - _995;
        float _998 = 1.0 - (_996 * _996);
        _1004 = mix(fast::clamp(dot(_994, _807), 0.0, 1.0), 1.0, _998);
        _1005 = _995;
        _1006 = mix(_994, _807, float3(_998));
    }
    else
    {
        _1004 = 1.0;
        _1005 = 1.0;
        _1006 = _807;
    }
    float4 _1010 = float4(_1006, 1.0);
    float3 _1014 = _213;
    _1014.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _1010);
    float3 _1018 = _1014;
    _1018.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _1010);
    float3 _1022 = _1018;
    _1022.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _1010);
    float4 _1025 = _1010.xyzz * _1010.yzzx;
    float3 _1029 = _213;
    _1029.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _1025);
    float3 _1033 = _1029;
    _1033.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _1025);
    float3 _1037 = _1033;
    _1037.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _1025);
    float3 _1052 = (_978 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_1022 + _1037) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_1006.x * _1006.x) - (_1006.y * _1006.y)))) * View.View_SkyLightColor.xyz) * (_1005 * _1004));
    float3 _1074 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1103;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1102;
        if (any(abs(_283 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _754 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _754 + 19u)].xyz + float3(1.0))))
        {
            _1102 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_283, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1102 = _1074;
        }
        _1103 = _1102;
    }
    else
    {
        _1103 = _1074;
    }
    float4 _1110 = float4(((mix(float3(0.0), _899 + (_901 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_1052 * _899) * fast::max(_910, ((((((_806 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _748) + ((_806 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _748) + ((_806 * 2.755199909210205078125) + float3(0.69029998779296875))) * _748))) + _1103) * 1.0, 0.0);
    float4 _1117;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1116 = _1110;
        _1116.w = 0.0;
        _1117 = _1116;
    }
    else
    {
        _1117 = _1110;
    }
    float2 _1121 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1129 = (_807 * 0.5) + float3(0.5);
    float4 _1131 = float4(_1129.x, _1129.y, _1129.z, float4(0.0).w);
    _1131.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _755)].y;
    float4 _1132 = float4(0.0);
    _1132.x = _805;
    float4 _1133 = _1132;
    _1133.y = _804;
    float4 _1134 = _1133;
    _1134.z = _803;
    float4 _1135 = _1134;
    _1135.w = 0.50588238239288330078125;
    float4 _1147 = float4(_806.x, _806.y, _806.z, float4(0.0).w);
    _1147.w = ((log2(((dot(_1052, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_910, ((((((_903 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _748) + ((_903 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _748) + ((_903 * 2.755199909210205078125) + float3(0.69029998779296875))) * _748).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1121.xyx * _1121.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1117 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1131;
    out.out_var_SV_Target2 = _1135;
    out.out_var_SV_Target3 = _1147;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_870, 1.0, 1.0, 1.0);
    return out;
}

