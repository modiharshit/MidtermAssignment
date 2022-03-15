

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

constant float4 _207 = {};
constant float3 _208 = {};
constant float _224 = {};
constant float4 _225 = {};

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

fragment MainPS_out Main_00007259_3230f631(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _271 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _282 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _224, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _287 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _291 = _287.xyz / float3(_287.w);
    float3 _292 = _291 - View.View_PreViewTranslation;
    float4 _300 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _303 = (_300.xy * float2(2.0)) - float2(1.0);
    float2 _312 = (normalize(-_291) * _271).xy;
    float2 _314 = (_312 * (-0.00310000008903443813323974609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _316 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _314, bias(View.View_MaterialTextureMipBias));
    float2 _319 = (_316.xy * float2(2.0)) - float2(1.0);
    float2 _328 = (_312 * (-0.0062000001780688762664794921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _330 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _328, bias(View.View_MaterialTextureMipBias));
    float2 _333 = (_330.xy * float2(2.0)) - float2(1.0);
    float2 _342 = (_312 * (-0.009300000034272670745849609375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _344 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _342, bias(View.View_MaterialTextureMipBias));
    float2 _347 = (_344.xy * float2(2.0)) - float2(1.0);
    float2 _356 = (_312 * (-0.012400000356137752532958984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _358 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _356, bias(View.View_MaterialTextureMipBias));
    float2 _361 = (_358.xy * float2(2.0)) - float2(1.0);
    float2 _370 = (_312 * (-0.01549999974668025970458984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _372 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _370, bias(View.View_MaterialTextureMipBias));
    float2 _375 = (_372.xy * float2(2.0)) - float2(1.0);
    float2 _384 = (_312 * (-0.01860000006854534149169921875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _386 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _384, bias(View.View_MaterialTextureMipBias));
    float2 _389 = (_386.xy * float2(2.0)) - float2(1.0);
    float2 _398 = (_312 * (-0.02170000039041042327880859375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _400 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _398, bias(View.View_MaterialTextureMipBias));
    float2 _403 = (_400.xy * float2(2.0)) - float2(1.0);
    float2 _412 = (_312 * (-0.02542000077664852142333984375)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _414 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _412, bias(View.View_MaterialTextureMipBias));
    float2 _417 = (_414.xy * float2(2.0)) - float2(1.0);
    float2 _426 = (_312 * (-0.0291399993002414703369140625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _428 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _426, bias(View.View_MaterialTextureMipBias));
    float2 _431 = (_428.xy * float2(2.0)) - float2(1.0);
    float2 _440 = (_312 * (-0.0340999998152256011962890625)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _442 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _440, bias(View.View_MaterialTextureMipBias));
    float2 _445 = (_442.xy * float2(2.0)) - float2(1.0);
    float2 _454 = (_312 * (-0.039680004119873046875)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _456 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _454, bias(View.View_MaterialTextureMipBias));
    float2 _459 = (_456.xy * float2(2.0)) - float2(1.0);
    float4 _470 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.949999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _473 = _470.x;
    float3 _474 = float3(_473);
    float4 _477 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.89999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _479 = _477.x;
    float3 _480 = float3(_479);
    float4 _483 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.800000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _485 = _483.x;
    float3 _486 = float3(_485);
    float4 _489 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.699999988079071044921875), bias(View.View_MaterialTextureMipBias));
    float _491 = _489.x;
    float3 _492 = float3(_491);
    float4 _495 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.60000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _497 = _495.x;
    float3 _498 = float3(_497);
    float4 _501 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.5), bias(View.View_MaterialTextureMipBias));
    float _503 = _501.x;
    float3 _504 = float3(_503);
    float4 _507 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.39999997615814208984375), bias(View.View_MaterialTextureMipBias));
    float _509 = _507.x;
    float3 _510 = float3(_509);
    float4 _513 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.300000011920928955078125), bias(View.View_MaterialTextureMipBias));
    float _515 = _513.x;
    float3 _516 = float3(_515);
    float4 _519 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2599999904632568359375), bias(View.View_MaterialTextureMipBias));
    float _521 = _519.x;
    float3 _522 = float3(_521);
    float4 _525 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.2400000095367431640625), bias(View.View_MaterialTextureMipBias));
    float _527 = _525.x;
    float3 _528 = float3(_527);
    float4 _531 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.10000002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _533 = _531.x;
    float3 _534 = float3(_533);
    float3 _543 = normalize(_271 * normalize((mix(float4(_303, sqrt(fast::clamp(1.0 - dot(_303, _303), 0.0, 1.0)), 1.0).xyz, mix(float4(_319, sqrt(fast::clamp(1.0 - dot(_319, _319), 0.0, 1.0)), 1.0).xyz, mix(float4(_333, sqrt(fast::clamp(1.0 - dot(_333, _333), 0.0, 1.0)), 1.0).xyz, mix(float4(_347, sqrt(fast::clamp(1.0 - dot(_347, _347), 0.0, 1.0)), 1.0).xyz, mix(float4(_361, sqrt(fast::clamp(1.0 - dot(_361, _361), 0.0, 1.0)), 1.0).xyz, mix(float4(_375, sqrt(fast::clamp(1.0 - dot(_375, _375), 0.0, 1.0)), 1.0).xyz, mix(float4(_389, sqrt(fast::clamp(1.0 - dot(_389, _389), 0.0, 1.0)), 1.0).xyz, mix(float4(_403, sqrt(fast::clamp(1.0 - dot(_403, _403), 0.0, 1.0)), 1.0).xyz, mix(float4(_417, sqrt(fast::clamp(1.0 - dot(_417, _417), 0.0, 1.0)), 1.0).xyz, mix(float4(_431, sqrt(fast::clamp(1.0 - dot(_431, _431), 0.0, 1.0)), 1.0).xyz, mix(float4(_445, sqrt(fast::clamp(1.0 - dot(_445, _445), 0.0, 1.0)), 1.0).xyz, float4(_459, sqrt(fast::clamp(1.0 - dot(_459, _459), 0.0, 1.0)), 1.0).xyz, _474), _480), _486), _492), _498), _504), _510), _516), _522), _528), _534) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _554 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _564 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_314 * Material.Material_ScalarExpressions[0].y) + float2(0.800000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _574 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_328 * Material.Material_ScalarExpressions[0].y) + float2(0.699999988079071044921875)), bias(View.View_MaterialTextureMipBias));
    float4 _584 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_342 * Material.Material_ScalarExpressions[0].y) + float2(0.60000002384185791015625)), bias(View.View_MaterialTextureMipBias));
    float4 _594 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_356 * Material.Material_ScalarExpressions[0].y) + float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float4 _600 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_370 * Material.Material_ScalarExpressions[0].y) + float2(0.4000000059604644775390625)), bias(View.View_MaterialTextureMipBias));
    float4 _606 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_384 * Material.Material_ScalarExpressions[0].y) + float2(0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float4 _612 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_398 * Material.Material_ScalarExpressions[0].y) + float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float4 _618 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_412 * Material.Material_ScalarExpressions[0].y) + float2(0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _624 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_426 * Material.Material_ScalarExpressions[0].y) + float2(0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _630 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_440 * Material.Material_ScalarExpressions[0].y) + float2(-0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float4 _636 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((_454 * Material.Material_ScalarExpressions[0].y) + float2(-0.20000000298023223876953125)), bias(View.View_MaterialTextureMipBias));
    float4 _640 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _454, bias(View.View_MaterialTextureMipBias));
    float4 _644 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(0.97500002384185791015625), bias(View.View_MaterialTextureMipBias));
    float _645 = _644.x;
    float3 _671 = fast::clamp(mix(_554.xyz * 1.0, mix((_564.xyz * 1.5) * fast::min(fast::max(0.60000002384185791015625 + _527, -0.0), 1.0), mix((_574.xyz * 1.2000000476837158203125) * fast::min(fast::max(0.60000002384185791015625 + _521, -0.0), 1.0), mix((_584.xyz * 1.0) * fast::min(fast::max(0.60000002384185791015625 + _515, -0.0), 1.0), mix(_594.xyz * 0.699999988079071044921875, mix(_600.xyz * 0.60000002384185791015625, mix(_606.xyz * 0.5, mix(_612.xyz * 0.4000000059604644775390625, mix(_618.xyz * 0.300000011920928955078125, mix(_624.xyz * 0.20000000298023223876953125, mix(_630.xyz * 0.1500000059604644775390625, mix(_636.xyz * 0.13799999654293060302734375, _640.xyz * 0.300000011920928955078125, float3(_645)), _474), _480), _486), _492), _498), _504), _510), _516), _522), _528), _534), float3(0.0), float3(1.0));
    float _676 = (fast::clamp(mix(0.60000002384185791015625, 0.800000011920928955078125, ((((((((((_645 * _473) * _479) * _485) * _491) * _497) * _503) * _509) * _515) * _521) * _527) * _533), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _677 = in.in_var_PRIMITIVE_ID * 36u;
    uint _678 = _677 + 20u;
    float _726;
    float _727;
    float _728;
    float3 _729;
    float3 _730;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _678)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _696 = ((_282.xy / float2(_282.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _700 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _696, level(0.0));
        float4 _703 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _696, level(0.0));
        float4 _706 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _696, level(0.0));
        float _716 = _706.w;
        _726 = (_676 * _716) + _706.z;
        _727 = (0.4000000059604644775390625 * _716) + _706.y;
        _728 = _706.x;
        _729 = (_671 * _700.w) + _700.xyz;
        _730 = normalize((_543 * _703.w) + ((_703.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _726 = _676;
        _727 = 0.4000000059604644775390625;
        _728 = 0.0;
        _729 = _671;
        _730 = _543;
    }
    float3 _740 = fast::clamp((_292 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _751 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_740.x), int(_740.y), int(_740.z), 0).xyz), 0));
    float3 _766 = (((_751.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_740 / float3(_751.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _779;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _678)].z > 0.0)
    {
        _779 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _766, level(0.0)).x;
    }
    else
    {
        _779 = 1.0;
    }
    float3 _793 = ((_729 - (_729 * _728)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _800 = (mix(float3(0.07999999821186065673828125 * _727), _729, float3(_728)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _803 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _808;
    if (_803)
    {
        _808 = _793 + (_800 * 0.449999988079071044921875);
    }
    else
    {
        _808 = _793;
    }
    float3 _810 = select(_800, float3(0.0), bool3(_803));
    float3 _812 = float3(dot(_810, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _829 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _766, level(0.0));
    float _845 = _829.x;
    float4 _847 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _766, level(0.0)) * 2.0) - float4(1.0)) * _845) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _848 = _829.y;
    float4 _850 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _766, level(0.0)) * 2.0) - float4(1.0)) * _848) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _851 = _829.z;
    float4 _853 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _766, level(0.0)) * 2.0) - float4(1.0)) * _851) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _870 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _766, level(0.0)) * 2.0) - float4(1.0)) * _845) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _872 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _766, level(0.0)) * 2.0) - float4(1.0)) * _848) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _874 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _766, level(0.0)) * 2.0) - float4(1.0)) * _851) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _907 = _225;
    _907.y = (-0.48860299587249755859375) * _730.y;
    float4 _910 = _907;
    _910.z = 0.48860299587249755859375 * _730.z;
    float4 _913 = _910;
    _913.w = (-0.48860299587249755859375) * _730.x;
    float3 _914 = _730 * _730;
    float4 _917 = _207;
    _917.x = (1.09254801273345947265625 * _730.x) * _730.y;
    float4 _920 = _917;
    _920.y = ((-1.09254801273345947265625) * _730.y) * _730.z;
    float4 _925 = _920;
    _925.z = 0.3153919875621795654296875 * ((3.0 * _914.z) - 1.0);
    float4 _928 = _925;
    _928.w = ((-1.09254801273345947265625) * _730.x) * _730.z;
    float4 _932 = _913;
    _932.x = 0.886227548122406005859375;
    float3 _934 = _932.yzw * 2.094395160675048828125;
    float4 _935 = float4(_932.x, _934.x, _934.y, _934.z);
    float4 _936 = _928 * 0.785398185253143310546875;
    float _937 = (_914.x - _914.y) * 0.4290426075458526611328125;
    float3 _943 = float3(0.0);
    _943.x = (dot(float4(_845, _847.xyz), _935) + dot(float4(_847.w, _870.xyz), _936)) + (_870.w * _937);
    float3 _949 = _943;
    _949.y = (dot(float4(_848, _850.xyz), _935) + dot(float4(_850.w, _872.xyz), _936)) + (_872.w * _937);
    float3 _955 = _949;
    _955.z = (dot(float4(_851, _853.xyz), _935) + dot(float4(_853.w, _874.xyz), _936)) + (_874.w * _937);
    float _984;
    float _985;
    float3 _986;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _971 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _766, level(0.0)).xyz * 2.0) - float3(1.0);
        float _972 = length(_971);
        float3 _975 = _971 / float3(fast::max(_972, 9.9999997473787516355514526367188e-05));
        float _976 = 1.0 - _972;
        float _978 = 1.0 - (_976 * _976);
        _984 = mix(fast::clamp(dot(_975, _730), 0.0, 1.0), 1.0, _978);
        _985 = _972;
        _986 = mix(_975, _730, float3(_978));
    }
    else
    {
        _984 = 1.0;
        _985 = 1.0;
        _986 = _730;
    }
    float4 _990 = float4(_986, 1.0);
    float3 _994 = _208;
    _994.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _990);
    float3 _998 = _994;
    _998.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _990);
    float3 _1002 = _998;
    _1002.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _990);
    float4 _1005 = _990.xyzz * _990.yzzx;
    float3 _1009 = _208;
    _1009.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _1005);
    float3 _1013 = _1009;
    _1013.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _1005);
    float3 _1017 = _1013;
    _1017.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _1005);
    float3 _1032 = ((fast::max(float3(0.0), _955) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_1002 + _1017) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_986.x * _986.x) - (_986.y * _986.y)))) * View.View_SkyLightColor.xyz) * (_985 * _984));
    float3 _1054 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _1083;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _1082;
        if (any(abs(_292 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _677 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _677 + 19u)].xyz + float3(1.0))))
        {
            _1082 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_292, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _1082 = _1054;
        }
        _1083 = _1082;
    }
    else
    {
        _1083 = _1054;
    }
    float4 _1090 = float4(((mix(float3(0.0), _808 + (_810 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_1032 * _808) * fast::max(float3(1.0), ((((((_729 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_729 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_729 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _1083) * 1.0, 0.0);
    float4 _1097;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _1096 = _1090;
        _1096.w = 0.0;
        _1097 = _1096;
    }
    else
    {
        _1097 = _1090;
    }
    float2 _1101 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _1109 = (_730 * 0.5) + float3(0.5);
    float4 _1111 = float4(_1109.x, _1109.y, _1109.z, float4(0.0).w);
    _1111.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _678)].y;
    float4 _1112 = float4(0.0);
    _1112.x = _728;
    float4 _1113 = _1112;
    _1113.y = _727;
    float4 _1114 = _1113;
    _1114.z = _726;
    float4 _1115 = _1114;
    _1115.w = 0.50588238239288330078125;
    float4 _1127 = float4(_729.x, _729.y, _729.z, float4(0.0).w);
    _1127.w = ((log2(((dot(_1032, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_812 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_812 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_812 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_1101.xyx * _1101.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _1097 * View.View_PreExposure;
    out.out_var_SV_Target1 = _1111;
    out.out_var_SV_Target2 = _1115;
    out.out_var_SV_Target3 = _1127;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_779, 1.0, 1.0, 1.0);
    return out;
}

