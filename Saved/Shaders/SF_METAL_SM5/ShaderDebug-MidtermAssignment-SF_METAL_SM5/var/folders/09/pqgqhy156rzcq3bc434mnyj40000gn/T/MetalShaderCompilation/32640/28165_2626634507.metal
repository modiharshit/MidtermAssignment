

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

constant float3 _199 = {};
constant float _200 = {};

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

fragment MainPS_out Main_00006e05_9c8f430b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], texture2d<float> Material_Texture2D_5 [[texture(10)]], texture2d<float> Material_Texture2D_6 [[texture(11)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _244 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _255 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _200, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _260 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _264 = _260.xyz / float3(_260.w);
    float3 _265 = _264 - View.View_PreViewTranslation;
    float4 _273 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _276 = (_273.xy * float2(2.0)) - float2(1.0);
    float2 _285 = (normalize(-_264) * _244).xy;
    float2 _287 = (_285 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _289 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _287, bias(View.View_MaterialTextureMipBias));
    float2 _292 = (_289.xy * float2(2.0)) - float2(1.0);
    float2 _301 = (_285 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _303 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _301, bias(View.View_MaterialTextureMipBias));
    float2 _306 = (_303.xy * float2(2.0)) - float2(1.0);
    float2 _315 = (_285 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _317 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _315, bias(View.View_MaterialTextureMipBias));
    float2 _320 = (_317.xy * float2(2.0)) - float2(1.0);
    float2 _329 = (_285 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _331 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _329, bias(View.View_MaterialTextureMipBias));
    float2 _334 = (_331.xy * float2(2.0)) - float2(1.0);
    float2 _343 = (_285 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _345 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _343, bias(View.View_MaterialTextureMipBias));
    float2 _348 = (_345.xy * float2(2.0)) - float2(1.0);
    float2 _357 = (_285 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _359 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _357, bias(View.View_MaterialTextureMipBias));
    float2 _362 = (_359.xy * float2(2.0)) - float2(1.0);
    float2 _371 = (_285 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _373 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _371, bias(View.View_MaterialTextureMipBias));
    float2 _376 = (_373.xy * float2(2.0)) - float2(1.0);
    float2 _385 = (_285 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _387 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _385, bias(View.View_MaterialTextureMipBias));
    float2 _390 = (_387.xy * float2(2.0)) - float2(1.0);
    float2 _399 = (_285 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _401 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _399, bias(View.View_MaterialTextureMipBias));
    float2 _404 = (_401.xy * float2(2.0)) - float2(1.0);
    float2 _413 = (_285 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _415 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _413, bias(View.View_MaterialTextureMipBias));
    float2 _418 = (_415.xy * float2(2.0)) - float2(1.0);
    float2 _427 = (_285 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _429 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _427, bias(View.View_MaterialTextureMipBias));
    float2 _432 = (_429.xy * float2(2.0)) - float2(1.0);
    float4 _443 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _413, bias(View.View_MaterialTextureMipBias));
    float4 _450 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_443.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _454 = float3(_450.x);
    float4 _457 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _399, bias(View.View_MaterialTextureMipBias));
    float4 _462 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_457.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _465 = float3(_462.x);
    float4 _468 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _385, bias(View.View_MaterialTextureMipBias));
    float4 _473 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_468.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _476 = float3(_473.x);
    float4 _479 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _371, bias(View.View_MaterialTextureMipBias));
    float4 _484 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_479.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _487 = float3(_484.x);
    float4 _490 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _357, bias(View.View_MaterialTextureMipBias));
    float4 _495 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_490.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _498 = float3(_495.x);
    float4 _501 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _343, bias(View.View_MaterialTextureMipBias));
    float4 _506 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_501.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _509 = float3(_506.x);
    float4 _512 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _329, bias(View.View_MaterialTextureMipBias));
    float4 _517 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_512.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _520 = float3(_517.x);
    float4 _523 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _315, bias(View.View_MaterialTextureMipBias));
    float4 _528 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_523.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _530 = _528.x;
    float3 _531 = float3(_530);
    float4 _534 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _301, bias(View.View_MaterialTextureMipBias));
    float4 _539 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_534.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _541 = _539.x;
    float3 _542 = float3(_541);
    float4 _545 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _287, bias(View.View_MaterialTextureMipBias));
    float4 _550 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_545.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _552 = _550.x;
    float3 _553 = float3(_552);
    float4 _558 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _559 = _558.w;
    float4 _563 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_559 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _566 = float3(_563.x);
    float3 _575 = normalize(_244 * normalize((mix(float4(_276, sqrt(fast::clamp(1.0 - dot(_276, _276), 0.0, 1.0)), 1.0).xyz, mix(float4(_292, sqrt(fast::clamp(1.0 - dot(_292, _292), 0.0, 1.0)), 1.0).xyz, mix(float4(_306, sqrt(fast::clamp(1.0 - dot(_306, _306), 0.0, 1.0)), 1.0).xyz, mix(float4(_320, sqrt(fast::clamp(1.0 - dot(_320, _320), 0.0, 1.0)), 1.0).xyz, mix(float4(_334, sqrt(fast::clamp(1.0 - dot(_334, _334), 0.0, 1.0)), 1.0).xyz, mix(float4(_348, sqrt(fast::clamp(1.0 - dot(_348, _348), 0.0, 1.0)), 1.0).xyz, mix(float4(_362, sqrt(fast::clamp(1.0 - dot(_362, _362), 0.0, 1.0)), 1.0).xyz, mix(float4(_376, sqrt(fast::clamp(1.0 - dot(_376, _376), 0.0, 1.0)), 1.0).xyz, mix(float4(_390, sqrt(fast::clamp(1.0 - dot(_390, _390), 0.0, 1.0)), 1.0).xyz, mix(float4(_404, sqrt(fast::clamp(1.0 - dot(_404, _404), 0.0, 1.0)), 1.0).xyz, mix(float4(_418, sqrt(fast::clamp(1.0 - dot(_418, _418), 0.0, 1.0)), 1.0).xyz, float4(_432, sqrt(fast::clamp(1.0 - dot(_432, _432), 0.0, 1.0)), 1.0).xyz, _454), _465), _476), _487), _498), _509), _520), _531), _542), _553), _566) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _587 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _592 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _595 = (_587.x + 0.5) * (_592.x + 0.5);
    float4 _606 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_287 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _616 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_301 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _626 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_315 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _636 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_329 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _642 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_343 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _648 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_357 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _654 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_371 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _660 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_385 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _666 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_399 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _672 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_413 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _678 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_427 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _682 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _427, bias(View.View_MaterialTextureMipBias));
    float4 _686 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _427, bias(View.View_MaterialTextureMipBias));
    float _688 = _686.y;
    float3 _689 = _682.xyz * _688;
    float4 _692 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _427, bias(View.View_MaterialTextureMipBias));
    float4 _697 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_692.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _719 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _728 = fast::clamp(mix(_558.xyz * 1.0, mix((_606.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _552, -0.0), 1.0), mix((_616.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _541, -0.0), 1.0), mix((_626.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _530, -0.0), 1.0), mix(_636.xyz * 0.699999988079071044921875, mix(_642.xyz * 0.60000002384185791015625, mix(_648.xyz * 0.5, mix(_654.xyz * 0.4000000059604644775390625, mix(_660.xyz * 0.300000011920928955078125, mix(_666.xyz * 0.20000000298023223876953125, mix(_672.xyz * 0.1500000059604644775390625, mix(_678.xyz * 0.13799999654293060302734375, _689 * 0.800000011920928955078125, float3(_697.x)), _454), _465), _476), _487), _498), _509), _520), _531), _542), _553), _566) * mix(0.5, 1.0, _595), float3(0.0), float3(1.0));
    float _729 = fast::clamp(mix((_689 * _688) * 3.0, float3(0.4000000059604644775390625), float3(_559)).x, 0.0, 1.0);
    float _730 = fast::clamp(mix(_688, _719.y, _559), 0.0, 1.0);
    float _735 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _595) + mix(_686.x, _719.x, _559)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _736 = in.in_var_PRIMITIVE_ID * 36u;
    uint _737 = _736 + 20u;
    float _785;
    float _786;
    float _787;
    float3 _788;
    float3 _789;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _737)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _755 = ((_255.xy / float2(_255.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _759 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _755, level(0.0));
        float4 _762 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _755, level(0.0));
        float4 _765 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _755, level(0.0));
        float _775 = _765.w;
        _785 = (_735 * _775) + _765.z;
        _786 = (_729 * _775) + _765.y;
        _787 = _765.x;
        _788 = (_728 * _759.w) + _759.xyz;
        _789 = normalize((_575 * _762.w) + ((_762.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _785 = _735;
        _786 = _729;
        _787 = 0.0;
        _788 = _728;
        _789 = _575;
    }
    float3 _804 = ((_788 - (_788 * _787)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _811 = (mix(float3(0.07999999821186065673828125 * _786), _788, float3(_787)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _814 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _819;
    if (_814)
    {
        _819 = _804 + (_811 * 0.449999988079071044921875);
    }
    else
    {
        _819 = _804;
    }
    float3 _821 = select(_811, float3(0.0), bool3(_814));
    float3 _823 = float3(dot(_821, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _830 = float3(_730);
    float2 _839 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _844 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _839);
    float4 _846 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_839 + float2(0.0, 0.5)));
    uint _852 = in.in_var_LIGHTMAP_ID * 15u;
    uint _853 = _852 + 4u;
    uint _858 = _852 + 6u;
    float3 _863 = _844.xyz;
    float _915;
    float _916;
    float3 _917;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _899 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _903 = _899.w;
        float _904 = _903 * _903;
        float3 _906 = normalize(((_899.xyz * 2.0) - float3(1.0)).xyz);
        float _907 = 1.0 - _904;
        float _909 = 1.0 - (_907 * _907);
        _915 = mix(fast::clamp(dot(_906, _789), 0.0, 1.0), 1.0, _909);
        _916 = _904;
        _917 = mix(_906, _789, float3(_909));
    }
    else
    {
        _915 = 1.0;
        _916 = 1.0;
        _917 = _789;
    }
    float4 _921 = float4(_917, 1.0);
    float3 _925 = _199;
    _925.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _921);
    float3 _929 = _925;
    _929.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _921);
    float3 _933 = _929;
    _933.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _921);
    float4 _936 = _921.xyzz * _921.yzzx;
    float3 _940 = _199;
    _940.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _936);
    float3 _944 = _940;
    _944.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _936);
    float3 _948 = _944;
    _948.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _936);
    float3 _963 = (((((_863 * _863) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _853)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _858)].xyz) * ((exp2(((_844.w + ((_846.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _853)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _858)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_846 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _852 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _852 + 7u)], float4(_789.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_933 + _948) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_917.x * _917.x) - (_917.y * _917.y)))) * View.View_SkyLightColor.xyz) * (_916 * _915));
    float3 _985 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1014;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1013;
        if (any(abs(_265 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _736 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _736 + 19u)].xyz + float3(1.0))))
        {
            _1013 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_265, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1013 = _985;
        }
        _1014 = _1013;
    }
    else
    {
        _1014 = _985;
    }
    float4 _1021 = float4(((mix(float3(0.0), _819 + (_821 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_963 * _819) * fast::max(_830, ((((((_788 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _730) + ((_788 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _730) + ((_788 * 2.755199909210205078125) + float3(0.69029998779296875))) * _730))) + _1014) * 1.0, 0.0);
    float4 _1028;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1027 = _1021;
        _1027.w = 0.0;
        _1028 = _1027;
    }
    else
    {
        _1028 = _1021;
    }
    float2 _1032 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1040 = (_789 * 0.5) + float3(0.5);
    float4 _1042 = float4(_1040.x, _1040.y, _1040.z, float4(0.0).w);
    _1042.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _737)].y;
    float4 _1043 = float4(0.0);
    _1043.x = _787;
    float4 _1044 = _1043;
    _1044.y = _786;
    float4 _1045 = _1044;
    _1045.z = _785;
    float4 _1046 = _1045;
    _1046.w = 0.75686275959014892578125;
    float4 _1058 = float4(_788.x, _788.y, _788.z, float4(0.0).w);
    _1058.w = ((log2(((dot(_963, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_830, ((((((_823 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _730) + ((_823 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _730) + ((_823 * 2.755199909210205078125) + float3(0.69029998779296875))) * _730).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1032.xyx * _1032.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1028 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1042;
    out.out_var_SV_Target2 = _1046;
    out.out_var_SV_Target3 = _1058;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

