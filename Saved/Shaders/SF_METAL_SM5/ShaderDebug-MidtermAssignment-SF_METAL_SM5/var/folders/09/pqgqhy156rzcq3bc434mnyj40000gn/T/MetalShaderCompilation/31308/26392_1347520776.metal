

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

constant float _198 = {};

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

fragment MainPS_out Main_00006718_50518908(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], texture2d<float> Material_Texture2D_5 [[texture(10)]], texture2d<float> Material_Texture2D_6 [[texture(11)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _240 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _251 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _198, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _256 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _260 = _256.xyz / float3(_256.w);
    float3 _261 = _260 - View.View_PreViewTranslation;
    float4 _269 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _272 = (_269.xy * float2(2.0)) - float2(1.0);
    float2 _281 = (normalize(-_260) * _240).xy;
    float2 _283 = (_281 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _285 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _283, bias(View.View_MaterialTextureMipBias));
    float2 _288 = (_285.xy * float2(2.0)) - float2(1.0);
    float2 _297 = (_281 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _297, bias(View.View_MaterialTextureMipBias));
    float2 _302 = (_299.xy * float2(2.0)) - float2(1.0);
    float2 _311 = (_281 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _313 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _311, bias(View.View_MaterialTextureMipBias));
    float2 _316 = (_313.xy * float2(2.0)) - float2(1.0);
    float2 _325 = (_281 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _327 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _325, bias(View.View_MaterialTextureMipBias));
    float2 _330 = (_327.xy * float2(2.0)) - float2(1.0);
    float2 _339 = (_281 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _341 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _339, bias(View.View_MaterialTextureMipBias));
    float2 _344 = (_341.xy * float2(2.0)) - float2(1.0);
    float2 _353 = (_281 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _355 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _353, bias(View.View_MaterialTextureMipBias));
    float2 _358 = (_355.xy * float2(2.0)) - float2(1.0);
    float2 _367 = (_281 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _369 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _367, bias(View.View_MaterialTextureMipBias));
    float2 _372 = (_369.xy * float2(2.0)) - float2(1.0);
    float2 _381 = (_281 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _383 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _381, bias(View.View_MaterialTextureMipBias));
    float2 _386 = (_383.xy * float2(2.0)) - float2(1.0);
    float2 _395 = (_281 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _397 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _395, bias(View.View_MaterialTextureMipBias));
    float2 _400 = (_397.xy * float2(2.0)) - float2(1.0);
    float2 _409 = (_281 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _411 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _409, bias(View.View_MaterialTextureMipBias));
    float2 _414 = (_411.xy * float2(2.0)) - float2(1.0);
    float2 _423 = (_281 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _425 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _423, bias(View.View_MaterialTextureMipBias));
    float2 _428 = (_425.xy * float2(2.0)) - float2(1.0);
    float4 _439 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _409, bias(View.View_MaterialTextureMipBias));
    float4 _446 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_439.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _450 = float3(_446.x);
    float4 _453 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _395, bias(View.View_MaterialTextureMipBias));
    float4 _458 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_453.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _461 = float3(_458.x);
    float4 _464 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _381, bias(View.View_MaterialTextureMipBias));
    float4 _469 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_464.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _472 = float3(_469.x);
    float4 _475 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _367, bias(View.View_MaterialTextureMipBias));
    float4 _480 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_475.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _483 = float3(_480.x);
    float4 _486 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _353, bias(View.View_MaterialTextureMipBias));
    float4 _491 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_486.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _494 = float3(_491.x);
    float4 _497 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _339, bias(View.View_MaterialTextureMipBias));
    float4 _502 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_497.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _505 = float3(_502.x);
    float4 _508 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _325, bias(View.View_MaterialTextureMipBias));
    float4 _513 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_508.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _516 = float3(_513.x);
    float4 _519 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _311, bias(View.View_MaterialTextureMipBias));
    float4 _524 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_519.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _526 = _524.x;
    float3 _527 = float3(_526);
    float4 _530 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _297, bias(View.View_MaterialTextureMipBias));
    float4 _535 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_530.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _537 = _535.x;
    float3 _538 = float3(_537);
    float4 _541 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _283, bias(View.View_MaterialTextureMipBias));
    float4 _546 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_541.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _548 = _546.x;
    float3 _549 = float3(_548);
    float4 _554 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _555 = _554.w;
    float4 _559 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_555 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _562 = float3(_559.x);
    float3 _571 = normalize(_240 * normalize((mix(float4(_272, sqrt(fast::clamp(1.0 - dot(_272, _272), 0.0, 1.0)), 1.0).xyz, mix(float4(_288, sqrt(fast::clamp(1.0 - dot(_288, _288), 0.0, 1.0)), 1.0).xyz, mix(float4(_302, sqrt(fast::clamp(1.0 - dot(_302, _302), 0.0, 1.0)), 1.0).xyz, mix(float4(_316, sqrt(fast::clamp(1.0 - dot(_316, _316), 0.0, 1.0)), 1.0).xyz, mix(float4(_330, sqrt(fast::clamp(1.0 - dot(_330, _330), 0.0, 1.0)), 1.0).xyz, mix(float4(_344, sqrt(fast::clamp(1.0 - dot(_344, _344), 0.0, 1.0)), 1.0).xyz, mix(float4(_358, sqrt(fast::clamp(1.0 - dot(_358, _358), 0.0, 1.0)), 1.0).xyz, mix(float4(_372, sqrt(fast::clamp(1.0 - dot(_372, _372), 0.0, 1.0)), 1.0).xyz, mix(float4(_386, sqrt(fast::clamp(1.0 - dot(_386, _386), 0.0, 1.0)), 1.0).xyz, mix(float4(_400, sqrt(fast::clamp(1.0 - dot(_400, _400), 0.0, 1.0)), 1.0).xyz, mix(float4(_414, sqrt(fast::clamp(1.0 - dot(_414, _414), 0.0, 1.0)), 1.0).xyz, float4(_428, sqrt(fast::clamp(1.0 - dot(_428, _428), 0.0, 1.0)), 1.0).xyz, _450), _461), _472), _483), _494), _505), _516), _527), _538), _549), _562) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _583 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _588 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _591 = (_583.x + 0.5) * (_588.x + 0.5);
    float4 _602 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_283 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _612 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_297 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _622 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_311 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _632 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_325 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _638 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_339 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _644 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_353 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _650 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_367 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _656 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_381 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _662 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_395 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _668 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_409 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _674 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_423 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _678 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _423, bias(View.View_MaterialTextureMipBias));
    float4 _682 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _423, bias(View.View_MaterialTextureMipBias));
    float _684 = _682.y;
    float3 _685 = _678.xyz * _684;
    float4 _688 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _423, bias(View.View_MaterialTextureMipBias));
    float4 _693 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_688.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _715 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _724 = fast::clamp(mix(_554.xyz * 1.0, mix((_602.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _548, -0.0), 1.0), mix((_612.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _537, -0.0), 1.0), mix((_622.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _526, -0.0), 1.0), mix(_632.xyz * 0.699999988079071044921875, mix(_638.xyz * 0.60000002384185791015625, mix(_644.xyz * 0.5, mix(_650.xyz * 0.4000000059604644775390625, mix(_656.xyz * 0.300000011920928955078125, mix(_662.xyz * 0.20000000298023223876953125, mix(_668.xyz * 0.1500000059604644775390625, mix(_674.xyz * 0.13799999654293060302734375, _685 * 0.800000011920928955078125, float3(_693.x)), _450), _461), _472), _483), _494), _505), _516), _527), _538), _549), _562) * mix(0.5, 1.0, _591), float3(0.0), float3(1.0));
    float _725 = fast::clamp(mix((_685 * _684) * 3.0, float3(0.4000000059604644775390625), float3(_555)).x, 0.0, 1.0);
    float _726 = fast::clamp(mix(_684, _715.y, _555), 0.0, 1.0);
    float _731 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _591) + mix(_682.x, _715.x, _555)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _732 = in.in_var_PRIMITIVE_ID * 36u;
    uint _733 = _732 + 20u;
    float _781;
    float _782;
    float _783;
    float3 _784;
    float3 _785;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _733)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _751 = ((_251.xy / float2(_251.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _755 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _751, level(0.0));
        float4 _758 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _751, level(0.0));
        float4 _761 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _751, level(0.0));
        float _771 = _761.w;
        _781 = (_731 * _771) + _761.z;
        _782 = (_725 * _771) + _761.y;
        _783 = _761.x;
        _784 = (_724 * _755.w) + _755.xyz;
        _785 = normalize((_571 * _758.w) + ((_758.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _781 = _731;
        _782 = _725;
        _783 = 0.0;
        _784 = _724;
        _785 = _571;
    }
    float4 _792 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _793 = in.in_var_LIGHTMAP_ID * 15u;
    uint _794 = _793 + 1u;
    float4 _801 = fast::clamp((_792 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _794)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _794)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _818 = ((_784 - (_784 * _783)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _825 = (mix(float3(0.07999999821186065673828125 * _782), _784, float3(_783)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _828 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _833;
    if (_828)
    {
        _833 = _818 + (_825 * 0.449999988079071044921875);
    }
    else
    {
        _833 = _818;
    }
    float3 _835 = select(_825, float3(0.0), bool3(_828));
    float3 _837 = float3(dot(_835, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _844 = float3(_726);
    float2 _853 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _857 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _853);
    float4 _859 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_853 + float2(0.0, 0.5)));
    uint _865 = _793 + 4u;
    uint _870 = _793 + 6u;
    float3 _875 = _857.xyz;
    float3 _903 = ((((_875 * _875) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _865)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _870)].xyz) * ((exp2(((_857.w + ((_859.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _865)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _870)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_859 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _793 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _793 + 7u)], float4(_785.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _925 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _954;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _953;
        if (any(abs(_261 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _732 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _732 + 19u)].xyz + float3(1.0))))
        {
            _953 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_261, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _953 = _925;
        }
        _954 = _953;
    }
    else
    {
        _954 = _925;
    }
    float4 _961 = float4(((mix(float3(0.0), _833 + (_835 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_903 * _833) * fast::max(_844, ((((((_784 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _726) + ((_784 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _726) + ((_784 * 2.755199909210205078125) + float3(0.69029998779296875))) * _726))) + _954) * 1.0, 0.0);
    float4 _968;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _967 = _961;
        _967.w = 0.0;
        _968 = _967;
    }
    else
    {
        _968 = _961;
    }
    float2 _972 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _980 = (_785 * 0.5) + float3(0.5);
    float4 _982 = float4(_980.x, _980.y, _980.z, float4(0.0).w);
    _982.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _733)].y;
    float4 _983 = float4(0.0);
    _983.x = _783;
    float4 _984 = _983;
    _984.y = _782;
    float4 _985 = _984;
    _985.z = _781;
    float4 _986 = _985;
    _986.w = 0.50588238239288330078125;
    float4 _998 = float4(_784.x, _784.y, _784.z, float4(0.0).w);
    _998.w = ((log2(((dot(_903, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_844, ((((((_837 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _726) + ((_837 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _726) + ((_837 * 2.755199909210205078125) + float3(0.69029998779296875))) * _726).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_972.xyx * _972.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _968 * View.View_PreExposure;
    out.out_var_SV_Target1 = _982;
    out.out_var_SV_Target2 = _986;
    out.out_var_SV_Target3 = _998;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _793)] * _801) * _801;
    return out;
}

