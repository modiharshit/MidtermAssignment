

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

constant float4 _212 = {};
constant float _214 = {};
constant float4 _215 = {};

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

fragment MainPS_out Main_00006f70_6320e70a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], texture2d<float> Material_Texture2D_5 [[texture(10)]], texture2d<float> Material_Texture2D_6 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _258 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _269 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _214, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _274 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _278 = _274.xyz / float3(_274.w);
    float3 _279 = _278 - View.View_PreViewTranslation;
    float4 _287 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _290 = (_287.xy * float2(2.0)) - float2(1.0);
    float2 _299 = (normalize(-_278) * _258).xy;
    float2 _301 = (_299 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _303 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _301, bias(View.View_MaterialTextureMipBias));
    float2 _306 = (_303.xy * float2(2.0)) - float2(1.0);
    float2 _315 = (_299 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _317 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _315, bias(View.View_MaterialTextureMipBias));
    float2 _320 = (_317.xy * float2(2.0)) - float2(1.0);
    float2 _329 = (_299 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _331 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _329, bias(View.View_MaterialTextureMipBias));
    float2 _334 = (_331.xy * float2(2.0)) - float2(1.0);
    float2 _343 = (_299 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _345 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _343, bias(View.View_MaterialTextureMipBias));
    float2 _348 = (_345.xy * float2(2.0)) - float2(1.0);
    float2 _357 = (_299 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _359 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _357, bias(View.View_MaterialTextureMipBias));
    float2 _362 = (_359.xy * float2(2.0)) - float2(1.0);
    float2 _371 = (_299 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _373 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _371, bias(View.View_MaterialTextureMipBias));
    float2 _376 = (_373.xy * float2(2.0)) - float2(1.0);
    float2 _385 = (_299 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _387 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _385, bias(View.View_MaterialTextureMipBias));
    float2 _390 = (_387.xy * float2(2.0)) - float2(1.0);
    float2 _399 = (_299 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _401 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _399, bias(View.View_MaterialTextureMipBias));
    float2 _404 = (_401.xy * float2(2.0)) - float2(1.0);
    float2 _413 = (_299 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _415 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _413, bias(View.View_MaterialTextureMipBias));
    float2 _418 = (_415.xy * float2(2.0)) - float2(1.0);
    float2 _427 = (_299 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _429 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _427, bias(View.View_MaterialTextureMipBias));
    float2 _432 = (_429.xy * float2(2.0)) - float2(1.0);
    float2 _441 = (_299 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _443 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _441, bias(View.View_MaterialTextureMipBias));
    float2 _446 = (_443.xy * float2(2.0)) - float2(1.0);
    float4 _457 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _427, bias(View.View_MaterialTextureMipBias));
    float4 _464 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_457.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _468 = float3(_464.x);
    float4 _471 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _413, bias(View.View_MaterialTextureMipBias));
    float4 _476 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_471.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _479 = float3(_476.x);
    float4 _482 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _399, bias(View.View_MaterialTextureMipBias));
    float4 _487 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_482.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _490 = float3(_487.x);
    float4 _493 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _385, bias(View.View_MaterialTextureMipBias));
    float4 _498 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_493.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _501 = float3(_498.x);
    float4 _504 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _371, bias(View.View_MaterialTextureMipBias));
    float4 _509 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_504.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _512 = float3(_509.x);
    float4 _515 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _357, bias(View.View_MaterialTextureMipBias));
    float4 _520 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_515.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _523 = float3(_520.x);
    float4 _526 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _343, bias(View.View_MaterialTextureMipBias));
    float4 _531 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_526.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _534 = float3(_531.x);
    float4 _537 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _329, bias(View.View_MaterialTextureMipBias));
    float4 _542 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_537.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _544 = _542.x;
    float3 _545 = float3(_544);
    float4 _548 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _315, bias(View.View_MaterialTextureMipBias));
    float4 _553 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_548.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _555 = _553.x;
    float3 _556 = float3(_555);
    float4 _559 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _301, bias(View.View_MaterialTextureMipBias));
    float4 _564 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_559.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _566 = _564.x;
    float3 _567 = float3(_566);
    float4 _572 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _573 = _572.w;
    float4 _577 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_573 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _580 = float3(_577.x);
    float3 _589 = normalize(_258 * normalize((mix(float4(_290, sqrt(fast::clamp(1.0 - dot(_290, _290), 0.0, 1.0)), 1.0).xyz, mix(float4(_306, sqrt(fast::clamp(1.0 - dot(_306, _306), 0.0, 1.0)), 1.0).xyz, mix(float4(_320, sqrt(fast::clamp(1.0 - dot(_320, _320), 0.0, 1.0)), 1.0).xyz, mix(float4(_334, sqrt(fast::clamp(1.0 - dot(_334, _334), 0.0, 1.0)), 1.0).xyz, mix(float4(_348, sqrt(fast::clamp(1.0 - dot(_348, _348), 0.0, 1.0)), 1.0).xyz, mix(float4(_362, sqrt(fast::clamp(1.0 - dot(_362, _362), 0.0, 1.0)), 1.0).xyz, mix(float4(_376, sqrt(fast::clamp(1.0 - dot(_376, _376), 0.0, 1.0)), 1.0).xyz, mix(float4(_390, sqrt(fast::clamp(1.0 - dot(_390, _390), 0.0, 1.0)), 1.0).xyz, mix(float4(_404, sqrt(fast::clamp(1.0 - dot(_404, _404), 0.0, 1.0)), 1.0).xyz, mix(float4(_418, sqrt(fast::clamp(1.0 - dot(_418, _418), 0.0, 1.0)), 1.0).xyz, mix(float4(_432, sqrt(fast::clamp(1.0 - dot(_432, _432), 0.0, 1.0)), 1.0).xyz, float4(_446, sqrt(fast::clamp(1.0 - dot(_446, _446), 0.0, 1.0)), 1.0).xyz, _468), _479), _490), _501), _512), _523), _534), _545), _556), _567), _580) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _601 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _606 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _609 = (_601.x + 0.5) * (_606.x + 0.5);
    float4 _620 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_301 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _630 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_315 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _640 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_329 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _650 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_343 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _656 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_357 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _662 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_371 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _668 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_385 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _674 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_399 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _680 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_413 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _686 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_427 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _692 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_441 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _696 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _441, bias(View.View_MaterialTextureMipBias));
    float4 _700 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _441, bias(View.View_MaterialTextureMipBias));
    float _702 = _700.y;
    float3 _703 = _696.xyz * _702;
    float4 _706 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _441, bias(View.View_MaterialTextureMipBias));
    float4 _711 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_706.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _733 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _742 = fast::clamp(mix(_572.xyz * 1.0, mix((_620.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _566, -0.0), 1.0), mix((_630.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _555, -0.0), 1.0), mix((_640.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _544, -0.0), 1.0), mix(_650.xyz * 0.699999988079071044921875, mix(_656.xyz * 0.60000002384185791015625, mix(_662.xyz * 0.5, mix(_668.xyz * 0.4000000059604644775390625, mix(_674.xyz * 0.300000011920928955078125, mix(_680.xyz * 0.20000000298023223876953125, mix(_686.xyz * 0.1500000059604644775390625, mix(_692.xyz * 0.13799999654293060302734375, _703 * 0.800000011920928955078125, float3(_711.x)), _468), _479), _490), _501), _512), _523), _534), _545), _556), _567), _580) * mix(0.5, 1.0, _609), float3(0.0), float3(1.0));
    float _743 = fast::clamp(mix((_703 * _702) * 3.0, float3(0.4000000059604644775390625), float3(_573)).x, 0.0, 1.0);
    float _744 = fast::clamp(mix(_702, _733.y, _573), 0.0, 1.0);
    float _749 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _609) + mix(_700.x, _733.x, _573)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _750 = in.in_var_PRIMITIVE_ID * 36u;
    uint _751 = _750 + 20u;
    float _799;
    float _800;
    float _801;
    float3 _802;
    float3 _803;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _751)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _769 = ((_269.xy / float2(_269.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _773 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _769, level(0.0));
        float4 _776 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _769, level(0.0));
        float4 _779 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _769, level(0.0));
        float _789 = _779.w;
        _799 = (_749 * _789) + _779.z;
        _800 = (_743 * _789) + _779.y;
        _801 = _779.x;
        _802 = (_742 * _773.w) + _773.xyz;
        _803 = normalize((_589 * _776.w) + ((_776.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _799 = _749;
        _800 = _743;
        _801 = 0.0;
        _802 = _742;
        _803 = _589;
    }
    bool _813 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _819;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _750 + 18u)].w > 0.0) && _813)
    {
        _819 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _819 = 1.0;
    }
    float _866;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _751)].z > 0.0)
    {
        float3 _834 = fast::clamp((_279 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _845 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_834.x), int(_834.y), int(_834.z), 0).xyz), 0));
        _866 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_845.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_834 / float3(_845.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _866 = _819;
    }
    float3 _880 = ((_802 - (_802 * _801)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _887 = (mix(float3(0.07999999821186065673828125 * _800), _802, float3(_801)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _890 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _895;
    if (_890)
    {
        _895 = _880 + (_887 * 0.449999988079071044921875);
    }
    else
    {
        _895 = _880;
    }
    float3 _897 = select(_887, float3(0.0), bool3(_890));
    float3 _899 = float3(dot(_897, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _906 = float3(_744);
    float3 _986;
    if (_813)
    {
        float4 _936 = _215;
        _936.y = (-0.48860299587249755859375) * _803.y;
        float4 _939 = _936;
        _939.z = 0.48860299587249755859375 * _803.z;
        float4 _942 = _939;
        _942.w = (-0.48860299587249755859375) * _803.x;
        float3 _943 = _803 * _803;
        float4 _946 = _212;
        _946.x = (1.09254801273345947265625 * _803.x) * _803.y;
        float4 _949 = _946;
        _949.y = ((-1.09254801273345947265625) * _803.y) * _803.z;
        float4 _954 = _949;
        _954.z = 0.3153919875621795654296875 * ((3.0 * _943.z) - 1.0);
        float4 _957 = _954;
        _957.w = ((-1.09254801273345947265625) * _803.x) * _803.z;
        float4 _961 = _942;
        _961.x = 0.886227548122406005859375;
        float3 _963 = _961.yzw * 2.094395160675048828125;
        float4 _964 = float4(_961.x, _963.x, _963.y, _963.z);
        float4 _965 = _957 * 0.785398185253143310546875;
        float _966 = (_943.x - _943.y) * 0.4290426075458526611328125;
        float3 _972 = float3(0.0);
        _972.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _964) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _965)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _966);
        float3 _978 = _972;
        _978.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _964) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _965)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _966);
        float3 _984 = _978;
        _984.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _964) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _965)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _966);
        _986 = fast::max(float3(0.0), _984);
    }
    else
    {
        _986 = float3(0.0);
    }
    float3 _989 = _986 * View.View_IndirectLightingColorScale;
    float3 _1011 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1040;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1039;
        if (any(abs(_279 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _750 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _750 + 19u)].xyz + float3(1.0))))
        {
            _1039 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_279, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1039 = _1011;
        }
        _1040 = _1039;
    }
    else
    {
        _1040 = _1011;
    }
    float4 _1047 = float4(((mix(float3(0.0), _895 + (_897 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_989 * _895) * fast::max(_906, ((((((_802 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _744) + ((_802 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _744) + ((_802 * 2.755199909210205078125) + float3(0.69029998779296875))) * _744))) + _1040) * 1.0, 0.0);
    float4 _1054;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1053 = _1047;
        _1053.w = 0.0;
        _1054 = _1053;
    }
    else
    {
        _1054 = _1047;
    }
    float2 _1058 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1066 = (_803 * 0.5) + float3(0.5);
    float4 _1068 = float4(_1066.x, _1066.y, _1066.z, float4(0.0).w);
    _1068.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _751)].y;
    float4 _1069 = float4(0.0);
    _1069.x = _801;
    float4 _1070 = _1069;
    _1070.y = _800;
    float4 _1071 = _1070;
    _1071.z = _799;
    float4 _1072 = _1071;
    _1072.w = 0.50588238239288330078125;
    float4 _1084 = float4(_802.x, _802.y, _802.z, float4(0.0).w);
    _1084.w = ((log2(((dot(_989, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_906, ((((((_899 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _744) + ((_899 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _744) + ((_899 * 2.755199909210205078125) + float3(0.69029998779296875))) * _744).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1058.xyx * _1058.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1054 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1068;
    out.out_var_SV_Target2 = _1072;
    out.out_var_SV_Target3 = _1084;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_866, 1.0, 1.0, 1.0);
    return out;
}

