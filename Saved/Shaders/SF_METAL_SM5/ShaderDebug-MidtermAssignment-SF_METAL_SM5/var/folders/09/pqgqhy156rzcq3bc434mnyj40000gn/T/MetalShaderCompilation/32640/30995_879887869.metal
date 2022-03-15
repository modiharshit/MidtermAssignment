

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
    char _m0_pad[64];
    float4 IndirectLightingCache_PointSkyBentNormal;
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

constant float4 _214 = {};
constant float3 _215 = {};
constant float _217 = {};
constant float4 _218 = {};

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

fragment MainPS_out Main_00007913_347205fd(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], texture2d<float> Material_Texture2D_5 [[texture(10)]], texture2d<float> Material_Texture2D_6 [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _264 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _275 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _217, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _280 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _284 = _280.xyz / float3(_280.w);
    float3 _285 = _284 - View.View_PreViewTranslation;
    float4 _293 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _296 = (_293.xy * float2(2.0)) - float2(1.0);
    float2 _305 = (normalize(-_284) * _264).xy;
    float2 _307 = (_305 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _309 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _307, bias(View.View_MaterialTextureMipBias));
    float2 _312 = (_309.xy * float2(2.0)) - float2(1.0);
    float2 _321 = (_305 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _323 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _321, bias(View.View_MaterialTextureMipBias));
    float2 _326 = (_323.xy * float2(2.0)) - float2(1.0);
    float2 _335 = (_305 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _337 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _335, bias(View.View_MaterialTextureMipBias));
    float2 _340 = (_337.xy * float2(2.0)) - float2(1.0);
    float2 _349 = (_305 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _351 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _349, bias(View.View_MaterialTextureMipBias));
    float2 _354 = (_351.xy * float2(2.0)) - float2(1.0);
    float2 _363 = (_305 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _365 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _363, bias(View.View_MaterialTextureMipBias));
    float2 _368 = (_365.xy * float2(2.0)) - float2(1.0);
    float2 _377 = (_305 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _379 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _377, bias(View.View_MaterialTextureMipBias));
    float2 _382 = (_379.xy * float2(2.0)) - float2(1.0);
    float2 _391 = (_305 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _393 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _391, bias(View.View_MaterialTextureMipBias));
    float2 _396 = (_393.xy * float2(2.0)) - float2(1.0);
    float2 _405 = (_305 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _407 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _405, bias(View.View_MaterialTextureMipBias));
    float2 _410 = (_407.xy * float2(2.0)) - float2(1.0);
    float2 _419 = (_305 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _421 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _419, bias(View.View_MaterialTextureMipBias));
    float2 _424 = (_421.xy * float2(2.0)) - float2(1.0);
    float2 _433 = (_305 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _435 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _433, bias(View.View_MaterialTextureMipBias));
    float2 _438 = (_435.xy * float2(2.0)) - float2(1.0);
    float2 _447 = (_305 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _449 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _447, bias(View.View_MaterialTextureMipBias));
    float2 _452 = (_449.xy * float2(2.0)) - float2(1.0);
    float4 _463 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _433, bias(View.View_MaterialTextureMipBias));
    float4 _470 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_463.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _474 = float3(_470.x);
    float4 _477 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _419, bias(View.View_MaterialTextureMipBias));
    float4 _482 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_477.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _485 = float3(_482.x);
    float4 _488 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _405, bias(View.View_MaterialTextureMipBias));
    float4 _493 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_488.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _496 = float3(_493.x);
    float4 _499 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _391, bias(View.View_MaterialTextureMipBias));
    float4 _504 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_499.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _507 = float3(_504.x);
    float4 _510 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _377, bias(View.View_MaterialTextureMipBias));
    float4 _515 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_510.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _518 = float3(_515.x);
    float4 _521 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _363, bias(View.View_MaterialTextureMipBias));
    float4 _526 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_521.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _529 = float3(_526.x);
    float4 _532 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _349, bias(View.View_MaterialTextureMipBias));
    float4 _537 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_532.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _540 = float3(_537.x);
    float4 _543 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _335, bias(View.View_MaterialTextureMipBias));
    float4 _548 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_543.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _550 = _548.x;
    float3 _551 = float3(_550);
    float4 _554 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _321, bias(View.View_MaterialTextureMipBias));
    float4 _559 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_554.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _561 = _559.x;
    float3 _562 = float3(_561);
    float4 _565 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _307, bias(View.View_MaterialTextureMipBias));
    float4 _570 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_565.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _572 = _570.x;
    float3 _573 = float3(_572);
    float4 _578 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _579 = _578.w;
    float4 _583 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_579 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _586 = float3(_583.x);
    float3 _595 = normalize(_264 * normalize((mix(float4(_296, sqrt(fast::clamp(1.0 - dot(_296, _296), 0.0, 1.0)), 1.0).xyz, mix(float4(_312, sqrt(fast::clamp(1.0 - dot(_312, _312), 0.0, 1.0)), 1.0).xyz, mix(float4(_326, sqrt(fast::clamp(1.0 - dot(_326, _326), 0.0, 1.0)), 1.0).xyz, mix(float4(_340, sqrt(fast::clamp(1.0 - dot(_340, _340), 0.0, 1.0)), 1.0).xyz, mix(float4(_354, sqrt(fast::clamp(1.0 - dot(_354, _354), 0.0, 1.0)), 1.0).xyz, mix(float4(_368, sqrt(fast::clamp(1.0 - dot(_368, _368), 0.0, 1.0)), 1.0).xyz, mix(float4(_382, sqrt(fast::clamp(1.0 - dot(_382, _382), 0.0, 1.0)), 1.0).xyz, mix(float4(_396, sqrt(fast::clamp(1.0 - dot(_396, _396), 0.0, 1.0)), 1.0).xyz, mix(float4(_410, sqrt(fast::clamp(1.0 - dot(_410, _410), 0.0, 1.0)), 1.0).xyz, mix(float4(_424, sqrt(fast::clamp(1.0 - dot(_424, _424), 0.0, 1.0)), 1.0).xyz, mix(float4(_438, sqrt(fast::clamp(1.0 - dot(_438, _438), 0.0, 1.0)), 1.0).xyz, float4(_452, sqrt(fast::clamp(1.0 - dot(_452, _452), 0.0, 1.0)), 1.0).xyz, _474), _485), _496), _507), _518), _529), _540), _551), _562), _573), _586) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _607 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _612 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _615 = (_607.x + 0.5) * (_612.x + 0.5);
    float4 _626 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_307 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _636 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_321 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _646 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_335 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _656 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_349 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _662 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_363 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _668 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_377 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _674 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_391 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _680 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_405 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _686 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_419 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _692 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_433 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _698 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_447 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _702 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _447, bias(View.View_MaterialTextureMipBias));
    float4 _706 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _447, bias(View.View_MaterialTextureMipBias));
    float _708 = _706.y;
    float3 _709 = _702.xyz * _708;
    float4 _712 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _447, bias(View.View_MaterialTextureMipBias));
    float4 _717 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_712.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _739 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _748 = fast::clamp(mix(_578.xyz * 1.0, mix((_626.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _572, -0.0), 1.0), mix((_636.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _561, -0.0), 1.0), mix((_646.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _550, -0.0), 1.0), mix(_656.xyz * 0.699999988079071044921875, mix(_662.xyz * 0.60000002384185791015625, mix(_668.xyz * 0.5, mix(_674.xyz * 0.4000000059604644775390625, mix(_680.xyz * 0.300000011920928955078125, mix(_686.xyz * 0.20000000298023223876953125, mix(_692.xyz * 0.1500000059604644775390625, mix(_698.xyz * 0.13799999654293060302734375, _709 * 0.800000011920928955078125, float3(_717.x)), _474), _485), _496), _507), _518), _529), _540), _551), _562), _573), _586) * mix(0.5, 1.0, _615), float3(0.0), float3(1.0));
    float _749 = fast::clamp(mix((_709 * _708) * 3.0, float3(0.4000000059604644775390625), float3(_579)).x, 0.0, 1.0);
    float _750 = fast::clamp(mix(_708, _739.y, _579), 0.0, 1.0);
    float _755 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _615) + mix(_706.x, _739.x, _579)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _756 = in.in_var_PRIMITIVE_ID * 36u;
    uint _757 = _756 + 20u;
    float _805;
    float _806;
    float _807;
    float3 _808;
    float3 _809;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _757)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _775 = ((_275.xy / float2(_275.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _779 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _775, level(0.0));
        float4 _782 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _775, level(0.0));
        float4 _785 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _775, level(0.0));
        float _795 = _785.w;
        _805 = (_755 * _795) + _785.z;
        _806 = (_749 * _795) + _785.y;
        _807 = _785.x;
        _808 = (_748 * _779.w) + _779.xyz;
        _809 = normalize((_595 * _782.w) + ((_782.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _805 = _755;
        _806 = _749;
        _807 = 0.0;
        _808 = _748;
        _809 = _595;
    }
    bool _819 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _825;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _756 + 18u)].w > 0.0) && _819)
    {
        _825 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _825 = 1.0;
    }
    float _872;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _757)].z > 0.0)
    {
        float3 _840 = fast::clamp((_285 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _851 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_840.x), int(_840.y), int(_840.z), 0).xyz), 0));
        _872 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_851.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_840 / float3(_851.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _872 = _825;
    }
    float3 _886 = ((_808 - (_808 * _807)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _893 = (mix(float3(0.07999999821186065673828125 * _806), _808, float3(_807)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _896 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _901;
    if (_896)
    {
        _901 = _886 + (_893 * 0.449999988079071044921875);
    }
    else
    {
        _901 = _886;
    }
    float3 _903 = select(_893, float3(0.0), bool3(_896));
    float3 _905 = float3(dot(_903, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _912 = float3(_750);
    float3 _992;
    if (_819)
    {
        float4 _942 = _218;
        _942.y = (-0.48860299587249755859375) * _809.y;
        float4 _945 = _942;
        _945.z = 0.48860299587249755859375 * _809.z;
        float4 _948 = _945;
        _948.w = (-0.48860299587249755859375) * _809.x;
        float3 _949 = _809 * _809;
        float4 _952 = _214;
        _952.x = (1.09254801273345947265625 * _809.x) * _809.y;
        float4 _955 = _952;
        _955.y = ((-1.09254801273345947265625) * _809.y) * _809.z;
        float4 _960 = _955;
        _960.z = 0.3153919875621795654296875 * ((3.0 * _949.z) - 1.0);
        float4 _963 = _960;
        _963.w = ((-1.09254801273345947265625) * _809.x) * _809.z;
        float4 _967 = _948;
        _967.x = 0.886227548122406005859375;
        float3 _969 = _967.yzw * 2.094395160675048828125;
        float4 _970 = float4(_967.x, _969.x, _969.y, _969.z);
        float4 _971 = _963 * 0.785398185253143310546875;
        float _972 = (_949.x - _949.y) * 0.4290426075458526611328125;
        float3 _978 = float3(0.0);
        _978.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _970) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _971)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _972);
        float3 _984 = _978;
        _984.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _970) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _971)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _972);
        float3 _990 = _984;
        _990.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _970) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _971)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _972);
        _992 = fast::max(float3(0.0), _990);
    }
    else
    {
        _992 = float3(0.0);
    }
    float _1018;
    float _1019;
    float3 _1020;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _1008;
        float _1009;
        if (_819)
        {
            _1008 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.xyz;
            _1009 = IndirectLightingCache.IndirectLightingCache_PointSkyBentNormal.w;
        }
        else
        {
            _1008 = _809;
            _1009 = 1.0;
        }
        float _1010 = 1.0 - _1009;
        float _1012 = 1.0 - (_1010 * _1010);
        _1018 = mix(fast::clamp(dot(_1008, _809), 0.0, 1.0), 1.0, _1012);
        _1019 = _1009;
        _1020 = mix(_1008, _809, float3(_1012));
    }
    else
    {
        _1018 = 1.0;
        _1019 = 1.0;
        _1020 = _809;
    }
    float4 _1024 = float4(_1020, 1.0);
    float3 _1028 = _215;
    _1028.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _1024);
    float3 _1032 = _1028;
    _1032.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _1024);
    float3 _1036 = _1032;
    _1036.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _1024);
    float4 _1039 = _1024.xyzz * _1024.yzzx;
    float3 _1043 = _215;
    _1043.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _1039);
    float3 _1047 = _1043;
    _1047.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _1039);
    float3 _1051 = _1047;
    _1051.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _1039);
    float3 _1066 = (_992 * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_1036 + _1051) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_1020.x * _1020.x) - (_1020.y * _1020.y)))) * View.View_SkyLightColor.xyz) * (_1019 * _1018));
    float3 _1088 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1117;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1116;
        if (any(abs(_285 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _756 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _756 + 19u)].xyz + float3(1.0))))
        {
            _1116 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_285, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1116 = _1088;
        }
        _1117 = _1116;
    }
    else
    {
        _1117 = _1088;
    }
    float4 _1124 = float4(((mix(float3(0.0), _901 + (_903 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_1066 * _901) * fast::max(_912, ((((((_808 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _750) + ((_808 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _750) + ((_808 * 2.755199909210205078125) + float3(0.69029998779296875))) * _750))) + _1117) * 1.0, 0.0);
    float4 _1131;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1130 = _1124;
        _1130.w = 0.0;
        _1131 = _1130;
    }
    else
    {
        _1131 = _1124;
    }
    float2 _1135 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1143 = (_809 * 0.5) + float3(0.5);
    float4 _1145 = float4(_1143.x, _1143.y, _1143.z, float4(0.0).w);
    _1145.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _757)].y;
    float4 _1146 = float4(0.0);
    _1146.x = _807;
    float4 _1147 = _1146;
    _1147.y = _806;
    float4 _1148 = _1147;
    _1148.z = _805;
    float4 _1149 = _1148;
    _1149.w = 0.50588238239288330078125;
    float4 _1161 = float4(_808.x, _808.y, _808.z, float4(0.0).w);
    _1161.w = ((log2(((dot(_1066, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_912, ((((((_905 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _750) + ((_905 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _750) + ((_905 * 2.755199909210205078125) + float3(0.69029998779296875))) * _750).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1135.xyx * _1135.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1131 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1145;
    out.out_var_SV_Target2 = _1149;
    out.out_var_SV_Target3 = _1161;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_872, 1.0, 1.0, 1.0);
    return out;
}

