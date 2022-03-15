

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

constant float4 _225 = {};
constant float3 _226 = {};
constant float _228 = {};
constant float4 _229 = {};

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

fragment MainPS_out Main_00007d95_02996868(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], texture2d<float> Material_Texture2D_4 [[texture(17)]], texture2d<float> Material_Texture2D_5 [[texture(18)]], texture2d<float> Material_Texture2D_6 [[texture(19)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _275 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _286 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _228, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _291 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _295 = _291.xyz / float3(_291.w);
    float3 _296 = _295 - View.View_PreViewTranslation;
    float4 _304 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _307 = (_304.xy * float2(2.0)) - float2(1.0);
    float2 _316 = (normalize(-_295) * _275).xy;
    float2 _318 = (_316 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _320 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _318, bias(View.View_MaterialTextureMipBias));
    float2 _323 = (_320.xy * float2(2.0)) - float2(1.0);
    float2 _332 = (_316 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _334 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _332, bias(View.View_MaterialTextureMipBias));
    float2 _337 = (_334.xy * float2(2.0)) - float2(1.0);
    float2 _346 = (_316 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _348 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _346, bias(View.View_MaterialTextureMipBias));
    float2 _351 = (_348.xy * float2(2.0)) - float2(1.0);
    float2 _360 = (_316 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _362 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _360, bias(View.View_MaterialTextureMipBias));
    float2 _365 = (_362.xy * float2(2.0)) - float2(1.0);
    float2 _374 = (_316 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _376 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _374, bias(View.View_MaterialTextureMipBias));
    float2 _379 = (_376.xy * float2(2.0)) - float2(1.0);
    float2 _388 = (_316 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _390 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _388, bias(View.View_MaterialTextureMipBias));
    float2 _393 = (_390.xy * float2(2.0)) - float2(1.0);
    float2 _402 = (_316 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _404 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _402, bias(View.View_MaterialTextureMipBias));
    float2 _407 = (_404.xy * float2(2.0)) - float2(1.0);
    float2 _416 = (_316 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _418 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _416, bias(View.View_MaterialTextureMipBias));
    float2 _421 = (_418.xy * float2(2.0)) - float2(1.0);
    float2 _430 = (_316 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _432 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _430, bias(View.View_MaterialTextureMipBias));
    float2 _435 = (_432.xy * float2(2.0)) - float2(1.0);
    float2 _444 = (_316 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _446 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _444, bias(View.View_MaterialTextureMipBias));
    float2 _449 = (_446.xy * float2(2.0)) - float2(1.0);
    float2 _458 = (_316 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _460 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _458, bias(View.View_MaterialTextureMipBias));
    float2 _463 = (_460.xy * float2(2.0)) - float2(1.0);
    float4 _474 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _444, bias(View.View_MaterialTextureMipBias));
    float4 _481 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_474.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _485 = float3(_481.x);
    float4 _488 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _430, bias(View.View_MaterialTextureMipBias));
    float4 _493 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_488.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _496 = float3(_493.x);
    float4 _499 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _416, bias(View.View_MaterialTextureMipBias));
    float4 _504 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_499.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _507 = float3(_504.x);
    float4 _510 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _402, bias(View.View_MaterialTextureMipBias));
    float4 _515 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_510.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _518 = float3(_515.x);
    float4 _521 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _388, bias(View.View_MaterialTextureMipBias));
    float4 _526 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_521.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _529 = float3(_526.x);
    float4 _532 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _374, bias(View.View_MaterialTextureMipBias));
    float4 _537 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_532.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _540 = float3(_537.x);
    float4 _543 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _360, bias(View.View_MaterialTextureMipBias));
    float4 _548 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_543.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _551 = float3(_548.x);
    float4 _554 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _346, bias(View.View_MaterialTextureMipBias));
    float4 _559 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_554.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _561 = _559.x;
    float3 _562 = float3(_561);
    float4 _565 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _332, bias(View.View_MaterialTextureMipBias));
    float4 _570 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_565.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _572 = _570.x;
    float3 _573 = float3(_572);
    float4 _576 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _318, bias(View.View_MaterialTextureMipBias));
    float4 _581 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_576.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _583 = _581.x;
    float3 _584 = float3(_583);
    float4 _589 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _590 = _589.w;
    float4 _594 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_590 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _597 = float3(_594.x);
    float3 _606 = normalize(_275 * normalize((mix(float4(_307, sqrt(fast::clamp(1.0 - dot(_307, _307), 0.0, 1.0)), 1.0).xyz, mix(float4(_323, sqrt(fast::clamp(1.0 - dot(_323, _323), 0.0, 1.0)), 1.0).xyz, mix(float4(_337, sqrt(fast::clamp(1.0 - dot(_337, _337), 0.0, 1.0)), 1.0).xyz, mix(float4(_351, sqrt(fast::clamp(1.0 - dot(_351, _351), 0.0, 1.0)), 1.0).xyz, mix(float4(_365, sqrt(fast::clamp(1.0 - dot(_365, _365), 0.0, 1.0)), 1.0).xyz, mix(float4(_379, sqrt(fast::clamp(1.0 - dot(_379, _379), 0.0, 1.0)), 1.0).xyz, mix(float4(_393, sqrt(fast::clamp(1.0 - dot(_393, _393), 0.0, 1.0)), 1.0).xyz, mix(float4(_407, sqrt(fast::clamp(1.0 - dot(_407, _407), 0.0, 1.0)), 1.0).xyz, mix(float4(_421, sqrt(fast::clamp(1.0 - dot(_421, _421), 0.0, 1.0)), 1.0).xyz, mix(float4(_435, sqrt(fast::clamp(1.0 - dot(_435, _435), 0.0, 1.0)), 1.0).xyz, mix(float4(_449, sqrt(fast::clamp(1.0 - dot(_449, _449), 0.0, 1.0)), 1.0).xyz, float4(_463, sqrt(fast::clamp(1.0 - dot(_463, _463), 0.0, 1.0)), 1.0).xyz, _485), _496), _507), _518), _529), _540), _551), _562), _573), _584), _597) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _618 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _623 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _626 = (_618.x + 0.5) * (_623.x + 0.5);
    float4 _637 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_318 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _647 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_332 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _657 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_346 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _667 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_360 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _673 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_374 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _679 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_388 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _685 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_402 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _691 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_416 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _697 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_430 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _703 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_444 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _709 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_458 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _713 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _458, bias(View.View_MaterialTextureMipBias));
    float4 _717 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _458, bias(View.View_MaterialTextureMipBias));
    float _719 = _717.y;
    float3 _720 = _713.xyz * _719;
    float4 _723 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _458, bias(View.View_MaterialTextureMipBias));
    float4 _728 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_723.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _750 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _759 = fast::clamp(mix(_589.xyz * 1.0, mix((_637.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _583, -0.0), 1.0), mix((_647.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _572, -0.0), 1.0), mix((_657.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _561, -0.0), 1.0), mix(_667.xyz * 0.699999988079071044921875, mix(_673.xyz * 0.60000002384185791015625, mix(_679.xyz * 0.5, mix(_685.xyz * 0.4000000059604644775390625, mix(_691.xyz * 0.300000011920928955078125, mix(_697.xyz * 0.20000000298023223876953125, mix(_703.xyz * 0.1500000059604644775390625, mix(_709.xyz * 0.13799999654293060302734375, _720 * 0.800000011920928955078125, float3(_728.x)), _485), _496), _507), _518), _529), _540), _551), _562), _573), _584), _597) * mix(0.5, 1.0, _626), float3(0.0), float3(1.0));
    float _760 = fast::clamp(mix((_720 * _719) * 3.0, float3(0.4000000059604644775390625), float3(_590)).x, 0.0, 1.0);
    float _761 = fast::clamp(mix(_719, _750.y, _590), 0.0, 1.0);
    float _766 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _626) + mix(_717.x, _750.x, _590)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _767 = in.in_var_PRIMITIVE_ID * 36u;
    uint _768 = _767 + 20u;
    float _816;
    float _817;
    float _818;
    float3 _819;
    float3 _820;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _768)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _786 = ((_286.xy / float2(_286.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _790 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _786, level(0.0));
        float4 _793 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _786, level(0.0));
        float4 _796 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _786, level(0.0));
        float _806 = _796.w;
        _816 = (_766 * _806) + _796.z;
        _817 = (_760 * _806) + _796.y;
        _818 = _796.x;
        _819 = (_759 * _790.w) + _790.xyz;
        _820 = normalize((_606 * _793.w) + ((_793.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _816 = _766;
        _817 = _760;
        _818 = 0.0;
        _819 = _759;
        _820 = _606;
    }
    float3 _830 = fast::clamp((_296 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _841 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_830.x), int(_830.y), int(_830.z), 0).xyz), 0));
    float3 _856 = (((_841.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_830 / float3(_841.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _869;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _768)].z > 0.0)
    {
        _869 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _856, level(0.0)).x;
    }
    else
    {
        _869 = 1.0;
    }
    float3 _883 = ((_819 - (_819 * _818)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _890 = (mix(float3(0.07999999821186065673828125 * _817), _819, float3(_818)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _893 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _898;
    if (_893)
    {
        _898 = _883 + (_890 * 0.449999988079071044921875);
    }
    else
    {
        _898 = _883;
    }
    float3 _900 = select(_890, float3(0.0), bool3(_893));
    float3 _902 = float3(dot(_900, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _909 = float3(_761);
    float4 _920 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _856, level(0.0));
    float _936 = _920.x;
    float4 _938 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _856, level(0.0)) * 2.0) - float4(1.0)) * _936) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _939 = _920.y;
    float4 _941 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _856, level(0.0)) * 2.0) - float4(1.0)) * _939) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _942 = _920.z;
    float4 _944 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _856, level(0.0)) * 2.0) - float4(1.0)) * _942) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _961 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _856, level(0.0)) * 2.0) - float4(1.0)) * _936) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _963 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _856, level(0.0)) * 2.0) - float4(1.0)) * _939) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _965 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _856, level(0.0)) * 2.0) - float4(1.0)) * _942) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _998 = _229;
    _998.y = (-0.48860299587249755859375) * _820.y;
    float4 _1001 = _998;
    _1001.z = 0.48860299587249755859375 * _820.z;
    float4 _1004 = _1001;
    _1004.w = (-0.48860299587249755859375) * _820.x;
    float3 _1005 = _820 * _820;
    float4 _1008 = _225;
    _1008.x = (1.09254801273345947265625 * _820.x) * _820.y;
    float4 _1011 = _1008;
    _1011.y = ((-1.09254801273345947265625) * _820.y) * _820.z;
    float4 _1016 = _1011;
    _1016.z = 0.3153919875621795654296875 * ((3.0 * _1005.z) - 1.0);
    float4 _1019 = _1016;
    _1019.w = ((-1.09254801273345947265625) * _820.x) * _820.z;
    float4 _1023 = _1004;
    _1023.x = 0.886227548122406005859375;
    float3 _1025 = _1023.yzw * 2.094395160675048828125;
    float4 _1026 = float4(_1023.x, _1025.x, _1025.y, _1025.z);
    float4 _1027 = _1019 * 0.785398185253143310546875;
    float _1028 = (_1005.x - _1005.y) * 0.4290426075458526611328125;
    float3 _1034 = float3(0.0);
    _1034.x = (dot(float4(_936, _938.xyz), _1026) + dot(float4(_938.w, _961.xyz), _1027)) + (_961.w * _1028);
    float3 _1040 = _1034;
    _1040.y = (dot(float4(_939, _941.xyz), _1026) + dot(float4(_941.w, _963.xyz), _1027)) + (_963.w * _1028);
    float3 _1046 = _1040;
    _1046.z = (dot(float4(_942, _944.xyz), _1026) + dot(float4(_944.w, _965.xyz), _1027)) + (_965.w * _1028);
    float _1075;
    float _1076;
    float3 _1077;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _1062 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _856, level(0.0)).xyz * 2.0) - float3(1.0);
        float _1063 = length(_1062);
        float3 _1066 = _1062 / float3(fast::max(_1063, 9.9999997473787516355514526367188e-05));
        float _1067 = 1.0 - _1063;
        float _1069 = 1.0 - (_1067 * _1067);
        _1075 = mix(fast::clamp(dot(_1066, _820), 0.0, 1.0), 1.0, _1069);
        _1076 = _1063;
        _1077 = mix(_1066, _820, float3(_1069));
    }
    else
    {
        _1075 = 1.0;
        _1076 = 1.0;
        _1077 = _820;
    }
    float4 _1081 = float4(_1077, 1.0);
    float3 _1085 = _226;
    _1085.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _1081);
    float3 _1089 = _1085;
    _1089.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _1081);
    float3 _1093 = _1089;
    _1093.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _1081);
    float4 _1096 = _1081.xyzz * _1081.yzzx;
    float3 _1100 = _226;
    _1100.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _1096);
    float3 _1104 = _1100;
    _1104.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _1096);
    float3 _1108 = _1104;
    _1108.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _1096);
    float3 _1123 = ((fast::max(float3(0.0), _1046) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_1093 + _1108) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_1077.x * _1077.x) - (_1077.y * _1077.y)))) * View.View_SkyLightColor.xyz) * (_1076 * _1075));
    float3 _1145 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1174;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1173;
        if (any(abs(_296 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _767 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _767 + 19u)].xyz + float3(1.0))))
        {
            _1173 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_296, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1173 = _1145;
        }
        _1174 = _1173;
    }
    else
    {
        _1174 = _1145;
    }
    float4 _1181 = float4(((mix(float3(0.0), _898 + (_900 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_1123 * _898) * fast::max(_909, ((((((_819 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _761) + ((_819 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _761) + ((_819 * 2.755199909210205078125) + float3(0.69029998779296875))) * _761))) + _1174) * 1.0, 0.0);
    float4 _1188;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1187 = _1181;
        _1187.w = 0.0;
        _1188 = _1187;
    }
    else
    {
        _1188 = _1181;
    }
    float2 _1192 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1200 = (_820 * 0.5) + float3(0.5);
    float4 _1202 = float4(_1200.x, _1200.y, _1200.z, float4(0.0).w);
    _1202.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _768)].y;
    float4 _1203 = float4(0.0);
    _1203.x = _818;
    float4 _1204 = _1203;
    _1204.y = _817;
    float4 _1205 = _1204;
    _1205.z = _816;
    float4 _1206 = _1205;
    _1206.w = 0.50588238239288330078125;
    float4 _1218 = float4(_819.x, _819.y, _819.z, float4(0.0).w);
    _1218.w = ((log2(((dot(_1123, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_909, ((((((_902 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _761) + ((_902 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _761) + ((_902 * 2.755199909210205078125) + float3(0.69029998779296875))) * _761).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1192.xyx * _1192.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1188 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1202;
    out.out_var_SV_Target2 = _1206;
    out.out_var_SV_Target3 = _1218;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_869, 1.0, 1.0, 1.0);
    return out;
}

