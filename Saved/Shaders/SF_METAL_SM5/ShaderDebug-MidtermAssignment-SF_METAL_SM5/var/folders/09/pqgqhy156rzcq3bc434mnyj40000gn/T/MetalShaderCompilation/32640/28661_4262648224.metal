

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

constant float _211 = {};
constant float4 _212 = {};

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

fragment MainPS_out Main_00006ff5_fe12d9a0(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture0 [[texture(5)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture1 [[texture(6)]], texture3d<float> IndirectLightingCache_IndirectLightingCacheTexture2 [[texture(7)]], texture2d<float> Material_Texture2D_0 [[texture(8)]], texture2d<float> Material_Texture2D_1 [[texture(9)]], texture2d<float> Material_Texture2D_2 [[texture(10)]], texture2d<float> Material_Texture2D_3 [[texture(11)]], texture2d<float> Material_Texture2D_4 [[texture(12)]], texture2d<float> Material_Texture2D_5 [[texture(13)]], texture2d<float> Material_Texture2D_6 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler IndirectLightingCache_IndirectLightingCacheTextureSampler0 [[sampler(2)]], sampler Material_Texture2D_0Sampler [[sampler(3)]], sampler Material_Texture2D_1Sampler [[sampler(4)]], sampler Material_Texture2D_2Sampler [[sampler(5)]], sampler Material_Texture2D_3Sampler [[sampler(6)]], sampler Material_Texture2D_4Sampler [[sampler(7)]], sampler Material_Texture2D_5Sampler [[sampler(8)]], sampler Material_Texture2D_6Sampler [[sampler(9)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _256 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _267 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _211, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _272 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _276 = _272.xyz / float3(_272.w);
    float3 _277 = _276 - View.View_PreViewTranslation;
    float4 _285 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _288 = (_285.xy * float2(2.0)) - float2(1.0);
    float2 _297 = (normalize(-_276) * _256).xy;
    float2 _299 = (_297 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _301 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _299, bias(View.View_MaterialTextureMipBias));
    float2 _304 = (_301.xy * float2(2.0)) - float2(1.0);
    float2 _313 = (_297 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _315 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _313, bias(View.View_MaterialTextureMipBias));
    float2 _318 = (_315.xy * float2(2.0)) - float2(1.0);
    float2 _327 = (_297 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _329 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _327, bias(View.View_MaterialTextureMipBias));
    float2 _332 = (_329.xy * float2(2.0)) - float2(1.0);
    float2 _341 = (_297 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _343 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _341, bias(View.View_MaterialTextureMipBias));
    float2 _346 = (_343.xy * float2(2.0)) - float2(1.0);
    float2 _355 = (_297 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _357 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _355, bias(View.View_MaterialTextureMipBias));
    float2 _360 = (_357.xy * float2(2.0)) - float2(1.0);
    float2 _369 = (_297 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _371 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _369, bias(View.View_MaterialTextureMipBias));
    float2 _374 = (_371.xy * float2(2.0)) - float2(1.0);
    float2 _383 = (_297 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _385 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _383, bias(View.View_MaterialTextureMipBias));
    float2 _388 = (_385.xy * float2(2.0)) - float2(1.0);
    float2 _397 = (_297 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _399 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _397, bias(View.View_MaterialTextureMipBias));
    float2 _402 = (_399.xy * float2(2.0)) - float2(1.0);
    float2 _411 = (_297 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _413 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _411, bias(View.View_MaterialTextureMipBias));
    float2 _416 = (_413.xy * float2(2.0)) - float2(1.0);
    float2 _425 = (_297 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _427 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _425, bias(View.View_MaterialTextureMipBias));
    float2 _430 = (_427.xy * float2(2.0)) - float2(1.0);
    float2 _439 = (_297 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _441 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _439, bias(View.View_MaterialTextureMipBias));
    float2 _444 = (_441.xy * float2(2.0)) - float2(1.0);
    float4 _455 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _425, bias(View.View_MaterialTextureMipBias));
    float4 _462 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_455.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _466 = float3(_462.x);
    float4 _469 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _411, bias(View.View_MaterialTextureMipBias));
    float4 _474 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_469.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _477 = float3(_474.x);
    float4 _480 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _397, bias(View.View_MaterialTextureMipBias));
    float4 _485 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_480.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _488 = float3(_485.x);
    float4 _491 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _383, bias(View.View_MaterialTextureMipBias));
    float4 _496 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_491.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _499 = float3(_496.x);
    float4 _502 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _369, bias(View.View_MaterialTextureMipBias));
    float4 _507 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_502.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _510 = float3(_507.x);
    float4 _513 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _355, bias(View.View_MaterialTextureMipBias));
    float4 _518 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_513.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _521 = float3(_518.x);
    float4 _524 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _341, bias(View.View_MaterialTextureMipBias));
    float4 _529 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_524.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _532 = float3(_529.x);
    float4 _535 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _327, bias(View.View_MaterialTextureMipBias));
    float4 _540 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_535.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _542 = _540.x;
    float3 _543 = float3(_542);
    float4 _546 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _313, bias(View.View_MaterialTextureMipBias));
    float4 _551 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_546.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _553 = _551.x;
    float3 _554 = float3(_553);
    float4 _557 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _299, bias(View.View_MaterialTextureMipBias));
    float4 _562 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_557.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _564 = _562.x;
    float3 _565 = float3(_564);
    float4 _570 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _571 = _570.w;
    float4 _575 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_571 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _578 = float3(_575.x);
    float3 _587 = normalize(_256 * normalize((mix(float4(_288, sqrt(fast::clamp(1.0 - dot(_288, _288), 0.0, 1.0)), 1.0).xyz, mix(float4(_304, sqrt(fast::clamp(1.0 - dot(_304, _304), 0.0, 1.0)), 1.0).xyz, mix(float4(_318, sqrt(fast::clamp(1.0 - dot(_318, _318), 0.0, 1.0)), 1.0).xyz, mix(float4(_332, sqrt(fast::clamp(1.0 - dot(_332, _332), 0.0, 1.0)), 1.0).xyz, mix(float4(_346, sqrt(fast::clamp(1.0 - dot(_346, _346), 0.0, 1.0)), 1.0).xyz, mix(float4(_360, sqrt(fast::clamp(1.0 - dot(_360, _360), 0.0, 1.0)), 1.0).xyz, mix(float4(_374, sqrt(fast::clamp(1.0 - dot(_374, _374), 0.0, 1.0)), 1.0).xyz, mix(float4(_388, sqrt(fast::clamp(1.0 - dot(_388, _388), 0.0, 1.0)), 1.0).xyz, mix(float4(_402, sqrt(fast::clamp(1.0 - dot(_402, _402), 0.0, 1.0)), 1.0).xyz, mix(float4(_416, sqrt(fast::clamp(1.0 - dot(_416, _416), 0.0, 1.0)), 1.0).xyz, mix(float4(_430, sqrt(fast::clamp(1.0 - dot(_430, _430), 0.0, 1.0)), 1.0).xyz, float4(_444, sqrt(fast::clamp(1.0 - dot(_444, _444), 0.0, 1.0)), 1.0).xyz, _466), _477), _488), _499), _510), _521), _532), _543), _554), _565), _578) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _599 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _604 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _607 = (_599.x + 0.5) * (_604.x + 0.5);
    float4 _618 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_299 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _628 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_313 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _638 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_327 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _648 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_341 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _654 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_355 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _660 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_369 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _666 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_383 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _672 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_397 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _678 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_411 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _684 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_425 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _690 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_439 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _694 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _439, bias(View.View_MaterialTextureMipBias));
    float4 _698 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _439, bias(View.View_MaterialTextureMipBias));
    float _700 = _698.y;
    float3 _701 = _694.xyz * _700;
    float4 _704 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _439, bias(View.View_MaterialTextureMipBias));
    float4 _709 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_704.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _731 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _740 = fast::clamp(mix(_570.xyz * 1.0, mix((_618.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _564, -0.0), 1.0), mix((_628.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _553, -0.0), 1.0), mix((_638.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _542, -0.0), 1.0), mix(_648.xyz * 0.699999988079071044921875, mix(_654.xyz * 0.60000002384185791015625, mix(_660.xyz * 0.5, mix(_666.xyz * 0.4000000059604644775390625, mix(_672.xyz * 0.300000011920928955078125, mix(_678.xyz * 0.20000000298023223876953125, mix(_684.xyz * 0.1500000059604644775390625, mix(_690.xyz * 0.13799999654293060302734375, _701 * 0.800000011920928955078125, float3(_709.x)), _466), _477), _488), _499), _510), _521), _532), _543), _554), _565), _578) * mix(0.5, 1.0, _607), float3(0.0), float3(1.0));
    float _741 = fast::clamp(mix((_701 * _700) * 3.0, float3(0.4000000059604644775390625), float3(_571)).x, 0.0, 1.0);
    float _742 = fast::clamp(mix(_700, _731.y, _571), 0.0, 1.0);
    float _747 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _607) + mix(_698.x, _731.x, _571)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _748 = in.in_var_PRIMITIVE_ID * 36u;
    uint _749 = _748 + 20u;
    float _797;
    float _798;
    float _799;
    float3 _800;
    float3 _801;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _749)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _767 = ((_267.xy / float2(_267.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _771 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _767, level(0.0));
        float4 _774 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _767, level(0.0));
        float4 _777 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _767, level(0.0));
        float _787 = _777.w;
        _797 = (_747 * _787) + _777.z;
        _798 = (_741 * _787) + _777.y;
        _799 = _777.x;
        _800 = (_740 * _771.w) + _771.xyz;
        _801 = normalize((_587 * _774.w) + ((_774.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _797 = _747;
        _798 = _741;
        _799 = 0.0;
        _800 = _740;
        _801 = _587;
    }
    bool _811 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _817;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _748 + 18u)].w > 0.0) && _811)
    {
        _817 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _817 = 1.0;
    }
    float _864;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _749)].z > 0.0)
    {
        float3 _832 = fast::clamp((_277 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _843 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_832.x), int(_832.y), int(_832.z), 0).xyz), 0));
        _864 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_843.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_832 / float3(_843.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _864 = _817;
    }
    float3 _878 = ((_800 - (_800 * _799)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _885 = (mix(float3(0.07999999821186065673828125 * _798), _800, float3(_799)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _888 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _893;
    if (_888)
    {
        _893 = _878 + (_885 * 0.449999988079071044921875);
    }
    else
    {
        _893 = _878;
    }
    float3 _895 = select(_885, float3(0.0), bool3(_888));
    float3 _897 = float3(dot(_895, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _904 = float3(_742);
    float3 _972;
    if (_811)
    {
        float3 _924 = fast::clamp((_277 * IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveScale) + IndirectLightingCache.IndirectLightingCache_IndirectLightingCachePrimitiveAdd, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMinUV, IndirectLightingCache.IndirectLightingCache_IndirectLightingCacheMaxUV);
        float4 _928 = IndirectLightingCache_IndirectLightingCacheTexture0.sample(IndirectLightingCache_IndirectLightingCacheTextureSampler0, _924);
        float4 _932 = IndirectLightingCache_IndirectLightingCacheTexture1.sample(View_SharedBilinearClampedSampler, _924);
        float4 _935 = IndirectLightingCache_IndirectLightingCacheTexture2.sample(View_SharedBilinearClampedSampler, _924);
        float4 _953 = _212;
        _953.y = (-0.48860299587249755859375) * _801.y;
        float4 _956 = _953;
        _956.z = 0.48860299587249755859375 * _801.z;
        float4 _959 = _956;
        _959.w = (-0.48860299587249755859375) * _801.x;
        float4 _960 = _959;
        _960.x = 0.886227548122406005859375;
        float3 _962 = _960.yzw * 2.094395160675048828125;
        float4 _963 = float4(_960.x, _962.x, _962.y, _962.z);
        float3 _965 = float3(0.0);
        _965.x = dot(float4(_928.x, _932.x, _935.x, _928.w), _963);
        float3 _967 = _965;
        _967.y = dot(float4(_928.y, _932.y, _935.y, _932.w), _963);
        float3 _969 = _967;
        _969.z = dot(float4(_928.z, _932.z, _935.zw), _963);
        _972 = fast::max(float3(0.0), _969) * float3(0.3183098733425140380859375);
    }
    else
    {
        _972 = float3(0.0);
    }
    float3 _975 = _972 * View.View_IndirectLightingColorScale;
    float3 _997 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1026;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1025;
        if (any(abs(_277 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _748 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _748 + 19u)].xyz + float3(1.0))))
        {
            _1025 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_277, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
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
    float4 _1033 = float4(((mix(float3(0.0), _893 + (_895 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_975 * _893) * fast::max(_904, ((((((_800 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _742) + ((_800 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _742) + ((_800 * 2.755199909210205078125) + float3(0.69029998779296875))) * _742))) + _1026) * 1.0, 0.0);
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
    float3 _1052 = (_801 * 0.5) + float3(0.5);
    float4 _1054 = float4(_1052.x, _1052.y, _1052.z, float4(0.0).w);
    _1054.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _749)].y;
    float4 _1055 = float4(0.0);
    _1055.x = _799;
    float4 _1056 = _1055;
    _1056.y = _798;
    float4 _1057 = _1056;
    _1057.z = _797;
    float4 _1058 = _1057;
    _1058.w = 0.50588238239288330078125;
    float4 _1070 = float4(_800.x, _800.y, _800.z, float4(0.0).w);
    _1070.w = ((log2(((dot(_975, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_904, ((((((_897 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _742) + ((_897 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _742) + ((_897 * 2.755199909210205078125) + float3(0.69029998779296875))) * _742).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1044.xyx * _1044.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1040 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1054;
    out.out_var_SV_Target2 = _1058;
    out.out_var_SV_Target3 = _1070;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_864, 1.0, 1.0, 1.0);
    return out;
}

