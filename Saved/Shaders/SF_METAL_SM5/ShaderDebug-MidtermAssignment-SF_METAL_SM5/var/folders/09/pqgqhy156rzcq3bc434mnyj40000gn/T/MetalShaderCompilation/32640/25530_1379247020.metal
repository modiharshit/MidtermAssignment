

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
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _195 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000063ba_5235a3ac(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], texture2d<float> Material_Texture2D_4 [[texture(8)]], texture2d<float> Material_Texture2D_5 [[texture(9)]], texture2d<float> Material_Texture2D_6 [[texture(10)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _237 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _248 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _195, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _253 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _257 = _253.xyz / float3(_253.w);
    float3 _258 = _257 - View.View_PreViewTranslation;
    float4 _266 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _269 = (_266.xy * float2(2.0)) - float2(1.0);
    float2 _278 = (normalize(-_257) * _237).xy;
    float2 _280 = (_278 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _282 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _280, bias(View.View_MaterialTextureMipBias));
    float2 _285 = (_282.xy * float2(2.0)) - float2(1.0);
    float2 _294 = (_278 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _296 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _294, bias(View.View_MaterialTextureMipBias));
    float2 _299 = (_296.xy * float2(2.0)) - float2(1.0);
    float2 _308 = (_278 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _310 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _308, bias(View.View_MaterialTextureMipBias));
    float2 _313 = (_310.xy * float2(2.0)) - float2(1.0);
    float2 _322 = (_278 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _324 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _322, bias(View.View_MaterialTextureMipBias));
    float2 _327 = (_324.xy * float2(2.0)) - float2(1.0);
    float2 _336 = (_278 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _338 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _336, bias(View.View_MaterialTextureMipBias));
    float2 _341 = (_338.xy * float2(2.0)) - float2(1.0);
    float2 _350 = (_278 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _352 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _350, bias(View.View_MaterialTextureMipBias));
    float2 _355 = (_352.xy * float2(2.0)) - float2(1.0);
    float2 _364 = (_278 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _366 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _364, bias(View.View_MaterialTextureMipBias));
    float2 _369 = (_366.xy * float2(2.0)) - float2(1.0);
    float2 _378 = (_278 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _380 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _378, bias(View.View_MaterialTextureMipBias));
    float2 _383 = (_380.xy * float2(2.0)) - float2(1.0);
    float2 _392 = (_278 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _394 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _392, bias(View.View_MaterialTextureMipBias));
    float2 _397 = (_394.xy * float2(2.0)) - float2(1.0);
    float2 _406 = (_278 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _408 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _406, bias(View.View_MaterialTextureMipBias));
    float2 _411 = (_408.xy * float2(2.0)) - float2(1.0);
    float2 _420 = (_278 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _422 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _420, bias(View.View_MaterialTextureMipBias));
    float2 _425 = (_422.xy * float2(2.0)) - float2(1.0);
    float4 _436 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _406, bias(View.View_MaterialTextureMipBias));
    float4 _443 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_436.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _447 = float3(_443.x);
    float4 _450 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _392, bias(View.View_MaterialTextureMipBias));
    float4 _455 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_450.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _458 = float3(_455.x);
    float4 _461 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _378, bias(View.View_MaterialTextureMipBias));
    float4 _466 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_461.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _469 = float3(_466.x);
    float4 _472 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _364, bias(View.View_MaterialTextureMipBias));
    float4 _477 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_472.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _480 = float3(_477.x);
    float4 _483 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _350, bias(View.View_MaterialTextureMipBias));
    float4 _488 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_483.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _491 = float3(_488.x);
    float4 _494 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _336, bias(View.View_MaterialTextureMipBias));
    float4 _499 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_494.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _502 = float3(_499.x);
    float4 _505 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _322, bias(View.View_MaterialTextureMipBias));
    float4 _510 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_505.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _513 = float3(_510.x);
    float4 _516 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _308, bias(View.View_MaterialTextureMipBias));
    float4 _521 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_516.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _523 = _521.x;
    float3 _524 = float3(_523);
    float4 _527 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _294, bias(View.View_MaterialTextureMipBias));
    float4 _532 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_527.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _534 = _532.x;
    float3 _535 = float3(_534);
    float4 _538 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _280, bias(View.View_MaterialTextureMipBias));
    float4 _543 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_538.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _545 = _543.x;
    float3 _546 = float3(_545);
    float4 _551 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _552 = _551.w;
    float4 _556 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_552 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _559 = float3(_556.x);
    float3 _568 = normalize(_237 * normalize((mix(float4(_269, sqrt(fast::clamp(1.0 - dot(_269, _269), 0.0, 1.0)), 1.0).xyz, mix(float4(_285, sqrt(fast::clamp(1.0 - dot(_285, _285), 0.0, 1.0)), 1.0).xyz, mix(float4(_299, sqrt(fast::clamp(1.0 - dot(_299, _299), 0.0, 1.0)), 1.0).xyz, mix(float4(_313, sqrt(fast::clamp(1.0 - dot(_313, _313), 0.0, 1.0)), 1.0).xyz, mix(float4(_327, sqrt(fast::clamp(1.0 - dot(_327, _327), 0.0, 1.0)), 1.0).xyz, mix(float4(_341, sqrt(fast::clamp(1.0 - dot(_341, _341), 0.0, 1.0)), 1.0).xyz, mix(float4(_355, sqrt(fast::clamp(1.0 - dot(_355, _355), 0.0, 1.0)), 1.0).xyz, mix(float4(_369, sqrt(fast::clamp(1.0 - dot(_369, _369), 0.0, 1.0)), 1.0).xyz, mix(float4(_383, sqrt(fast::clamp(1.0 - dot(_383, _383), 0.0, 1.0)), 1.0).xyz, mix(float4(_397, sqrt(fast::clamp(1.0 - dot(_397, _397), 0.0, 1.0)), 1.0).xyz, mix(float4(_411, sqrt(fast::clamp(1.0 - dot(_411, _411), 0.0, 1.0)), 1.0).xyz, float4(_425, sqrt(fast::clamp(1.0 - dot(_425, _425), 0.0, 1.0)), 1.0).xyz, _447), _458), _469), _480), _491), _502), _513), _524), _535), _546), _559) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _580 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _585 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _588 = (_580.x + 0.5) * (_585.x + 0.5);
    float4 _599 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_280 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _609 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_294 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _619 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_308 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _629 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_322 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _635 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_336 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _641 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_350 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _647 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_364 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _653 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_378 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _659 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_392 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _665 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_406 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _671 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_420 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _675 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _420, bias(View.View_MaterialTextureMipBias));
    float4 _679 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _420, bias(View.View_MaterialTextureMipBias));
    float _681 = _679.y;
    float3 _682 = _675.xyz * _681;
    float4 _685 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _420, bias(View.View_MaterialTextureMipBias));
    float4 _690 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_685.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _712 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _721 = fast::clamp(mix(_551.xyz * 1.0, mix((_599.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _545, -0.0), 1.0), mix((_609.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _534, -0.0), 1.0), mix((_619.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _523, -0.0), 1.0), mix(_629.xyz * 0.699999988079071044921875, mix(_635.xyz * 0.60000002384185791015625, mix(_641.xyz * 0.5, mix(_647.xyz * 0.4000000059604644775390625, mix(_653.xyz * 0.300000011920928955078125, mix(_659.xyz * 0.20000000298023223876953125, mix(_665.xyz * 0.1500000059604644775390625, mix(_671.xyz * 0.13799999654293060302734375, _682 * 0.800000011920928955078125, float3(_690.x)), _447), _458), _469), _480), _491), _502), _513), _524), _535), _546), _559) * mix(0.5, 1.0, _588), float3(0.0), float3(1.0));
    float _722 = fast::clamp(mix((_682 * _681) * 3.0, float3(0.4000000059604644775390625), float3(_552)).x, 0.0, 1.0);
    float _723 = fast::clamp(mix(_681, _712.y, _552), 0.0, 1.0);
    float _728 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _588) + mix(_679.x, _712.x, _552)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _729 = in.in_var_PRIMITIVE_ID * 36u;
    uint _730 = _729 + 20u;
    float _778;
    float _779;
    float _780;
    float3 _781;
    float3 _782;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _730)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _748 = ((_248.xy / float2(_248.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _752 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _748, level(0.0));
        float4 _755 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _748, level(0.0));
        float4 _758 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _748, level(0.0));
        float _768 = _758.w;
        _778 = (_728 * _768) + _758.z;
        _779 = (_722 * _768) + _758.y;
        _780 = _758.x;
        _781 = (_721 * _752.w) + _752.xyz;
        _782 = normalize((_568 * _755.w) + ((_755.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _778 = _728;
        _779 = _722;
        _780 = 0.0;
        _781 = _721;
        _782 = _568;
    }
    float3 _797 = ((_781 - (_781 * _780)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _804 = (mix(float3(0.07999999821186065673828125 * _779), _781, float3(_780)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _807 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _812;
    if (_807)
    {
        _812 = _797 + (_804 * 0.449999988079071044921875);
    }
    else
    {
        _812 = _797;
    }
    float3 _814 = select(_804, float3(0.0), bool3(_807));
    float3 _816 = float3(dot(_814, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _823 = float3(_723);
    float2 _832 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _837 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _832);
    float4 _839 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_832 + float2(0.0, 0.5)));
    uint _841 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _851 = (_837.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _841 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _841 + 6u)].xyz;
    float _852 = dot(_851, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _871 = (exp2((_852 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_839 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _841 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _841 + 7u)], float4(_782.yzx, 1.0)));
    float3 _881 = float4(_851 * (_871 / _852), _871).xyz * View.View_IndirectLightingColorScale;
    float3 _903 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _932;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _931;
        if (any(abs(_258 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _729 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _729 + 19u)].xyz + float3(1.0))))
        {
            _931 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_258, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _931 = _903;
        }
        _932 = _931;
    }
    else
    {
        _932 = _903;
    }
    float4 _939 = float4(((mix(float3(0.0), _812 + (_814 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_881 * _812) * fast::max(_823, ((((((_781 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _723) + ((_781 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _723) + ((_781 * 2.755199909210205078125) + float3(0.69029998779296875))) * _723))) + _932) * 1.0, 0.0);
    float4 _946;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _945 = _939;
        _945.w = 0.0;
        _946 = _945;
    }
    else
    {
        _946 = _939;
    }
    float2 _950 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _958 = (_782 * 0.5) + float3(0.5);
    float4 _960 = float4(_958.x, _958.y, _958.z, float4(0.0).w);
    _960.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _730)].y;
    float4 _961 = float4(0.0);
    _961.x = _780;
    float4 _962 = _961;
    _962.y = _779;
    float4 _963 = _962;
    _963.z = _778;
    float4 _964 = _963;
    _964.w = 0.75686275959014892578125;
    float4 _976 = float4(_781.x, _781.y, _781.z, float4(0.0).w);
    _976.w = ((log2(((dot(_881, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_823, ((((((_816 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _723) + ((_816 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _723) + ((_816 * 2.755199909210205078125) + float3(0.69029998779296875))) * _723).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_950.xyx * _950.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _946 * View.View_PreExposure;
    out.out_var_SV_Target1 = _960;
    out.out_var_SV_Target2 = _964;
    out.out_var_SV_Target3 = _976;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

