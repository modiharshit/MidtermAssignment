

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

constant float4 _219 = {};
constant float _221 = {};
constant float4 _222 = {};

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

fragment MainPS_out Main_000073fb_e8556feb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], texture2d<float> Material_Texture2D_4 [[texture(16)]], texture2d<float> Material_Texture2D_5 [[texture(17)]], texture2d<float> Material_Texture2D_6 [[texture(18)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], sampler Material_Texture2D_5Sampler [[sampler(7)]], sampler Material_Texture2D_6Sampler [[sampler(8)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _267 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _278 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _221, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _283 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _287 = _283.xyz / float3(_283.w);
    float3 _288 = _287 - View.View_PreViewTranslation;
    float4 _296 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _299 = (_296.xy * float2(2.0)) - float2(1.0);
    float2 _308 = (normalize(-_287) * _267).xy;
    float2 _310 = (_308 * (-0.0040000001899898052215576171875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _312 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _310, bias(View.View_MaterialTextureMipBias));
    float2 _315 = (_312.xy * float2(2.0)) - float2(1.0);
    float2 _324 = (_308 * (-0.008000000379979610443115234375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _326 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _324, bias(View.View_MaterialTextureMipBias));
    float2 _329 = (_326.xy * float2(2.0)) - float2(1.0);
    float2 _338 = (_308 * (-0.01200000010430812835693359375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _340 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _338, bias(View.View_MaterialTextureMipBias));
    float2 _343 = (_340.xy * float2(2.0)) - float2(1.0);
    float2 _352 = (_308 * (-0.01600000075995922088623046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _354 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _352, bias(View.View_MaterialTextureMipBias));
    float2 _357 = (_354.xy * float2(2.0)) - float2(1.0);
    float2 _366 = (_308 * (-0.02000000141561031341552734375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _368 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _366, bias(View.View_MaterialTextureMipBias));
    float2 _371 = (_368.xy * float2(2.0)) - float2(1.0);
    float2 _380 = (_308 * (-0.0240000002086162567138671875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _382 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _380, bias(View.View_MaterialTextureMipBias));
    float2 _385 = (_382.xy * float2(2.0)) - float2(1.0);
    float2 _394 = (_308 * (-0.0280000008642673492431640625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _396 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _394, bias(View.View_MaterialTextureMipBias));
    float2 _399 = (_396.xy * float2(2.0)) - float2(1.0);
    float2 _408 = (_308 * (-0.0328000001609325408935546875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _410 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _408, bias(View.View_MaterialTextureMipBias));
    float2 _413 = (_410.xy * float2(2.0)) - float2(1.0);
    float2 _422 = (_308 * (-0.0375999994575977325439453125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _424 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _422, bias(View.View_MaterialTextureMipBias));
    float2 _427 = (_424.xy * float2(2.0)) - float2(1.0);
    float2 _436 = (_308 * (-0.0439999997615814208984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _438 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _436, bias(View.View_MaterialTextureMipBias));
    float2 _441 = (_438.xy * float2(2.0)) - float2(1.0);
    float2 _450 = (_308 * (-0.0512000061571598052978515625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _452 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _450, bias(View.View_MaterialTextureMipBias));
    float2 _455 = (_452.xy * float2(2.0)) - float2(1.0);
    float4 _466 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _436, bias(View.View_MaterialTextureMipBias));
    float4 _473 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_466.w + (-0.0500000007450580596923828125)), bias(View.View_MaterialTextureMipBias));
    float3 _477 = float3(_473.x);
    float4 _480 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _422, bias(View.View_MaterialTextureMipBias));
    float4 _485 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_480.w + (-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float3 _488 = float3(_485.x);
    float4 _491 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _408, bias(View.View_MaterialTextureMipBias));
    float4 _496 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_491.w + (-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float3 _499 = float3(_496.x);
    float4 _502 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _394, bias(View.View_MaterialTextureMipBias));
    float4 _507 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_502.w + (-0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float3 _510 = float3(_507.x);
    float4 _513 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _380, bias(View.View_MaterialTextureMipBias));
    float4 _518 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_513.w + (-0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float3 _521 = float3(_518.x);
    float4 _524 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _366, bias(View.View_MaterialTextureMipBias));
    float4 _529 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_524.w + (-0.5)), bias(View.View_MaterialTextureMipBias));
    float3 _532 = float3(_529.x);
    float4 _535 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _352, bias(View.View_MaterialTextureMipBias));
    float4 _540 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_535.w + (-0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float3 _543 = float3(_540.x);
    float4 _546 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _338, bias(View.View_MaterialTextureMipBias));
    float4 _551 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_546.w + (-0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float _553 = _551.x;
    float3 _554 = float3(_553);
    float4 _557 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _324, bias(View.View_MaterialTextureMipBias));
    float4 _562 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_557.w + (-0.7400000095367431640625)), bias(View.View_MaterialTextureMipBias));
    float _564 = _562.x;
    float3 _565 = float3(_564);
    float4 _568 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _310, bias(View.View_MaterialTextureMipBias));
    float4 _573 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_568.w + (-0.7599999904632568359375)), bias(View.View_MaterialTextureMipBias));
    float _575 = _573.x;
    float3 _576 = float3(_575);
    float4 _581 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _582 = _581.w;
    float4 _586 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_582 + (-0.89999997615814208984375)), bias(View.View_MaterialTextureMipBias));
    float3 _589 = float3(_586.x);
    float3 _598 = normalize(_267 * normalize((mix(float4(_299, sqrt(fast::clamp(1.0 - dot(_299, _299), 0.0, 1.0)), 1.0).xyz, mix(float4(_315, sqrt(fast::clamp(1.0 - dot(_315, _315), 0.0, 1.0)), 1.0).xyz, mix(float4(_329, sqrt(fast::clamp(1.0 - dot(_329, _329), 0.0, 1.0)), 1.0).xyz, mix(float4(_343, sqrt(fast::clamp(1.0 - dot(_343, _343), 0.0, 1.0)), 1.0).xyz, mix(float4(_357, sqrt(fast::clamp(1.0 - dot(_357, _357), 0.0, 1.0)), 1.0).xyz, mix(float4(_371, sqrt(fast::clamp(1.0 - dot(_371, _371), 0.0, 1.0)), 1.0).xyz, mix(float4(_385, sqrt(fast::clamp(1.0 - dot(_385, _385), 0.0, 1.0)), 1.0).xyz, mix(float4(_399, sqrt(fast::clamp(1.0 - dot(_399, _399), 0.0, 1.0)), 1.0).xyz, mix(float4(_413, sqrt(fast::clamp(1.0 - dot(_413, _413), 0.0, 1.0)), 1.0).xyz, mix(float4(_427, sqrt(fast::clamp(1.0 - dot(_427, _427), 0.0, 1.0)), 1.0).xyz, mix(float4(_441, sqrt(fast::clamp(1.0 - dot(_441, _441), 0.0, 1.0)), 1.0).xyz, float4(_455, sqrt(fast::clamp(1.0 - dot(_455, _455), 0.0, 1.0)), 1.0).xyz, _477), _488), _499), _510), _521), _532), _543), _554), _565), _576), _589) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _610 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _615 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _618 = (_610.x + 0.5) * (_615.x + 0.5);
    float4 _629 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_310 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _639 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_324 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _649 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_338 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _659 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_352 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _665 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_366 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _671 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_380 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _677 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_394 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _683 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_408 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _689 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_422 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _695 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_436 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _701 = Material_Texture2D_5.sample(Material_Texture2D_5Sampler, ((_450 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _705 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _450, bias(View.View_MaterialTextureMipBias));
    float4 _709 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, _450, bias(View.View_MaterialTextureMipBias));
    float _711 = _709.y;
    float3 _712 = _705.xyz * _711;
    float4 _715 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _450, bias(View.View_MaterialTextureMipBias));
    float4 _720 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(_715.w + (-0.02500000037252902984619140625)), bias(View.View_MaterialTextureMipBias));
    float4 _742 = Material_Texture2D_6.sample(Material_Texture2D_6Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _751 = fast::clamp(mix(_581.xyz * 1.0, mix((_629.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _575, -0.0), 1.0), mix((_639.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _564, -0.0), 1.0), mix((_649.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _553, -0.0), 1.0), mix(_659.xyz * 0.699999988079071044921875, mix(_665.xyz * 0.60000002384185791015625, mix(_671.xyz * 0.5, mix(_677.xyz * 0.4000000059604644775390625, mix(_683.xyz * 0.300000011920928955078125, mix(_689.xyz * 0.20000000298023223876953125, mix(_695.xyz * 0.1500000059604644775390625, mix(_701.xyz * 0.13799999654293060302734375, _712 * 0.800000011920928955078125, float3(_720.x)), _477), _488), _499), _510), _521), _532), _543), _554), _565), _576), _589) * mix(0.5, 1.0, _618), float3(0.0), float3(1.0));
    float _752 = fast::clamp(mix((_712 * _711) * 3.0, float3(0.4000000059604644775390625), float3(_582)).x, 0.0, 1.0);
    float _753 = fast::clamp(mix(_711, _742.y, _582), 0.0, 1.0);
    float _758 = (fast::clamp(mix(0.20000000298023223876953125, 1.5, mix(-0.300000011920928955078125, 0.100000001490116119384765625, _618) + mix(_709.x, _742.x, _582)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _759 = in.in_var_PRIMITIVE_ID * 36u;
    uint _760 = _759 + 20u;
    float _808;
    float _809;
    float _810;
    float3 _811;
    float3 _812;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _760)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _778 = ((_278.xy / float2(_278.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _782 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _778, level(0.0));
        float4 _785 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _778, level(0.0));
        float4 _788 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _778, level(0.0));
        float _798 = _788.w;
        _808 = (_758 * _798) + _788.z;
        _809 = (_752 * _798) + _788.y;
        _810 = _788.x;
        _811 = (_751 * _782.w) + _782.xyz;
        _812 = normalize((_598 * _785.w) + ((_785.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _808 = _758;
        _809 = _752;
        _810 = 0.0;
        _811 = _751;
        _812 = _598;
    }
    float3 _822 = fast::clamp((_288 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _833 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_822.x), int(_822.y), int(_822.z), 0).xyz), 0));
    float3 _848 = (((_833.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_822 / float3(_833.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _861;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _760)].z > 0.0)
    {
        _861 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _848, level(0.0)).x;
    }
    else
    {
        _861 = 1.0;
    }
    float3 _875 = ((_811 - (_811 * _810)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _882 = (mix(float3(0.07999999821186065673828125 * _809), _811, float3(_810)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _885 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _890;
    if (_885)
    {
        _890 = _875 + (_882 * 0.449999988079071044921875);
    }
    else
    {
        _890 = _875;
    }
    float3 _892 = select(_882, float3(0.0), bool3(_885));
    float3 _894 = float3(dot(_892, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _901 = float3(_753);
    float4 _912 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _848, level(0.0));
    float _928 = _912.x;
    float4 _930 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _848, level(0.0)) * 2.0) - float4(1.0)) * _928) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _931 = _912.y;
    float4 _933 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _848, level(0.0)) * 2.0) - float4(1.0)) * _931) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _934 = _912.z;
    float4 _936 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _848, level(0.0)) * 2.0) - float4(1.0)) * _934) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _953 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _848, level(0.0)) * 2.0) - float4(1.0)) * _928) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _955 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _848, level(0.0)) * 2.0) - float4(1.0)) * _931) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _957 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _848, level(0.0)) * 2.0) - float4(1.0)) * _934) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _990 = _222;
    _990.y = (-0.48860299587249755859375) * _812.y;
    float4 _993 = _990;
    _993.z = 0.48860299587249755859375 * _812.z;
    float4 _996 = _993;
    _996.w = (-0.48860299587249755859375) * _812.x;
    float3 _997 = _812 * _812;
    float4 _1000 = _219;
    _1000.x = (1.09254801273345947265625 * _812.x) * _812.y;
    float4 _1003 = _1000;
    _1003.y = ((-1.09254801273345947265625) * _812.y) * _812.z;
    float4 _1008 = _1003;
    _1008.z = 0.3153919875621795654296875 * ((3.0 * _997.z) - 1.0);
    float4 _1011 = _1008;
    _1011.w = ((-1.09254801273345947265625) * _812.x) * _812.z;
    float4 _1015 = _996;
    _1015.x = 0.886227548122406005859375;
    float3 _1017 = _1015.yzw * 2.094395160675048828125;
    float4 _1018 = float4(_1015.x, _1017.x, _1017.y, _1017.z);
    float4 _1019 = _1011 * 0.785398185253143310546875;
    float _1020 = (_997.x - _997.y) * 0.4290426075458526611328125;
    float3 _1026 = float3(0.0);
    _1026.x = (dot(float4(_928, _930.xyz), _1018) + dot(float4(_930.w, _953.xyz), _1019)) + (_953.w * _1020);
    float3 _1032 = _1026;
    _1032.y = (dot(float4(_931, _933.xyz), _1018) + dot(float4(_933.w, _955.xyz), _1019)) + (_955.w * _1020);
    float3 _1038 = _1032;
    _1038.z = (dot(float4(_934, _936.xyz), _1018) + dot(float4(_936.w, _957.xyz), _1019)) + (_957.w * _1020);
    float3 _1043 = (fast::max(float3(0.0), _1038) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _1065 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1094;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1093;
        if (any(abs(_288 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _759 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _759 + 19u)].xyz + float3(1.0))))
        {
            _1093 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_288, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1093 = _1065;
        }
        _1094 = _1093;
    }
    else
    {
        _1094 = _1065;
    }
    float4 _1101 = float4(((mix(float3(0.0), _890 + (_892 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_1043 * _890) * fast::max(_901, ((((((_811 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _753) + ((_811 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _753) + ((_811 * 2.755199909210205078125) + float3(0.69029998779296875))) * _753))) + _1094) * 1.0, 0.0);
    float4 _1108;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1107 = _1101;
        _1107.w = 0.0;
        _1108 = _1107;
    }
    else
    {
        _1108 = _1101;
    }
    float2 _1112 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1120 = (_812 * 0.5) + float3(0.5);
    float4 _1122 = float4(_1120.x, _1120.y, _1120.z, float4(0.0).w);
    _1122.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _760)].y;
    float4 _1123 = float4(0.0);
    _1123.x = _810;
    float4 _1124 = _1123;
    _1124.y = _809;
    float4 _1125 = _1124;
    _1125.z = _808;
    float4 _1126 = _1125;
    _1126.w = 0.50588238239288330078125;
    float4 _1138 = float4(_811.x, _811.y, _811.z, float4(0.0).w);
    _1138.w = ((log2(((dot(_1043, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_901, ((((((_894 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _753) + ((_894 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _753) + ((_894 * 2.755199909210205078125) + float3(0.69029998779296875))) * _753).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1112.xyx * _1112.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1108 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1122;
    out.out_var_SV_Target2 = _1126;
    out.out_var_SV_Target3 = _1138;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_861, 1.0, 1.0, 1.0);
    return out;
}

