

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
    char _m15_pad[48];
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
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

constant float3 _198 = {};
constant float _199 = {};

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

fragment MainPS_out Main_000069ba_11d99d04(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], texture2d<float> Material_Texture2D_4 [[texture(8)]], texture2d<float> Material_Texture2D_5 [[texture(9)]], texture2d<float> Material_Texture2D_6 [[texture(10)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _242 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _253 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _199, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _258 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _262 = _258.xyz / float3(_258.w);
    float3 _263 = _262 - View.View_PreViewTranslation;
    float4 _271 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _274 = (_271.xy * float2(2.0)) - float2(1.0);
    float2 _283 = (normalize(-_262) * _242).xy;
    float2 _285 = (_283 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _287 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _285, bias(View.View_MaterialTextureMipBias));
    float2 _290 = (_287.xy * float2(2.0)) - float2(1.0);
    float2 _299 = (_283 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _301 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _299, bias(View.View_MaterialTextureMipBias));
    float2 _304 = (_301.xy * float2(2.0)) - float2(1.0);
    float2 _313 = (_283 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _315 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _313, bias(View.View_MaterialTextureMipBias));
    float2 _318 = (_315.xy * float2(2.0)) - float2(1.0);
    float2 _327 = (_283 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _329 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _327, bias(View.View_MaterialTextureMipBias));
    float2 _332 = (_329.xy * float2(2.0)) - float2(1.0);
    float2 _341 = (_283 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _343 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _341, bias(View.View_MaterialTextureMipBias));
    float2 _346 = (_343.xy * float2(2.0)) - float2(1.0);
    float2 _355 = (_283 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _357 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _355, bias(View.View_MaterialTextureMipBias));
    float2 _360 = (_357.xy * float2(2.0)) - float2(1.0);
    float2 _369 = (_283 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _371 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _369, bias(View.View_MaterialTextureMipBias));
    float2 _374 = (_371.xy * float2(2.0)) - float2(1.0);
    float2 _383 = (_283 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _385 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _383, bias(View.View_MaterialTextureMipBias));
    float2 _388 = (_385.xy * float2(2.0)) - float2(1.0);
    float2 _397 = (_283 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _399 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _397, bias(View.View_MaterialTextureMipBias));
    float2 _402 = (_399.xy * float2(2.0)) - float2(1.0);
    float2 _411 = (_283 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _413 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _411, bias(View.View_MaterialTextureMipBias));
    float2 _416 = (_413.xy * float2(2.0)) - float2(1.0);
    float2 _425 = (_283 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _427 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _425, bias(View.View_MaterialTextureMipBias));
    float2 _430 = (_427.xy * float2(2.0)) - float2(1.0);
    float4 _441 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _411, bias(View.View_MaterialTextureMipBias));
    float4 _448 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_441.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _452 = float3(_448.x);
    float4 _455 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _397, bias(View.View_MaterialTextureMipBias));
    float4 _460 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_455.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _463 = float3(_460.x);
    float4 _466 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _383, bias(View.View_MaterialTextureMipBias));
    float4 _471 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_466.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _474 = float3(_471.x);
    float4 _477 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _369, bias(View.View_MaterialTextureMipBias));
    float4 _482 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_477.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _485 = float3(_482.x);
    float4 _488 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _355, bias(View.View_MaterialTextureMipBias));
    float4 _493 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_488.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _496 = float3(_493.x);
    float4 _499 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _341, bias(View.View_MaterialTextureMipBias));
    float4 _504 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_499.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _507 = float3(_504.x);
    float4 _510 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _327, bias(View.View_MaterialTextureMipBias));
    float4 _515 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_510.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _518 = float3(_515.x);
    float4 _521 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _313, bias(View.View_MaterialTextureMipBias));
    float4 _526 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_521.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _528 = _526.x;
    float3 _529 = float3(_528);
    float4 _532 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _299, bias(View.View_MaterialTextureMipBias));
    float4 _537 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_532.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _539 = _537.x;
    float3 _540 = float3(_539);
    float4 _543 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _285, bias(View.View_MaterialTextureMipBias));
    float4 _548 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_543.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _550 = _548.x;
    float3 _551 = float3(_550);
    float4 _556 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _557 = _556.w;
    float4 _561 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_557 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _564 = float3(_561.x);
    float3 _573 = normalize(_242 * normalize((mix(float4(_274, sqrt(fast::clamp(1.0 - dot(_274, _274), 0.0, 1.0)), 1.0).xyz, mix(float4(_290, sqrt(fast::clamp(1.0 - dot(_290, _290), 0.0, 1.0)), 1.0).xyz, mix(float4(_304, sqrt(fast::clamp(1.0 - dot(_304, _304), 0.0, 1.0)), 1.0).xyz, mix(float4(_318, sqrt(fast::clamp(1.0 - dot(_318, _318), 0.0, 1.0)), 1.0).xyz, mix(float4(_332, sqrt(fast::clamp(1.0 - dot(_332, _332), 0.0, 1.0)), 1.0).xyz, mix(float4(_346, sqrt(fast::clamp(1.0 - dot(_346, _346), 0.0, 1.0)), 1.0).xyz, mix(float4(_360, sqrt(fast::clamp(1.0 - dot(_360, _360), 0.0, 1.0)), 1.0).xyz, mix(float4(_374, sqrt(fast::clamp(1.0 - dot(_374, _374), 0.0, 1.0)), 1.0).xyz, mix(float4(_388, sqrt(fast::clamp(1.0 - dot(_388, _388), 0.0, 1.0)), 1.0).xyz, mix(float4(_402, sqrt(fast::clamp(1.0 - dot(_402, _402), 0.0, 1.0)), 1.0).xyz, mix(float4(_416, sqrt(fast::clamp(1.0 - dot(_416, _416), 0.0, 1.0)), 1.0).xyz, float4(_430, sqrt(fast::clamp(1.0 - dot(_430, _430), 0.0, 1.0)), 1.0).xyz, _452), _463), _474), _485), _496), _507), _518), _529), _540), _551), _564) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _585 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _590 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _593 = (_585.x + 0.5) * (_590.x + 0.5);
    float4 _604 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_285 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _614 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_299 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _624 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_313 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _634 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_327 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _640 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_341 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _646 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_355 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _652 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_369 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _658 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_383 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _664 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_397 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _670 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_411 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _676 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_425 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _680 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _425, bias(View.View_MaterialTextureMipBias));
    float4 _684 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _425, bias(View.View_MaterialTextureMipBias));
    float _686 = _684.y;
    float3 _687 = _680.xyz * _686;
    float4 _690 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _425, bias(View.View_MaterialTextureMipBias));
    float4 _695 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_690.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _717 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _726 = fast::clamp(mix(_556.xyz * 1.0, mix((_604.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _550, -0.0), 1.0), mix((_614.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _539, -0.0), 1.0), mix((_624.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _528, -0.0), 1.0), mix(_634.xyz * 0.699999988079071044921875, mix(_640.xyz * 0.60000002384185791015625, mix(_646.xyz * 0.5, mix(_652.xyz * 0.4000000059604644775390625, mix(_658.xyz * 0.300000011920928955078125, mix(_664.xyz * 0.20000000298023223876953125, mix(_670.xyz * 0.1500000059604644775390625, mix(_676.xyz * 0.13799999654293060302734375, _687 * 0.800000011920928955078125, float3(_695.x)), _452), _463), _474), _485), _496), _507), _518), _529), _540), _551), _564) * mix(0.5, 1.0, _593), float3(0.0), float3(1.0));
    float _727 = fast::clamp(mix((_687 * _686) * 3.0, float3(0.4000000059604644775390625), float3(_557)).x, 0.0, 1.0);
    float _728 = fast::clamp(mix(_686, _717.y, _557), 0.0, 1.0);
    float _733 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _593) + mix(_684.x, _717.x, _557)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _734 = in.in_var_PRIMITIVE_ID * 36u;
    uint _735 = _734 + 20u;
    float _783;
    float _784;
    float _785;
    float3 _786;
    float3 _787;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _735)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _753 = ((_253.xy / float2(_253.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _757 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _753, level(0.0));
        float4 _760 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _753, level(0.0));
        float4 _763 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _753, level(0.0));
        float _773 = _763.w;
        _783 = (_733 * _773) + _763.z;
        _784 = (_727 * _773) + _763.y;
        _785 = _763.x;
        _786 = (_726 * _757.w) + _757.xyz;
        _787 = normalize((_573 * _760.w) + ((_760.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _783 = _733;
        _784 = _727;
        _785 = 0.0;
        _786 = _726;
        _787 = _573;
    }
    float3 _802 = ((_786 - (_786 * _785)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _809 = (mix(float3(0.07999999821186065673828125 * _784), _786, float3(_785)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _812 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _817;
    if (_812)
    {
        _817 = _802 + (_809 * 0.449999988079071044921875);
    }
    else
    {
        _817 = _802;
    }
    float3 _819 = select(_809, float3(0.0), bool3(_812));
    float3 _821 = float3(dot(_819, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _828 = float3(_728);
    float2 _837 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _842 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _837);
    float4 _844 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_837 + float2(0.0, 0.5)));
    uint _846 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _856 = (_842.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _846 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _846 + 6u)].xyz;
    float _857 = dot(_856, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _876 = (exp2((_857 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_844 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _846 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _846 + 7u)], float4(_787.yzx, 1.0)));
    float4 _887 = float4(_787, 1.0);
    float3 _891 = _198;
    _891.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _887);
    float3 _895 = _891;
    _895.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _887);
    float3 _899 = _895;
    _899.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _887);
    float4 _902 = _887.xyzz * _887.yzzx;
    float3 _906 = _198;
    _906.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _902);
    float3 _910 = _906;
    _910.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _902);
    float3 _914 = _910;
    _914.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _902);
    float3 _928 = (float4(_856 * (_876 / _857), _876).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_899 + _914) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_787.x * _787.x) - (_787.y * _787.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _950 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _979;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _978;
        if (any(abs(_263 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _734 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _734 + 19u)].xyz + float3(1.0))))
        {
            _978 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_263, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _978 = _950;
        }
        _979 = _978;
    }
    else
    {
        _979 = _950;
    }
    float4 _986 = float4(((mix(float3(0.0), _817 + (_819 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_928 * _817) * fast::max(_828, ((((((_786 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _728) + ((_786 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _728) + ((_786 * 2.755199909210205078125) + float3(0.69029998779296875))) * _728))) + _979) * 1.0, 0.0);
    float4 _993;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _992 = _986;
        _992.w = 0.0;
        _993 = _992;
    }
    else
    {
        _993 = _986;
    }
    float2 _997 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1005 = (_787 * 0.5) + float3(0.5);
    float4 _1007 = float4(_1005.x, _1005.y, _1005.z, float4(0.0).w);
    _1007.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _735)].y;
    float4 _1008 = float4(0.0);
    _1008.x = _785;
    float4 _1009 = _1008;
    _1009.y = _784;
    float4 _1010 = _1009;
    _1010.z = _783;
    float4 _1011 = _1010;
    _1011.w = 0.75686275959014892578125;
    float4 _1023 = float4(_786.x, _786.y, _786.z, float4(0.0).w);
    _1023.w = ((log2(((dot(_928, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_828, ((((((_821 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _728) + ((_821 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _728) + ((_821 * 2.755199909210205078125) + float3(0.69029998779296875))) * _728).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_997.xyx * _997.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _993 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1007;
    out.out_var_SV_Target2 = _1011;
    out.out_var_SV_Target3 = _1023;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

