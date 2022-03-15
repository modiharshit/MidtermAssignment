

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

constant float3 _202 = {};
constant float _203 = {};

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

fragment MainPS_out Main_000070b9_49bb3dc7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(5)]], texture2d<float> Material_Texture2D_0 [[texture(6)]], texture2d<float> Material_Texture2D_1 [[texture(7)]], texture2d<float> Material_Texture2D_2 [[texture(8)]], texture2d<float> Material_Texture2D_3 [[texture(9)]], texture2d<float> Material_Texture2D_4 [[texture(10)]], texture2d<float> Material_Texture2D_5 [[texture(11)]], texture2d<float> Material_Texture2D_6 [[texture(12)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _247 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _258 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _203, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _263 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _267 = _263.xyz / float3(_263.w);
    float3 _268 = _267 - View.View_PreViewTranslation;
    float4 _276 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _279 = (_276.xy * float2(2.0)) - float2(1.0);
    float2 _288 = (normalize(-_267) * _247).xy;
    float2 _290 = (_288 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _292 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _290, bias(View.View_MaterialTextureMipBias));
    float2 _295 = (_292.xy * float2(2.0)) - float2(1.0);
    float2 _304 = (_288 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _306 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _304, bias(View.View_MaterialTextureMipBias));
    float2 _309 = (_306.xy * float2(2.0)) - float2(1.0);
    float2 _318 = (_288 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _320 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _318, bias(View.View_MaterialTextureMipBias));
    float2 _323 = (_320.xy * float2(2.0)) - float2(1.0);
    float2 _332 = (_288 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _334 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _332, bias(View.View_MaterialTextureMipBias));
    float2 _337 = (_334.xy * float2(2.0)) - float2(1.0);
    float2 _346 = (_288 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _348 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _346, bias(View.View_MaterialTextureMipBias));
    float2 _351 = (_348.xy * float2(2.0)) - float2(1.0);
    float2 _360 = (_288 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _362 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _360, bias(View.View_MaterialTextureMipBias));
    float2 _365 = (_362.xy * float2(2.0)) - float2(1.0);
    float2 _374 = (_288 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _376 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _374, bias(View.View_MaterialTextureMipBias));
    float2 _379 = (_376.xy * float2(2.0)) - float2(1.0);
    float2 _388 = (_288 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _390 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _388, bias(View.View_MaterialTextureMipBias));
    float2 _393 = (_390.xy * float2(2.0)) - float2(1.0);
    float2 _402 = (_288 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _404 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _402, bias(View.View_MaterialTextureMipBias));
    float2 _407 = (_404.xy * float2(2.0)) - float2(1.0);
    float2 _416 = (_288 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _418 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _416, bias(View.View_MaterialTextureMipBias));
    float2 _421 = (_418.xy * float2(2.0)) - float2(1.0);
    float2 _430 = (_288 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _432 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _430, bias(View.View_MaterialTextureMipBias));
    float2 _435 = (_432.xy * float2(2.0)) - float2(1.0);
    float4 _446 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _416, bias(View.View_MaterialTextureMipBias));
    float4 _453 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_446.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _457 = float3(_453.x);
    float4 _460 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _402, bias(View.View_MaterialTextureMipBias));
    float4 _465 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_460.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _468 = float3(_465.x);
    float4 _471 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _388, bias(View.View_MaterialTextureMipBias));
    float4 _476 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_471.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _479 = float3(_476.x);
    float4 _482 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _374, bias(View.View_MaterialTextureMipBias));
    float4 _487 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_482.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _490 = float3(_487.x);
    float4 _493 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _360, bias(View.View_MaterialTextureMipBias));
    float4 _498 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_493.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _501 = float3(_498.x);
    float4 _504 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _346, bias(View.View_MaterialTextureMipBias));
    float4 _509 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_504.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _512 = float3(_509.x);
    float4 _515 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _332, bias(View.View_MaterialTextureMipBias));
    float4 _520 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_515.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _523 = float3(_520.x);
    float4 _526 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _318, bias(View.View_MaterialTextureMipBias));
    float4 _531 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_526.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _533 = _531.x;
    float3 _534 = float3(_533);
    float4 _537 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _304, bias(View.View_MaterialTextureMipBias));
    float4 _542 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_537.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _544 = _542.x;
    float3 _545 = float3(_544);
    float4 _548 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _290, bias(View.View_MaterialTextureMipBias));
    float4 _553 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_548.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _555 = _553.x;
    float3 _556 = float3(_555);
    float4 _561 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _562 = _561.w;
    float4 _566 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_562 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _569 = float3(_566.x);
    float3 _578 = normalize(_247 * normalize((mix(float4(_279, sqrt(fast::clamp(1.0 - dot(_279, _279), 0.0, 1.0)), 1.0).xyz, mix(float4(_295, sqrt(fast::clamp(1.0 - dot(_295, _295), 0.0, 1.0)), 1.0).xyz, mix(float4(_309, sqrt(fast::clamp(1.0 - dot(_309, _309), 0.0, 1.0)), 1.0).xyz, mix(float4(_323, sqrt(fast::clamp(1.0 - dot(_323, _323), 0.0, 1.0)), 1.0).xyz, mix(float4(_337, sqrt(fast::clamp(1.0 - dot(_337, _337), 0.0, 1.0)), 1.0).xyz, mix(float4(_351, sqrt(fast::clamp(1.0 - dot(_351, _351), 0.0, 1.0)), 1.0).xyz, mix(float4(_365, sqrt(fast::clamp(1.0 - dot(_365, _365), 0.0, 1.0)), 1.0).xyz, mix(float4(_379, sqrt(fast::clamp(1.0 - dot(_379, _379), 0.0, 1.0)), 1.0).xyz, mix(float4(_393, sqrt(fast::clamp(1.0 - dot(_393, _393), 0.0, 1.0)), 1.0).xyz, mix(float4(_407, sqrt(fast::clamp(1.0 - dot(_407, _407), 0.0, 1.0)), 1.0).xyz, mix(float4(_421, sqrt(fast::clamp(1.0 - dot(_421, _421), 0.0, 1.0)), 1.0).xyz, float4(_435, sqrt(fast::clamp(1.0 - dot(_435, _435), 0.0, 1.0)), 1.0).xyz, _457), _468), _479), _490), _501), _512), _523), _534), _545), _556), _569) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _590 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _595 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _598 = (_590.x + 0.5) * (_595.x + 0.5);
    float4 _609 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_290 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _619 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_304 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _629 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_318 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _639 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_332 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _645 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_346 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _651 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_360 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _657 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_374 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _663 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_388 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _669 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_402 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _675 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_416 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _681 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_430 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _685 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _430, bias(View.View_MaterialTextureMipBias));
    float4 _689 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _430, bias(View.View_MaterialTextureMipBias));
    float _691 = _689.y;
    float3 _692 = _685.xyz * _691;
    float4 _695 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _430, bias(View.View_MaterialTextureMipBias));
    float4 _700 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_695.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _722 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _731 = fast::clamp(mix(_561.xyz * 1.0, mix((_609.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _555, -0.0), 1.0), mix((_619.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _544, -0.0), 1.0), mix((_629.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _533, -0.0), 1.0), mix(_639.xyz * 0.699999988079071044921875, mix(_645.xyz * 0.60000002384185791015625, mix(_651.xyz * 0.5, mix(_657.xyz * 0.4000000059604644775390625, mix(_663.xyz * 0.300000011920928955078125, mix(_669.xyz * 0.20000000298023223876953125, mix(_675.xyz * 0.1500000059604644775390625, mix(_681.xyz * 0.13799999654293060302734375, _692 * 0.800000011920928955078125, float3(_700.x)), _457), _468), _479), _490), _501), _512), _523), _534), _545), _556), _569) * mix(0.5, 1.0, _598), float3(0.0), float3(1.0));
    float _732 = fast::clamp(mix((_692 * _691) * 3.0, float3(0.4000000059604644775390625), float3(_562)).x, 0.0, 1.0);
    float _733 = fast::clamp(mix(_691, _722.y, _562), 0.0, 1.0);
    float _738 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _598) + mix(_689.x, _722.x, _562)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _739 = in.in_var_PRIMITIVE_ID * 36u;
    uint _740 = _739 + 20u;
    float _788;
    float _789;
    float _790;
    float3 _791;
    float3 _792;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _740)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _758 = ((_258.xy / float2(_258.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _762 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _758, level(0.0));
        float4 _765 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _758, level(0.0));
        float4 _768 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _758, level(0.0));
        float _778 = _768.w;
        _788 = (_738 * _778) + _768.z;
        _789 = (_732 * _778) + _768.y;
        _790 = _768.x;
        _791 = (_731 * _762.w) + _762.xyz;
        _792 = normalize((_578 * _765.w) + ((_765.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _788 = _738;
        _789 = _732;
        _790 = 0.0;
        _791 = _731;
        _792 = _578;
    }
    float4 _799 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _800 = in.in_var_LIGHTMAP_ID * 15u;
    uint _801 = _800 + 1u;
    float4 _808 = fast::clamp((_799 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _801)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _801)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _825 = ((_791 - (_791 * _790)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _832 = (mix(float3(0.07999999821186065673828125 * _789), _791, float3(_790)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _835 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _840;
    if (_835)
    {
        _840 = _825 + (_832 * 0.449999988079071044921875);
    }
    else
    {
        _840 = _825;
    }
    float3 _842 = select(_832, float3(0.0), bool3(_835));
    float3 _844 = float3(dot(_842, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _851 = float3(_733);
    float2 _860 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _864 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _860);
    float4 _866 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_860 + float2(0.0, 0.5)));
    uint _872 = _800 + 4u;
    uint _877 = _800 + 6u;
    float3 _882 = _864.xyz;
    float _934;
    float _935;
    float3 _936;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _918 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _922 = _918.w;
        float _923 = _922 * _922;
        float3 _925 = normalize(((_918.xyz * 2.0) - float3(1.0)).xyz);
        float _926 = 1.0 - _923;
        float _928 = 1.0 - (_926 * _926);
        _934 = mix(fast::clamp(dot(_925, _792), 0.0, 1.0), 1.0, _928);
        _935 = _923;
        _936 = mix(_925, _792, float3(_928));
    }
    else
    {
        _934 = 1.0;
        _935 = 1.0;
        _936 = _792;
    }
    float4 _940 = float4(_936, 1.0);
    float3 _944 = _202;
    _944.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _940);
    float3 _948 = _944;
    _948.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _940);
    float3 _952 = _948;
    _952.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _940);
    float4 _955 = _940.xyzz * _940.yzzx;
    float3 _959 = _202;
    _959.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _955);
    float3 _963 = _959;
    _963.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _955);
    float3 _967 = _963;
    _967.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _955);
    float3 _982 = (((((_882 * _882) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _872)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _877)].xyz) * ((exp2(((_864.w + ((_866.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _872)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _877)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_866 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _800 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _800 + 7u)], float4(_792.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_952 + _967) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_936.x * _936.x) - (_936.y * _936.y)))) * View.View_SkyLightColor.xyz) * (_935 * _934));
    float3 _1004 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1033;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1032;
        if (any(abs(_268 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _739 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _739 + 19u)].xyz + float3(1.0))))
        {
            _1032 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_268, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1032 = _1004;
        }
        _1033 = _1032;
    }
    else
    {
        _1033 = _1004;
    }
    float4 _1040 = float4(((mix(float3(0.0), _840 + (_842 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_982 * _840) * fast::max(_851, ((((((_791 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _733) + ((_791 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _733) + ((_791 * 2.755199909210205078125) + float3(0.69029998779296875))) * _733))) + _1033) * 1.0, 0.0);
    float4 _1047;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1046 = _1040;
        _1046.w = 0.0;
        _1047 = _1046;
    }
    else
    {
        _1047 = _1040;
    }
    float2 _1051 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1059 = (_792 * 0.5) + float3(0.5);
    float4 _1061 = float4(_1059.x, _1059.y, _1059.z, float4(0.0).w);
    _1061.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _740)].y;
    float4 _1062 = float4(0.0);
    _1062.x = _790;
    float4 _1063 = _1062;
    _1063.y = _789;
    float4 _1064 = _1063;
    _1064.z = _788;
    float4 _1065 = _1064;
    _1065.w = 0.50588238239288330078125;
    float4 _1077 = float4(_791.x, _791.y, _791.z, float4(0.0).w);
    _1077.w = ((log2(((dot(_982, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_851, ((((((_844 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _733) + ((_844 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _733) + ((_844 * 2.755199909210205078125) + float3(0.69029998779296875))) * _733).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1051.xyx * _1051.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1047 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1061;
    out.out_var_SV_Target2 = _1065;
    out.out_var_SV_Target3 = _1077;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _800)] * _808) * _808;
    return out;
}

