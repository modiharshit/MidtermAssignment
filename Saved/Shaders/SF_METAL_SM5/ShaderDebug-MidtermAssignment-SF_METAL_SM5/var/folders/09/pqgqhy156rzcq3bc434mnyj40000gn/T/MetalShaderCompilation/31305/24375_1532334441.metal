

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
    char _m13_pad[612];
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

constant float _182 = {};

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

fragment MainPS_out Main_00005f37_5b559169(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], texture2d<float> Material_Texture2D_5 [[texture(10)]], texture2d<float> Material_Texture2D_6 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _226 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _182, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = _242.xyz / float3(_242.w);
    float3 _247 = _246 - View.View_PreViewTranslation;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float2 _267 = (normalize(-_246) * _226).xy;
    float2 _269 = (_267 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _271 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _269, bias(View.View_MaterialTextureMipBias));
    float2 _274 = (_271.xy * float2(2.0)) - float2(1.0);
    float2 _283 = (_267 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _285 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _283, bias(View.View_MaterialTextureMipBias));
    float2 _288 = (_285.xy * float2(2.0)) - float2(1.0);
    float2 _297 = (_267 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _297, bias(View.View_MaterialTextureMipBias));
    float2 _302 = (_299.xy * float2(2.0)) - float2(1.0);
    float2 _311 = (_267 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _313 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _311, bias(View.View_MaterialTextureMipBias));
    float2 _316 = (_313.xy * float2(2.0)) - float2(1.0);
    float2 _325 = (_267 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _327 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _325, bias(View.View_MaterialTextureMipBias));
    float2 _330 = (_327.xy * float2(2.0)) - float2(1.0);
    float2 _339 = (_267 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _341 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _339, bias(View.View_MaterialTextureMipBias));
    float2 _344 = (_341.xy * float2(2.0)) - float2(1.0);
    float2 _353 = (_267 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _355 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _353, bias(View.View_MaterialTextureMipBias));
    float2 _358 = (_355.xy * float2(2.0)) - float2(1.0);
    float2 _367 = (_267 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _369 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _367, bias(View.View_MaterialTextureMipBias));
    float2 _372 = (_369.xy * float2(2.0)) - float2(1.0);
    float2 _381 = (_267 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _383 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _381, bias(View.View_MaterialTextureMipBias));
    float2 _386 = (_383.xy * float2(2.0)) - float2(1.0);
    float2 _395 = (_267 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _397 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _395, bias(View.View_MaterialTextureMipBias));
    float2 _400 = (_397.xy * float2(2.0)) - float2(1.0);
    float2 _409 = (_267 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _411 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _409, bias(View.View_MaterialTextureMipBias));
    float2 _414 = (_411.xy * float2(2.0)) - float2(1.0);
    float4 _425 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _395, bias(View.View_MaterialTextureMipBias));
    float4 _432 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_425.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _436 = float3(_432.x);
    float4 _439 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _381, bias(View.View_MaterialTextureMipBias));
    float4 _444 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_439.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _447 = float3(_444.x);
    float4 _450 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _367, bias(View.View_MaterialTextureMipBias));
    float4 _455 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_450.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _458 = float3(_455.x);
    float4 _461 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _353, bias(View.View_MaterialTextureMipBias));
    float4 _466 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_461.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _469 = float3(_466.x);
    float4 _472 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _339, bias(View.View_MaterialTextureMipBias));
    float4 _477 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_472.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _480 = float3(_477.x);
    float4 _483 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _325, bias(View.View_MaterialTextureMipBias));
    float4 _488 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_483.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _491 = float3(_488.x);
    float4 _494 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _311, bias(View.View_MaterialTextureMipBias));
    float4 _499 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_494.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _502 = float3(_499.x);
    float4 _505 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _297, bias(View.View_MaterialTextureMipBias));
    float4 _510 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_505.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _512 = _510.x;
    float3 _513 = float3(_512);
    float4 _516 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _283, bias(View.View_MaterialTextureMipBias));
    float4 _521 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_516.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _523 = _521.x;
    float3 _524 = float3(_523);
    float4 _527 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _269, bias(View.View_MaterialTextureMipBias));
    float4 _532 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_527.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _534 = _532.x;
    float3 _535 = float3(_534);
    float4 _540 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _541 = _540.w;
    float4 _545 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_541 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _548 = float3(_545.x);
    float3 _557 = normalize(_226 * normalize((mix(float4(_258, sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)), 1.0).xyz, mix(float4(_274, sqrt(fast::clamp(1.0 - dot(_274, _274), 0.0, 1.0)), 1.0).xyz, mix(float4(_288, sqrt(fast::clamp(1.0 - dot(_288, _288), 0.0, 1.0)), 1.0).xyz, mix(float4(_302, sqrt(fast::clamp(1.0 - dot(_302, _302), 0.0, 1.0)), 1.0).xyz, mix(float4(_316, sqrt(fast::clamp(1.0 - dot(_316, _316), 0.0, 1.0)), 1.0).xyz, mix(float4(_330, sqrt(fast::clamp(1.0 - dot(_330, _330), 0.0, 1.0)), 1.0).xyz, mix(float4(_344, sqrt(fast::clamp(1.0 - dot(_344, _344), 0.0, 1.0)), 1.0).xyz, mix(float4(_358, sqrt(fast::clamp(1.0 - dot(_358, _358), 0.0, 1.0)), 1.0).xyz, mix(float4(_372, sqrt(fast::clamp(1.0 - dot(_372, _372), 0.0, 1.0)), 1.0).xyz, mix(float4(_386, sqrt(fast::clamp(1.0 - dot(_386, _386), 0.0, 1.0)), 1.0).xyz, mix(float4(_400, sqrt(fast::clamp(1.0 - dot(_400, _400), 0.0, 1.0)), 1.0).xyz, float4(_414, sqrt(fast::clamp(1.0 - dot(_414, _414), 0.0, 1.0)), 1.0).xyz, _436), _447), _458), _469), _480), _491), _502), _513), _524), _535), _548) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _569 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _574 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _577 = (_569.x + 0.5) * (_574.x + 0.5);
    float4 _588 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_269 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _598 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_283 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _608 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_297 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _618 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_311 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _624 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_325 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _630 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_339 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _636 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_353 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _642 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_367 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _648 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_381 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _654 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_395 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _660 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_409 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _664 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _409, bias(View.View_MaterialTextureMipBias));
    float4 _668 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _409, bias(View.View_MaterialTextureMipBias));
    float _670 = _668.y;
    float3 _671 = _664.xyz * _670;
    float4 _674 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _409, bias(View.View_MaterialTextureMipBias));
    float4 _679 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_674.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _701 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _708 = fast::clamp(mix(_540.xyz * 1.0, mix((_588.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _534, -0.0), 1.0), mix((_598.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _523, -0.0), 1.0), mix((_608.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _512, -0.0), 1.0), mix(_618.xyz * 0.699999988079071044921875, mix(_624.xyz * 0.60000002384185791015625, mix(_630.xyz * 0.5, mix(_636.xyz * 0.4000000059604644775390625, mix(_642.xyz * 0.300000011920928955078125, mix(_648.xyz * 0.20000000298023223876953125, mix(_654.xyz * 0.1500000059604644775390625, mix(_660.xyz * 0.13799999654293060302734375, _671 * 0.800000011920928955078125, float3(_679.x)), _436), _447), _458), _469), _480), _491), _502), _513), _524), _535), _548) * mix(0.5, 1.0, _577), float3(0.0), float3(1.0));
    float _709 = fast::clamp(mix((_671 * _670) * 3.0, float3(0.4000000059604644775390625), float3(_541)).x, 0.0, 1.0);
    float _714 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _577) + mix(_668.x, _701.x, _541)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _715 = in.in_var_PRIMITIVE_ID * 36u;
    uint _716 = _715 + 20u;
    float _764;
    float _765;
    float _766;
    float3 _767;
    float3 _768;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _716)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _734 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _738 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _734, level(0.0));
        float4 _741 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _734, level(0.0));
        float4 _744 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _734, level(0.0));
        float _754 = _744.w;
        _764 = (_714 * _754) + _744.z;
        _765 = (_709 * _754) + _744.y;
        _766 = _744.x;
        _767 = (_708 * _738.w) + _738.xyz;
        _768 = normalize((_557 * _741.w) + ((_741.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _764 = _714;
        _765 = _709;
        _766 = 0.0;
        _767 = _708;
        _768 = _557;
    }
    float _817;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _716)].z > 0.0)
    {
        float3 _785 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _796 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_785.x), int(_785.y), int(_785.z), 0).xyz), 0));
        _817 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_796.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_785 / float3(_796.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _817 = 1.0;
    }
    float3 _831 = ((_767 - (_767 * _766)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _838 = (mix(float3(0.07999999821186065673828125 * _765), _767, float3(_766)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _841 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _846;
    if (_841)
    {
        _846 = _831 + (_838 * 0.449999988079071044921875);
    }
    else
    {
        _846 = _831;
    }
    float3 _855 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _884;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _883;
        if (any(abs(_247 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _715 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _715 + 19u)].xyz + float3(1.0))))
        {
            _883 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _883 = _855;
        }
        _884 = _883;
    }
    else
    {
        _884 = _855;
    }
    float4 _890 = float4((mix(float3(0.0), _846 + (select(_838, float3(0.0), bool3(_841)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _884) * 1.0, 0.0);
    float4 _897;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _896 = _890;
        _896.w = 0.0;
        _897 = _896;
    }
    else
    {
        _897 = _890;
    }
    float2 _901 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _909 = (_768 * 0.5) + float3(0.5);
    float4 _911 = float4(_909.x, _909.y, _909.z, float4(0.0).w);
    _911.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _716)].y;
    float4 _912 = float4(0.0);
    _912.x = _766;
    float4 _913 = _912;
    _913.y = _765;
    float4 _914 = _913;
    _914.z = _764;
    float4 _915 = _914;
    _915.w = 0.50588238239288330078125;
    float4 _918 = float4(_767.x, _767.y, _767.z, float4(0.0).w);
    _918.w = (fract(dot(_901.xyx * _901.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _897 * View.View_PreExposure;
    out.out_var_SV_Target1 = _911;
    out.out_var_SV_Target2 = _915;
    out.out_var_SV_Target3 = _918;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_817, 1.0, 1.0, 1.0);
    return out;
}

